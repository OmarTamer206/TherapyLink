const { executeQuery } = require('../controllers/databaseController');
let emergencyRequests = [];


function EmergencySocket(io) {
 io.on('connection', (socket) => {
    console.log('Emergency Team connected:', socket.id);

    socket.on('requestEmergency', async (patientData) => {
        socket.join(socket.id)

          const exists = emergencyRequests.find(r => r.requestId === patientData.id);
        if (exists) return; // 🚫 Prevent duplicate entries


      const request = {
        ...patientData,
        requestId: patientData.id,
        socketId: socket.id,
      };
      emergencyRequests.push(request);
      io.emit('newEmergencyRequest', request); // broadcast to team
    });

    socket.on('cancelEmergencyRequest', (requestId) => {
      emergencyRequests = emergencyRequests.filter(r => r.requestId !== requestId);
      io.emit('removeEmergencyRequest', requestId);
    });

    socket.on('acceptEmergencyRequest', async ({ requestId, teamMember }) => {
      const request = emergencyRequests.find(r => r.requestId === requestId);
      console.log(request);
      
      if (!request) return;

      const callId = await executeQuery(`INSERT INTO \`call\` () VALUES ()`);
      console.log(callId.insertId, request.id, teamMember.id , teamMember.name);


      await executeQuery(`INSERT INTO emergency_team_session ( call_id, patient_id, team_member_ID , time) VALUES (?, ?, ? , NOW())`,
        [ callId.insertId, request.id, teamMember.id]);

        console.log("socket id " , request.socketId);
        
        socket.join(request.socketId)

      io.to(request.socketId).emit('emergencyAccepted', {
        callId:callId.insertId,
        patientId: request.id,
        emergencyMember: teamMember
      });

      io.emit('removeEmergencyRequest', requestId);
      emergencyRequests = emergencyRequests.filter(r => r.requestId !== requestId);
    });
  });
}


module.exports = { EmergencySocket };
