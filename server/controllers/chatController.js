const { executeQuery } = require('./databaseController');

function ChatController(io) {
  const chats = {}; // Shared chat states and metadata by chatId
  const chatParticipants = {}; // tracks participants per chatId

  // Helper: clear typing status for a user after 2 seconds
  function scheduleTypingRemoval(chatId, userId) {
    setTimeout(() => {
      if (chats[chatId] && chats[chatId].typingStatus && chats[chatId].typingStatus[userId]) {
        delete chats[chatId].typingStatus[userId];
        io.to(chatId).emit('participantTyping', { userId, typing: false });
      }
    }, 2000);
  }

  // Helper: close chat session when session time ends
  function scheduleSessionEnd(chatId) {
    if (!chats[chatId] || !chats[chatId].sessionEndTime) return;

    const delay = chats[chatId].sessionEndTime - Date.now();
    if (delay <= 0) {
      closeSession(chatId);
      return;
    }

    setTimeout(() => closeSession(chatId), delay);
  }

  // Close session logic - notify clients and cleanup
  async function closeSession(chatId) {
    io.to(chatId).emit('sessionEnded');
    delete chats[chatId];
    delete chatParticipants[chatId];
  }

  function checkIfSessionStarted(chatId) {
    return chats[chatId] && chats[chatId].sessionStarted === true;
  }

  io.on('connection', (socket) => {
    console.log(`Client connected: ${socket.id}`);

    // Fetch user names from the database by userId
    async function getUserName(userId , userType) {
      try {
        const user = await executeQuery(`SELECT Name FROM ${userType} WHERE id = ?`, [userId]);
        if(userType != "patient" && user[0].Name)
          user[0].Name = `Dr. ${user[0]?.Name}`;

        return user[0]?.Name || 'Unknown';
      } catch (err) {
        console.error('Error fetching user name:', err);
        return 'Unknown';
      }
    }

    async function getPreviousMessages(chatId) {
  try {
    const previousMessages = await executeQuery(
      `SELECT m.chat_ID AS chatId, m.message_content AS message, m.sender_id AS senderId, 
              m.sender_type AS senderType, m.receiver_id AS receiverId, m.receiver_type AS receiverType, 
              m.time AS timestamp
       FROM message m
       WHERE m.chat_ID = ? ORDER BY m.time ASC`,
      [chatId]
    );

    // For each message, fetch sender's name based on sender_type
    for (let message of previousMessages) {
      const senderName = await getUserName(message.senderId, message.senderType);
      message.senderName = senderName;
    }

    return previousMessages;
  } catch (err) {
    console.error('Error loading previous messages:', err);
    return [];
  }
}

    socket.on('patientReady', ({ chatId }) => {
      socket.join(chatId);
      if (!chats[chatId]) chats[chatId] = { typingStatus: {}, patientReady: false, doctorReady: false, sessionStarted: false };

      chats[chatId].patientReady = true;
      if (chats[chatId].doctorReady && !chats[chatId].sessionStarted) {
        chats[chatId].sessionStarted = true;
        io.to(chatId).emit('sessionStart');
        scheduleSessionEnd(chatId);
      }
    });

    socket.on('doctorReady', ({ chatId, sessionDurationMinutes }) => {
      socket.join(chatId);
      if (!chats[chatId]) chats[chatId] = { typingStatus: {}, patientReady: false, doctorReady: false, sessionStarted: false };

      chats[chatId].doctorReady = true;
      if (!chats[chatId].sessionStarted) {
        chats[chatId].sessionStarted = true;
        io.to(chatId).emit('sessionStart');
        chats[chatId].sessionEndTime = Date.now() + sessionDurationMinutes * 60 * 1000;
        scheduleSessionEnd(chatId);
      }
    });

    socket.on('enterChat', async ({ chatId, userId, userType }) => {
      socket.join(chatId);

      // Fetch user name from database
      const userName = await getUserName(userId, userType);

      if (!chatParticipants[chatId]) chatParticipants[chatId] = {};

      const wasPresent = chatParticipants[chatId][userId] !== undefined;
      chatParticipants[chatId][userId] = { type: userType, name: userName };

      if (!chats[chatId]) {
        chats[chatId] = {
          typingStatus: {},
          patientReady: false,
          doctorReady: false,
          sessionStarted: false,
          sessionEndTime: null,
        };
      }

      if (chats[chatId].sessionStarted) {
        socket.emit('sessionStart');
        console.log(`User ${userId} re-entered ongoing session ${chatId}`);
      } else {
        console.log(`User ${userId} entered chat ${chatId}, session not started`);
      }

      // Send previous messages always
      try {
      const previousMessages = await getPreviousMessages(chatId);
      socket.emit('previousMessages', previousMessages);
      console.log(`Sent ${previousMessages.length} messages to user ${userId}`);
    } catch (err) {
      console.error('Error loading previous messages:', err);
    }

      // Send join notification only if session started and user is NEW in this session
      if (chats[chatId].sessionStarted && !wasPresent) {
        const joinMsg = {
          chatId,
          message: `${userName} has joined the chat.`,
          senderId: 'system',
          senderType: 'system',
          receiverId: null,
          receiverType: null,
          timestamp: new Date(),
        };
        io.to(chatId).emit('systemMessage', joinMsg);
      }

      console.log(`Participants in chat ${chatId}:`, chatParticipants[chatId]);
    });

    socket.on('sendMessage', async ({ chatId, senderId, senderType, receiverId, receiverType, message }) => {
      if (!chats[chatId]?.sessionStarted) {
        socket.emit('errorChat', 'Session not started or chat closed');
        return;
      }
      try {
        await executeQuery(
          `INSERT INTO message (chat_ID, message_content, receiver_type, sender_type, receiver_id, sender_id)
           VALUES (?, ?, ?, ?, ?, ?)`,
          [chatId, message, receiverType, senderType, receiverId, senderId]
        );

        // Fetch sender name from database
        const senderName = await getUserName(senderId , senderType);
        io.to(chatId).emit('receiveMessage', {
          chatId,
          message,
          senderId,
          senderType,
          senderName,  // Pass the sender name
          receiverId,
          receiverType,
          timestamp: new Date(),
        });
      } catch (err) {
        socket.emit('errorChat', 'Failed to save message');
      }
    });

     socket.on('typing', async ({ chatId, userId ,userType }) => {
      if (!chats[chatId]) return;

      const userName = await getUserName(userId, chatParticipants[chatId][userId].type); 


      if (!chats[chatId].typingStatus) chats[chatId].typingStatus = {};
      chats[chatId].typingStatus[userId] = true;
      socket.to(chatId).emit('participantTyping', { userId, userName ,typing: true });
      scheduleTypingRemoval(chatId, userId);
    });

    socket.on('stopTyping', ({ chatId, userId }) => {
      if (!chats[chatId]?.typingStatus) return;
      delete chats[chatId].typingStatus[userId];
      socket.to(chatId).emit('participantTyping', { userId, typing: false });
    });

    socket.on('exitChat', ({ chatId, userId }) => {
      socket.leave(chatId);

      if (chats[chatId]?.sessionStarted) {
        io.to(chatId).emit('systemMessage', {
          chatId,
          message: `${chatParticipants[chatId][userId].name} has left the chat.`,
          senderId: 'system',
          senderType: 'system',
          receiverId: null,
          receiverType: null,
          timestamp: new Date(),
        });
      }
      if (chatParticipants[chatId]) {
        delete chatParticipants[chatId][userId];


        if (Object.keys(chatParticipants[chatId]).length === 0) {
          delete chatParticipants[chatId];
          delete chats[chatId];
        }
      }
    });

    // Doctor manually ends the session
    socket.on('doctorEndSession', async ({ chatId, userId }) => {
      if (!chats[chatId]) {
        console.log("1");
        
        socket.emit('errorChat', 'Session not found or already ended');
        return;
      }

      const isDoctor = chatParticipants[chatId][userId].type === 'doctor';
      if (!isDoctor) {
        console.log("2");

        socket.emit('errorChat', 'Only doctor can end the session');
        return;
      }

        console.log("3");


      delete chats[chatId].sessionStarted;
      delete chats[chatId].sessionEndTime;

      await executeQuery(
          `UPDATE ${chatParticipants[chatId][userId].type}_session SET ended = 1 WHERE chat_ID = ?`,
          [chatId]
        );

      io.to(chatId).emit('sessionEnded');
      console.log(`Doctor ${userId} manually ended session ${chatId}`);
    });

    socket.on('disconnect', () => {
      console.log(`Socket disconnected: ${socket.id}`);
    });
  });
}

module.exports = { ChatController };
