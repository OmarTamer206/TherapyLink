import { Component } from '@angular/core';
import { RouterModule } from '@angular/router';
import { FormsModule } from '@angular/forms';  // Correct import
import { NgModel } from '@angular/forms';      // Correct import for ngModel

@Component({
  selector: 'app-admin-settings',
  standalone: true,
  imports: [RouterModule, FormsModule],  // Add FormsModule here for ngModel to work
  templateUrl: './admin-settings.component.html',
  styleUrls: ['./admin-settings.component.css']
})
export class AdminSettingsComponent {
  // Define the form model
  phoneNumber: string = '';
  email: string = '';
  password: string = '';

  // Define the onSubmit method to handle form submission
  onSubmit() {
    // Output the form data to the console for now
    console.log('Form submitted');
    console.log('Phone:', this.phoneNumber);
    console.log('Email:', this.email);
    console.log('Password:', this.password);
  }
}
