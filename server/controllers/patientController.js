const { executeQuery } = require("./databaseController"); // adjust path if needed

// Change the patient's therapist preference
async function Change_Therapist_Preference(user, choice) {
  const query = `
    UPDATE patients
    SET therapist_preference = ?
    WHERE id = ?
  `;
  return await executeQuery(query, [choice, patient_id]);
}

// Submit feedback for a specific session
async function Make_Feedback(session_id, rating, feedback) {
  const query = `
    INSERT INTO session_feedback (session_id, rating, feedback)
    VALUES (?, ?, ?)
  `;
  return await executeQuery(query, [session_id, rating, feedback]);
}

// Create a new appointment for a patient
async function Make_an_appointment(patientData, sessionData) {
  const query = `
    INSERT INTO appointments (patient_id, therapist_id, session_type, appointment_date, appointment_time, status)
    VALUES (?, ?, ?, ?, ?, ?)
  `;
  return await executeQuery(query, [
    patientData.patient_id,
    sessionData.therapist_id,
    sessionData.session_type,
    sessionData.appointment_date,
    sessionData.appointment_time,
    "scheduled",
  ]);
}

// Get all doctor sessions a patient has taken
async function get_doctor_sessions_taken(patient_id) {
  const query = `
    SELECT *
    FROM sessions
    WHERE patient_id = ? AND session_type = 'doctor'
  `;
  return await executeQuery(query, [patient_id]);
}

// Get all group sessions a patient has participated in
async function get_group_Sessions_taken(patient_id) {
  const query = `
    SELECT gs.*
    FROM group_sessions_participants gsp
    JOIN group_sessions gs ON gsp.session_id = gs.id
    WHERE gsp.patient_id = ?
  `;
  return await executeQuery(query, [patient_id]);
}

// Get all emergency team sessions a patient has attended
async function get_emergency_team_sessions_taken(patient_id) {
  const query = `
    SELECT *
    FROM emergency_sessions
    WHERE patient_id = ?
  `;
  return await executeQuery(query, [patient_id]);
}

// Add a journal entry for a patient
async function Write_in_journal(patient_id, entry_content) {
  const query = `
    INSERT INTO journals (patient_id, entry_content, created_at)
    VALUES (?, ?, NOW())
  `;
  return await executeQuery(query, [patient_id, entry_content]);
}

// Delete a specific journal entry for a patient
async function delete_from_journal(patient_id, journal_id) {
  const query = `
    DELETE FROM journals
    WHERE id = ? AND patient_id = ?
  `;
  return await executeQuery(query, [journal_id, patient_id]);
}

module.exports = {
  Change_Therapist_Preference,
  Make_Feedback,
  Make_an_appointment,
  get_doctor_sessions_taken,
  get_group_Sessions_taken,
  get_emergency_team_sessions_taken,
  Write_in_journal,
  delete_from_journal,
};
