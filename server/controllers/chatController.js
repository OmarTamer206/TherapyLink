const { executeQuery } = require('./databaseController');

function ChatController(io) {
  const chatParticipants = {};
  const typingStatus = {};

  io.on('connection', (socket) => {
    console.log('Client connected:', socket.id);

    // ========================
    // 🔄 Sync Session Start
    // ========================

    socket.on('patientReady', ({ sessionId }) => {
      socket.join(sessionId);
      if (!socket.sessionStatus) socket.sessionStatus = {};
      socket.sessionStatus[sessionId] = { patientReady: true };

      if (socket.sessionStatus[sessionId]?.doctorTriedToStart) {
        io.to(sessionId).emit('sessionStart');
      }
    });

    socket.on('doctorStartAttempt', ({ sessionId }) => {
      if (!socket.sessionStatus) socket.sessionStatus = {};
      const session = socket.sessionStatus[sessionId] || {};

      if (session.patientReady) {
        io.to(sessionId).emit('sessionStart');
      } else {
        socket.sessionStatus[sessionId] = { ...session, doctorTriedToStart: true };
        socket.emit('waitingForPatient');
      }
    });

    // ========================
    // 💬 Chat Functionality
    // ========================

    socket.on('enterChat', async ({ chatId, userId, userType }) => {
      socket.join(chatId);

      // Store participants
      if (!chatParticipants[chatId]) {
        chatParticipants[chatId] = { participantA: { id: userId, type: userType } };
      } else {
        const existing = chatParticipants[chatId];

        const alreadyRegistered = Object.values(existing).some(
          (p) => p.id === userId && p.type === userType
        );

        if (!alreadyRegistered) {
          // Assign as participantB if available
          chatParticipants[chatId].participantB = { id: userId, type: userType };
        }
      }

      console.log(`User ${userId} (${userType}) joined chat ${chatId}`);
    });

    socket.on('sendMessage', async ({ chatId, senderId, senderType, receiverId, receiverType, message }) => {
      const timestamp = new Date();

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
        timestamp
      });
    });

    socket.on('typing', ({ chatId, userId }) => {
      if (!typingStatus[chatId]) typingStatus[chatId] = {};
      typingStatus[chatId][userId] = true;

      socket.to(chatId).emit('participantTyping', { userId, typing: true });
    });

    socket.on('stopTyping', ({ chatId, userId }) => {
      if (typingStatus[chatId]) typingStatus[chatId][userId] = false;
      socket.to(chatId).emit('participantTyping', { userId, typing: false });
    });

    socket.on('exitChat', ({ chatId, userId }) => {
      socket.leave(chatId);

      if (chatParticipants[chatId]) {
        const p = chatParticipants[chatId];
        if (p.participantA?.id === userId) delete p.participantA;
        if (p.participantB?.id === userId) delete p.participantB;

        if (!p.participantA && !p.participantB) {
          delete chatParticipants[chatId];
          delete typingStatus[chatId];
        }
      }

      console.log(`User ${userId} left chat ${chatId}`);
    });

    socket.on('disconnect', () => {
      console.log('Socket disconnected:', socket.id);
      // You could also clean up here if needed
    });
  });
}

module.exports = {ChatController};
