const express = require('express');
const router = express.Router();
const { sendEmail } = require('../controllers/emailController');

// Route to send an email
router.post('/send', async (req, res) => {
  const { to, subject, message } = req.body;

  if (!to || !subject || !message) {
    return res.status(400).json({ success: false, message: 'Missing email fields' });
  }

  const result = await sendEmail(to, subject, message);

  if (result.success) {
    res.status(200).json({ success: true, message: 'Email sent successfully' });
  } else {
    res.status(500).json({ success: false, message: 'Email sending failed', error: result.error.message });
  }
});

module.exports = router;
