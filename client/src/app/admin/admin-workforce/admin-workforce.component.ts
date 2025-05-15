import { Component } from '@angular/core';
import { RouterModule } from '@angular/router';
import { FormsModule } from '@angular/forms';  // Import FormsModule for ngModel
import { CommonModule } from '@angular/common';  // Import CommonModule for ngIf
import { AdminService } from '../../services/admin/admin.service';
import { AuthService } from '../../services/auth/auth.service';
@Component({
  selector: 'app-admin-workforce',
  standalone: true,
  imports: [RouterModule, FormsModule, CommonModule],  // Include CommonModule for ngIf
  templateUrl: './admin-workforce.component.html',
  styleUrls: ['./admin-workforce.component.css']
})
export class AdminWorkforceComponent {


  constructor(private adminService: AdminService, private authService: AuthService) {


  }

  registerElementClass: string = '';
  editElementClass: string = 'hide';
  jobDescription: string = 'doctor';  // Store selected job description
  isEditing: boolean = false;  // Flag to track if in 'edit' mode
  searchQuery: string = '';  // Variable to bind the search query

  id:number = 0
  name: string = '';
  email: string = '';
  phone: string = '';
  birthMonth: string ="Jan";
  birthDay: number = 1;
  birthYear: number = 2000;
  password: string = '';
  confirmPassword: string = '';
  specialization: string = '';
  description: string = '';
  sessionPrice: string = '';
  gender: string = '';
  salary: number = 0;  // Salary field declaration

  months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
  days = Array.from({length: 31}, (_, i) => i + 1); // Days 1-31
  years = Array.from({length: 101}, (_, i) => 1920 + i); // Years 1920-2020

 results : any

 editingProfileState=false;
  editingProfileData:any
errorFlag = ""
successFlag = ""

email_State:string = "" ;
edit_old_email_verification:string = ""

  // Filtered Admins based on search query


  // get filteredAdmins() {
  //   return this.admins.filter(admin =>
  //     admin.name.toLowerCase().includes(this.searchQuery.toLowerCase())
  //   );
  // }



  // Handle Register/Edit state changes
  checkState(event: Event) {
    const selectedValue = (event.target as HTMLSelectElement).value;
    if (selectedValue === 'register') {
      this.registerElementClass = '';
      this.editElementClass = 'hide';
      this.isEditing = false;
    } else if (selectedValue === 'edit') {
      this.registerElementClass = 'hide';
      this.editElementClass = '';
      this.isEditing = true;
    }
  }

  // Handle job description change
  onJobDescriptionChange(event: Event) {
    this.jobDescription = (event.target as HTMLSelectElement).value;
    if(this.editElementClass === ''){
      this.searchWorkforce();
    }
    else{
      this.editingProfileState=false
      this.editingProfileData = undefined
    }
  }

  // Handle adding new user (Doctor/Life Coach Registration)
  async addEmergencyTeam() {

    if(await this.formValidator() === false){
      console.error('Form validation failed');
      return; // Exit if validation fails
    }

    const data = {
      name: this.name,
      email: this.email,
      password: this.password,
      Date_Of_Birth: `${this.birthYear}-${(this.months.indexOf(`${this.birthMonth}`)+ 1)}-${this.birthDay}`,
      phone_number: this.phone,
      Salary: this.salary,  // Use the salary field
      Profile_pic_url: null
    }

    console.log(data.Date_Of_Birth);

    this.authService.registerEmergencyTeamMember(data).subscribe((response) => {

      console.log("Emergency team member registered successfully:", response);
      // Handle success response here, e.g., show a success message or redirect
    }
    , (error) => {
      console.error("Error registering emergency team member: ", error);
    });


    console.log('User Added:', {
      name: this.name,
      email: this.email,
      phone: this.phone,
      birthMonth: this.birthMonth,
      birthDay: this.birthDay,
      birthYear: this.birthYear,
      password: this.password,
      confirmPassword: this.confirmPassword,
      specialization: this.specialization,
      description: this.description,
      sessionPrice: this.sessionPrice,
      gender: this.gender,
      salary: this.salary  // Including salary in the logged output
    });
    // Reset form after adding user
    this.name = '';
    this.email = '';
    this.phone = '';
    this.birthMonth = "Jan";
    this.birthDay = 1;
    this.birthYear = 2000;
    this.password = '';
    this.confirmPassword = '';
    this.specialization = '';
    this.description = '';
    this.sessionPrice = '';
    this.gender = '';
    this.salary = 0;  // Reset salary field

    this.successFlag = "Emergency team member added successfully!" // Set success message
    setTimeout(()=>{
      this.successFlag = ""; // Clear success message after 3 seconds
    },3000)
  }



