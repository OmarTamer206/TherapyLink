const { executeQuery } = require("./databaseController"); // Adjust path if needed

// View upcoming sessions for a patient
async function view_upcoming_Sessions_patient(patient_id) {
  try {
    const query = `
      SELECT * FROM ${type}_session
      WHERE patient_ID = ? AND schedule_time >= NOW()
      ORDER BY schedule_time ASC
    `;
    const result = await executeQuery(query, [patient_id]);

    return { success: true, data: result };
  } catch (error) {
    return { success: false, message: "Error retrieving upcoming sessions for patient.", error: error.message };
  }
}

// View upcoming sessions for a doctor
async function view_upcoming_Sessions_doctor(doctor_id) {
  try {
    const query = `
      SELECT * FROM ${type}_session
      WHERE ${type}_ID = ? AND schedule_time >= NOW()
      ORDER BY  schedule_time ASC
    `;
    const result = await executeQuery(query, [doctor_id]);

    return { success: true, data: result };
  } catch (error) {
    return { success: false, message: "Error retrieving upcoming sessions for doctor.", error: error.message };
  }
}

// View past sessions for a patient
async function view_old_Sessions(patient_id) {
  try {
    const query = `
      SELECT * FROM ${type}_session
      WHERE patient_ID = ? AND schedule_time < NOW()
      ORDER BY schedule_time DESC
    `;
    const result = await executeQuery(query, [patient_id]);

    return { success: true, data: result };
  } catch (error) {
    return { success: false, message: "Error retrieving old sessions for patient.", error: error.message };
  }
}

// View session details for a specific past session
async function view_old_session_details(session_id, session_type) {
  try {
    const query = `
      SELECT s.*, f.rating, f.feedback 
      FROM ${type}_session s
      LEFT JOIN feedback f ON s.id = f.${type}_session_ID
      WHERE s.ID = ? AND s.${type}_session = ?
    `;
    const result = await executeQuery(query, [session_id, session_type]);

    if (result.length > 0) {
      return { success: true, data: result[0] };
    } else {
      return { success: false, message: "Session not found or invalid session type." };
    }
  } catch (error) {
    return { success: false, message: "Error retrieving session details.", error: error.message };
  }
}

// Initialize communication for a session (could be chat or video) idk what the hell is that ಠ~ಠ
async function initialize_communication(session_id, session_type) {
  try {
    // Assume there's a `session_communication` table where sessions get assigned a communication room
    const query = `
      INSERT INTO session_communication (session_id, session_type, communication_link, created_at)
      VALUES (?, ?, CONCAT('https://chat-platform.com/room/', ?), NOW())
      ON DUPLICATE KEY UPDATE communication_link = VALUES(communication_link)
    `;
    const result = await executeQuery(query, [session_id, session_type, session_id]);

    if (result.affectedRows > 0) {
      return {
        success: true,
        message: "Communication initialized successfully.",
        link: `https://chat-platform.com/room/${session_id}`
      };
    } else {
      return { success: false, message: "Failed to initialize communication." };
    }
  } catch (error) {
    return { success: false, message: "Error initializing communication.", error: error.message };
  }
}

// Initialize an emergency session for a patient status msh mawgoda fel DB ≧☉_☉≦
async function initalize_emergency_session(patient_id) {
  try {
    const query = `
      INSERT INTO emergency_team_session (patient_ID, status, Created_at)
      VALUES (?, 'pending', NOW())
    `;
    const result = await executeQuery(query, [patient_id]);

    if (result.affectedRows > 0) {
      return { success: true, message: "Emergency session initialized successfully." };
    } else {
      return { success: false, message: "Failed to initialize emergency session." };
    }
  } catch (error) {
    return { success: false, message: "Error initializing emergency session.", error: error.message };
  }
}

module.exports = {
  view_upcoming_Sessions_patient,
  view_upcoming_Sessions_doctor,
  view_old_Sessions,
  view_old_session_details,
  initialize_communication,
  initalize_emergency_session
};
