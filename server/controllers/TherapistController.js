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

async function get_upcoming_sessions(doctor_id, type) {
  try {
    let query = "";

    if (type === "doctor") {
      query = `
        SELECT s.*, p.name AS patient_name
        FROM doctor_session s
        JOIN patient p ON s.patient_id = p.id
        WHERE s.doctor_id = ? AND s.scheduled_time > NOW()
        ORDER BY s.scheduled_time ASC
      `;
    } else {
      query = `
        SELECT *
        FROM ${type}_session
        WHERE ${type}_ID = ? AND scheduled_time > NOW()
        ORDER BY scheduled_time ASC
      `;
    }

    const result = await executeQuery(query, [doctor_id]);

    return { success: true, data: result };
  } catch (error) {
    return {
      success: false,
      message: "Error retrieving upcoming sessions.",
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
      WHERE ${type}_ID = ? AND MONTH(scheduled_time) = MONTH(CURDATE()) AND YEAR(scheduled_time) = YEAR(CURDATE())
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
    let query = "";

    if (type === "doctor") {
      query = `
        SELECT DISTINCT p.id, p.Name, p.Email, p.Gender, p.Date_Of_Birth, 
                        p.Marital_Status, p.Diagnosis, p.phone_number, s.scheduled_time , s.duration
        FROM patient p
        JOIN doctor_session s ON p.ID = s.patient_ID
        WHERE s.doctor_id = ?
        ORDER BY s.scheduled_time ASC
      `;
    } else if (type === "life_coach") {
      query = `
        SELECT DISTINCT p.id, p.Name, p.Email, p.Gender, p.Date_Of_Birth, 
                        p.Marital_Status, p.Diagnosis, p.phone_number, s.scheduled_time, s.duration
        FROM patient p
        JOIN patient_lifecoach_session pls ON p.ID = pls.patient_id
        JOIN life_coach_session s ON pls.session_id = s.session_id
        WHERE s.dr_id = ?
        ORDER BY s.scheduled_time ASC
      `;
    } else {
      return {
        success: false,
        message: "Invalid type. Expected 'doctor' or 'life_coach'.",
      };
    }

    const result = await executeQuery(query, [doctor_id]);

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
    
    const reports = await executeQuery(reportsQuery, [patient_id]);
    
    // Step 2: For each report, fetch the reporter name from the corresponding table
    for (let report of reports) {
      const reporterTable = report.reporter_type; // e.g., 'doctor'
      const reporterId = report.reporter_id;
      
      // Get the name from the respective table
      const nameQuery = `SELECT name FROM ${reporterTable} WHERE id = ? LIMIT 1`;
      const nameResult = await executeQuery(nameQuery, [reporterId]);
      
      report.reporter_name = nameResult.length > 0 ? nameResult[0].name : 'Unknown';
      
    }
      const journalQuery = `SELECT * FROM journal WHERE patient_id = ?`;
      const patientQuery = `SELECT Name,Therapist_Preference FROM patient WHERE id = ?`;
    const journals = await executeQuery(journalQuery, [patient_id]);
    const patient = await executeQuery(patientQuery, [patient_id]);
    console.log("patient : ", patient_id);
    
    return { success: true, data: { reports, journals,patient } };
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
async function view_available_time(date, doctor_id, doctor_type) {
  try {
    let query =""
    if (doctor_type === "doctor") {
      query = `
      SELECT * FROM doctor_availability
      WHERE doctor_id = ?
        AND DATE(available_date) = ?
      ORDER BY available_date ASC
    `;
    }
    else{
      query = `
      SELECT * FROM lifecoach_availability
      WHERE life_coach_id = ?
        AND DATE(available_date) = ?
      ORDER BY available_date ASC
    `;
    }
    
    const result = await executeQuery(query, [doctor_id, date]);

    return { success: true, data: result };
    }
   catch (error) {
    return {
      success: false,
      message: "Error retrieving available times.",
      error: error.message,
    };
  }
}


// Update available time for a doctor or life coach (update again 0-0)
async function update_available_time(timestamps, doctor_id, type) {
  try {
    if (!Array.isArray(timestamps) || timestamps.length === 0) {
      return { success: false, message: "No timestamps provided." };
    }

    let table = "";
    idIdentifier = ""
    if (type === "doctor") {
      table = "doctor_availability";
      idIdentifier = "doctor_ID";
    } else {
      table = "lifecoach_availability";
      idIdentifier = "life_coach_ID";

    }

    // Create placeholders (?, ?) for each row
    const placeholders = timestamps.map(() => "(?, ?)").join(", ");
    
    // Flatten parameters: [doctor_id, timestamp1, doctor_id, timestamp2, ...]
    const params = timestamps.flatMap(ts => [doctor_id, ts]);

    const query = `
      INSERT IGNORE INTO ${table} (${idIdentifier}, available_date)
      VALUES ${placeholders}
    `;

    const result = await executeQuery(query, params);

    if (result.affectedRows > 0) {
      return { success: true, message: "Availability updated successfully." };
    } else {
      return { success: true, message: "All timestamps were already inserted (duplicates ignored)." };
    }
  } catch (error) {
    return {
      success: false,
      message: "Error updating availability.",
      error: error.message,
    };
  }
}

async function delete_available_time(doctor_id, timestamp, type) {
  try {
    let query = "";

    if (type === "doctor") {
      query = `
        DELETE FROM doctor_availability
        WHERE doctor_id = ? AND available_date = ?
      `;
    } else {
      query = `
        DELETE FROM ${type}_availability
        WHERE ${type}_id = ? AND available_date = ?
      `;
    }

    const result = await executeQuery(query, [doctor_id, timestamp]);

    if (result.affectedRows > 0) {
      return { success: true, message: "Available time deleted successfully." };
    } else {
      return { success: false, message: "No matching availability found." };
    }
  } catch (error) {
    return {
      success: false,
      message: "Error deleting available time.",
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
  get_upcoming_sessions,
  get_new_patients_this_month,
  get_total_patients,
  get_patients_data,
  get_patient_data,
  update_patient_report,
  view_available_time,
  update_available_time,
  delete_available_time,
  get_patient_analytics,
  View_all_doctors,
};
