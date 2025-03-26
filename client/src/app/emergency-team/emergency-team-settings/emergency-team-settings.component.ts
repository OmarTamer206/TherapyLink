import { Component } from '@angular/core';
import { RouterModule } from '@angular/router';
import { FormsModule } from '@angular/forms';  // Import FormsModule for ngModel

@Component({
  selector: 'app-emergency-team-settings',
  standalone: true,
  imports: [RouterModule, FormsModule], // Include FormsModule in the imports array
  templateUrl: './emergency-team-settings.component.html',
  styleUrls: ['./emergency-team-settings.component.css']
})
export class EmergencyTeamSettingsComponent {
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