  async addTherapist() {

    if(await this.formValidator() === false){
      console.error('Form validation failed');
      return; // Exit if validation fails
    }

    const data = {
      name: this.name ,
      email: this.email,
      password: this.password,
      Date_Of_Birth: `${this.birthYear}-${(this.months.indexOf(`${this.birthMonth}`)+ 1)}-${this.birthDay}`,
      Gender: this.gender,
      phone_number: this.phone,
      Description : this.description,
      Specialization : this.specialization,
      Session_price: this.sessionPrice,
      Profile_pic_url: null,
      role: this.jobDescription // Add the role to the data object
    }

    this.authService.registerTherapist(data).subscribe((response) => {

      console.log("Therapist registered successfully:", response);
      // Handle success response here, e.g., show a success message or redirect
    }
    , (error) => {
      console.error("Error registering Therapist: ", error);
    });

    console.log('User Added:', {
      name: this.name,
      email: this.email,
      phone: this.phone,
      birthMonth: this.birthMonth,
      birthDay: this.birthDay,
      birthYear: this.birthYear,
      password: this.password,
      confirmPassword: this.confirmPassword,
      specialization: this.specialization,
      description: this.description,
      sessionPrice: this.sessionPrice,
      gender: this.gender,
      salary: this.salary  // Including salary in the logged output
    });
    // Reset form after adding user
    this.name = '';
    this.email = '';
    this.phone = '';
    this.birthMonth = "Jan";
    this.birthDay = 1;
    this.birthYear = 2000;
    this.password = '';
    this.confirmPassword = '';
    this.specialization = '';
    this.description = '';
    this.sessionPrice = '';
    this.gender = '';
    this.salary = 0;  // Reset salary field

    this.successFlag = `${this.jobDescription} added successfully!` // Set success message
    setTimeout(()=>{
      this.successFlag = ""; // Clear success message after 3 seconds
    },3000)
  }

 searchWorkforce (){

  if(this.searchQuery !== '' && this.jobDescription !== ''){


    this.adminService.searchWorkforce(this.searchQuery,this.jobDescription).subscribe((response) => {
      this.results = response.data; // Assuming the response contains the data in 'data' property
      console.log("Workforce search results:", response);
      // Handle success response here, e.g., show a success message or redirect
    }
    , (error) => {
      console.error("Error searching workforce: ", error);
    });

  }
}



  // Delete admin method
  onDelete(id: number,type: string) {

    const data = {
      id: id,
      role: type
    };

    this.authService.deleteUser(data).subscribe((response) => {
      console.log("User deleted successfully:", response);
      // Handle success response here, e.g., show a success message or redirect
    }
    , (error) => {
      console.error("Error deleting user: ", error);
    });

    this.successFlag = `${type} deleted successfully!` // Set success message
    setTimeout(()=>{
      this.successFlag = ""; // Clear success message after 3 seconds
    },3000)
  }

