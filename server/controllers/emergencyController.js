const { executeQuery } = require('./databaseController');
const jwt = require('jsonwebtoken');

async function getEmergencyTeamData(req, res) {
  try {
    const token = req.headers['authorization']?.split(' ')[1];
    if (!token) return res.status(401).json({ message: 'Access denied' });

    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    const result = await executeQuery('SELECT * FROM emergency_team WHERE id = ?', [decoded.id]);
    
    res.status(200).json({data : result , success:true});
  } catch (err) {
    res.status(500).json({ error: err.message , success:false });
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
    res.status(500).json({ error: err.message , success:false });
  }
}

module.exports = {
  getEmergencyTeamData,
  getEmergencyTeamChats,
};
