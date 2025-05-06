const { executeQuery } = require("./databaseController"); // Adjust path if needed

// Get today's sessions for a specific doctor or life coach
async function get_today_sessions(doctor_id, type) {
  try {
    let query = "";

    if (type === "doctor") {
      query = `
        SELECT s.*, p.name AS patient_name
        FROM ${type}_session s
        JOIN patient p ON s.patient_id = p.id
        WHERE s.${type}_ID = ? AND DATE(s.scheduled_time) = CURDATE()
        ORDER BY s.scheduled_time ASC
      `;
    } else {
      query = `
        SELECT * FROM ${type}_session
        WHERE ${type}_ID = ? AND DATE(scheduled_time) = CURDATE()
        ORDER BY scheduled_time ASC
      `;
    }

    const result = await executeQuery(query, [doctor_id]);

    return { success: true, data: result };
  } catch (error) {
    return {
      success: false,
      message: "Error retrieving today's sessions.",
      error: error.message,
    };
  }
}


// Get new patients registered this month for a specific doctor or life coach
async function get_new_patients_this_month(doctor_id, type) {
  try {
    const query = `
      SELECT COUNT(DISTINCT patient_ID) AS new_patients
      FROM ${type}_session
      WHERE ${type}_ID = ? AND MONTH(schedule_time) = MONTH(CURDATE()) AND YEAR(schedule_time) = YEAR(CURDATE())
    `;
    const result = await executeQuery(query, [doctor_id]);

    return { success: true, data: result[0] };
  } catch (error) {
    return {
      success: false,
      message: "Error retrieving new patients for this month.",
      error: error.message,
    };
  }
}

// Get total patients for a specific doctor or life coach
async function get_total_patients(doctor_id, type) {
  try {
    const query = `
      SELECT COUNT(DISTINCT patient_ID) AS total_patients
      FROM ${type}_session
      WHERE ${type}_ID = ?
    `;
    const result = await executeQuery(query, [doctor_id]);

    return { success: true, data: result[0] };
  } catch (error) {
    return {
      success: false,
      message: "Error retrieving total patients.",
      error: error.message,
    };
  }
}

// Get patient list for a doctor or life coach
async function get_patients_data(doctor_id, type) {
  try {
    const query = `
      SELECT DISTINCT p.id, p.Name, p.Email, p.Gender, p.Date_Of_Birth, p.Martial_Status, p.Diagnosis, p.phone_number
      FROM patient p
      JOIN ${type}_session s ON p.ID = s.patient_ID
      WHERE s.doctor_id = ? AND s.session_type = ?
    `;
    const result = await executeQuery(query, [doctor_id, type]);

    return { success: true, data: result };
  } catch (error) {
    return {
      success: false,
      message: "Error retrieving patient data.",
      error: error.message,
    };
  }
}

// Get detailed reports and journal entries for a specific patient (mehtag a3rf al name bta3 al doctor dah)(8aleban hanhtag join bs dynamic)
async function get_patient_data(patient_id) {
  try {
    const reportsQuery = `SELECT * FROM report WHERE patient_id = ?`;
    const journalQuery = `SELECT * FROM journal WHERE patient_id = ?`;

    const reports = await executeQuery(reportsQuery, [patient_id]);
    const journals = await executeQuery(journalQuery, [patient_id]);

    return { success: true, data: { reports, journals } };
  } catch (error) {
    return {
      success: false,
      message: "Error retrieving patient data.",
      error: error.message,
    };
  }
}

// Update patient report after a session(UPDATE DB 0_-)
async function update_patient_report(doctor_id, session_data) {
  try {
    const query = `
      INSERT INTO patient_reports (doctor_id, patient_id, session_id, report_content, created_at)
      VALUES (?, ?, ?, ?, NOW())
      ON DUPLICATE KEY UPDATE report_content = VALUES(report_content), updated_at = NOW()
    `;
    const result = await executeQuery(query, [
      doctor_id,
      session_data.patient_id,
      session_data.session_id,
      session_data.report_content,
    ]);

    if (result.affectedRows > 0) {
      return { success: true, message: "Patient report updated successfully." };
    } else {
      return { success: false, message: "Failed to update patient report." };
    }
  } catch (error) {
    return {
      success: false,
      message: "Error updating patient report.",
      error: error.message,
    };
  }
}

// View available time slots for a specific date
async function view_available_time(date, doctor_id,doctor_type) {
  try {
    const query = `
      SELECT * FROM ${doctor_type}_availability
      WHERE ${doctor_type}_id = ? AND Available_date = ?
    `;
    const result = await executeQuery(query, [doctor_id, date]);

    return { success: true, data: result };
  } catch (error) {
    return {
      success: false,
      message: "Error retrieving available times.",
      error: error.message,
    };
  }
}

// Update available time for a doctor or life coach (update again 0-0)
async function update_available_time(timestamp, doctor_id) {
  try {
    const query = `
      INSERT INTO doctor_availability (doctor_id, available_timestamp)
      VALUES (?, ?)
      ON DUPLICATE KEY UPDATE available_timestamp = VALUES(available_timestamp)
    `;
    const result = await executeQuery(query, [doctor_id, timestamp]);

    if (result.affectedRows > 0) {
      return { success: true, message: "Availability updated successfully." };
    } else {
      return { success: false, message: "Failed to update availability." };
    }
  } catch (error) {
    return {
      success: false,
      message: "Error updating availability.",
      error: error.message,
    };
  }
}
//U DO IT :-
async function get_patient_analytics(doctor_id, type) {
  try {
    const query = `
      SELECT 
        COUNT(DISTINCT s.patient_id) AS total_patients,
        (SELECT AVG(f.rating) FROM session_feedback f 
         JOIN sessions s2 ON f.session_id = s2.id 
         WHERE s2.doctor_id = ? AND s2.session_type = ?) AS overall_rating,
        COUNT(*) AS total_sessions,
        COUNT(DISTINCT CASE WHEN patient_visits > 1 THEN patient_id END) AS returning_patients
      FROM (
        SELECT patient_id, COUNT(*) AS patient_visits, MONTH(session_date) AS session_month
        FROM sessions
        WHERE doctor_id = ? AND session_type = ?
        GROUP BY patient_id, session_month
      ) AS patient_data;
    `;

    const result = await executeQuery(query, [
      doctor_id,
      type,
      doctor_id,
      type,
    ]);

    return { success: true, data: result[0] };
  } catch (error) {
    return {
      success: false,
      message: "Error retrieving patient analytics.",
      error: error.message,
    };
  }
}

// View all doctors of a specific type (e.g., therapists, life coaches)
async function View_all_doctors(doctor_type) {
  try {
    const query = `
      SELECT id, name, specialization, experience_years, contact_info
      FROM ${type}_session
      WHERE ${type} = ?
    `;
    const result = await executeQuery(query, [doctor_type]);

    return { success: true, data: result };
  } catch (error) {
    return {
      success: false,
      message: "Error retrieving doctor list.",
      error: error.message,
    };
  }
}

module.exports = {
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
};
