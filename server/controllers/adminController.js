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
        (SELECT SUM(price) FROM doctor_session ) + 
        (SELECT SUM(price) FROM life_coach_session) 
      AS count
    `;
    const result = await executeQuery(query);

    return { success: true, data: result[0]?.count || 0 };
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
    MONTHNAME(timestamp) AS month, 
    COUNT(patient_ID) AS count
    FROM (
    SELECT patient_ID, timestamp FROM doctor_session
    UNION ALL
    SELECT patient_ID, timestamp FROM life_coach_sessions
    ) AS combined_sessions
    GROUP BY month
    ORDER BY MONTH(timestamp);
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
    const validRoles = ["doctor", "life_coach", "emergency_team"];

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
async function get_booked_session_data() {
  try {
    const query = `
      SELECT 
        MONTHNAME(timestamp) AS month, 
        COUNT(*) AS count
      FROM (
        SELECT timestamp FROM doctor_session
        UNION ALL
        SELECT timestamp FROM life_coach_session
      ) AS combined_sessions
      GROUP BY month
      ORDER BY MONTH(timestamp);
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
        (SELECT COUNT(*) FROM doctor_availability WHERE IsReserved != 'true') +
        (SELECT COUNT(*) FROM life_coach_availability WHERE IsReserved != 'true') 
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
module.exports = {
  get_total_doctors_count,
  get_total_appointment_count,
  get_total_patient_count,
  get_total_earnings_count,
  get_patient_visit_data_by_month,
  search_workforce,
  get_booked_session_data,
  get_available_sessions_data,
  // process_refund,
};
