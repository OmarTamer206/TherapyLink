import { Component } from '@angular/core';
import { Router, RouterModule } from '@angular/router';
import { AuthService } from '../services/auth/auth.service';
import { CommonModule, NgFor } from '@angular/common';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-signup',
  standalone: true,
  imports: [RouterModule ,FormsModule , NgFor],
  templateUrl: './signup.component.html',
  styleUrl: './signup.component.css',
})
export class SignupComponent {

  // Define the form model
  fullName: string = '';
  gender: string = 'Male';
  marital_status: string = 'Single';
  phoneNumber: string = '';
  email: string = '';
  password: string = '';
  confirmPassword: string = '';
  // Need this
  birthMonth: string = 'Jan';
  birthDay: number = 1;
  birthYear: number = 2000;

  months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
  days = Array.from({length: 31}, (_, i) => i + 1); // Days 1-31
  years = Array.from({length: 101}, (_, i) => 1920 + i); // Years 1920-2020



  email_State: string = 'not_taken'; // Default state
  errorFlag: string = '';



  constructor(private router: Router , private authService: AuthService) {

  }


    // Initialize values in ngOnInit to make sure they are set before the view is rendered.

  goToLogin() {
    this.router.navigate(['/login']);
  }




  async onSubmit() {

    if(await this.formValidator() === false){
      console.error('Form validation failed');
      return; // Exit if validation fails
    }

    let data ={
      name:this.fullName,
      email:this.email,
      password:this.password,
      Date_Of_Birth: `${this.birthYear}-${(this.months.indexOf(`${this.birthMonth}`)+ 1)}-${this.birthDay}`,
      Gender:this.gender,
      phone_number:this.phoneNumber,
      Marital_Status:this.marital_status
    };


    this.authService.registerPatient(data).subscribe(
       (response) => {
        console.log("Registration response: ", response);

          // Store tokens in localStorage or cookies
          this.router.navigate(['/login']);

      },
      (error) => {
        console.error("Error during registration: ", error);
        this.errorFlag = 'Error during registration!';
      }
    );


  }





  async formValidator(){
    if(this.fullName === '') {
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




      const data = {
        email: this.email
      }
      console.log("Checking email: ",data.email);
      const emailValid = await this.checkEmail({ email: this.email });
      if (!emailValid) {
        return false;
      }





    if(this.phoneNumber === '') {
      this.errorFlag = 'Phone number is required'
      return false;
    }

    const phoneRegex = /^01[0125][0-9]{8}$/;
    if (!phoneRegex.test(this.phoneNumber)) {
      this.errorFlag = 'Invalid Egyptian phone number';
      return false;
    }


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









    this.errorFlag = "";
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
