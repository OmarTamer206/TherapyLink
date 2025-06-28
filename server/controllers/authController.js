const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const { executeQuery } = require("./databaseController");
require("dotenv").config();

// User Login
async function loginPatient(data) {
  const staffRoles = [
    "patient"
  ];
  try {
    let users;
    let roleOfUser;
    for (const role in staffRoles) {
      users = await executeQuery(
        "SELECT * FROM " + staffRoles[role] + " WHERE email = ?",
        [data.email]
      );

      if (users.length !== 0) 
      {
        
        roleOfUser = staffRoles[role]
        break;
      }
    }

    if (users.length === 0) return null;

    const user = users[0];
    const passwordMatch = await bcrypt.compare(
      data.password,
      users[0].Password
    );
    if (!passwordMatch) return null;

    const { password, ...userWithoutPassword } = user;

    const token = jwt.sign(
      { ...userWithoutPassword, role: roleOfUser },
      process.env.JWT_SECRET,
      { expiresIn: "10h" }
    );

    const refreshToken = jwt.sign(
      { ...userWithoutPassword , role: roleOfUser },
      process.env.REFRESH_SECRET_KEY,
      { expiresIn: '30d' } // Refresh token expires in 30 days
    );

    console.log(roleOfUser);
    
    return { token, refreshToken , roleOfUser };
  } catch (error) {
    console.error("Login Error:", error);
    
    throw new Error("Login failed");
  }
}

async function loginStaff(data) {
  const staffRoles = [
    "patient",
    "doctor",
    "life_coach",
    "emergency_team",
    "admin",
    "manager",
  ];
  try {
    let users;
    let roleOfUser;
    for (const role in staffRoles) {
      users = await executeQuery(
        "SELECT * FROM " + staffRoles[role] + " WHERE email = ?",
        [data.email]
      );

      if (users.length !== 0) 
      {
        
        roleOfUser = staffRoles[role]
        break;
      }
    }

    if (users.length === 0) return null;

    const user = users[0];
    const passwordMatch = await bcrypt.compare(
      data.password,
      users[0].Password
    );
    if (!passwordMatch) return null;

    const { password, ...userWithoutPassword } = user;

    const token = jwt.sign(
      { ...userWithoutPassword, role: roleOfUser },
      process.env.JWT_SECRET,
      { expiresIn: "10h" }
    );

    const refreshToken = jwt.sign(
      { ...userWithoutPassword , role: roleOfUser },
      process.env.REFRESH_SECRET_KEY,
      { expiresIn: '30d' } // Refresh token expires in 30 days
    );

    console.log(roleOfUser);
    
    return { token, refreshToken , roleOfUser };
  } catch (error) {
    console.error("Login Error:", error);
    
    throw new Error("Login failed");
  }
}

// User Registration
async function registerPatient(data) {
  try {
    const hashedPassword = await bcrypt.hash(data.password, 10);
    await executeQuery(
      "INSERT INTO patient (Name,Email, Password,Date_Of_Birth,phone_number,Marital_Status,Therapist_Preference,Diagnosis,Gender,Profile_pic_url) VALUES (?, ?, ? , ? , ?,?, ?, ? , ? , ?)",
      [
        data.name,
        data.email,
        hashedPassword,
        data.Date_Of_Birth,
        data.phone_number,
        data.Marital_Status,
        'General Psychological Support',
        data.Diagnosis || null,
        data.Gender,
        data.Profile_pic_url || null,
      ]
    );

    return { message: "User registered successfully" };
  } catch (error) {
    console.error("Registration Error:", error);
    throw new Error("User registration failed");
  }
}

async function registerAdmin(data) {
  if (!["admin", "manager"].includes(data.role))
    throw new Error("Invalid role. Please choose 'admin' or'manager'");


  

  try {
    const hashedPassword = await bcrypt.hash(data.password, 10);
    await executeQuery(
      "INSERT INTO " +
        data.role +
        " (Name,Email,Password,Date_Of_Birth,Gender,phone_number,Salary,Profile_pic_url) VALUES (?, ?, ?, ?, ?, ? , ?, ?)",
      [
        data.name,
        data.email,
        hashedPassword,
        data.Date_Of_Birth,
        data.Gender,
        data.phone_number,
        data.salary,
        data.Profile_pic_url || null,
      ]
    );

    return { message: "User registered successfully" };
  } catch (error) {
    console.error("Registration Error:", error);
    throw new Error("User registration failed");
  }
}

