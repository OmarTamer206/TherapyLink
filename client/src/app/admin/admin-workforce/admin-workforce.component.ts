import { Component } from '@angular/core';
import { RouterModule } from '@angular/router';
import { FormsModule } from '@angular/forms';  // Import FormsModule for ngModel
import { CommonModule } from '@angular/common';  // Import CommonModule for ngIf

@Component({
  selector: 'app-admin-workforce',
  standalone: true,
  imports: [RouterModule, FormsModule, CommonModule],  // Include CommonModule for ngIf
  templateUrl: './admin-workforce.component.html',
  styleUrls: ['./admin-workforce.component.css']
})
export class AdminWorkforceComponent {
  registerElementClass: string = '';
  editElementClass: string = 'hide';
  jobDescription: string = '';  // Store selected job description
  isEditing: boolean = false;  // Flag to track if in 'edit' mode

  checkState(event: Event) {
    const selectedValue = (event.target as HTMLSelectElement).value;
    if (selectedValue === 'register') {
      this.registerElementClass = '';
      this.editElementClass = 'hide';
      this.isEditing = false;  // Not in edit mode
    } else if (selectedValue === 'edit') {
      this.registerElementClass = 'hide';
      this.editElementClass = '';
      this.isEditing = true;  // In edit mode
    }
  }

  // Handle job description change
  onJobDescriptionChange(event: Event) {
    this.jobDescription = (event.target as HTMLSelectElement).value;
  }

  admins = [
    { name: 'Youssef Ahmed', id: 1 },
    { name: 'Ahmed Yasser', id: 2 },
    { name: 'Sara Fathi', id: 3 },
    { name: 'Mohamed Ali', id: 4 },
    { name: 'Khaled Nasser', id: 5 },
  ];

  onEdit(adminId: number) {
    console.log('Editing admin with id:', adminId);
  }

  onDelete(adminId: number) {
    console.log('Deleting admin with id:', adminId);
    this.admins = this.admins.filter((admin) => admin.id !== adminId);
  }
}
