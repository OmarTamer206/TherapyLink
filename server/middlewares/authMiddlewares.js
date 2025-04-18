const jwt = require("jsonwebtoken");
require("dotenv").config();

/**
 * Middleware to verify JWT and authenticate user.
 */
// function authenticateUser(req, res, next) {
//   const token = req.header("Authorization");

//   if (!token) {
//     return res.status(401).json({ error: "Access denied. No token provided." });
//   }

//   try {
//     const decoded = jwt.verify(
//       token.replace("Bearer ", ""),
//       process.env.JWT_SECRET
//     );
//     req.user = decoded; // Attach user data to the request object
//     next(); // Proceed to the next middleware or route handler
//   } catch (error) {
//     return res.status(403).json({ error: "Invalid token." });
//   }
// }

/**
 * Middleware to restrict access to specific roles.
 */

function authorizeRoles(...allowedRoles) {
  return (req, res, next) => {
    const token = req.header("Authorization");

    if (!token) {
      return res
        .status(401)
        .json({ error: "Access denied. No token provided." });
    }

    try {
      const decoded = jwt.verify(
        token.replace("Bearer ", ""),
        process.env.JWT_SECRET
      );
      req.user = decoded; // Attach user data to the request object
    } catch (error) {
      return res.status(403).json({ error: "Invalid token." });
    }

    if (!allowedRoles.includes(req.user.role)) {
      return res
        .status(403)
        .json({ error: "Forbidden. You don't have access." });
    }
    next();
  };
}

// module.exports = { authenticateUser, authorizeRoles };
module.exports = { authorizeRoles };
