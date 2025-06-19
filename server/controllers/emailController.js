const nodemailer = require('nodemailer');

// Create reusable transporter
const createTransporter = () => {
  return nodemailer.createTransport({
    service: 'gmail',
    auth: {
      user: 'therapylinkstaff@gmail.com',
      pass: 'adbe tdvj okvm akqf' // Use App Password if 2FA is enabled
    }
  });
};

// Function to send email
const sendEmail = async (to, subject, text) => {
  const transporter = createTransporter();

  const mailOptions = {
    from: '"TherapyLink Staff" <therapylinkstaff@gmail.com>',
    to,
    subject,
    text
  };

  try {
    const info = await transporter.sendMail(mailOptions);
    console.log('Email sent:', info.response);
    return { success: true, info };
  } catch (error) {
    console.error('Email sending failed:', error);
    return { success: false, error };
  }
};

module.exports = { sendEmail };
