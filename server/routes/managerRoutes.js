const express = require("express");
const jwt = require("jsonwebtoken");
const {
  get_average_patients_count_per_day,
  get_total_profit_count,
  get_total_salaries_expense_count,
  get_total_revenue_count,
  search_admin,
  get_total_revenue_by_month,
  get_total_expense_by_month,
  report_generator,
  get_total_coaches_count,
  get_total_emergency_team_count,
} = require("../controllers/managerController");
const { get_admin_data, get_total_earnings_count } = require("../controllers/adminController");

const router = express.Router();

// Get average patients count per day
router.get("/average-patients-count-per-day", async (req, res) => {
  try {
    const result = await get_average_patients_count_per_day();
    res.status(200).json(result);
  } catch (error) {
    if (err.name === 'TokenExpiredError') {
    // Token expired
    // Handle by sending 401 or redirecting user to login
    return res.status(401).json({ error: 'Token expired' });
  } else if (err.name === 'JsonWebTokenError') {
    // Invalid token
    return res.status(401).json({ error: 'Invalid token' });
  } else {
    // Other errors
    return res.status(500).json({ error: 'Internal server error' });
  }
  }
});

// Get total profit count
router.get("/total-profit-count", async (req, res) => {
  try {
    const result = await get_total_profit_count();
    res.status(200).json(result);
  } catch (error) {
    if (err.name === 'TokenExpiredError') {
    // Token expired
    // Handle by sending 401 or redirecting user to login
    return res.status(401).json({ error: 'Token expired' });
  } else if (err.name === 'JsonWebTokenError') {
    // Invalid token
    return res.status(401).json({ error: 'Invalid token' });
  } else {
    // Other errors
    return res.status(500).json({ error: 'Internal server error' });
  }
  }
});

// Get total salaries expense count
router.get("/total-salaries-expense-count", async (req, res) => {
  try {
    const result = await get_total_salaries_expense_count();
    res.status(200).json(result);
  } catch (error) {
    if (err.name === 'TokenExpiredError') {
    // Token expired
    // Handle by sending 401 or redirecting user to login
    return res.status(401).json({ error: 'Token expired' });
  } else if (err.name === 'JsonWebTokenError') {
    // Invalid token
    return res.status(401).json({ error: 'Invalid token' });
  } else {
    // Other errors
    return res.status(500).json({ error: 'Internal server error' });
  }
  }
});

// Get total revenue count
router.get("/total-revenue-count", async (req, res) => {
  try {
    const result = await get_total_revenue_count();
    res.status(200).json(result);
  } catch (error) {
    if (err.name === 'TokenExpiredError') {
    // Token expired
    // Handle by sending 401 or redirecting user to login
    return res.status(401).json({ error: 'Token expired' });
  } else if (err.name === 'JsonWebTokenError') {
    // Invalid token
    return res.status(401).json({ error: 'Invalid token' });
  } else {
    // Other errors
    return res.status(500).json({ error: 'Internal server error' });
  }
  }
});

// Search admin by name
router.get("/search-admin", async (req, res) => {
  const { name } = req.query;
  if (!name)
    return res.status(400).json({ error: "Name is required for search" });

  try {
    const result = await search_admin(name);
    res.status(200).json(result);
  } catch (error) {
    if (err.name === 'TokenExpiredError') {
    // Token expired
    // Handle by sending 401 or redirecting user to login
    return res.status(401).json({ error: 'Token expired' });
  } else if (err.name === 'JsonWebTokenError') {
    // Invalid token
    return res.status(401).json({ error: 'Invalid token' });
  } else {
    // Other errors
    return res.status(500).json({ error: 'Internal server error' });
  }
  }
});

// Get total revenue by month
router.get("/total-revenue-by-month", async (req, res) => {
  try {
    const result = await get_total_revenue_by_month();
    res.status(200).json(result);
  } catch (error) {
    if (err.name === 'TokenExpiredError') {
    // Token expired
    // Handle by sending 401 or redirecting user to login
    return res.status(401).json({ error: 'Token expired' });
  } else if (err.name === 'JsonWebTokenError') {
    // Invalid token
    return res.status(401).json({ error: 'Invalid token' });
  } else {
    // Other errors
    return res.status(500).json({ error: 'Internal server error' });
  }
  }
});

