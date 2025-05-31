const express = require("express");
const jwt = require("jsonwebtoken");
const multer = require('multer');
const path = require('path');

require("dotenv").config();

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
  checkEmail,
  findUserById,
} = require("../controllers/authController");
const {
  authenticateUser,
  authorizeRoles,
} = require("../middlewares/authMiddlewares");

const router = express.Router();




// Configure multer to save the uploaded file in 'public/uploads'
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'public/uploads/'); // Folder where the uploaded file will be saved
  },
  filename: function (req, file, cb) {
    cb(null, Date.now() + path.extname(file.originalname)); // Unique filename based on current timestamp
  }
});
const upload = multer({ storage: storage });

// Route to handle profile picture upload
router.post('/upload-profile-pic', upload.single('file'), (req, res) => {
  if (req.file) {
    const fileName = req.file.filename; // Get the uploaded file's name
    res.json({ success: true, fileName: fileName }); // Return the file name to the frontend
  } else {
    res.status(400).json({ error: 'No file uploaded' });
  }
});


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
      refreshToken: result.refreshToken,
      role: result.roleOfUser
    });
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
      refreshToken: result.refreshToken,
      role: result.roleOfUser
    });
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

router.post('/refresh-token', async (req, res) => {
  const { refreshToken } = req.body;

  if (!refreshToken) {
    return res.status(400).json({ message: 'Refresh token is required' });
  }

  try {
    // Validate refresh token
    const decoded = jwt.verify(refreshToken, process.env.REFRESH_SECRET_KEY);

    // Check if the refresh token is still valid (you may want to also store it in your database for validation)
    const user = await findUserById(decoded.id,decoded.role); // Find user based on the ID from decoded token

    // Generate a new access token
    const newAccessToken = jwt.sign(
      { ...user },
      process.env.SECRET_KEY,
      { expiresIn: '15m' } // New access token
    );
    console.log("token refreshed",token );
    
    res.json({ token: newAccessToken });

  } catch (error) {
    console.error('Refresh token error:', error);
    return res.status(403).json({ message: 'Invalid refresh token' });
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

router.post("/register-admin", async (req, res) => {
  const data = req.body;
  if (
    !data.name ||
    !data.email ||
    !data.password ||
    !data.Date_Of_Birth ||
    !data.Gender ||
    !data.phone_number ||
    !data.salary ||
    !data.role
  )
    return res.status(400).json({ error: "Missing data" });

  try {
    const result = await registerAdmin(data);
    res.status(201).json(result);
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

// Update

router.put("/update", authorizeRoles("patient"), async (req, res) => {
  const data = req.body;
  if (
    !data.id ||
    !data.name ||
    !data.email ||
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

router.put("/update-therapist", async (req, res) => {
  const data = req.body;
  if (
    !data.id ||
    !data.name ||
    !data.email ||
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

router.put("/update-admin", async (req, res) => {
  
  const data = req.body;
  if (
    !data.id ||
    !data.name ||
    !data.email ||
    !data.Date_Of_Birth ||
    !data.Gender ||
    !data.phone_number ||
    !data.role
  )
    return res.status(400).json({ error: "Missing data" });

  try {
    const result = await updateAdmin(data);
    res.status(201).json(result);
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

router.put("/update-emergency-member", async (req, res) => {
  const data = req.body;
  if (
    !data.id ||
    !data.name ||
    !data.email ||
    !data.Date_Of_Birth || 
    !data.phone_number 
  )
    return res.status(400).json({ error: "Missing data" });

  try {
    const result = await updateEmergencyTeamMember(data);
    res.status(201).json(result);
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

router.delete("/delete-user", async (req, res) => {
  const data = req.body;

  
  if (!data.id || !data.role)
    return res.status(400).json({ error: "Missing id or role" });

  try {
    const result = await deleteUser(data);
    res.status(201).json(result);
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

router.post("/check-email", async (req, res) => {
  const data = req.body;
  console.log(data);
  
  if (!data.email)
    return res.status(400).json({ error: "Missing data" });

  try {
    const result = await checkEmail(data);
    if (!result) return res.status(401).json({ error: "Error Occured" });

    res.json({
      message: "Success",
      data: result,
    });
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
