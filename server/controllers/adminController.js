const { executeQuery } = require("./databaseController"); // Adjust path if needed

// Get total doctors count
async function get_total_doctors_count() {
  try {
    const query = `SELECT COUNT(*) AS count FROM doctor`;
    const result = await executeQuery(query);

    return { success: true, data: result[0]?.count || 0 };
  } catch (error) {
    return {
      success: false,
      message: "Error retrieving doctor count.",
      error: error.message,
    };
  }
}

// Get total appointments count
async function get_total_appointment_count() {
  try {
    const query = `
      SELECT 
        (SELECT COUNT(*) FROM doctor_session) + 
        (SELECT COUNT(*) FROM life_coach_session) AS count
    `;
    const result = await executeQuery(query);

    return { success: true, data: result[0]?.count || 0 };
  } catch (error) {
    return {
      success: false,
      message: "Error retrieving appointment count.",
      error: error.message,
    };
  }
}

// Get total patients count
async function get_total_patient_count() {
  try {
    const query = `SELECT COUNT(*) AS count FROM patient`;
    const result = await executeQuery(query);

    return { success: true, data: result[0]?.count || 0 };
  } catch (error) {
    return {
      success: false,
      message: "Error retrieving patient count.",
      error: error.message,
    };
  }
}

// Get total earnings count
async function get_total_earnings_count() {
  try {
    const query = `
     SELECT 
    SUM(cost) AS total_cost
FROM (
    SELECT SUM(cost) AS cost 
    FROM doctor_session 
    UNION ALL
    SELECT lcs.cost * patient_count AS cost
    FROM life_coach_session lcs
    JOIN (
        SELECT session_ID, COUNT(patient_ID) AS patient_count
        FROM patient_lifecoach_session
        GROUP BY session_ID
    ) pls ON lcs.session_ID = pls.session_ID
) AS combined_costs;
    `;
    const result = await executeQuery(query);

    return { success: true, data: result[0] };
  } catch (error) {
    return {
      success: false,
      message: "Error retrieving earnings count.",
      error: error.message,
    };
  }
}

// Get patient visit data by month
async function get_patient_visit_data_by_month() {
  try {
    const query = `SELECT 
   MONTHNAME(cs.scheduled_time) AS month, 
    COUNT(cs.patient_ID) AS count
    FROM (
    SELECT patient_ID, scheduled_time FROM doctor_session
    UNION ALL
    SELECT patient_ID, scheduled_time
    FROM life_coach_session lcs
    JOIN patient_lifecoach_session plcs ON lcs.session_ID = plcs.session_ID
    ) AS cs
    GROUP BY month
    ORDER BY MONTH(cs.scheduled_time);
`;
    const result = await executeQuery(query);

    return { success: true, data: result };
  } catch (error) {
    return {
      success: false,
      message: "Error retrieving patient visit data.",
      error: error.message,
    };
  }
}

// // Process refund request (FROZEN FOR NOW)
// async function process_refund(id, reason) {
//   try {
//     const query = `UPDATE transactions SET status = 'refunded', refund_reason = ? WHERE id = ?`;
//     const result = await executeQuery(query, [reason, id]);

//     if (result.affectedRows > 0) {
//       return { success: true, message: "Refund processed successfully." };
//     } else {
//       return {
//         success: false,
//         message: "Refund request failed or transaction not found.",
//       };
//     }
//   } catch (error) {
//     return {
//       success: false,
//       message: "Error processing refund.",
//       error: error.message,
//     };
//   }
// }

async function search_workforce(name, type) {
  try {
    const validRoles = ["doctor", "life_coach", "emergency_team" ];

    // Validate user type
    if (!validRoles.includes(type)) {
      return { success: false, message: "Invalid user type provided." };
    }

    const query = `
      SELECT * FROM ${type}
      WHERE Name LIKE ?
    `;

    const result = await executeQuery(query, [`%${name}%`]);

    return { success: true, data: result };
  } catch (error) {
    return {
      success: false,
      message: "Error searching users.",
      error: error.message,
    };
  }
}


