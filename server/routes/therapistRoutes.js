const express = require("express");
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
} = require("../controllers/TherapistController");

const router = express.Router();

// Get today's sessions for a specific doctor or life coach
router.get("/today-sessions/:doctor_id/:type", async (req, res) => {
  const { doctor_id, type } = req.params;
  try {
    const result = await get_today_sessions(doctor_id, type);
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Get new patients registered this month for a specific doctor or life coach
router.get("/new-patients-this-month/:doctor_id/:type", async (req, res) => {
  const { doctor_id, type } = req.params;
  try {
    const result = await get_new_patients_this_month(doctor_id, type);
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Get total patients for a specific doctor or life coach
router.get("/total-patients/:doctor_id/:type", async (req, res) => {
  const { doctor_id, type } = req.params;
  try {
    const result = await get_total_patients(doctor_id, type);
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Get patient list for a doctor or life coach
router.get("/patients-data/:doctor_id/:type", async (req, res) => {
  const { doctor_id, type } = req.params;
  try {
    const result = await get_patients_data(doctor_id, type);
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Get detailed reports and journal entries for a specific patient
router.get("/patient-data/:patient_id", async (req, res) => {
  const { patient_id } = req.params;
  try {
    const result = await get_patient_data(patient_id);
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Update patient report after a session
router.put("/update-patient-report", async (req, res) => {
  const { doctor_id, session_data } = req.body;
  if (!doctor_id || !session_data)
    return res.status(400).json({ error: "Missing doctor_id or session_data" });

  try {
    const result = await update_patient_report(doctor_id, session_data);
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// View available time slots for a specific date
router.get("/available-time/:date/:doctor_id/:doctor_type", async (req, res) => {
  const { date, doctor_id, doctor_type } = req.params;
  try {
    const result = await view_available_time(date, doctor_id, doctor_type);
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Update available time for a doctor or life coach
router.put("/update-available-time", async (req, res) => {
  const { timestamp, doctor_id } = req.body;
  if (!timestamp || !doctor_id)
    return res.status(400).json({ error: "Missing timestamp or doctor_id" });

  try {
    const result = await update_available_time(timestamp, doctor_id);
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Get patient analytics (e.g., total patients, overall rating, returning patients)
router.get("/patient-analytics/:doctor_id/:type", async (req, res) => {
  const { doctor_id, type } = req.params;
  try {
    const result = await get_patient_analytics(doctor_id, type);
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// View all doctors of a specific type (e.g., therapists, life coaches)
router.get("/all-doctors/:doctor_type", async (req, res) => {
  const { doctor_type } = req.params;
  try {
    const result = await View_all_doctors(doctor_type);
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;