async function registerTherapists(data) {
  if (!["doctor", "life_coach"].includes(data.role))
    throw new Error("Invalid role. Please choose 'doctor' or'life_coach'");

  try {
    const hashedPassword = await bcrypt.hash(data.password, 10);
    await executeQuery(
      "INSERT INTO " +
        data.role +
        " (Name,Email,Password,Date_Of_Birth,Gender,phone_number,Description,Specialization,Session_price,profile_pic_url) VALUES (?, ?, ?, ?, ?, ? , ?, ?,?,?)",
      [
        data.name,
        data.email,
        hashedPassword,
        data.Date_Of_Birth,
        data.Gender,
        data.phone_number,
        data.Description,
        data.Specialization,
        data.Session_price,
        data.Profile_pic_url || null,
      ]
    );

    return { message: "User registered successfully" };
  } catch (error) {
    console.error("Registration Error:", error);
    throw new Error("User registration failed");
  }
}

async function registerEmergencyTeamMember(data) {
  try {
    const hashedPassword = await bcrypt.hash(data.password, 10);
    await executeQuery(
      "INSERT INTO emergency_team (Name,Email,Password,Date_Of_Birth,phone_number,Salary,Profile_pic_url) VALUES (?, ?, ?, ?, ?, ? ,?)",
      [
        data.name,
        data.email,
        hashedPassword,
        data.Date_Of_Birth,
        data.phone_number,
        data.Salary,
        data.Profile_pic_url || null,
      ]
    );

    return { message: "User registered successfully" };
  } catch (error) {
    console.error("Registration Error:", error);
    throw new Error("User registration failed");
  }
}

async function updatePatient(data) {
  try {
    let fields = [];
    let values = [];

    if (data.name) {
      fields.push("Name = ?");
      values.push(data.name);
    }
    if (data.email) {
      fields.push("Email = ?");
      values.push(data.email);
    }
    if (data.password!=="") {
      const hashedPassword = await bcrypt.hash(data.password, 10);
      fields.push("Password = ?");
      values.push(hashedPassword);
    }
    if (data.Date_Of_Birth) {
      fields.push("Date_Of_Birth = ?");
      values.push(data.Date_Of_Birth);
    }
    if (data.phone_number) {
      fields.push("phone_number = ?");
      values.push(data.phone_number);
    }
    if (data.Marital_Status) {
      fields.push("Marital_Status = ?");
      values.push(data.Marital_Status);
    }
    if (data.Therapist_Preference !== undefined) {
      fields.push("Therapist_Preference = ?");
      values.push(data.Therapist_Preference || null);
    }
    if (data.Diagnosis !== undefined) {
      fields.push("Diagnosis = ?");
      values.push(data.Diagnosis || null);
    }
    if (data.Gender) {
      fields.push("Gender = ?");
      values.push(data.Gender);
    }
    if (data.Profile_pic_url !== undefined) {
      fields.push("Profile_pic_url = ?");
      values.push(data.Profile_pic_url || null);
    }

    if (fields.length === 0) {
      throw new Error("No valid fields provided for update.");
    }

    values.push(data.id); // Add userId to values for WHERE condition

    const query = `UPDATE patient SET ${fields.join(", ")} WHERE id = ?`;
    await executeQuery(query, values);

    return { message: "User updated successfully" };
  } catch (error) {
    console.error("Update Patient Error:", error);
    throw new Error("User update failed");
  }
}

async function updateAdmin(data) {
  if (!["admin", "manager"].includes(data.role)) {
    throw new Error("Invalid role. Please choose 'admin' or 'manager'");
  }

  try {
    let fields = [];
    let values = [];

    if (data.name) {
      fields.push("Name = ?");
      values.push(data.name);
    }
    if (data.email) {
      fields.push("Email = ?");
      values.push(data.email);
    }
    if (data.password!=="") {
      const hashedPassword = await bcrypt.hash(data.password, 10);
      fields.push("Password = ?");
      values.push(hashedPassword);
    }
    if (data.Date_Of_Birth) {
      fields.push("Date_Of_Birth = ?");
      values.push(data.Date_Of_Birth);
    }
    if (data.Gender) {
      fields.push("Gender = ?");
      values.push(data.Gender);
    }
    if (data.phone_number) {
      fields.push("phone_number = ?");
      values.push(data.phone_number);
    }
    if (data.Salary) {
      fields.push("Salary = ?");
      values.push(data.Salary);
    }
    if (data.Profile_pic_url !== undefined) {
      fields.push("Profile_pic_url = ?");
      values.push(data.Profile_pic_url || null);
    }

    if (fields.length === 0) {
      throw new Error("No valid fields provided for update.");
    }

    values.push(data.id); // Add userId to values for WHERE condition

    const query = `UPDATE ${data.role} SET ${fields.join(", ")} WHERE id = ?`;
    await executeQuery(query, values);

    return { message: "User updated successfully" };
  } catch (error) {
    console.error("Update Admin Error:", error);
    throw new Error("User update failed");
  }
}

