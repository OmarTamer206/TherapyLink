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
        WHERE s.${type}_ID = ? AND DATE(s.scheduled_time) = CURDATE() AND s.isCancelled = 0 AND s.ended = 0
        ORDER BY s.scheduled_time ASC
      `;
    } else {
      query = `
        SELECT * FROM ${type}_session
        WHERE coach_ID = ? AND DATE(scheduled_time) = CURDATE() AND isCancelled = 0 AND ended = 0
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
        WHERE s.doctor_id = ? AND s.scheduled_time >= DATE_SUB(NOW(), INTERVAL 2 HOUR) AND s.isCancelled = 0 AND s.ended = 0
        ORDER BY s.scheduled_time ASC
      `;
    } else {
      query = `
        SELECT 
            lcs.*, 
            COUNT(DISTINCT pls.patient_ID) AS patient_count
        FROM 
            ${type}_session lcs
        JOIN 
            patient_lifecoach_session pls ON pls.session_ID = lcs.session_ID
        WHERE 
            lcs.coach_ID = ? 
            AND lcs.scheduled_time >= DATE_SUB(NOW(), INTERVAL 2 HOUR)
            AND lcs.isCancelled = 0 
            AND lcs.ended = 0
        GROUP BY 
            lcs.session_ID
        ORDER BY 
            lcs.scheduled_time ASC;

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
    let query = "";
    
    if (type === "doctor") {
      // Query for doctor sessions
      query = `
        SELECT COUNT(DISTINCT patient_ID) AS new_patients
        FROM doctor_session
        WHERE doctor_ID = ? AND MONTH(scheduled_time) = MONTH(CURDATE()) 
        AND YEAR(scheduled_time) = YEAR(CURDATE())
      `;
    } else if (type === "life_coach") {
      // Query for life coach sessions (patient_lifecoach_session)
      query = `
        SELECT COUNT(DISTINCT pls.patient_ID) AS new_patients
        FROM patient_lifecoach_session pls
        JOIN life_coach_session lcs ON pls.session_ID = lcs.session_ID
        WHERE lcs.coach_ID = ? 
        AND MONTH(lcs.scheduled_time) = MONTH(CURDATE()) 
        AND YEAR(lcs.scheduled_time) = YEAR(CURDATE())
      `;
    }

    // Execute the query with the appropriate ID
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
    let query = "";
    
    if (type === "doctor") {
      // Query for doctor sessions
      query = `
        SELECT COUNT(DISTINCT patient_ID) AS total_patients
        FROM doctor_session
        WHERE doctor_ID = ?
      `;
    } else if (type === "life_coach") {
      // Query for life coach sessions (patient_lifecoach_session)
      query = `
        SELECT COUNT(DISTINCT pls.patient_ID) AS total_patients
        FROM patient_lifecoach_session pls
        JOIN life_coach_session lcs ON pls.session_ID = lcs.session_ID
        WHERE lcs.coach_ID = ?
      `;
    }

    // Execute the query with the appropriate ID
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
async function get_patients_data(doctor_id, session_ID) {
  try {
    let query = "";
    
    // Query to get the patients associated with the specified session_ID
    query = `
      SELECT DISTINCT p.id, p.Name, p.Email, p.Gender, p.Date_Of_Birth, 
                      p.Marital_Status, p.Diagnosis, p.phone_number, s.scheduled_time, s.duration, s.session_ID
      FROM patient p
      JOIN patient_lifecoach_session pls ON p.ID = pls.patient_id
      JOIN life_coach_session s ON pls.session_id = s.session_id
      WHERE s.coach_ID = ? AND s.session_ID = ?
      ORDER BY s.scheduled_time ASC
    `;
    
    // Get patients data
    const result = await executeQuery(query, [doctor_id, session_ID]);
    
    // Fetch the reports, journals, and patient info for each patient
    for (let patient of result) {
      // Fetch reports for the patient
      const reportsQuery = `SELECT * FROM report WHERE patient_id = ?`;
      const reports = await executeQuery(reportsQuery, [patient.id]);
      
      // For each report, fetch the reporter's name based on reporter_type and reporter_id
      for (let report of reports) {
        const reporterTable = report.reporter_type;  // e.g., 'doctor', 'life_coach'
        const reporterId = report.reporter_id;
        
        // Get the name from the corresponding table (doctor or life_coach)
        const nameQuery = `SELECT name FROM ${reporterTable} WHERE id = ? LIMIT 1`;
        const nameResult = await executeQuery(nameQuery, [reporterId]);
        
        report.reporter_name = nameResult.length > 0 ? nameResult[0].name : 'Unknown';
      }
      
      // Fetch journals for the patient
      const journalQuery = `SELECT * FROM journal WHERE patient_id = ?`;
      const journals = await executeQuery(journalQuery, [patient.id]);
      
      // Fetch additional patient information like Therapist_Preference
      const patientQuery = `SELECT Name, Therapist_Preference FROM patient WHERE id = ?`;
      const patientInfo = await executeQuery(patientQuery, [patient.id]);
      
      // Assign the reports, journals, and patient info to the patient
      patient.reports = reports;
      patient.journals = journals;
      patient.patientInfo = patientInfo.length > 0 ? patientInfo[0] : null;
    }

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
      const patientQuery = `SELECT id ,Name,Therapist_Preference FROM patient WHERE id = ?`;
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
async function update_patient_report(report, session_data , doctor_type) {
  console.log(report, session_data , doctor_type);
  
  try {
    const query = `
      INSERT INTO report (report_content, patient_id, reporter_id, reporter_type)
      VALUES (?, ?, ?, ?)
    `;
    const result = await executeQuery(query, [
      report,
      session_data.patient_ID,
      session_data.doctor_ID,
      doctor_type,
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
        AND DATE(available_date) = ? AND full = 0 
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
async function update_available_time(timestamps, doctor_id, type, topic = null) {
  try {
    if (!Array.isArray(timestamps) || timestamps.length === 0) {
      return { success: false, message: "No timestamps provided." };
    }

    let query = "";
    let params = [];
    
    // Separate logic for doctor and life coach
    if (type === "doctor") {
      // Query for Doctor: Only doctor_ID and available_date
      query = `
        INSERT IGNORE INTO doctor_availability (doctor_ID, available_date)
        VALUES ${timestamps.map(() => "(?, ?)").join(", ")}
      `;
      
      // Flatten the parameters: [doctor_id, timestamp1, doctor_id, timestamp2, ...]
      params = timestamps.flatMap(ts => [doctor_id, ts]);

    } else if (type === "life_coach") {
      // Query for Life Coach: life_coach_ID, available_date, and topic
      query = `
        INSERT IGNORE INTO lifecoach_availability (life_coach_ID, available_date, topic)
        VALUES ${timestamps.map(() => "(?, ?, ?)").join(", ")}
      `;

      // Flatten the parameters: [life_coach_id, timestamp1, topic, life_coach_id, timestamp2, topic, ...]
      params = timestamps.flatMap(ts => [doctor_id, ts, topic]);
    }

    // Execute the query
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
        DELETE FROM lifecoach_availability
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
    let ratingQuery = "";
    let returningPatientsQuery = "";
    let totalPatientsQuery = "";

    if (type === "doctor") {
      // Get rating count for doctor
      ratingQuery = `
        SELECT 
            rating, 
            COUNT(*) AS rating_count
        FROM feedback
        WHERE doctor_id = ? AND doctor_type = 'doctor'
        GROUP BY rating;
      `;

      // Get returning patients by month for doctor
      returningPatientsQuery = `
        SELECT 
            COUNT(DISTINCT patient_ID) AS total_patients, 
            COUNT(DISTINCT CASE WHEN session_count > 1 THEN patient_ID END) AS returning_patients
        FROM (
            SELECT patient_ID, COUNT(*) AS session_count
            FROM doctor_session
            WHERE doctor_ID = ?
            GROUP BY patient_ID
        ) AS patient_sessions;


      `;

      // Get total patients by month for doctor
      totalPatientsQuery = `
        SELECT 
            MONTH(ds.scheduled_time) AS session_month,
            COUNT(DISTINCT ds.patient_ID) AS total_patients
        FROM doctor_session ds
        WHERE ds.doctor_ID = ?
        GROUP BY session_month;
      `;
    } else if (type === "life_coach") {
      // Get rating count for life coach
      ratingQuery = `
        SELECT 
            rating, 
            COUNT(*) AS rating_count
        FROM feedback
        WHERE doctor_id = ? AND doctor_type = 'life_coach'
        GROUP BY rating;
      `;

      // Get returning patients by month for life coach
      returningPatientsQuery = `
        SELECT 
            COUNT(DISTINCT pls.patient_ID) AS total_patients,
            COUNT(DISTINCT CASE WHEN patient_sessions.session_count > 1 THEN pls.patient_ID END) AS returning_patients
        FROM patient_lifecoach_session pls
        JOIN life_coach_session lcs ON pls.session_ID = lcs.session_ID
        JOIN (
            SELECT patient_ID, COUNT(*) AS session_count
            FROM patient_lifecoach_session
            WHERE session_ID IN (SELECT session_ID FROM life_coach_session WHERE coach_ID = ?)
            GROUP BY patient_ID
        ) AS patient_sessions ON pls.patient_ID = patient_sessions.patient_ID
        WHERE lcs.coach_ID = ? 
        AND lcs.scheduled_time >= CURDATE()



      `;

      // Get total patients by month for life coach
      totalPatientsQuery = `
        SELECT 
            MONTH(lcs.scheduled_time) AS session_month,
            COUNT(DISTINCT pls.patient_ID) AS total_patients
        FROM patient_lifecoach_session pls
        JOIN life_coach_session lcs ON pls.session_ID = lcs.session_ID
        WHERE lcs.coach_ID = ?
        GROUP BY session_month;
      `;
    }

    // Execute all queries in parallel
    const ratingResult = await executeQuery(ratingQuery, [doctor_id]);
    const returningPatientsResult = await executeQuery(returningPatientsQuery, [doctor_id, doctor_id]);
    const totalPatientsResult = await executeQuery(totalPatientsQuery, [doctor_id]);

    const ratingCounts = ratingResult.reduce((acc, { rating, rating_count }) => {
      acc[rating] = rating_count;  // Set rating as key and rating_count as value
      return acc;
    }, {});

    const TotalPatientsByMonth = totalPatientsResult.reduce((acc, { session_month, total_patients }) => {
      acc[session_month] = total_patients;  // Set session_month as key and returning_patients as value
      return acc;
    }, {});

    // Return the results
    return {
      success: true,
      ratingCounts , returningPatientsResult , TotalPatientsByMonth 
      
    };
  } catch (error) {
    return {
      success: false,
      message: "Error retrieving data.",
      error: error.message,
    };
  }
}


async function get_therapist_data(id,type) {
 
  try {

   

    const validRoles = ["doctor", "life_coach"];

    // Validate user type
    if (!validRoles.includes(type)) {
      return { success: false, message: "Invalid user type provided." };
    }

    const query = `
      SELECT * FROM ${type}
      WHERE id = ?
    `;

    const result = await executeQuery(query, [id]);

    return { success: true, data: result };
  } catch (error) {
    return {
      success: false,
      message: "Error searching users.",
      error: error.message,
    };
  }
}






// View all doctors of a specific type (e.g., therapists, life coaches)
async function View_all_doctors(doctor_type, doctor_specialization) {
  try {
    let doctorQuery;
    let feedbackQuery;

    // Step 1: Check doctor_type and create dynamic queries
    if (doctor_type === 'doctor') {
      doctorQuery = `
        SELECT id , Name, Specialization, Description, id , Session_price
        FROM doctor
        WHERE Specialization = ?;
      `;
      feedbackQuery = `
        SELECT reason, rating, doctor_id
        FROM feedback
        WHERE doctor_id = ? AND doctor_type = "doctor";
      `;
    } else if (doctor_type === 'life_coach') {
      doctorQuery = `
        SELECT id ,Name, Specialization, Description, id , Session_price
        FROM life_coach
        WHERE Specialization = ?;
      `;
      feedbackQuery = `
        SELECT reason , rating, doctor_id
        FROM feedback
        WHERE doctor_id = ? AND doctor_type = 'life_coach';
      `;
    } else {
      throw new Error("Invalid doctor type");
    }

    // Step 2: Query the doctor information
    const doctorResult = await executeQuery(doctorQuery, [doctor_specialization]);
    const doctorData = [];

    for (const doctor of doctorResult) {
      // Get the feedback for each doctor
      const feedbackResult = await executeQuery(feedbackQuery, [doctor.id]);

      // Format the doctor object with reviews and calculate average rating
      const reviews = feedbackResult.map((feedback) => ({
        content: feedback.reason,
        rating: feedback.rating
      }));

      const totalRating = reviews.reduce((sum, review) => sum + review.rating, 0);
      const avgRating = reviews.length > 0 ? (totalRating / reviews.length).toFixed(2) : 0;

      doctorData.push({
        doctor_data: {
          id: doctor.id,
          Name: doctor.Name,
          Specialization: doctor.Specialization,
          Description: doctor.Description,
          Session_price : doctor.Session_price
        },
        reviews: reviews,
        avgRating: avgRating
      });
    }

    return { success: true, data: doctorData };
  } catch (error) {
    return {
      success: false,
      message: "Error retrieving doctor list with reviews.",
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
  get_therapist_data,
  View_all_doctors,
};
