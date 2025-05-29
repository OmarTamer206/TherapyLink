const express = require("express");
const jwt = require("jsonwebtoken");
const {
  Change_Therapist_Preference,
  Make_Feedback,
  Make_an_appointment,
  get_doctor_sessions_taken,
  get_group_Sessions_taken,
  get_emergency_team_sessions_taken,
  Write_in_journal,
  delete_from_journal,
  getProfileData,
  check_Feedback,
} = require("../controllers/patientController");

const router = express.Router();

// Change therapist preference for a patient
router.put("/change-therapist-preference", async (req, res) => {
  const { choice } = req.body;
  if (!choice)
    return res.status(400).json({ error: "choice is required" });
    const token = req.headers['authorization']?.split(' ')[1];
    if (!token) return res.status(401).json({ message: 'Access denied' });
    
    
    try {
    console.log("1",process.env.JWT_SECRET);
    
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    const result = await Change_Therapist_Preference(decoded.id, choice);
    res.status(200).json(result);
  } catch (error) {
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
});

// Submit feedback for a specific session
router.post("/submit-feedback", async (req, res) => {
  const { session, rating, feedback , editState } = req.body;
  if (!session || !rating || !feedback )
    return res.status(400).json({ error: "Missing session, rating or feedback" });

  const token = req.headers['authorization']?.split(' ')[1];
    if (!token) return res.status(401).json({ message: 'Access denied' });
    
    
    try {
    console.log("1",process.env.JWT_SECRET);
    
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    const result = await Make_Feedback(decoded.id,session , rating, feedback , editState);
    res.status(200).json(result);
  } catch (error) {
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
});

router.get("/check-feedback/:session_ID/:session_type", async (req, res) => {
  const { session_ID , session_type} = req.params;
  if (!session_ID || !session_type )
    return res.status(400).json({ error: "Missing session" });


  
  const token = req.headers['authorization']?.split(' ')[1];
    if (!token) return res.status(401).json({ message: 'Access denied' });
    
    
    try {
    console.log("1",process.env.JWT_SECRET);
    
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    const result = await check_Feedback(decoded.id,session_ID , session_type);
    res.status(200).json(result);
  } catch (error) {
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
});

// Create a new appointment for a patient
router.post("/make-appointment", async (req, res) => {
  const { sessionData } = req.body;
  if (!sessionData)
    return res.status(400).json({ error: "Missing patient or session data" });
  
  const token = req.headers['authorization']?.split(' ')[1];
    if (!token) return res.status(401).json({ message: 'Access denied' });
    
    
    try {
    console.log("1",process.env.JWT_SECRET);
    
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    const result = await Make_an_appointment(decoded.id, sessionData);
    res.status(201).json(result);
  } catch (error) {
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
});

// Get all doctor sessions a patient has taken
router.get("/doctor-sessions", async (req, res) => {
     const token = req.headers['authorization']?.split(' ')[1];
    if (!token) return res.status(401).json({ message: 'Access denied' });
    
    
    try {
    console.log("1",process.env.JWT_SECRET);
    
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    const result = await get_doctor_sessions_taken(decoded.id);
    res.status(200).json(result);
  } catch (error) {
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
});

// Get all group sessions a patient has participated in
router.get("/group-sessions", async (req, res) => {
     const token = req.headers['authorization']?.split(' ')[1];
    if (!token) return res.status(401).json({ message: 'Access denied' });
    
    
    try {
    console.log("1",process.env.JWT_SECRET);
    
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    const result = await get_group_Sessions_taken(decoded.id);
    res.status(200).json(result);
  } catch (error) {
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
});

// Get all emergency team sessions a patient has attended
router.get("/emergency-team-sessions", async (req, res) => {
     const token = req.headers['authorization']?.split(' ')[1];
    if (!token) return res.status(401).json({ message: 'Access denied' });
    
    
    try {
    console.log("1",process.env.JWT_SECRET);
    
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    const result = await get_emergency_team_sessions_taken(decoded.id);
    res.status(200).json(result);
  } catch (error) {
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
});

// Add a journal entry for a patient
router.post("/write-journal", async (req, res) => {
  const { entry_content } = req.body;
  if (!entry_content)
    return res.status(400).json({ error: "entry content required" });

   const token = req.headers['authorization']?.split(' ')[1];
    if (!token) return res.status(401).json({ message: 'Access denied' });
    
    
    try {
    console.log("1",process.env.JWT_SECRET);
    
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    const result = await Write_in_journal(decoded.id, entry_content);
    res.status(201).json(result);
  } catch (error) {
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
});

// Delete a specific journal entry for a patient
router.delete("/delete-journal-entry/:journal_id", async (req, res) => {
  const { journal_id } = req.params;
  if (!journal_id) return res.status(400).json({ error: "Journal ID is required" });

  try {
    const result = await delete_from_journal(journal_id);
    res.status(200).json(result);
  } catch (error) {
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
});

router.get("/get-profile-data", async (req, res) => {
  const token = req.headers['authorization']?.split(' ')[1];
    if (!token) return res.status(401).json({ message: 'Access denied' });
    
    
    try {
    console.log("1",process.env.JWT_SECRET);
    
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    const result = await getProfileData(decoded.id);
    res.status(200).json(result);
  } catch (error) {
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
});

module.exports = router;
