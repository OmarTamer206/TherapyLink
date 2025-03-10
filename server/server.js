const express = require("express");
const http = require("http");
const authRoutes = require("./routes/authRoutes");
const { initializeChat } = require("./controllers/chatController");
require("dotenv").config();

const app = express();
app.use(express.json());

app.use("/auth", authRoutes);

const PORT = process.env.PORT || 3000;

const server = http.createServer(app);

initializeChat(server);

server.listen(PORT, () => console.log(`Server running on port ${PORT}`));
