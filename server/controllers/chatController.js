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
  function closeSession(chatId) {
    io.to(chatId).emit('sessionEnded');
    delete chats[chatId];
    delete chatParticipants[chatId];
  }

  function checkIfSessionStarted(chatId) {
    return chats[chatId] && chats[chatId].sessionStarted === true;
  }

  io.on('connection', (socket) => {
    console.log(`Client connected: ${socket.id}`);

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

  if (!chatParticipants[chatId]) chatParticipants[chatId] = {};

  const wasPresent = chatParticipants[chatId][userId] !== undefined;
  chatParticipants[chatId][userId] = userType;

  if (!chats[chatId]) {
    chats[chatId] = {
      typingStatus: {},
      patientReady: false,
      doctorReady: false,
      sessionStarted: false,
      sessionEndTime: null,
    };
  }

  // If session started, tell this socket ONLY to start session UI
  if (chats[chatId].sessionStarted) {
    socket.emit('sessionStart');
    console.log(`User ${userId} re-entered ongoing session ${chatId}`);
  } else {
    console.log(`User ${userId} entered chat ${chatId}, session not started`);
  }

  // Send previous messages always
  try {
    const previousMessages = await executeQuery(
      `SELECT chat_ID AS chatId, message_content AS message, sender_id AS senderId, sender_type AS senderType, receiver_id AS receiverId, receiver_type AS receiverType, time AS timestamp
       FROM message WHERE chat_ID = ? ORDER BY time ASC`,
      [chatId]
    );
    socket.emit('previousMessages', previousMessages);
    console.log(`Sent ${previousMessages.length} messages to user ${userId}`);
  } catch (err) {
    console.error('Error loading previous messages:', err);
  }

  // Send join notification only if session started and user is NEW in this session
  if (chats[chatId].sessionStarted && !wasPresent) {
    const joinMsg = {
      chatId,
      message: `${userType.charAt(0).toUpperCase() + userType.slice(1)} ${userId} has joined the chat.`,
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
        io.to(chatId).emit('receiveMessage', {
          chatId,
          message,
          senderId,
          senderType,
          receiverId,
          receiverType,
          timestamp: new Date()
        });
      } catch (err) {
        socket.emit('errorChat', 'Failed to save message');
      }
    });

    socket.on('typing', ({ chatId, userId }) => {
      if (!chats[chatId]) return;
      if (!chats[chatId].typingStatus) chats[chatId].typingStatus = {};
      chats[chatId].typingStatus[userId] = true;
      socket.to(chatId).emit('participantTyping', { userId, typing: true });
      scheduleTypingRemoval(chatId, userId);
    });

    socket.on('stopTyping', ({ chatId, userId }) => {
      if (!chats[chatId]?.typingStatus) return;
      delete chats[chatId].typingStatus[userId];
      socket.to(chatId).emit('participantTyping', { userId, typing: false });
    });

    socket.on('exitChat', ({ chatId, userId }) => {
      socket.leave(chatId);

      if (chatParticipants[chatId]) {
        delete chatParticipants[chatId][userId];

        // Broadcast leave notification if mid-session
        if (chats[chatId]?.sessionStarted) {
          io.to(chatId).emit('systemMessage', {
            chatId,
            message: `User ${userId} has left the chat.`,
            senderId: 'system',
            senderType: 'system',
            receiverId: null,
            receiverType: null,
            timestamp: new Date()
          });
        }

        if (Object.keys(chatParticipants[chatId]).length === 0) {
          delete chatParticipants[chatId];
          delete chats[chatId];
        }
      }
    });

    socket.on('disconnect', () => {
      console.log(`Socket disconnected: ${socket.id}`);
    });
  });
}

module.exports = { ChatController };
