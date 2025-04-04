import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';

@Component({
  selector: 'app-profile',
  standalone: true,
  imports: [RouterModule,FormsModule],
  templateUrl: './profile.component.html',
  styleUrl: './profile.component.css'
})
export class lifeProfileComponent {
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
