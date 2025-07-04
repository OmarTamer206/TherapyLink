const express = require("express");
const jwt = require("jsonwebtoken")
const {
  get_today_sessions,
  get_new_patients_this_month,
  get_total_patients,
  get_patients_data,
  get_patient_data,
  update_patient_report,
  view_available_time,
  update_available_time,
  get_patient_analytics,
  View_all_doctors,
  get_upcoming_sessions,
  delete_available_time,
  get_therapist_data,
  view_available_time_all,
  view_available_days,
} = require("../controllers/TherapistController");

const router = express.Router();

// Get today's sessions for a specific doctor or life coach
router.get("/today-sessions", async (req, res) => {

  const token = req.headers['authorization']?.split(' ')[1];
    if (!token) return res.status(401).json({ message: 'Access denied' });
    
    
    try {
    console.log("1",process.env.JWT_SECRET);
    
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    const result = await get_today_sessions(decoded.id, decoded.role);
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

router.get("/upcoming-sessions", async (req, res) => {

  const token = req.headers['authorization']?.split(' ')[1];
    if (!token) return res.status(401).json({ message: 'Access denied' });
    
    
    try {
    console.log("1",process.env.JWT_SECRET);
    
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    const result = await get_upcoming_sessions(decoded.id, decoded.role);
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

// Get new patients registered this month for a specific doctor or life coach
router.get("/new-patients-this-month", async (req, res) => {
  const token = req.headers['authorization']?.split(' ')[1];
    if (!token) return res.status(401).json({ message: 'Access denied' });
    
    
    try {
    console.log("1",process.env.JWT_SECRET);
    
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    const result = await get_new_patients_this_month(decoded.id, decoded.role);
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

// Get total patients for a specific doctor or life coach
router.get("/total-patients", async (req, res) => {
  const token = req.headers['authorization']?.split(' ')[1];
    if (!token) return res.status(401).json({ message: 'Access denied' });
    
    
    try {
    console.log("1",process.env.JWT_SECRET);
    
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    const result = await get_total_patients(decoded.id, decoded.role);
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

// Get patient list for a doctor or life coach
router.get("/patients-data/:session_ID", async (req, res) => {
  const { session_ID } = req.params;

  const token = req.headers['authorization']?.split(' ')[1];
    if (!token) return res.status(401).json({ message: 'Access denied' });
    
    
    try {
    console.log("1",process.env.JWT_SECRET);
    
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    const result = await get_patients_data(decoded.id, session_ID);
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

// Get detailed reports and journal entries for a specific patient
router.get("/patient-data/:patient_id", async (req, res) => {
  const { patient_id } = req.params;
  try {
    const result = await get_patient_data(patient_id);
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

// Update patient report after a session [msh 3arf ha3ml eh fl ]
router.put("/update-patient-report", async (req, res) => {
  const { session_data , report } = req.body;
  if ( !session_data , !report)
    return res.status(400).json({ error: "Missing report or session_data" });
  
  const token = req.headers['authorization']?.split(' ')[1];
  if (!token) return res.status(401).json({ message: 'Access denied' });
  
  
  try {
  console.log("1",process.env.JWT_SECRET);
  
  const decoded = jwt.verify(token, process.env.JWT_SECRET);
    const result = await update_patient_report(report, session_data ,decoded.role);
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

// View available time slots for a specific date
router.get("/available-time/:date/:id/:type", async (req, res) => {

  let doctor_id ;
  let doctor_type ;

  const { date , id , type } = req.params;
  const token = req.headers['authorization']?.split(' ')[1];
    if (!token) return res.status(401).json({ message: 'Access denied' });
    
    
    try {
      console.log("1",process.env.JWT_SECRET);
      const decoded = jwt.verify(token, process.env.JWT_SECRET);
      
      if(id && type){
        doctor_id = id;
        doctor_type = type;
      }
      else{
        doctor_id = decoded.id;
        doctor_type = decoded.role;
      }
    const result = await view_available_time(date, doctor_id, doctor_type);
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

router.get("/available-days/:id/:type", async (req, res) => {

  let doctor_id ;
  let doctor_type ;

  const { date , id , type } = req.params;
  const token = req.headers['authorization']?.split(' ')[1];
    if (!token) return res.status(401).json({ message: 'Access denied' });
    
    
    try {
      console.log("1",process.env.JWT_SECRET);
      const decoded = jwt.verify(token, process.env.JWT_SECRET);
      
      
        doctor_id = id;
        doctor_type = type;
      
      
    const result = await view_available_days( doctor_id, doctor_type);
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

router.get("/available-time/:date", async (req, res) => {

  let doctor_id ;
  let doctor_type ;

  const { date } = req.params;
  const token = req.headers['authorization']?.split(' ')[1];
    if (!token) return res.status(401).json({ message: 'Access denied' });
    
    
    try {
      console.log("1",process.env.JWT_SECRET);
      const decoded = jwt.verify(token, process.env.JWT_SECRET);
      
      
      
        doctor_id = decoded.id;
        doctor_type = decoded.role;
      
    const result = await view_available_time(date, doctor_id, doctor_type);
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



// Update available time for a doctor or life coach
router.put("/update-available-time", async (req, res) => {
  const { timestamp , topic } = req.body;
  if (!timestamp )
    return res.status(400).json({ error: "Missing timestamp or doctor_id" });
  
  
  const token = req.headers['authorization']?.split(' ')[1];
  if (!token) return res.status(401).json({ message: 'Access denied' });
  
  
  try {
  console.log("1",process.env.JWT_SECRET);
  
  const decoded = jwt.verify(token, process.env.JWT_SECRET);
    const result = await update_available_time(timestamp, decoded.id,decoded.role,topic);
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

router.delete("/delete-available-time", async (req, res) => {
  const { timestamp } = req.body;
  if (!timestamp )
    return res.status(400).json({ error: "Missing timestamp or doctor_id" });
  
  
  const token = req.headers['authorization']?.split(' ')[1];
  if (!token) return res.status(401).json({ message: 'Access denied' });
  
  
  try {
  console.log("1",process.env.JWT_SECRET);
  
  const decoded = jwt.verify(token, process.env.JWT_SECRET);
    const result = await delete_available_time(decoded.id,timestamp,decoded.role);
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

// Get patient analytics (e.g., total patients, overall rating, returning patients)
router.get("/patient-analytics", async (req, res) => {
  const token = req.headers['authorization']?.split(' ')[1];
    if (!token) return res.status(401).json({ message: 'Access denied' });
    
    
    try {
    console.log("1",process.env.JWT_SECRET);
    
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    const result = await get_patient_analytics(decoded.id, decoded.role);
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

router.get("/get-therapist-data", async (req, res) => {
  const token = req.headers['authorization']?.split(' ')[1];
  if (!token) return res.status(401).json({ message: 'Access denied' });
  
  
  try {
  console.log("1",process.env.JWT_SECRET);
  
  const decoded = jwt.verify(token, process.env.JWT_SECRET);
    const result = await get_therapist_data(decoded.id, decoded.role);
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

// View all doctors of a specific type (e.g., therapists, life coaches)
router.get("/all-doctors/:doctor_type/:doctor_specialization", async (req, res) => {
  const { doctor_type , doctor_specialization } = req.params;
  try {
    const result = await View_all_doctors(doctor_type , doctor_specialization);
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
