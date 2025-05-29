const jwt = require("jsonwebtoken");
require("dotenv").config();


/**
 * Middleware to restrict access to specific roles.
 */


function authorizeRoles(...allowedRoles) {
  return (req, res, next) => {
    const authHeader = req.headers['authorization'];
    if (!authHeader) return res.status(401).json({ message: 'No token provided' });

    const token = authHeader.split(' ')[1];
    if (!token) return res.status(401).json({ message: 'No token provided' });

    try {
      const decoded = jwt.verify(token, process.env.JWT_SECRET);
      if (!allowedRoles.includes(decoded.role)) {
        return res.status(403).json({ message: 'Forbidden: You do not have permission' });
      }
      req.user = decoded; // attach user info to request object
      next();
    } catch (err) {
      return res.status(401).json({ message: 'Invalid or expired token' });
    }
  };
}


// module.exports = { authenticateUser, authorizeRoles };
module.exports = { authorizeRoles };
