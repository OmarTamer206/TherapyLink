import { Component } from '@angular/core';
import { RouterModule } from '@angular/router';
import { FormsModule } from '@angular/forms';  // Import FormsModule for ngModel
import { CommonModule } from '@angular/common';  // Import CommonModule for ngIf
import { AdminService } from '../../services/admin/admin.service';
import { AuthService } from '../../services/auth/auth.service';
@Component({
  selector: 'app-admin-workforce',
  standalone: true,
  imports: [RouterModule, FormsModule, CommonModule],  // Include CommonModule for ngIf
  templateUrl: './admin-workforce.component.html',
  styleUrls: ['./admin-workforce.component.css']
})
export class AdminWorkforceComponent {


  constructor(private adminService: AdminService, private authService: AuthService) {


  }

  registerElementClass: string = '';
  editElementClass: string = 'hide';
  jobDescription: string = '';  // Store selected job description
  isEditing: boolean = false;  // Flag to track if in 'edit' mode
  searchQuery: string = '';  // Variable to bind the search query
  firstName: string = '';
  lastName: string = '';
  email: string = '';
  phone: string = '';
  birthMonth: number = 1;
  birthDay: number = 1;
  birthYear: number = 2000;
  password: string = '';
  confirmPassword: string = '';
  specialization: string = '';
  description: string = '';
  sessionPrice: string = '';
  gender: string = '';
  salary: number = 0;  // Salary field declaration

  months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
  days = Array.from({length: 31}, (_, i) => i + 1); // Days 1-31
  years = Array.from({length: 101}, (_, i) => 1920 + i); // Years 1920-2020

  // Dummy Admin Data for editing
  admins = [
    { name: 'John Doe', id: 1 },
    { name: 'Jane Smith', id: 2 },
  ];

  // Filtered Admins based on search query
  get filteredAdmins() {
    return this.admins.filter(admin =>
      admin.name.toLowerCase().includes(this.searchQuery.toLowerCase())
    );
  }

  // Handle Register/Edit state changes
  checkState(event: Event) {
    const selectedValue = (event.target as HTMLSelectElement).value;
    if (selectedValue === 'register') {
      this.registerElementClass = '';
      this.editElementClass = 'hide';
      this.isEditing = false;
    } else if (selectedValue === 'edit') {
      this.registerElementClass = 'hide';
      this.editElementClass = '';
      this.isEditing = true;
    }
  }

  // Handle job description change
  onJobDescriptionChange(event: Event) {
    this.jobDescription = (event.target as HTMLSelectElement).value;
  }

  // Handle adding new user (Doctor/Life Coach Registration)
  addEmergencyTeam() {

    const data = {
      name: this.firstName + ' ' + this.lastName,
      email: this.email,
      password: this.password,
      Date_Of_Birth: `${this.birthYear}-${(this.months.indexOf(`${this.birthMonth}`)+ 1)}-${this.birthDay}`,
      phone_number: this.phone,
      Salary: this.salary,  // Use the salary field
      Profile_pic_url: null
    }

    console.log(data.Date_Of_Birth);

    this.authService.registerEmergencyTeamMember(data).subscribe((response) => {

      console.log("Emergency team member registered successfully:", response);
      // Handle success response here, e.g., show a success message or redirect
    }
    , (error) => {
      console.error("Error registering emergency team member: ", error);
    });


    console.log('User Added:', {
      firstName: this.firstName,
      lastName: this.lastName,
      email: this.email,
      phone: this.phone,
      birthMonth: this.birthMonth,
      birthDay: this.birthDay,
      birthYear: this.birthYear,
      password: this.password,
      confirmPassword: this.confirmPassword,
      specialization: this.specialization,
      description: this.description,
      sessionPrice: this.sessionPrice,
      gender: this.gender,
      salary: this.salary  // Including salary in the logged output
    });
    // Reset form after adding user
    this.firstName = '';
    this.lastName = '';
    this.email = '';
    this.phone = '';
    this.birthMonth = 1;
    this.birthDay = 1;
    this.birthYear = 2000;
    this.password = '';
    this.confirmPassword = '';
    this.specialization = '';
    this.description = '';
    this.sessionPrice = '';
    this.gender = '';
    this.salary = 0;  // Reset salary field
  }

  addTherapist() {
    console.log('User Added:', {
      firstName: this.firstName,
      lastName: this.lastName,
      email: this.email,
      phone: this.phone,
      birthMonth: this.birthMonth,
      birthDay: this.birthDay,
      birthYear: this.birthYear,
      password: this.password,
      confirmPassword: this.confirmPassword,
      specialization: this.specialization,
      description: this.description,
      sessionPrice: this.sessionPrice,
      gender: this.gender,
      salary: this.salary  // Including salary in the logged output
    });
    // Reset form after adding user
    this.firstName = '';
    this.lastName = '';
    this.email = '';
    this.phone = '';
    this.birthMonth = 1;
    this.birthDay = 1;
    this.birthYear = 2000;
    this.password = '';
    this.confirmPassword = '';
    this.specialization = '';
    this.description = '';
    this.sessionPrice = '';
    this.gender = '';
    this.salary = 0;  // Reset salary field
  }

  // Delete admin method
  onDelete(adminId: number) {
    this.admins = this.admins.filter(admin => admin.id !== adminId);
    console.log(`Admin with id ${adminId} deleted.`);
  }

  onEdit(adminId: number) {
    console.log('Editing admin with id:', adminId);
  }
}
