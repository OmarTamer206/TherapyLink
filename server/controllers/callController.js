const { executeQuery } = require('./databaseController');

function CallController(io) {
  const activeCalls = {}; // Tracks active calls by call_ID


  function scheduleCallEnd(call_ID) {
  if (!activeCalls[call_ID] || !activeCalls[call_ID].sessionEndTime) return;

  const delay = activeCalls[call_ID].sessionEndTime - Date.now();
  if (delay <= 0) {
    endSession(call_ID);
    return;
  }

  activeCalls[call_ID].sessionTimeout = setTimeout(() => {
    endSession(call_ID, activeCalls[call_ID].sessionOwnerType);
  }, delay);
}

async function endSession(call_ID) {
  if (!activeCalls[call_ID]) return;

    
      
        activeCalls[call_ID].sessionEnded = true;

        io.to(call_ID).emit('callEnded');

        const sessionTable = `${user.userType}_session`;
        await executeQuery(`UPDATE ${sessionTable} SET ended = 1 WHERE call_ID = ?`, [call_ID]);

        delete activeCalls[call_ID];
        console.log(`Call ${call_ID} ended by ${user.userName} (${user.userType})`);
      

 

  delete activeCalls[call_ID];
}

  io.on('connection', (socket) => {
    console.log(`Client connected for call: ${socket.id}`);

    // Rejoin logic
    socket.on('checkCallStatus', ({ call_ID, userId }, callback) => {
      const call = activeCalls[call_ID];
      if (!call || call.sessionEnded || !call.callStarted) {
        callback({ rejoinAllowed: false });
      } else {
        if (!call.participants[userId]) {
          call.participants[userId] = {
            userType: 'unknown',
            userName: 'Reconnected User',
            muted: false,
            videoOn: false,
            socketId: socket.id,
          };
        }
        socket.join(call_ID);
        io.to(call_ID).emit('participantsUpdate', call.participants);
        callback({ rejoinAllowed: true });
      }
    });

    // Join call but do NOT trigger session yet
    socket.on('joinCall', ({ call_ID, userId, userType, userName }) => {
      socket.join(call_ID);

      if (!activeCalls[call_ID]) {
        activeCalls[call_ID] = {
          participants: {},
          sessionEnded: false,
          callStarted: false, // NEW
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

    //   if (userType === 'patient' ) {
    //     io.to(call_ID).emit('sessionStarted');
    //     }

      for (const id in activeCalls[call_ID].participants) {
        if (id !== userId) {
          const socketId = activeCalls[call_ID].participants[id].socketId;
          io.to(socketId).emit('rejoinRequest', { call_ID, targetId: userId });
        }
      }

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

    // WebRTC signaling
    socket.on('webrtc-offer', ({ call_ID, offer, senderId }) => {
      socket.to(call_ID).emit('webrtc-offer', { offer, senderId });
    });

    socket.on('webrtc-answer', ({ call_ID, answer, senderId }) => {
      socket.to(call_ID).emit('webrtc-answer', { answer, senderId });
    });

    socket.on('webrtc-ice-candidate', ({ call_ID, candidate, senderId }) => {
      socket.to(call_ID).emit('webrtc-ice-candidate', { candidate, senderId });
    });

    // Manual start of session by doctor/life_coach/emergency_team
    socket.on('startSession', ({ call_ID, durationMinutes }) => {
  if (activeCalls[call_ID]) {
    activeCalls[call_ID].callStarted = true;
    activeCalls[call_ID].sessionEndTime = Date.now() + durationMinutes * 60 * 1000;
    io.to(call_ID).emit('sessionStarted');
    console.log(`Session started for call ${call_ID} for ${durationMinutes} minutes`);
    scheduleCallEnd(call_ID);
  }
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
  });
}

module.exports = { CallController };
