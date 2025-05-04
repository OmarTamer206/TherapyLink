import { Component } from '@angular/core';
import { RouterModule } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { NgModel } from '@angular/forms';
import { NgFor, NgIf } from '@angular/common';
import { AuthService } from '../../services/auth/auth.service';

@Component({
  selector: 'app-life-profile',
  standalone: true,
  imports: [RouterModule, FormsModule, NgFor],
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css']
})
export class lifeProfileComponent {
  name: string = '';
  birthMonth: string = "Jan";
  birthDay: number = 1;
  birthYear: number = 2000;
  phone: string = '';
  email: string = '';
  password: string = '';
  confirmPassword: string = '';
  gender: string = "";
  profile_pic: null | string = null;

  months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
  days = Array.from({ length: 31 }, (_, i) => i + 1);
  years = Array.from({ length: 101 }, (_, i) => 1920 + i);

  email_State: string = 'not_taken';
  edit_old_email_verification: string = '';
  errorFlag: string = "";
  successFlag: string = "";
  user: any = { id: 1 }; // Minimal mock data if needed

  constructor(private authService: AuthService) {
    // Optional: Populate initial values manually or leave empty
    // You can fetch the profile later if needed
  }

  async editProfile() {
    if (await this.formValidator() === false) return;

    let data = {
      id: this.user.id,
      name: this.name,
      email: this.email,
      password: this.password,
      Date_Of_Birth: `${this.birthYear}-${(this.months.indexOf(this.birthMonth) + 1)}-${this.birthDay}`,
      Gender: this.gender,
      phone_number: this.phone,
      profile_pic: this.profile_pic,
      role: "life-coach"
    };

    this.authService.updateLifeCoach(data).subscribe((response) => {
      this.successFlag = `Profile updated successfully!`;
      this.edit_old_email_verification = this.email;
      setTimeout(() => { this.successFlag = ""; }, 3000);
    }, (error) => {
      console.error("Error updating profile: ", error);
    });
  }

  async formValidator() {
    if (this.name === '') return this.error('Name is required');
    if (this.email === '') return this.error('Email is required');
    if (!this.email.match(/^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/)) return this.error('Invalid email format');

    if (this.edit_old_email_verification !== this.email) {
      const emailValid = await this.checkEmail({ email: this.email });
      if (!emailValid) return false;
    }

    if (this.phone === '') return this.error('Phone number is required');

    if (this.password !== "" || this.confirmPassword !== "") {
      if (this.password === '') return this.error('Password is required');
      if (this.confirmPassword === '') return this.error('Confirm password is required');
      if (this.password !== this.confirmPassword) return this.error('Passwords do not match');
      if (!this.password.match(/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$/))
        return this.error('Password must meet complexity requirements');
    }

    this.errorFlag = "";
    return true;
  }

  error(msg: string) {
    this.errorFlag = msg;
    return false;
  }

  checkEmail(data: any): Promise<boolean> {
    return new Promise((resolve) => {
      this.authService.checkEmail(data).subscribe(
        (response) => {
          this.email_State = response.data;
          if (this.email_State !== "not_taken") {
            this.errorFlag = 'Email already exists';
            resolve(false);
          } else {
            resolve(true);
          }
        },
        (error) => {
          this.errorFlag = 'Error checking email';
          resolve(false);
        }
      );
    });
  }
}
