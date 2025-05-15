const express = require('express');
const router = express.Router();
const {
  startChat,
  getQuestion,
  respondToChat,
  getSummary,
} = require('../controllers/AgentController');

// POST /chat/start
router.post('/start', startChat);

// POST /chat/ask
router.post('/ask', getQuestion);

// POST /chat/respond
router.post('/respond', respondToChat);

// POST /chat/summary
router.post('/summary', getSummary);

module.exports = router;
