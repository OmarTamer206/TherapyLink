const express = require("express");
const {
  get_average_patients_count_per_day,
  get_total_profit_count,
  get_total_salaries_expense_count,
  get_total_revenue_count,
  search_admin,
  get_total_revenue_by_month,
  get_total_expense_by_month,
  report_generator,
} = require("../controllers/managerController");

const router = express.Router();

// Get average patients count per day
router.get("/average-patients-count-per-day", async (req, res) => {
  try {
    const result = await get_average_patients_count_per_day();
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Get total profit count
router.get("/total-profit-count", async (req, res) => {
  try {
    const result = await get_total_profit_count();
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Get total salaries expense count
router.get("/total-salaries-expense-count", async (req, res) => {
  try {
    const result = await get_total_salaries_expense_count();
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Get total revenue count
router.get("/total-revenue-count", async (req, res) => {
  try {
    const result = await get_total_revenue_count();
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
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
    res.status(500).json({ error: error.message });
  }
});

// Get total revenue by month
router.get("/total-revenue-by-month", async (req, res) => {
  try {
    const result = await get_total_revenue_by_month();
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Get total expenses by month
router.get("/total-expense-by-month", async (req, res) => {
  try {
    const result = await get_total_expense_by_month();
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Generate report based on factor and date range
router.get("/report", async (req, res) => {
  const { factor, report_type, date_from, date_to } = req.query;

  if (!factor || !report_type || !date_from || !date_to)
    return res.status(400).json({ error: "Missing required parameters" });

  try {
    const result = await report_generator(factor, report_type, date_from, date_to);
    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;