async function get_workforce_data(id, type) {
  try {
    const validRoles = ["doctor", "life_coach", "emergency_team"];

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

async function get_admin_data(id,type) {
 
  try {

   

    const validRoles = ["admin", "manager"];

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



async function get_booked_session_data() {
  try {
    const query = `
      SELECT 
        MONTHNAME(scheduled_time) AS month, 
        COUNT(*) AS count
      FROM (
        SELECT scheduled_time FROM doctor_session
        UNION ALL
        SELECT scheduled_time FROM life_coach_session
      ) AS combined_sessions
      GROUP BY month
      ORDER BY MONTH(scheduled_time);
    `;
    const result = await executeQuery(query);

    return { success: true, data: result };
  } catch (error) {
    return {
      success: false,
      message: "Error retrieving booked session data.",
      error: error.message,
    };
  }
}

// Get total available sessions count
async function get_available_sessions_data() {
  try {
    const query = `
      SELECT 
        (SELECT COUNT(*) FROM doctor_availability WHERE IsReserved != '1') +
        (SELECT COUNT(*) FROM lifecoach_availability WHERE IsReserved != '1') 
      AS count;
    `;
    const result = await executeQuery(query);

    return { success: true, data: result[0]?.count || 0 };
  } catch (error) {
    return {
      success: false,
      message: "Error retrieving available sessions data.",
      error: error.message,
    };
  }
}
async function get_cancelled_session_data() {
  try {
    const query = `
    SELECT 
        MONTHNAME(scheduled_time) AS month, 
        COUNT(*) AS count
    FROM (
        -- Doctor session refunded sessions
        SELECT session_id, scheduled_time
        FROM doctor_session
        WHERE refunded = TRUE

        UNION ALL

        -- Life Coach session refunded sessions
        SELECT session_id, scheduled_time
        FROM life_coach_session
        WHERE refunded = TRUE
    ) AS refunded_sessions
    GROUP BY MONTH(scheduled_time), MONTHNAME(scheduled_time)
    ORDER BY MONTH(scheduled_time);

    `;
    const result = await executeQuery(query);

    return { success: true, data: result };
  } catch (error) {
    return {
      success: false,
      message: "Error retrieving booked session data.",
      error: error.message,
    };
  }
}
async function getAllFeedbacks() {
  try {
    // Fetch all feedback records where replied = 0
    const query = `SELECT * FROM feedback WHERE replied = 0 AND rating = 1 ;`;
    const result = await executeQuery(query);

    // Iterate over the feedback records and add doctor or life coach info
    for (let feedback of result) {
      if (feedback.doctor_type === 'doctor') {
        // If doctor_type is 'doctor', get doctor info
        const doctorQuery = `SELECT Name,Email,phone_number,profile_pic_url FROM doctor WHERE id = ?`;
        const doctorData = await executeQuery(doctorQuery, [feedback.doctor_id]);

        if (doctorData.length > 0) {
          feedback.doctor_info = doctorData[0]; // Add doctor info to feedback
        } else {
          feedback.doctor_info = null; // If no doctor data found
        }
      } else if (feedback.doctor_type === 'life_coach') {
        // If doctor_type is 'life_coach', get life coach info
        const lifeCoachQuery = `SELECT Name,Email,phone_number,profile_pic_url FROM life_coach WHERE id = ?`;
        const lifeCoachData = await executeQuery(lifeCoachQuery, [feedback.doctor_id]);

        if (lifeCoachData.length > 0) {
          feedback.doctor_info = lifeCoachData[0]; // Add life coach info to feedback
        } else {
          feedback.doctor_info = null; // If no life coach data found
        }
      }

      const isRefunded = await checkRefunded(feedback.session_id,feedback.doctor_type)

      if(isRefunded){
        feedback.isRefunded = isRefunded.data;
      }

    }

    return { success: true, data: result };

  } catch (error) {
    return {
      success: false,
      message: "Error retrieving feedback data.",
      error: error.message,
    };
  }
}

async function replyFeedback(feedback_ID, Session_ID, patient_ID, doctor_type, response, IsRefunded) {
  try {
    // If refunding is true, process the refund logic
    if (IsRefunded) {
      let refundAmount = 0;

      // Process refund for doctor session
      if (doctor_type === 'doctor') {
        // Get the session cost from doctor_session table
        const sessionData = await executeQuery(
          `SELECT cost FROM doctor_session WHERE session_ID = ?`, [Session_ID]
        );

        if (sessionData.length > 0) {
          console.log("sessionData", sessionData);
          
          refundAmount = sessionData[0].cost;
          // Mark the session as refunded
          await executeQuery(
            `UPDATE doctor_session SET refunded = TRUE WHERE session_ID = ?`, [Session_ID]
          );

          // Add the refund amount to the patient's wallet
          await executeQuery(
            `UPDATE patient SET wallet = wallet + ? WHERE id = ?`, [refundAmount, patient_ID]
          );
        } else {
          return { success: false, message: 'Doctor session not found' };
        }
      }

      // Process refund for life coach session
      if (doctor_type === 'life_coach') {
        // Get the session cost from life_coach_session table
        const sessionData = await executeQuery(
          `SELECT cost FROM life_coach_session WHERE session_ID = ?`, [Session_ID]
        );

        if (sessionData.length > 0) {
          refundAmount = sessionData[0].cost;
          // Mark the life coach session as refunded
          await executeQuery(
            `UPDATE life_coach_session SET refunded = TRUE WHERE session_ID = ?`, [Session_ID]
          );

          // Get all patients who have this session
          const patientData = await executeQuery(
            `SELECT patient_ID FROM patient_lifecoach_session WHERE session_ID = ?`, [Session_ID]
          );
          console.log("patientData", patientData);
          
          // Add the refund amount to the wallet of each patient
          for (const patient of patientData) {
            await executeQuery(
              `UPDATE patient SET wallet = wallet + ? WHERE id = ?`, [refundAmount, patient.patient_ID]
            );
          }
        } else {
          return { success: false, message: 'Life Coach session not found' };
        }
      }
    }

    // Add the response to the feedback and set replied to TRUE
    await executeQuery(
      `UPDATE feedback SET response = ?, replied = TRUE WHERE feedback_id = ?`, [response, feedback_ID]
    );

    return { success: true, message: 'Feedback replied successfully' };
  } catch (error) {
    console.error('Error replying to feedback:', error);
    return {
      success: false,
      message: 'Error replying to feedback',
      error: error.message,
    };
  }
}
async function checkRefunded(session_ID,doctor_type) {
  try {
    let query="";
    if(doctor_type === 'doctor'){
       query = `SELECT refunded FROM doctor_session WHERE session_ID = ?`;
    }
    else{
       query = `SELECT refunded FROM life_coach_session WHERE session_ID = ?`;
    }
    const result = await executeQuery(query, [session_ID]);
    
    if (result.length > 0) {
      return { success: true, data: result[0].refunded };
    } else {
      return { success: false, message: "Session not found." };
    }
  } catch (error) {
    return {
      success: false,
      message: "Error checking refund status.",
      error: error.message,
    };
  }
}




module.exports = {
  get_total_doctors_count,
  get_total_appointment_count,
  get_total_patient_count,
  get_total_earnings_count,
  get_patient_visit_data_by_month,
  search_workforce,
  get_workforce_data,
  get_booked_session_data,
  get_available_sessions_data,
  get_admin_data,
  get_cancelled_session_data,
  getAllFeedbacks,
  replyFeedback,
  checkRefunded,
};
