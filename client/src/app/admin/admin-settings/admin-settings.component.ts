import { Component } from '@angular/core';
import { RouterModule } from '@angular/router';
import { FormsModule } from '@angular/forms';  // Correct import
import { NgModel } from '@angular/forms';      // Correct import for ngModel
import { NgFor, NgIf } from '@angular/common';
import { AuthService } from '../../services/auth/auth.service';

@Component({
  selector: 'app-admin-settings',
  standalone: true,
  imports: [RouterModule, FormsModule,NgFor,NgIf],  // Add FormsModule here for ngModel to work
  templateUrl: './admin-settings.component.html',
  styleUrls: ['./admin-settings.component.css']
})
export class AdminSettingsComponent {







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

  months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
  days = Array.from({length: 31}, (_, i) => i + 1); // Days 1-31
  years = Array.from({length: 101}, (_, i) => 1920 + i); // Years 1920-2020


  email_State: string = 'not_taken'; // Default state
  edit_old_email_verification: string = ''; // Default state
  errorFlag: string = "";

  constructor(private authService: AuthService) {}



editProfile(){

  this.formValidator()

  let data ={
    name:this.name,
    email:this.email,
    password:this.password,
    Date_Of_Birth: `${this.birthYear}-${(this.months.indexOf(`${this.birthMonth}`)+ 1)}-${this.birthDay}`,
    Gender:this.gender,
    phone_number:this.phone,
    profile_pic:this.profile_pic
  };

  this.authService.updateAdmin(data).subscribe((response)=>{
    console.log("Admin updated successfully:", response);
    // Handle success response here, e.g., show a success message or redirect
  }
  , (error) => {
    console.error("Error updating Admin: ", error);
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

    if(this.password!==""){
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