  onEdit(id: number,type:string) {
    this.editingProfileState=true
    console.log("Editing profile for ID:", id , type);

    this.adminService.getWorkforce(id,type).subscribe((response) => {

      this.editingProfileData = response.data[0]; // Assuming the response contains the data in 'data' property
      console.log("Editing profile data:", this.editingProfileData);

      const birthDate = new Date(this.editingProfileData.Date_Of_Birth);

    // Extract year, month, and day
      this.birthYear = birthDate.getFullYear();
      this.birthMonth = this.months[birthDate.getMonth()] // Get the short name of the month
      this.birthDay = birthDate.getDate();

      this.id= this.editingProfileData.id
      this.edit_old_email_verification = this.editingProfileData.Email

      if(type != "emergency_team"){
        this.name = this.editingProfileData.Name;
        this.email = this.editingProfileData.Email;
        this.password = "";
        this.confirmPassword = "";
        this.gender = this.editingProfileData.Gender;
        this.phone = this.editingProfileData.phone_number;
        this.description = this.editingProfileData.Description;
        this.specialization = this.editingProfileData.Specialization;
        this.sessionPrice = this.editingProfileData.Session_price;
              }
      else{
        this.name = this.editingProfileData.Name;
        this.email = this.editingProfileData.Email;
        this.password =""
        this.confirmPassword = "";
        this.phone = this.editingProfileData.phone_number;
        this.salary = this.editingProfileData.Salary;

      }

    }
    , (error) => {
      console.error("Error fetching user data for editing: ", error);
    });




  }

  async submitEdit(type:string){
    if(await this.formValidator() === false){
      console.error('Form validation failed');
      return; // Exit if validation fails
    }

    if(type != "emergency_team"){

    const data = {
      id:this.id,
      name: this.name ,
      email: this.email,
      password: this.password,
      Date_Of_Birth: `${this.birthYear}-${(this.months.indexOf(`${this.birthMonth}`)+ 1)}-${this.birthDay}`,
      Gender: this.gender,
      phone_number: this.phone,
      Description : this.description,
      Specialization : this.specialization,
      Session_price: this.sessionPrice,
      Profile_pic_url: null,
      role: this.jobDescription // Add the role to the data object
    }


    this.authService.updateTherapist(data).subscribe((response) => {

      console.log("Therapist updated successfully:", response);
      // Handle success response here, e.g., show a success message or redirect
    }
    , (error) => {
      console.error("Error updating Therapist: ", error);
    });

    console.log('User updated:', {
      name: this.name,
      email: this.email,
      phone: this.phone,
      birthMonth: this.birthMonth,
      birthDay: this.birthDay,
      birthYear: this.birthYear,
      password: this.password,
      confirmPassword: this.confirmPassword,
      specialization: this.specialization,
      description: this.description,
      sessionPrice: this.sessionPrice,
      gender: this.gender,
      salary: this.salary  // Including salary in the logged output
    });
    // Reset form after adding user
    this.name = '';
    this.email = '';
    this.phone = '';
    this.birthMonth = "Jan";
    this.birthDay = 1;
    this.birthYear = 2000;
    this.password = '';
    this.confirmPassword = '';
    this.specialization = '';
    this.description = '';
    this.sessionPrice = '';
    this.gender = '';
    this.salary = 0;  // Reset salary field
    }
    else{
      const data = {
        id:this.id,
        name: this.name,
        email: this.email,
        password: this.password,
        Date_Of_Birth: `${this.birthYear}-${(this.months.indexOf(`${this.birthMonth}`)+ 1)}-${this.birthDay}`,
        phone_number: this.phone,
        Salary: this.salary,  // Use the salary field
        Profile_pic_url: null
      }


      this.authService.updateEmergencyTeamMember(data).subscribe((response) => {

        console.log("Emergency team member updated successfully:", response);
        // Handle success response here, e.g., show a success message or redirect
      }
      , (error) => {
        console.error("Error updating emergency team member: ", error);
      });


      console.log('User updated:', {
        name: this.name,
        email: this.email,
        phone: this.phone,
        birthMonth: this.birthMonth,
        birthDay: this.birthDay,
        birthYear: this.birthYear,
        password: this.password,
        confirmPassword: this.confirmPassword,
        specialization: this.specialization,
        description: this.description,
        sessionPrice: this.sessionPrice,
        gender: this.gender,
        salary: this.salary  // Including salary in the logged output
      });
      // Reset form after adding user
      this.name = '';
      this.email = '';
      this.phone = '';
      this.birthMonth = "Jan";
      this.birthDay = 1;
      this.birthYear = 2000;
      this.password = '';
      this.confirmPassword = '';
      this.specialization = '';
      this.description = '';
      this.sessionPrice = '';
      this.gender = '';
      this.salary = 0;  // Reset salary field
    }


    this.editingProfileData = undefined
    this.editingProfileState=false

    this.successFlag = `${type} updated successfully!` // Set success message
    setTimeout(()=>{
      this.successFlag = ""; // Clear success message after 3 seconds
    },3000)
  }

