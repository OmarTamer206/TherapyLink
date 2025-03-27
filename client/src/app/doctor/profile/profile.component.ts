import { Component } from '@angular/core';
import { RouterModule } from '@angular/router';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-profile',
  standalone: true,
  imports: [RouterModule, FormsModule],
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css']
})
export class ProfileComponent {
  // Define the form model
  phoneNumber: string = '';
  email: string = '';
  password: string = '';

  // Define the onSubmit method to handle form submission
  onSubmit() {
    console.log('Form submitted');
    console.log('Phone:', this.phoneNumber);
    console.log('Email:', this.email);
    console.log('Password:', this.password);
  }
}