const express = require("express");
const jwt = require("jsonwebtoken");
require("dotenv").config();

const {
  get_total_doctors_count,
  get_total_appointment_count,
  get_total_patient_count,
  get_total_earnings_count,
  get_patient_visit_data_by_month,
  search_workforce,
  get_booked_session_data,
  get_available_sessions_data,
  get_workforce_data,
  get_admin_data,
  get_cancelled_session_data,
  checkRefunded,
  getAllFeedbacks,
  replyFeedback,
} = require("../controllers/adminController");

const { authorizeRoles } = require("../middlewares/authMiddlewares");

const router = express.Router();

// Get total doctors count
router.get("/total-doctors-count", async (req, res) => {
  try {
    const result = await get_total_doctors_count();
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Get total appointments count
router.get("/total-appointments-count", async (req, res) => {
  try {
    const result = await get_total_appointment_count();
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Get total patients count
router.get("/total-patient-count", async (req, res) => {
  try {
    const result = await get_total_patient_count();
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Get total earnings count
router.get("/total-earnings-count", async (req, res) => {
  try {
    const result = await get_total_earnings_count();
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Get patient visit data by month
router.get("/patient-visit-data-by-month", async (req, res) => {
  try {
    const result = await get_patient_visit_data_by_month();
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Search workforce by name and type (doctor, life_coach, emergency_team)
router.get("/search-workforce", async (req, res) => {
  const { name, type } = req.query;
  if (!name || !type)
    return res.status(400).json({ error: "Name and type are required" });

  try {
    const result = await search_workforce(name, type);
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.get("/get-workforce-data", async (req, res) => {
  const { id, type } = req.query;
  if (!id || !type)
    return res.status(400).json({ error: "id and type are required" });

  try {
    const result = await get_workforce_data(id, type);
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Get booked session data
router.get("/booked-session-data", async (req, res) => {
  try {
    const result = await get_booked_session_data();
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Get available session data
router.get("/available-session-data", async (req, res) => {
  try {
    const result = await get_available_sessions_data();
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.get("/cancelled-session-data", async (req, res) => {
  try {
    const result = await get_cancelled_session_data();
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.get("/get-admin-data", async (req, res) => {
  const token = req.headers['authorization']?.split(' ')[1];
  if (!token) return res.status(401).json({ message: 'Access denied' });
  
  try {
    console.log("1",process.env.JWT_SECRET);
    
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    
    
    const result = await get_admin_data(decoded.id,decoded.role);
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.post("/check-refunded", async (req, res) => {
  const data = req.body;
  if (
    !data.doctor_type ||
    !data.session_ID
  )
    return res.status(400).json({ error: "Missing data" });
  try {
    const result = await checkRefunded(session_id, doctor_type);
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.get("/get-all-feedbacks", async (req, res) => {
  try {
    const result = await getAllFeedbacks();
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.post("/reply-feedback", async (req, res) => {
  const data = req.body;
  console.log(data);
  
 

  if (
    !data.feedback_ID  ||
    !data.session_ID  ||
    !data.patient_ID  ||
    !data.doctor_type  ||
    !data.response  ||
    data.IsRefunded == null
  )
    return res.status(400).json({ error: "Missing data" });
  try {
    const result = await replyFeedback(data.feedback_ID, data.session_ID, data.patient_ID, data.doctor_type, data.response, data.IsRefunded);
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;