  stopEditing(){
    this.name = '';
      this.email = '';
      this.phone = '';
      this.birthMonth = "Jan";
      this.birthDay = 1;
      this.birthYear = 2000;
      this.password = '';
      this.confirmPassword = '';
      this.specialization = '';
      this.description = '';
      this.sessionPrice = '';
      this.gender = '';
      this.salary = 0;

    this.editingProfileData = undefined
    this.editingProfileState=false
  }


  // name: this.name ,
  // email: this.email,
  // password: this.password,
  // phone_number: this.phone,


  // Description : this.description,
  // Specialization : this.specialization,
  // Session_price: this.sessionPrice,



  // Salary: this.salary,  // Use the salary field




  async formValidator(){
    if(this.name === '') {
      this.errorFlag = 'Name is required'
      return false;
    }
    if(this.email === '') {
      this.errorFlag = 'Email is required'
      return false;
    }
    if (!this.email.match(/^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/)) {
      this.errorFlag = 'Invalid email format';
      return false;
    }



    if(this.edit_old_email_verification !== this.email){
      const data = {
        email: this.email
      }
      console.log("Checking email: ",data.email);
      const emailValid = await this.checkEmail({ email: this.email });
      if (!emailValid) {
        return false;
      }
    }




    if(this.phone === '') {
      this.errorFlag = 'Phone number is required'
      return false;
    }

    if(!this.isEditing || this.password!=="" || this.confirmPassword!==""){
      if(this.password === '') {
        this.errorFlag = 'Password is required'
        return false;
      }
      if(this.confirmPassword === '') {
        this.errorFlag = 'Confirm password is required'
        return false;
      }
      if(this.password !== this.confirmPassword) {
        this.errorFlag = 'Passwords do not match'
        return false;
      }
      if (this.password.match(/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$/) === null) {
        this.errorFlag = 'Password must contain at least one uppercase letter, one lowercase letter, one number, and be at least 8 characters long'
        return false;
      }


    }

    if(this.jobDescription != "emergency_team"){
      if(this.specialization === '') {
        this.errorFlag = 'Specialization is required'
        return false;
      }
      if(this.gender === '') {
        this.errorFlag = 'Gender is required'
        return false;
      }
      if(this.description === '') {
        this.errorFlag = 'Description is required'
        return false;
      }
      if(this.sessionPrice === '') {
        this.errorFlag = 'Session price is required'
        return false;
      }

    }
    else{
      if(this.salary === 0) {
        this.errorFlag = 'Salary is required'
        return false;
      }
    }


    this.errorFlag = "";
    this.edit_old_email_verification= ""
    return true

  }

  checkEmail(data: any): Promise<boolean> {
    return new Promise((resolve, reject) => {
      this.authService.checkEmail(data).subscribe(
        (response) => {
          this.email_State = response.data;
          console.log("Email check response:", this.email_State);

          if (this.email_State !== "not_taken") {
            this.errorFlag = 'Email already exists';
            resolve(false); // Resolve with false if email is already taken
          } else {
            resolve(true); // Resolve with true if email is not taken
          }
        },
        (error) => {
          console.error("Error checking email: ", error);
          this.errorFlag = 'Error checking email';
          resolve(false); // Resolve with false if there is an error
        }
      );
    });
  }


}
