import { Component } from '@angular/core';
import { RouterModule } from '@angular/router';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-admin-workforce',
  standalone: true,
  imports: [RouterModule, FormsModule],
  templateUrl: './admin-workforce.component.html',
  styleUrls: ['./admin-workforce.component.css']
})
export class AdminWorkforceComponent {
  selectedJob: string = '';  // Holds selected job
  selectedAction: string = '';  // Holds selected action (register/edit)

  // Initialize job forms data
  doctor = { name: 'Youssef Ahmed', email: 'example@gmail.com', phone: '+20 30100214231' };
  lifeCoach = { name: 'Youssef Ahmed', email: 'example@gmail.com', phone: '+20 30100214231' };
  emergencyTeam = {
    firstName: '',
    lastName: '',
    email: '',
    phone: '',
    dob: '',
    password: '',
    confirmPassword: ''
  };

  // Initialize users list for editing
  users = [
    { name: 'Youssef Ahmed', email: 'example@gmail.com', image: 'user-image-url' },
    { name: 'Jane Doe', email: 'jane.doe@gmail.com', image: 'user-image-url' },
    { name: 'John Smith', email: 'john.smith@gmail.com', image: 'user-image-url' },
    { name: 'Alice Johnson', email: 'alice.johnson@gmail.com', image: 'user-image-url' },
    { name: 'Bob Brown', email: 'bob.brown@gmail.com', image: 'user-image-url' },
    { name: 'Charlie White', email: 'charlie.white@gmail.com', image: 'user-image-url' },
    { name: 'David Black', email: 'david.black@gmail.com', image: 'user-image-url' }
  ];

  // Handle job change selection
  onJobChange() {
    console.log('Job Changed:', this.selectedJob);
  }

  // Handle action change selection (Register/Edit)
  onActionChange() {
    console.log('Action Changed:', this.selectedAction);
  }

  // Methods for editing and registering doctors
  editDoctor() {
    console.log('Doctor Edited:', this.doctor);
    // Implement save logic for the doctor form
  }

  registerDoctor() {
    console.log('Doctor Registered:', this.doctor);
    // Implement register logic for the doctor form
  }

  // Methods for editing and registering life coaches
  editLifeCoach() {
    console.log('Life Coach Edited:', this.lifeCoach);
    // Implement save logic for the life coach form
  }

  registerLifeCoach() {
    console.log('Life Coach Registered:', this.lifeCoach);
    // Implement register logic for the life coach form
  }

  // Methods for editing and registering emergency team
  editEmergencyTeam() {
    console.log('Emergency Team Edited:', this.emergencyTeam);
    // Implement save logic for the emergency team form
  }

  registerEmergencyTeam() {
    console.log('Emergency Team Registered:', this.emergencyTeam);
    // Implement register logic for the emergency team form
  }

  // Method to handle user edit
  editUser(user: any) {
    console.log('Editing user:', user);
    // Implement user edit logic
  }
}
