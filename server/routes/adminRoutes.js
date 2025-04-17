const express = require("express");
const {
  get_total_doctors_count,
  get_total_appointment_count,
  get_total_patient_count,
  get_total_earnings_count,
  get_patient_visit_data_by_month,
  search_workforce,
  get_booked_session_data,
  get_available_sessions_data,
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

module.exports = router;