async function updateTherapist(data) {
  if (!["doctor", "life_coach"].includes(data.role)) {
    throw new Error("Invalid role. Please choose 'doctor' or 'life_coach'");
  }

  try {
    let fields = [];
    let values = [];

    if (data.name) {
      fields.push("Name = ?");
      values.push(data.name);
    }
    if (data.email) {
      fields.push("Email = ?");
      values.push(data.email);
    }
    if (data.password!=="") {
      const hashedPassword = await bcrypt.hash(data.password, 10);
      fields.push("Password = ?");
      values.push(hashedPassword);
    }
    if (data.Date_Of_Birth) {
      fields.push("Date_Of_Birth = ?");
      values.push(data.Date_Of_Birth);
    }
    if (data.Gender) {
      fields.push("Gender = ?");
      values.push(data.Gender);
    }
    if (data.phone_number) {
      fields.push("phone_number = ?");
      values.push(data.phone_number);
    }
    if (data.Description) {
      fields.push("Description = ?");
      values.push(data.Description);
    }
    if (data.Specialization) {
      fields.push("Specialization = ?");
      values.push(data.Specialization);
    }
    if (data.Session_price) {
      fields.push("Session_price = ?");
      values.push(data.Session_price);
    }
    if (data.Profile_pic_url !== undefined) {
      fields.push("Profile_pic_url = ?");
      values.push(data.Profile_pic_url || null);
    }

    if (fields.length === 0) {
      throw new Error("No valid fields provided for update.");
    }

    values.push(data.id); // Add userId to values for WHERE condition

    const query = `UPDATE ${data.role} SET ${fields.join(", ")} WHERE id = ?`;
    await executeQuery(query, values);

    return { message: "User updated successfully" };
  } catch (error) {
    console.error("Update Therapist Error:", error);
    throw new Error("User update failed");
  }
}

async function updateEmergencyTeamMember(data) {
  try {
    let fields = [];
    let values = [];

    if (data.name) {
      fields.push("Name = ?");
      values.push(data.name);
    }
    if (data.email) {
      fields.push("Email = ?");
      values.push(data.email);
    }
    if (data.password!=="") {
      const hashedPassword = await bcrypt.hash(data.password, 10);
      fields.push("Password = ?");
      values.push(hashedPassword);
    }
    if (data.Date_Of_Birth) {
      fields.push("Date_Of_Birth = ?");
      values.push(data.Date_Of_Birth);
    }
    if (data.phone_number) {
      fields.push("phone_number = ?");
      values.push(data.phone_number);
    }
    if (data.Salary) {
      fields.push("Salary = ?");
      values.push(data.Salary);
    }
    if (data.Profile_pic_url !== undefined) {
      fields.push("Profile_pic_url = ?");
      values.push(data.Profile_pic_url || null);
    }

    if (fields.length === 0) {
      throw new Error("No valid fields provided for update.");
    }

    values.push(data.id); // Add userId to values for WHERE condition

    const query = `UPDATE emergency_team SET ${fields.join(", ")} WHERE id = ?`;
    await executeQuery(query, values);

    return { message: "User updated successfully" };
  } catch (error) {
    console.error("Update User Error:", error);
    throw new Error("User update failed");
  }
}

async function deleteUser(data) {
  try {
    const result = await executeQuery(
      "DELETE FROM " + data.role + " WHERE id = ?",
      [data.id]
    );

    if (result.affectedRows === 0) {
      throw new Error("User not found.");
    }

    return { message: "User deleted successfully" };
  } catch (error) {
    console.error("Delete User Error:", error);
    throw new Error("User deletion failed");
  }
}


async function checkEmail(data) {
  const staffRoles = [
    "patient",
    "doctor",
    "life_coach",
    "emergency_team",
    "admin",
    "manager",
  ];
  try {
    let users;
    
    for (const role in staffRoles) {
      users = await executeQuery(
        "SELECT * FROM " + staffRoles[role] + " WHERE email = ?",
        [data.email]
      );

      if (users.length !== 0) break;
    }

    if (users.length === 0) return "not_taken";
    else{
      return "taken";
    }
   
  } catch (error) {
    console.error("Checking Email Error:", error);
    throw new Error("Checking Email failed");
  }
}

async function findUserById(id,role){
  
  try {
    let users;
    
   
      users = await executeQuery(
        "SELECT * FROM " + role + " WHERE id = ?",
        [id]
      );



    
   
  } catch (error) {
    console.error("Error Getting User:", error);
    throw new Error("Getting User failed");
  }
}

module.exports = {
  
  loginPatient,
  loginStaff,
  registerPatient,
  registerAdmin,
  registerEmergencyTeamMember,
  registerTherapists,
  updatePatient,
  updateAdmin,
  updateTherapist,
  updateEmergencyTeamMember,
  deleteUser,
  checkEmail,
  findUserById,
};
