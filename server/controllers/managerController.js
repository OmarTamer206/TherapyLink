const { executeQuery } = require("./databaseController");

// Get average patient count per day
async function get_average_patients_count_per_day() {
  try {
    const query = `
    SELECT AVG(daily_count) AS count
FROM (
  -- Doctor Sessions
  SELECT DATE(scheduled_time) AS day, COUNT(patient_ID) AS daily_count
  FROM doctor_session
  GROUP BY day

  UNION ALL

  -- Life Coach Sessions
  SELECT DATE(lcs.scheduled_time) AS day, COUNT(pls.patient_ID) AS daily_count
  FROM life_coach_session lcs
  JOIN patient_lifecoach_session pls ON lcs.session_ID = pls.session_ID
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

// Get total profit count bna5od 30% of the price of the session and subtract the salaries of the workforce
async function get_total_profit_count() {
  try {
    const query = `
      SELECT 
    (SELECT COALESCE(SUM(cost) * 0.30, 0) FROM doctor_session ) + 
    (SELECT COALESCE(SUM(lcs.cost) * 0.30 * COUNT(pls.patient_ID), 0) 
     FROM life_coach_session lcs 
     JOIN patient_lifecoach_session pls ON lcs.session_ID = pls.session_ID) 
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
    const query = `SELECT 
    (SELECT COALESCE(SUM(cost) * 0.30, 0) FROM doctor_session ) + 
    (SELECT COALESCE(SUM(lcs.cost) * 0.30 * COUNT(pls.patient_ID), 0) 
     FROM life_coach_session lcs 
     JOIN patient_lifecoach_session pls ON lcs.session_ID = pls.session_ID) 
     AS count `;
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
async function report_generator(queryOption, dateFrom, dateTo ) {
  try {
    let query;
    console.log(queryOption, dateFrom, dateTo);
    

    switch (queryOption) {
      case 'Revenue':
        query = `
          SELECT 
              MONTHNAME(scheduled_time) AS month, 
              SUM(revenue) AS count
          FROM (
           
              SELECT cost * 0.30 AS revenue, scheduled_time 
              FROM doctor_session
              WHERE scheduled_time BETWEEN '${dateFrom}-1' AND '${dateTo}-1' 

              UNION ALL

             
              SELECT 
                  lcs.cost * 0.30 * COUNT(pls.patient_ID) AS revenue, 
                  lcs.scheduled_time
              FROM 
                  life_coach_session lcs
              JOIN 
                  patient_lifecoach_session pls 
              ON 
                  lcs.session_ID = pls.session_ID
              WHERE lcs.scheduled_time BETWEEN '${dateFrom}-1' AND '${dateTo}-1' 
              GROUP BY 
                  lcs.session_ID, lcs.scheduled_time
          ) AS all_sessions
          GROUP BY 
              MONTH(scheduled_time), MONTHNAME(scheduled_time)
          ORDER BY 
              MONTH(scheduled_time);

        `;
        break;

      case 'Salaries Expenses':
        query = `
          SELECT 
              MONTHNAME(Created_at) AS month, 
              SUM(salary) AS count
          FROM (
              -- Admin salaries: Calculate all salaries until the to-date
              SELECT salary, Created_at 
              FROM admin
              WHERE Created_at <= '${dateTo}-1'  
              UNION ALL
              -- Manager salaries: Calculate all salaries until the to-date
              SELECT salary, Created_at 
              FROM manager
              WHERE Created_at <= '${dateTo}-1'  
              UNION ALL
              -- Emergency team salaries: Calculate all salaries until the to-date
              SELECT salary, Created_at 
              FROM emergency_team
              WHERE Created_at <= '${dateTo}-1'  
          ) AS workforce_salaries
          GROUP BY 
              MONTH(Created_at), MONTHNAME(Created_at)
          ORDER BY 
              MONTH(Created_at);

        `;
        break;

      case 'Total Profit':
        query = `
        SELECT 
    MONTHNAME(scheduled_time) AS month,
    SUM(revenue) AS revenue,
    SUM(expenses) AS expenses,
    SUM(revenue) - SUM(expenses) AS count
FROM (
    -- Doctor sessions: Price is taken directly
    SELECT cost * 0.30 AS revenue, 0 AS expenses, scheduled_time
    FROM doctor_session
    WHERE scheduled_time BETWEEN '${dateFrom}-1' AND '${dateTo}-1'

    UNION ALL

    -- Life coach sessions: Price is multiplied by number of patients and then by 0.30
    SELECT 
        lcs.cost * 0.30 * COUNT(pls.patient_ID) AS revenue, 
        0 AS expenses, 
        lcs.scheduled_time
    FROM 
        life_coach_session lcs
    JOIN 
        patient_lifecoach_session pls 
    ON 
        lcs.session_ID = pls.session_ID
    WHERE 
        lcs.scheduled_time BETWEEN '${dateFrom}-1' AND '${dateTo}-1'
    GROUP BY 
        lcs.session_ID, lcs.scheduled_time

    UNION ALL

    -- Admin salaries: Expenses
    SELECT 
        0 AS revenue, salary AS expenses, Created_at AS scheduled_time
    FROM admin
    WHERE Created_at <= '${dateTo}-1'  

    UNION ALL

    -- Manager salaries: Expenses
    SELECT 
        0 AS revenue, salary AS expenses, Created_at AS scheduled_time
    FROM manager
    WHERE Created_at <= '${dateTo}-1'  

    UNION ALL

    -- Emergency team salaries: Expenses
    SELECT 
        0 AS revenue, salary AS expenses, Created_at AS scheduled_time
    FROM emergency_team
    WHERE Created_at <= '${dateTo}-1'  
) AS all_sessions
GROUP BY 
    MONTH(scheduled_time), MONTHNAME(scheduled_time)
ORDER BY 
    MONTH(scheduled_time);

        `;
        break;

      case 'Emergency Requests':
        query = `
          SELECT 
              MONTHNAME(time) AS month, 
              COUNT(session_ID) AS count
          FROM 
              emergency_team_session
          WHERE 
              time BETWEEN '${dateFrom}-1' AND '${dateTo}-1'
          GROUP BY 
              YEAR(time), MONTH(time)
          ORDER BY 
              YEAR(time), MONTH(time);

        `;
        break;

      case 'Average Patients Monthly Use Count':
        query = `
         SELECT 
          MONTHNAME(cs.scheduled_time) AS month, 
          COUNT(cs.patient_ID) AS count
        FROM (
            -- Doctor sessions: Select patient_ID and scheduled_time from doctor_session
            SELECT patient_ID, scheduled_time 
            FROM doctor_session 
            WHERE scheduled_time BETWEEN '${dateFrom}-1' AND '${dateTo}-1'

            UNION ALL

            -- Life Coach sessions: Select patient_ID and scheduled_time from life_coach_session
            SELECT plcs.patient_ID, lcs.scheduled_time
            FROM life_coach_session lcs
            JOIN patient_lifecoach_session plcs ON lcs.session_ID = plcs.session_ID
            WHERE lcs.scheduled_time BETWEEN '${dateFrom}-1' AND '${dateTo}-1'
        ) AS cs
        GROUP BY month
        ORDER BY MONTH(cs.scheduled_time);

        `;
        break;

      case 'Number of Doctors By Specialization':
        query = `
          SELECT specialization, COUNT(*) AS count
          FROM doctor
          WHERE specialization IS NOT NULL
          GROUP BY specialization
          ORDER BY count DESC;


        `;
        break;

      case 'Number of Life Coaches By Specialization':
        query = `
          SELECT specialization, COUNT(*) AS count
          FROM life_coach
          WHERE specialization IS NOT NULL
          GROUP BY specialization
          ORDER BY count DESC;

        `;
        break;

      case 'Number of Sessions By Therapist type':
        query = `
          SELECT 'doctor' AS type, COUNT(*) AS count
          FROM doctor_session
          WHERE scheduled_time BETWEEN  '${dateFrom}-1' AND '${dateTo}-1'

          UNION ALL

          SELECT 'life_coach' AS type, COUNT(*) AS count
          FROM life_coach_session
          WHERE scheduled_time BETWEEN  '${dateFrom}-1' AND '${dateTo}-1'

          UNION ALL

          SELECT 'emergency_team' AS type, COUNT(*) AS count
          FROM emergency_team_session
          WHERE time BETWEEN  '${dateFrom}-1' AND '${dateTo}-1';

        `;
        break;

     

      default:
        return res.status(400).json({ error: 'Invalid query option' });
    }
    
    // Execute query and return the result
    const result = await executeQuery(query);
    console.log(result);
    return { success: true, data: result };

  } catch (error) {
    console.error('Error generating report:', error);
    res.status(500).json({ error: 'Error generating report' });
  }

}
// Get total revenue per month (10% of completed session prices)
async function get_total_revenue_by_month() {
  try {
    const query = `
      SELECT 
    MONTHNAME(scheduled_time) AS month, 
    SUM(revenue) AS revenue
FROM (
    -- Doctor sessions: Price is taken directly
    SELECT cost * 0.30 AS revenue, scheduled_time 
    FROM doctor_session

    UNION ALL

    -- Life coach sessions: Price is multiplied by number of patients and then by 0.10
    SELECT 
        lcs.cost * 0.10 * COUNT(pls.patient_ID) AS revenue, 
        lcs.scheduled_time
    FROM 
        life_coach_session lcs
    JOIN 
        patient_lifecoach_session pls 
    ON 
        lcs.session_ID = pls.session_ID
    GROUP BY 
        lcs.session_ID, lcs.scheduled_time
) AS all_sessions
GROUP BY 
    MONTH(scheduled_time), MONTHNAME(scheduled_time)
ORDER BY 
    MONTH(scheduled_time);

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
    -- Admin salaries
    SELECT salary, Created_at FROM admin

    UNION ALL

    -- Manager salaries
    SELECT salary, Created_at FROM manager

    UNION ALL

    -- Emergency team salaries
    SELECT salary, Created_at FROM emergency_team
) AS workforce_salaries
GROUP BY 
    MONTH(Created_at), MONTHNAME(Created_at)
ORDER BY 
    MONTH(Created_at);

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

async function get_admin_data(id) {
  try {

    const query = `
      SELECT * FROM admin
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

async function get_total_coaches_count() {
  try {
    const query = `SELECT COUNT(*) AS count FROM life_coach`;
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


async function get_total_emergency_team_count() {
  try {
    const query = `SELECT COUNT(*) AS count FROM emergency_team`;
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

module.exports = {
  get_average_patients_count_per_day,
  get_total_profit_count,
  get_total_salaries_expense_count,
  get_total_revenue_count,
  search_admin,
  get_total_revenue_by_month,
  get_total_expense_by_month,
  report_generator,
  search_admin,
  get_admin_data,
  get_total_coaches_count,
  get_total_emergency_team_count
};
