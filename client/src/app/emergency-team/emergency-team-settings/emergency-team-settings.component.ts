import { Component } from '@angular/core';
import { RouterModule } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { NgFor } from '@angular/common';

@Component({
  selector: 'app-emergency-team-settings',
  standalone: true,
  imports: [RouterModule, FormsModule, NgFor],
  templateUrl: './emergency-team-settings.component.html',
  styleUrls: ['./emergency-team-settings.component.css']
})
export class EmergencyTeamSettingsComponent {
  name: string = '';
  birthMonth: string = 'Jan';
  birthDay: number = 1;
  birthYear: number = 2000;
  phone: string = '';
  email: string = '';
  password: string = '';
  confirmPassword: string = '';
  gender: string = '';
  profile_pic: null | string = null;

  months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
  days = Array.from({ length: 31 }, (_, i) => i + 1);
  years = Array.from({ length: 101 }, (_, i) => 1920 + i);

  errorFlag: string = "";
  successFlag: string = "";

  async editProfile() {
    if (!this.name || !this.email || !this.phone) {
      this.errorFlag = 'All required fields must be filled';
      return;
    }
    this.successFlag = 'Emergency profile updated successfully!';
    setTimeout(() => this.successFlag = '', 3000);
  }
}
