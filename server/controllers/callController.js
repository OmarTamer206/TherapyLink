const { executeQuery } = require('./databaseController');

function CallController(io) {
  const activeCalls = {}; // Tracks active calls by call_ID

  io.on('connection', (socket) => {
    console.log(`Client connected for call: ${socket.id}`);

    socket.on('joinCall', ({ call_ID, userId, userType, userName }) => {
      socket.join(call_ID);

      if (!activeCalls[call_ID]) {
        activeCalls[call_ID] = {
          participants: {},
          sessionEnded: false,
        };
      }

      activeCalls[call_ID].participants[userId] = {
        userType,
        userName,
        muted: false,
        videoOn: false,
        socketId: socket.id,
      };

      io.to(call_ID).emit('participantsUpdate', activeCalls[call_ID].participants);

      if (activeCalls[call_ID].sessionEnded) {
        socket.emit('callEnded');
        socket.leave(call_ID);
      } else {
        console.log(`${userName} (${userType}) joined call ${call_ID}`);
      }
    });

    socket.on('toggleMute', ({ call_ID, userId, muted }) => {
      if (activeCalls[call_ID]?.participants[userId]) {
        activeCalls[call_ID].participants[userId].muted = muted;
        io.to(call_ID).emit('participantsUpdate', activeCalls[call_ID].participants);
      }
    });

    socket.on('toggleVideo', ({ call_ID, userId, videoOn }) => {
      if (activeCalls[call_ID]?.participants[userId]) {
        activeCalls[call_ID].participants[userId].videoOn = videoOn;
        io.to(call_ID).emit('participantsUpdate', activeCalls[call_ID].participants);
      }
    });

    socket.on('leaveCall', ({ call_ID, userId }) => {
      socket.leave(call_ID);
      if (activeCalls[call_ID]?.participants[userId]) {
        const userName = activeCalls[call_ID].participants[userId].userName;
        delete activeCalls[call_ID].participants[userId];
        io.to(call_ID).emit('participantsUpdate', activeCalls[call_ID].participants);
        console.log(`${userName} left call ${call_ID}`);
      }
    });

    socket.on('endCall', async ({ call_ID, userId }) => {
      const user = activeCalls[call_ID]?.participants[userId];
      if (user && ['doctor', 'life_coach', 'emergency_team'].includes(user.userType)) {
        activeCalls[call_ID].sessionEnded = true;
        
        io.to(call_ID).emit('callEnded');

        const sessionTable = `${user.userType}_session`;
        await executeQuery(`UPDATE ${sessionTable} SET ended = 1 WHERE call_ID = ?`, [call_ID]);
        
        delete activeCalls[call_ID];
        console.log(`Call ${call_ID} ended by ${user.userName} (${user.userType})`);
      }
    });

    // WebRTC signaling events
    socket.on('webrtc-offer', ({ call_ID, offer, senderId }) => {
      socket.to(call_ID).emit('webrtc-offer', { offer, senderId });
    });

    socket.on('webrtc-answer', ({ call_ID, answer, senderId }) => {
      socket.to(call_ID).emit('webrtc-answer', { answer, senderId });
    });

    socket.on('webrtc-ice-candidate', ({ call_ID, candidate, senderId }) => {
      socket.to(call_ID).emit('webrtc-ice-candidate', { candidate, senderId });
    });

    socket.on('disconnect', () => {
      for (const call_ID in activeCalls) {
        for (const userId in activeCalls[call_ID].participants) {
          if (activeCalls[call_ID].participants[userId].socketId === socket.id) {
            const userName = activeCalls[call_ID].participants[userId].userName;
            delete activeCalls[call_ID].participants[userId];
            io.to(call_ID).emit('participantsUpdate', activeCalls[call_ID].participants);
            console.log(`${userName} disconnected from call ${call_ID}`);
            break;
          }
        }
      }
    });

    // Auto-start call for patients when doctor joins
    socket.on('startSession', ({ call_ID }) => {
      io.to(call_ID).emit('sessionStarted');
      console.log(`Session started for call ${call_ID}`);
    });
  });
}

module.exports = { CallController };