// Get total expenses by month
router.get("/total-expense-by-month", async (req, res) => {
  try {
    const result = await get_total_expense_by_month();
    res.status(200).json(result);
  } catch (error) {
    if (err.name === 'TokenExpiredError') {
    // Token expired
    // Handle by sending 401 or redirecting user to login
    return res.status(401).json({ error: 'Token expired' });
  } else if (err.name === 'JsonWebTokenError') {
    // Invalid token
    return res.status(401).json({ error: 'Invalid token' });
  } else {
    // Other errors
    return res.status(500).json({ error: 'Internal server error' });
  }
  }
});

router.get("/search-admins", async (req, res) => {
  const name = req.query;
  try {
    const result = await search_admin(name);
    res.status(200).json(result);
  } catch (error) {
    if (err.name === 'TokenExpiredError') {
    // Token expired
    // Handle by sending 401 or redirecting user to login
    return res.status(401).json({ error: 'Token expired' });
  } else if (err.name === 'JsonWebTokenError') {
    // Invalid token
    return res.status(401).json({ error: 'Invalid token' });
  } else {
    // Other errors
    return res.status(500).json({ error: 'Internal server error' });
  }
  }
});
router.get("/get-manager-data", async (req, res) => {
  const token = req.headers['authorization']?.split(' ')[1];
  if (!token) return res.status(401).json({ message: 'Access denied' });
  
  try {
    console.log("1",process.env.JWT_SECRET);
    
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    
    
    const result = await get_admin_data(decoded.id,decoded.role);
    res.status(200).json(result);
  } catch (error) {
    if (err.name === 'TokenExpiredError') {
    // Token expired
    // Handle by sending 401 or redirecting user to login
    return res.status(401).json({ error: 'Token expired' });
  } else if (err.name === 'JsonWebTokenError') {
    // Invalid token
    return res.status(401).json({ error: 'Invalid token' });
  } else {
    // Other errors
    return res.status(500).json({ error: 'Internal server error' });
  }
  }
});


router.get("/get-admin-data", async (req, res) => {
  const { id } = req.query;
  if (!id )
    return res.status(400).json({ error: "id  are required" });

  try {
    const result = await get_admin_data(id,"admin");
    res.status(200).json(result);
  } catch (error) {
    if (err.name === 'TokenExpiredError') {
    // Token expired
    // Handle by sending 401 or redirecting user to login
    return res.status(401).json({ error: 'Token expired' });
  } else if (err.name === 'JsonWebTokenError') {
    // Invalid token
    return res.status(401).json({ error: 'Invalid token' });
  } else {
    // Other errors
    return res.status(500).json({ error: 'Internal server error' });
  }
  }
});
// Generate report based on factor and date range
router.get("/report", async (req, res) => {
  const {report_type, date_from, date_to } = req.query;

  if (!report_type || !date_from || !date_to)
    return res.status(400).json({ error: "Missing required parameters" });

  try {
    const result = await report_generator(report_type, date_from, date_to);
    res.status(200).json(result);
  } catch (error) {
    if (err.name === 'TokenExpiredError') {
    // Token expired
    // Handle by sending 401 or redirecting user to login
    return res.status(401).json({ error: 'Token expired' });
  } else if (err.name === 'JsonWebTokenError') {
    // Invalid token
    return res.status(401).json({ error: 'Invalid token' });
  } else {
    // Other errors
    return res.status(500).json({ error: 'Internal server error' });
  }
  }
});

router.get("/total-coaches-count", async (req, res) => {
  try {
    const result = await get_total_coaches_count();
    res.status(200).json(result);
  } catch (error) {
    if (err.name === 'TokenExpiredError') {
    // Token expired
    // Handle by sending 401 or redirecting user to login
    return res.status(401).json({ error: 'Token expired' });
  } else if (err.name === 'JsonWebTokenError') {
    // Invalid token
    return res.status(401).json({ error: 'Invalid token' });
  } else {
    // Other errors
    return res.status(500).json({ error: 'Internal server error' });
  }
  }
});

router.get("/total-emergency-team-count", async (req, res) => {
  try {
    const result = await get_total_emergency_team_count();
    res.status(200).json(result);
  } catch (error) {
    if (err.name === 'TokenExpiredError') {
    // Token expired
    // Handle by sending 401 or redirecting user to login
    return res.status(401).json({ error: 'Token expired' });
  } else if (err.name === 'JsonWebTokenError') {
    // Invalid token
    return res.status(401).json({ error: 'Invalid token' });
  } else {
    // Other errors
    return res.status(500).json({ error: 'Internal server error' });
  }
  }
});

module.exports = router;
