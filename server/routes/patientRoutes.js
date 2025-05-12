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
} = require("../controllers/patientController");

const router = express.Router();

// Change therapist preference for a patient
router.put("/change-therapist-preference", async (req, res) => {
  const { user, choice } = req.body;
  if (!user || !choice)
    return res.status(400).json({ error: "User and choice are required" });

  try {
    const result = await Change_Therapist_Preference(user, choice);
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Submit feedback for a specific session
router.post("/submit-feedback", async (req, res) => {
  const { session, rating, feedback } = req.body;
  if (!session || !rating || !feedback)
    return res.status(400).json({ error: "Missing session, rating or feedback" });

  try {
    const result = await Make_Feedback(session, rating, feedback);
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Create a new appointment for a patient
router.post("/make-appointment", async (req, res) => {
  const { patientData, sessionData } = req.body;
  if (!patientData || !sessionData)
    return res.status(400).json({ error: "Missing patient or session data" });

  try {
    const result = await Make_an_appointment(patientData, sessionData);
    res.status(201).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Get all doctor sessions a patient has taken
router.get("/doctor-sessions/:patient_id", async (req, res) => {
  const { patient_id } = req.params;
  try {
    const result = await get_doctor_sessions_taken(patient_id);
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Get all group sessions a patient has participated in
router.get("/group-sessions/:patient_id", async (req, res) => {
  const { patient_id } = req.params;
  try {
    const result = await get_group_Sessions_taken(patient_id);
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Get all emergency team sessions a patient has attended
router.get("/emergency-team-sessions/:patient_id", async (req, res) => {
  const { patient_id } = req.params;
  try {
    const result = await get_emergency_team_sessions_taken(patient_id);
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Add a journal entry for a patient
router.post("/write-journal", async (req, res) => {
  const { patient_id, entry_content } = req.body;
  if (!patient_id || !entry_content)
    return res.status(400).json({ error: "Patient ID and entry content required" });

  try {
    const result = await Write_in_journal(patient_id, entry_content);
    res.status(201).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
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
    res.status(500).json({ error: error.message });
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
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;
