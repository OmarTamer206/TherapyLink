const mysql = require("mysql2/promise");
require("dotenv").config();

// Create a database connection pool
const pool = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASS,
  database: process.env.DB_NAME,
  waitForConnections: true,
});

// Execute any query (Reusable function)
async function executeQuery(query, params = []) {
  try {
    const [rows] = await pool.execute(query, params);
    return rows;
  } catch (error) {
    console.error("Database Error:", error);
    throw new Error("Database query failed");
  }
}

module.exports = { executeQuery };
