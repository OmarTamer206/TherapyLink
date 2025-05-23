const express = require("express");
const cors = require("cors");
const http = require("http");
const path = require("path");
const { Server } = require("socket.io");

const authRoutes = require("./routes/authRoutes");
const adminRoutes = require("./routes/adminRoutes");
const managerRoutes = require("./routes/managerRoutes");
const patientRoutes = require("./routes/patientRoutes");
const sessionRoutes = require("./routes/sessionRoutes");
const therapistRoutes = require("./routes/therapistRoutes");
const agentRoutes = require("./routes/agentRoutes");

const { ChatController } = require("./controllers/chatController");
const { CallController } = require("./controllers/callController");
require("dotenv").config();

const app = express();
const server = http.createServer(app);

// 🔌 Initialize Socket.IO with CORS
const io = new Server(server, {
  cors: {
    origin: "http://localhost:4200", // Update with your Angular app origin
    methods: ["GET", "POST"]
  }
});

// 🔄 Real-time chat logic
ChatController(io); // Call the function from chatController.js

CallController(io); // Add this below your ChatController initialization

// 🌐 Middleware
app.use(cors());
app.use(express.json());

// 📦 Routes
app.use("/auth", authRoutes);
app.use("/admin", adminRoutes);
app.use("/manager", managerRoutes);
app.use("/patient", patientRoutes);
app.use("/session", sessionRoutes);
app.use("/therapist", therapistRoutes);
app.use("/agent", agentRoutes);

// 📁 Static file serving for uploads
app.use("/uploads", express.static(path.join(__dirname, "public/uploads")));

// 🚀 Start Server
const PORT = process.env.PORT || 3000;
server.listen(PORT, () => console.log(`Server running on port ${PORT}`));
