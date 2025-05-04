import { Component } from '@angular/core';
import { RouterModule } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { NgModel } from '@angular/forms';
import { NgFor, NgIf } from '@angular/common';

@Component({
  selector: 'app-doctor-profile',
  standalone: true,
  imports: [RouterModule, FormsModule, NgFor],
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css']
})
export class ProfileComponent {
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

  errorFlag: string = "";
  successFlag: string = "";

  editProfile() {
    if (this.name === '' || this.email === '' || this.phone === '') {
      this.errorFlag = 'All fields are required';
      return;
    }

    if (this.password !== this.confirmPassword) {
      this.errorFlag = 'Passwords do not match';
      return;
    }

    this.successFlag = "Profile updated successfully!";
    setTimeout(() => {
      this.successFlag = "";
    }, 3000);

    console.log("Doctor updated:", {
      name: this.name,
      email: this.email,
      phone: this.phone,
      gender: this.gender,
      Date_Of_Birth: `${this.birthYear}-${this.birthMonth}-${this.birthDay}`
    });
  }
}
