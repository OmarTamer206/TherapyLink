const { executeQuery } = require("./databaseController");

// Get average patient count per day
async function get_average_patients_count_per_day() {
  try {
    const query = `
    SELECT AVG(daily_count) AS count 
    FROM (
      SELECT DATE(timestamp) AS day, COUNT(patient_ID) AS daily_count 
      FROM doctor_session 
      GROUP BY day
      UNION ALL
      SELECT DATE(timestamp) AS day, COUNT( patient_ID) AS daily_count 
      FROM life_coach_sessions 
      GROUP BY day
    ) AS combined_sessions;
  `;
    const result = await executeQuery(query);

    return { success: true, data: result[0]?.count || 0 };
  } catch (error) {
    return {
      success: false,
      message: "Error retrieving average patient count.",
      error: error.message,
    };
  }
}

// Get total profit count
async function get_total_profit_count() {
  try {
    const query = `
      SELECT 
        (SELECT COALESCE(SUM(price) * 0.10, 0) FROM doctor_session ) + 
        (SELECT COALESCE(SUM(price) * 0.10, 0) FROM life_coach_session ) 
        - 
        (SELECT COALESCE(SUM(salary), 0) FROM admin) 
        - 
        (SELECT COALESCE(SUM(salary), 0) FROM manager) 
        - 
        (SELECT COALESCE(SUM(salary), 0) FROM emergency_team) 
      AS count;
    `;
    const result = await executeQuery(query);

    return { success: true, data: result[0]?.count || 0 };
  } catch (error) {
    return {
      success: false,
      message: "Error retrieving total profit count.",
      error: error.message,
    };
  }
}

// Get total salaries expense count
async function get_total_salaries_expense_count() {
  try {
    const query = `SELECT  
        (SELECT COALESCE(SUM(salary), 0) FROM admin) 
        +
        (SELECT COALESCE(SUM(salary), 0) FROM manager) 
        + 
        (SELECT COALESCE(SUM(salary), 0) FROM emergency_team) 
      AS count;`;
    const result = await executeQuery(query);

    return { success: true, data: result[0]?.count || 0 };
  } catch (error) {
    return {
      success: false,
      message: "Error retrieving salary expense count.",
      error: error.message,
    };
  }
}

// Get total revenue count
async function get_total_revenue_count() {
  try {
    const query = `(SELECT COALESCE(SUM(price) * 0.10, 0) FROM doctor_session ) + 
        (SELECT COALESCE(SUM(price) * 0.10, 0) FROM life_coach_session ) `;
    const result = await executeQuery(query);

    return { success: true, data: result[0]?.count || 0 };
  } catch (error) {
    return {
      success: false,
      message: "Error retrieving total revenue count.",
      error: error.message,
    };
  }
}

// Report generator for dynamic reports
async function report_generator(factor, report_type, date_from, date_to) {
  try {
    let query;
    switch (factor) {
      case "patients":
        query = `SELECT DATE(date) AS date, COUNT(*) AS count FROM patient_visits WHERE date BETWEEN ? AND ? GROUP BY date`;
        break;
      case "sessions":
        query = `SELECT DATE(date) AS date, COUNT(*) AS count FROM sessions WHERE date BETWEEN ? AND ? GROUP BY date`;
        break;
      case "revenue":
        query = `SELECT DATE(date) AS date, SUM(price) * 0.10 AS count FROM sessions WHERE date BETWEEN ? AND ? GROUP BY date`;
        break;
      default:
        throw new Error("Invalid report factor");
    }
    const result = await executeQuery(query, [date_from, date_to]);

    return { success: true, data: result };
  } catch (error) {
    return {
      success: false,
      message: "Error generating report.",
      error: error.message,
    };
  }
}
// Get total revenue per month (10% of completed session prices)
async function get_total_revenue_by_month() {
  try {
    const query = `
      SELECT 
        MONTHNAME(timestamp) AS month, 
        SUM(price) * 0.10 AS revenue
      FROM (
        SELECT price, timestamp FROM doctor_session
        UNION ALL
        SELECT price, timestamp FROM life_coach_session
      ) AS all_sessions
      GROUP BY MONTH(timestamp), MONTHNAME(timestamp)
      ORDER BY MONTH(timestamp);
    `;
    const result = await executeQuery(query);

    return { success: true, data: result };
  } catch (error) {
    return {
      success: false,
      message: "Error retrieving total revenue by month.",
      error: error.message,
    };
  }
}

// Get total expenses per month (salaries of workforce)
async function get_total_expense_by_month() {
  try {
    const query = `
      SELECT 
        MONTHNAME(Created_at) AS month, 
        SUM(salary) AS expenses
      FROM (
        SELECT salary, Created_at FROM admin
        UNION ALL
        SELECT salary, Created_at FROM manager
        UNION ALL
        SELECT salary, Created_at FROM emergency_team
      ) AS workforce_salaries
      GROUP BY MONTH(Created_at), MONTHNAME(Created_at)
      ORDER BY MONTH(Created_at);
    `;
    const result = await executeQuery(query);

    return { success: true, data: result };
  } catch (error) {
    return {
      success: false,
      message: "Error retrieving total expenses by month.",
      error: error.message,
    };
  }
}
async function search_admin(name) {
  try {
    // Validate user type

    const query = `
      SELECT * FROM admin
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

module.exports = {
  get_average_patients_count_per_day,
  get_total_profit_count,
  get_total_salaries_expense_count,
  get_total_revenue_count,
  search_admin,
  get_total_revenue_by_month,
  get_total_expense_by_month,
  report_generator,
};
