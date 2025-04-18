const express = require("express");
const {
  view_upcoming_Sessions_patient,
  view_upcoming_Sessions_doctor,
  view_old_Sessions,
  view_old_session_details,
  initialize_communication,
  initalize_emergency_session,
} = require("../controllers/SessionController");

const router = express.Router();

// View upcoming sessions for a patient
router.get("/view-upcoming-sessions-patient/:patient_id", async (req, res) => {
  const { patient_id } = req.params;
  try {
    const result = await view_upcoming_Sessions_patient(patient_id);
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
router.get("/view-old-session-details/:session_id/:session_type", async (req, res) => {
  const { session_id, session_type } = req.params;
  try {
    const result = await view_old_session_details(session_id, session_type);
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

module.exports = router;
