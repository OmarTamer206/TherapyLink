const { executeQuery } = require("./databaseController"); // Adjust path if needed

// Change the patient's therapist preference
async function Change_Therapist_Preference(patient_ID, choice) {
  try {
    const query = `
      UPDATE patient
      SET Therapist_Preference = ?
      WHERE id = ?
    `;
    const result = await executeQuery(query, [choice, patient_ID]);

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

// Submit feedback for a specific session asdasdasd    3adelah
async function Make_Feedback(patient_ID , session, rating, feedback , editState) {
  try {

    let query
    let result
    
    if(!editState){
       query = `
      INSERT INTO feedback (patient_ID,session_ID,doctor_type, doctor_ID , rating , reason)
      VALUES (? , ?, ?, ? , ? , ? )
    `;

    result = await executeQuery(query, [patient_ID , session.session_ID , session.session_type , session.doctor_ID , rating , feedback]);
    
  }
    else{
       query = `
      UPDATE feedback SET rating = ? , reason = ?
      WHERE patient_ID = ? AND session_ID = ? AND doctor_type = ? AND doctor_ID = ?
    `;

    result = await executeQuery(query, [ rating , feedback , patient_ID , session.session_ID , session.session_type , session.doctor_ID ]);

    }
    
    

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

async function check_Feedback(patient_ID , session_ID , session_type) {
  try {

    
    
    const query = `
      SELECT * FROM feedback WHERE patient_id = ? AND session_id = ? AND doctor_type = ?
    `;
    const result = await executeQuery(query, [patient_ID , session_ID , session_type]);

  
      return { success: true, message: "Feedback submitted successfully." , data: result };
  
  } catch (error) {
    return {
      success: false,
      message: "Error submitting feedback.",
      error: error.message,
    };
  }
}

// Create a new appointment for a patient (DOCTOR)
async function Make_an_appointment(patient_ID, sessionData) {
  try {
    let result;
    let sessionID;

    // Doctor session handling
    if (sessionData.type === "doctor") {
      let query = `UPDATE doctor_availability SET isReserved = 1 WHERE doctor_ID = ? AND available_date = ?`;
      
      await executeQuery(query, [
        sessionData.doctor_id,
        sessionData.time,
      ]);

      query = `
        INSERT INTO ${sessionData.type}_session (patient_ID, ${sessionData.type}_ID, communication_type, scheduled_time, cost , duration )
        VALUES (?, ?, ?, ?, ?, ?)
      `;
      result = await executeQuery(query, [
        patient_ID,
        sessionData.doctor_id,
        sessionData.com_type,
        sessionData.time,
        sessionData.cost,
        sessionData.duration,
      ]);

      // If the communication type is chat, create an entry in the chat table
      if (sessionData.com_type === 'Chatting') {
        // Insert into the chat table
        query = `INSERT INTO chat () VALUES ()`; // Empty insert to create a chat entry
        const chatResult = await executeQuery(query);
        
        // Update the session with the generated chat_id
        await executeQuery(`UPDATE ${sessionData.type}_session SET chat_id = ? WHERE session_ID = ?`, [chatResult.insertId, result.insertId]);
      } 
      // If the communication type is call, create an entry in the call table
      else if (sessionData.com_type === 'Voice / Video Call') {
        // Insert into the call table
        query = `INSERT INTO \`call\` () VALUES ()`; // Empty insert to create a call entry
        const callResult = await executeQuery(query);
        
        // Update the session with the generated call_id
        await executeQuery(`UPDATE ${sessionData.type}_session SET call_id = ? WHERE session_ID = ?`, [callResult.insertId, result.insertId]);
      }
    } 
    // Life coach session handling
    else {
      let query = `UPDATE lifecoach_availability SET isReserved = 1 WHERE life_coach_ID = ? AND available_date = ?`;

      await executeQuery(query, [
        sessionData.doctor_id,
        sessionData.time,
      ]);

      query = `
        SELECT session_ID 
        FROM ${sessionData.type}_session 
        WHERE coach_ID = ? 
        AND scheduled_time = ?;
      `;

      result = await executeQuery(query, [
        sessionData.doctor_id,
        sessionData.time,
      ]);
      console.log(sessionData);

      
      // If session exists, get its session_ID, else insert a new session
      if (result.length > 0) {
        sessionID = result[0].session_ID;
      } else {
        query = `
          INSERT INTO ${sessionData.type}_session (coach_ID, scheduled_time, cost, duration, topic) 
          VALUES (?, ?, ?, ?, ?);
        `;
        result = await executeQuery(query, [
          sessionData.doctor_id,
          sessionData.time,
          sessionData.cost,
          sessionData.duration,
          sessionData.topic,
        ]);

        sessionID = result.insertId;
      }

      query = `SELECT COUNT(*) AS count
               FROM patient_lifecoach_session
               WHERE session_ID = ?`;

      const countCheck = await executeQuery(query, [sessionID]);
      console.log("count : ", countCheck[0].count);

      // LIMITED TO 20 PATIENT ONLY IN THE GROUP SESSION
      if (countCheck[0].count === 19) {
        query = `UPDATE lifecoach_availability SET full = 1 WHERE life_coach_ID = ? AND available_date = ?`;
        await executeQuery(query, [
          sessionData.doctor_id,
          sessionData.time,
        ]);
      }

      // Step 4: Insert into patient_lifecoach_session with patient_ID and session_ID
      query = `
        INSERT IGNORE INTO patient_lifecoach_session (patient_ID, session_ID) 
        VALUES (?, ?);
      `;
      result = await executeQuery(query, [patient_ID, sessionID]);
      
      if (result.affectedRows === 1) {
  console.log("Insertion successful.");
} else {
  console.log("Insertion was ignored (probably duplicate).");
}

      // Insert into the call table for life coach (if applicable)
      query = `INSERT INTO \`call\` () VALUES ()`;
      const callResult = await executeQuery(query, [sessionID]);

      // Add call_id to the session
      await executeQuery(`UPDATE ${sessionData.type}_session SET call_id = ? WHERE session_ID = ?`, [callResult.insertId, sessionID]);
    }

    if (result.affectedRows > 0) {
      return { success: true,duplciate : false, message: "Appointment scheduled successfully." };
    } 
    else if (result.affectedRows == 0) {
      return { success: true,duplciate : true, message: "Appointment is already schedulled." };
    } 
    else {
      return { success: false,duplciate : false, message: "Failed to schedule appointment." };
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
      FROM patient_lifecoach_session pls
      JOIN life_coach_session lcs ON pls.session_ID = lcs.session_ID
      WHERE pls.patient_ID = ?
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
      WHERE journal_ID = ?
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

async function getProfileData(patient_ID){

 try {
    const reportsQuery = `SELECT * FROM report WHERE patient_id = ?`;
    
    const reports = await executeQuery(reportsQuery, [patient_ID]);
    
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
      const patientQuery = `SELECT * FROM patient WHERE id = ?`;
    const journals = await executeQuery(journalQuery, [patient_ID]);
    const patient = await executeQuery(patientQuery, [patient_ID]);
    console.log("patient : ", patient_ID);
    
    return { success: true, data: { reports, journals,patient } };
  } catch (error) {
    return {
      success: false,
      message: "Error retrieving patient data.",
      error: error.message,
    };
  }

}

async function changeFirstLogin(patient_ID){

  try {
    const query = `
      UPDATE patient
      SET first_time_login = 0
      WHERE id = ?
    `;
    const result = await executeQuery(query, [patient_ID]);

    if (result.affectedRows > 0) {
      return { success: true, message: "First login status updated successfully." };
    } else {
      return { success: false, message: "No changes made. Patient not found or already updated." };
    }
  } catch (error) {
    return {
      success: false,
      message: "Failed to update first login status.",
      error: error.message,
    };
  }

}

module.exports = {
  Change_Therapist_Preference,
  Make_Feedback,
  check_Feedback,
  Make_an_appointment,
  get_doctor_sessions_taken,
  get_group_Sessions_taken,
  get_emergency_team_sessions_taken,
  Write_in_journal,
  delete_from_journal,
  getProfileData,
  changeFirstLogin
};
