const { executeQuery } = require("./databaseController"); // Adjust path if needed

// Change the patient's therapist preference
async function Change_Therapist_Preference(user, choice) {
  try {
    const query = `
      UPDATE patient
      SET Therapist_Preference = ?
      WHERE id = ?
    `;
    const result = await executeQuery(query, [choice, user.id]);

    if (result.affectedRows > 0) {
      return {
        success: true,
        message: "Therapist preference updated successfully.",
      };
    } else {
      return {
        success: false,
        message: "No changes made. Patient not found or preference unchanged.",
      };
    }
  } catch (error) {
    return {
      success: false,
      message: "Failed to update therapist preference.",
      error: error.message,
    };
  }
}

// Submit feedback for a specific session
async function Make_Feedback(session, rating, feedback) {
  try {
    const query = `
      INSERT INTO ${session.type}_session (session_ID, rating, feedback)
      VALUES (?, ?, ?)
    `;
    const result = await executeQuery(query, [session.id, rating, feedback]);

    if (result.affectedRows > 0) {
      return { success: true, message: "Feedback submitted successfully." };
    } else {
      return { success: false, message: "Failed to submit feedback." };
    }
  } catch (error) {
    return {
      success: false,
      message: "Error submitting feedback.",
      error: error.message,
    };
  }
}

// Create a new appointment for a patient
async function Make_an_appointment(patientData, sessionData) {
  try {
    const query = `
      INSERT INTO ${sessionData.type}_session (patient_ID, ${sessionData.type}_ID, communication_type, scheduled_time, cost , duration )
      VALUES (?, ?, ?, ?, ?, ?)
    `;
    const result = await executeQuery(query, [
      patientData.id,
      sessionData.id,
      sessionData.com_type,
      sessionData.time,
      sessionData.cost,
      sessionData.duration,
    ]);

    if (result.affectedRows > 0) {
      return { success: true, message: "Appointment scheduled successfully." };
    } else {
      return { success: false, message: "Failed to schedule appointment." };
    }
  } catch (error) {
    return {
      success: false,
      message: "Error scheduling appointment.",
      error: error.message,
    };
  }
}

// Get all doctor sessions a patient has taken
async function get_doctor_sessions_taken(patient_id) {
  try {
    const query = `
      SELECT *
      FROM doctor_session
      WHERE patient_ID = ? 
    `;
    const result = await executeQuery(query, [patient_id]);

    return { success: true, data: result };
  } catch (error) {
    return {
      success: false,
      message: "Error retrieving doctor sessions.",
      error: error.message,
    };
  }
}

// Get all group sessions a patient has participated in
async function get_group_Sessions_taken(patient_id) {
  try {
    const query = `
      SELECT *
      FROM 	patient_lifecoach_session
      JOIN 	life_coach_session ON patient_ID = session_ID
      WHERE patient_ID = ?
    `;
    const result = await executeQuery(query, [patient_id]);

    return { success: true, data: result };
  } catch (error) {
    return {
      success: false,
      message: "Error retrieving group sessions.",
      error: error.message,
    };
  }
}

// Get all emergency team sessions a patient has attended
async function get_emergency_team_sessions_taken(patient_id) {
  try {
    const query = `
      SELECT *
      FROM emergency_team_session
      WHERE patient_ID = ?
    `;
    const result = await executeQuery(query, [patient_id]);

    return { success: true, data: result };
  } catch (error) {
    return {
      success: false,
      message: "Error retrieving emergency team sessions.",
      error: error.message,
    };
  }
}

// Add a journal entry for a patient
async function Write_in_journal(patient_id, entry_content) {
  try {
    const query = `
      INSERT INTO journal (patient_ID, journal_content, time  )
      VALUES (?, ?, NOW())
    `;
    const result = await executeQuery(query, [patient_id, entry_content]);

    if (result.affectedRows > 0) {
      return { success: true, message: "Journal entry added successfully." };
    } else {
      return { success: false, message: "Failed to add journal entry." };
    }
  } catch (error) {
    return {
      success: false,
      message: "Error adding journal entry.",
      error: error.message,
    };
  }
}

// Delete a specific journal entry for a patient
async function delete_from_journal(journal_id) {
  try {
    const query = `
      DELETE FROM journal
      WHERE id = ?
    `;
    const result = await executeQuery(query, [journal_id]);

    if (result.affectedRows > 0) {
      return { success: true, message: "Journal entry deleted successfully." };
    } else {
      return {
        success: false,
        message: "Journal entry not found or already deleted.",
      };
    }
  } catch (error) {
    return {
      success: false,
      message: "Error deleting journal entry.",
      error: error.message,
    };
  }
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
