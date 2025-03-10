const express = require("express");
const {
  loginStaff,
  loginPatient,
  registerPatient,
  registerTherapists,
  registerAdmin,
  registerEmergencyTeamMember,
  deleteUser,
  updatePatient,
  updateEmergencyTeamMember,
  updateAdmin,
  updateTherapist,
} = require("../controllers/authController");
const {
  authenticateUser,
  authorizeRoles,
} = require("../middlewares/authMiddlewares");

const router = express.Router();

// Login Route
router.post("/login", async (req, res) => {
  const data = req.body;
  if (!data.email || !data.password)
    return res.status(400).json({ error: "Missing data" });

  try {
    const result = await loginPatient(data);
    if (!result) return res.status(401).json({ error: "Invalid credentials" });

    res.json({
      message: "Login successful",
      token: result.token,
      user: result.user,
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.post("/login-staff", async (req, res) => {
  const data = req.body;
  if (!data.email || !data.password)
    return res.status(400).json({ error: "Missing data" });

  try {
    const result = await loginStaff(data);
    if (!result) return res.status(401).json({ error: "Invalid credentials" });

    res.json({
      message: "Login successful",
      token: result.token,
      user: result.user,
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Registration Route
router.post("/register", async (req, res) => {
  const data = req.body;
  if (
    !data.name ||
    !data.email ||
    !data.password ||
    !data.Date_Of_Birth ||
    !data.phone_number ||
    !data.Marital_Status ||
    !data.Gender
  )
    return res.status(400).json({ error: "Missing data" });

  try {
    const result = await registerPatient(data);
    res.status(201).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.post("/register-therapist", async (req, res) => {
  const data = req.body;
  if (
    !data.name ||
    !data.email ||
    !data.password ||
    !data.Date_Of_Birth ||
    !data.Gender ||
    !data.phone_number ||
    !data.Description ||
    !data.Specialization ||
    !data.Session_price ||
    !data.role
  )
    return res.status(400).json({ error: "Missing data" });

  try {
    const result = await registerTherapists(data);
    res.status(201).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.post("/register-admin", async (req, res) => {
  const data = req.body;
  if (
    !data.name ||
    !data.email ||
    !data.password ||
    !data.Date_Of_Birth ||
    !data.Gender ||
    !data.phone_number ||
    !data.Salary ||
    !data.role
  )
    return res.status(400).json({ error: "Missing data" });

  try {
    const result = await registerAdmin(data);
    res.status(201).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.post("/register-emergency-member", async (req, res) => {
  const data = req.body;
  if (
    !data.name ||
    !data.email ||
    !data.password ||
    !data.Date_Of_Birth ||
    !data.phone_number ||
    !data.Salary
  )
    return res.status(400).json({ error: "Missing data" });

  try {
    const result = await registerEmergencyTeamMember(data);
    res.status(201).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Update

router.put("/update", authorizeRoles("patient"), async (req, res) => {
  const data = req.body;
  if (
    !data.id ||
    !data.name ||
    !data.email ||
    !data.password ||
    !data.Date_Of_Birth ||
    !data.phone_number ||
    !data.Marital_Status ||
    !data.Gender
  )
    return res.status(400).json({ error: "Missing data" });

  try {
    const result = await updatePatient(data);
    res.status(201).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.put("/update-therapist", async (req, res) => {
  const data = req.body;
  if (
    !data.id ||
    !data.name ||
    !data.email ||
    !data.password ||
    !data.Date_Of_Birth ||
    !data.Gender ||
    !data.phone_number ||
    !data.Description ||
    !data.Specialization ||
    !data.Session_price ||
    !data.role
  )
    return res.status(400).json({ error: "Missing data" });

  try {
    const result = await updateTherapist(data);
    res.status(201).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.put("/update-admin", async (req, res) => {
  const data = req.body;
  if (
    !data.id ||
    !data.name ||
    !data.email ||
    !data.password ||
    !data.Date_Of_Birth ||
    !data.Gender ||
    !data.phone_number ||
    !data.Salary ||
    !data.role
  )
    return res.status(400).json({ error: "Missing data" });

  try {
    const result = await updateAdmin(data);
    res.status(201).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.put("/update-emergency-member", async (req, res) => {
  const data = req.body;
  if (
    !data.id ||
    !data.name ||
    !data.email ||
    !data.password ||
    !data.Date_Of_Birth ||
    !data.phone_number ||
    !data.Salary
  )
    return res.status(400).json({ error: "Missing data" });

  try {
    const result = await updateEmergencyTeamMember(data);
    res.status(201).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.delete("/delete-user", async (req, res) => {
  const data = req.body;
  if (!data.id || !data.role)
    return res.status(400).json({ error: "Missing id or role" });

  try {
    const result = await deleteUser(data);
    res.status(201).json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;
