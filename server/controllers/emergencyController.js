const { executeQuery } = require('./databaseController');
const jwt = require('jsonwebtoken');

async function getEmergencyTeamData(req, res) {
  try {
    const token = req.headers['authorization']?.split(' ')[1];
    if (!token) return res.status(401).json({ message: 'Access denied' });
    
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    console.log(!decoded);
    console.log(decoded == null);
    
    const result = await executeQuery('SELECT * FROM emergency_team WHERE id = ?', [decoded.id]);
    
    res.status(200).json({data : result , success:true});
  } catch (err) {
     if (err.name === 'TokenExpiredError') {
    // Token expired
    // Handle by sending 401 or redirecting user to login
    return res.status(401).json({ error: 'Token expired' });
  } else if (err.name === 'JsonWebTokenError') {
    // Invalid token
    return res.status(401).json({ error: 'Invalid token' });
  } else {
    // Other errors
    return res.status(500).json({ error: 'Internal server error' });
  }
  }
}

async function getEmergencyTeamChats(req, res) {
  try {
    const token = req.headers['authorization']?.split(' ')[1];
    if (!token) return res.status(401).json({ message: 'Access denied' });

    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    const result = await executeQuery('SELECT * FROM emergency_team_session WHERE team_member_ID = ?', [decoded.id]);
    res.status(200).json({data : result , success:true});
  } catch (err) {
   if (err.name === 'TokenExpiredError') {
    // Token expired
    // Handle by sending 401 or redirecting user to login
    return res.status(401).json({ error: 'Token expired' });
  } else if (err.name === 'JsonWebTokenError') {
    // Invalid token
    return res.status(401).json({ error: 'Invalid token' });
  } else {
    // Other errors
    return res.status(500).json({ error: 'Internal server error' });
  }
  }
}

module.exports = {
  getEmergencyTeamData,
  getEmergencyTeamChats,
};
