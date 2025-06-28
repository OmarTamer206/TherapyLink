import { Component } from '@angular/core';
import { RouterModule } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { NgModel } from '@angular/forms';
import { NgFor, NgIf } from '@angular/common';
import { AuthService } from '../../services/auth/auth.service';
import { TherapistService } from '../../services/therapist/therapist.service';

@Component({
  selector: 'app-life-profile',
  standalone: true,
  imports: [RouterModule, FormsModule, NgFor],
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css']
})
export class lifeProfileComponent {
  // Define the form model
    name: string = '';
    birthMonth: string ="Jan";
    birthDay: number = 1;
    birthYear: number = 2000;
    phone: string = '';
    email: string = '';
    password: string = '';
    confirmPassword: string = '';
    gender:string = "";
    profile_pic:null|string = null;

    description:any;
    specialization:any = "General Psychological Support";
    sessionPrice:any;

    months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    days = Array.from({length: 30}, (_, i) => i + 1); // Days 1-31
    years = Array.from({length: 101}, (_, i) => 1920 + i); // Years 1920-2020


    email_State: string = 'not_taken'; // Default state
    edit_old_email_verification: string = ''; // Default state
    errorFlag: string = "";
    successFlag: string = "";

    user:any;
      profilePic: any;
  selectedFile: any;
  newPhotofileName: any;

    constructor(private authService: AuthService,private therapistService: TherapistService) {

        this.therapistService.getTherapistData().subscribe((response)=>{
        console.log("Therapist data: ", response.data);

        this.user = response.data[0];

        const birthDate = new Date(this.user.Date_Of_Birth);

      // Extract year, month, and day
        this.birthYear = birthDate.getFullYear();
        this.birthMonth = this.months[birthDate.getMonth()] // Get the short name of the month
        this.birthDay = birthDate.getDate();
          console.log(this.months[birthDate.getMonth()]);



        this.name = this.user.Name;

        this.phone = this.user.phone_number;
        this.email = this.user.Email;
        this.edit_old_email_verification= this.user.Email
        this.gender = this.user.Gender
        this.description = this.user.Description
        this.specialization = this.user.Specialization
        this.sessionPrice = this.user.Session_price

        console.log("photo" , this.user.Profile_pic_url);


        // Set the profile picture URL if it exists, otherwise use a default image


      if(this.user.Profile_pic_url != null && this.user.Profile_pic_url != undefined && this.user.Profile_pic_url != "") {
          this.profilePic = `http://localhost:3000/uploads/${this.user.Profile_pic_url}`;
        }
        else{
          this.profilePic = "profileDefault.png";

        }

        },(error)=>{
          console.error("Error fetching admin data: ", error);
        })

    }






  async editProfile(){

    if(await this.formValidator() === false){
      console.error('Form validation failed');
      return; // Exit if validation fails
    }

    if (this.selectedFile) {
     await this.uploadProfilePic()
    }

    console.log(this.newPhotofileName);

    let data ={
      id:this.user.id,
      name:this.name,
      email:this.email,
      password:this.password,
      Date_Of_Birth: `${this.birthYear}-${(this.months.indexOf(`${this.birthMonth}`)+ 1)}-${this.birthDay}`,
      Gender:this.gender,
      phone_number:this.phone,
      Profile_pic_url:this.newPhotofileName,
      Description: this.description ,
      Specialization : this.specialization,
      Session_price : this.sessionPrice,
      role:"life_coach"
    };

    this.authService.updateTherapist(data).subscribe((response)=>{
      console.log("Therapist updated successfully:", response);
      // Handle success response here, e.g., show a success message or redirect
      this.successFlag = `profile updated successfully!` // Set success message
      this.edit_old_email_verification = this.email // Update the old email verification to the new one
        setTimeout(()=>{
          this.successFlag = ""; // Clear success message after 3 seconds
        },3000)
    }
    , (error) => {
      console.error("Error updating Therapist: ", error);
    });



  }


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

    const phoneRegex = /^01[0125][0-9]{8}$/;
    if (!phoneRegex.test(this.phone)) {
      this.errorFlag = 'Invalid Egyptian phone number';
      return false;
    }

      if(this.password!=="" || this.confirmPassword!==""){
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

           if(this.sessionPrice == undefined || this.sessionPrice  == null) {
        this.errorFlag = 'Session Price is required'
        return false;
      }
      if(this.sessionPrice <= 0) {
        this.errorFlag = 'Session Price cannot be zero or negative'
        return false;
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
 onImageChange(event: any): void {
    const file = event.target.files[0];
    if (file) {
      this.selectedFile = file;
      const reader = new FileReader();
      reader.onload = () => {
        this.profilePic = reader.result as string; // Update the preview
      };
      reader.readAsDataURL(file); // Read the file as data URL
    }
  }

  uploadProfilePic(): Promise<boolean> {
    return new Promise((resolve, reject) => {

    this.authService.uploadProfilePic(this.selectedFile).subscribe(
        (response) => {
          // Get the uploaded file name and update the profile
          console.log('Profile picture uploaded successfully', response);
          this.newPhotofileName = response.fileName;
          console.log("fileName" ,this.newPhotofileName);
          resolve(true)
          // You can update the profile in the backend with the returned fileName here
        },
        (error) => {
          console.error('Error uploading profile picture', error);
          resolve(false)
        }
      );
  })
}

updateDaysForMonth() {
  const monthIndex = this.months.indexOf(this.birthMonth); // 0 for Jan, 1 for Feb, etc.
  const year = this.birthYear;
  const lastDay = new Date(year, monthIndex + 1, 0).getDate(); // Get last day of selected month

  this.days = Array.from({ length: lastDay }, (_, i) => i + 1);

  // Ensure selected birthDay is within the valid range
  if (this.birthDay > lastDay) {
    this.birthDay = lastDay;
  }
}


}
