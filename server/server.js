const express = require("express");
const cors = require("cors");
const http = require("http");
const path = require("path");
const authRoutes = require("./routes/authRoutes");
const adminRoutes = require("./routes/adminRoutes");
const managerRoutes = require("./routes/managerRoutes");
const patientRoutes = require("./routes/patientRoutes");
const sessionRoutes = require("./routes/sessionRoutes");
const therapistRoutes = require("./routes/therapistRoutes");

const { initializeChat } = require("./controllers/chatController");
require("dotenv").config();

const app = express();
app.use(cors());
app.use(express.json());

app.use("/auth", authRoutes);
app.use("/admin",adminRoutes)
app.use("/manager",managerRoutes)
app.use("/patient",patientRoutes)
app.use("/session",sessionRoutes)
app.use("/therapist",therapistRoutes)
const PORT = process.env.PORT || 3000;

const server = http.createServer(app);

initializeChat(server);

app.use('/uploads', express.static(path.join(__dirname, 'public/uploads'))); // Serve the uploads folder


server.listen(PORT, () => console.log(`Server running on port ${PORT}`));
