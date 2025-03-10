// Under Testing

const { Server } = require("socket.io");

let io;
const activeUsers = new Map(); // Stores active users with socket ID

function initializeChat(server) {
  io = new Server(server, {
    cors: {
      origin: "*", // Allow all origins (Adjust for production)
    },
  });

  io.on("connection", (socket) => {
    console.log("New user connected:", socket.id);

    // Handle user joining chat
    socket.on("joinChat", (userData) => {
      activeUsers.set(socket.id, userData); // Store user info with socket ID
      socket.broadcast.emit("userJoined", userData.name); // Notify others
    });

    // Handle incoming messages
    socket.on("sendMessage", (messageData) => {
      io.emit("receiveMessage", messageData); // Send to all users
    });

    // Handle "typing" indicator
    socket.on("typing", (typingData) => {
      socket.broadcast.emit("userTyping", typingData);
    });

    // Handle user disconnecting
    socket.on("disconnect", () => {
      const user = activeUsers.get(socket.id);
      if (user) {
        socket.broadcast.emit("userLeft", user.name);
        activeUsers.delete(socket.id);
      }
      console.log("User disconnected:", socket.id);
    });
  });
}

module.exports = { initializeChat };
