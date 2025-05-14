const express = require("express");
const jwt = require("jsonwebtoken");
const {
  view_upcoming_Sessions_patient,
  view_upcoming_Sessions_doctor,
  view_old_Sessions,
  view_old_session_details,
  initialize_communication,
  initalize_emergency_session,
  view_session_details,
  cancellSession,
} = require("../controllers/SessionController");

const router = express.Router();

// View upcoming sessions for a patient
router.get("/view-upcoming-sessions-patient", async (req, res) => {
  const token = req.headers['authorization']?.split(' ')[1];
    if (!token) return res.status(401).json({ message: 'Access denied' });
    
    
    try {
    console.log("1",process.env.JWT_SECRET);
    
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    const result = await view_upcoming_Sessions_patient(decoded.id);
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// View upcoming sessions for a doctor
router.get("/view-upcoming-sessions-doctor/:doctor_id", async (req, res) => {
  const { doctor_id } = req.params;
  try {
    const result = await view_upcoming_Sessions_doctor(doctor_id);
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// View past sessions for a patient
router.get("/view-old-sessions/:patient_id", async (req, res) => {
  const { patient_id } = req.params;
  try {
    const result = await view_old_Sessions(patient_id);
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// View session details for a specific past session
router.get("/view-session-details/:session_id/", async (req, res) => {
  const { session_id } = req.params;
  const token = req.headers['authorization']?.split(' ')[1];

  if (!token) return res.status(401).json({ message: 'Access denied' });
      
      
    try {
    console.log("1",process.env.JWT_SECRET);
    
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    const result = await view_session_details(session_id, decoded.role);
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Initialize communication for a session (chat or video link)
router.post("/initialize-communication", async (req, res) => {
  const { session_id, session_type } = req.body;
  if (!session_id || !session_type)
    return res.status(400).json({ error: "Session ID and type are required." });

  try {
    const result = await initialize_communication(session_id, session_type);
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Initialize an emergency session for a patient
router.post("/initialize-emergency-session/:patient_id", async (req, res) => {
  const { patient_id } = req.params;
  try {
    const result = await initalize_emergency_session(patient_id);
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.post("/cancel-session", async (req, res) => {
  const { session_ID } = req.body;
  console.log(req.body);
  
  if (!session_ID )
    return res.status(400).json({ error: "Missing session_ID" });
  
  
  const token = req.headers['authorization']?.split(' ')[1];
  if (!token) return res.status(401).json({ message: 'Access denied' });
  
  
  try {
  console.log("1",process.env.JWT_SECRET);
  
  const decoded = jwt.verify(token, process.env.JWT_SECRET);
    const result = await cancellSession(session_ID,decoded.role);
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});


module.exports = router;
