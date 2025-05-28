const express = require('express');
const {
  getEmergencyTeamData,
  getEmergencyTeamChats
} = require('../controllers/emergencyController');

const router = express.Router();

router.get('/data', getEmergencyTeamData);
router.get('/chats', getEmergencyTeamChats);

module.exports = router;
