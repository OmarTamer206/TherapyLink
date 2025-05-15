const axios = require('axios');

// Base URL of your Flask model server
const FLASK_URL = 'http://localhost:5000';

const startChat = async (req, res) => {
  const { sessionId } = req.body;

  try {
    const response = await axios.post(`${FLASK_URL}/start`, { sessionId });
    res.json(response.data);
  } catch (error) {
    console.error('Error starting session:', error.message);
    res.status(500).json({ error: 'Failed to start session' });
  }
};

const getQuestion = async (req, res) => {
  const { sessionId } = req.body;

  try {
    const response = await axios.post(`${FLASK_URL}/ask`, { sessionId });
    res.json(response.data);
  } catch (error) {
    console.error('Error getting question:', error.message);
    res.status(500).json({ error: 'Failed to get question' });
  }
};

const respondToChat = async (req, res) => {
  const { sessionId, userInput } = req.body;

  try {
    const response = await axios.post(`${FLASK_URL}/respond`, {
      sessionId,
      userInput,
    });
    res.json(response.data);
  } catch (error) {
    console.error('Error sending response:', error.message);
    res.status(500).json({ error: 'Failed to process response' });
  }
};

const getSummary = async (req, res) => {
  const { sessionId } = req.body;

  try {
    const response = await axios.post(`${FLASK_URL}/summary`, { sessionId });
    res.json(response.data);
  } catch (error) {
    console.error('Error getting summary:', error.message);
    res.status(500).json({ error: 'Failed to get summary' });
  }
};

module.exports = {
  startChat,
  getQuestion,
  respondToChat,
  getSummary,
};
