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

  checkState(event: Event) {
    const selectedValue = (event.target as HTMLSelectElement).value;
    if (selectedValue === 'register') {
      this.registerElementClass = '';
      this.editElementClass = 'hide';
    } else if (selectedValue === 'edit') {
      this.registerElementClass = 'hide';
      this.editElementClass = '';
    }
  }

  admins = [
    { name: 'Youssef Ahmed', id: 1 },
    { name: 'Ahmed Yasser', id: 2 },
    { name: 'Sara Fathi', id: 3 },
    { name: 'Mohamed Ali', id: 4 },
    { name: 'Khaled Nasser', id: 5 },
  ];

  // For managing search and filters
  jobDescriptionFilter = '';
  registerEditFilter = '';

  onEdit(adminId: number) {
    console.log('Editing admin with id:', adminId);
  }

  onDelete(adminId: number) {
    console.log('Deleting admin with id:', adminId);
    this.admins = this.admins.filter((admin) => admin.id !== adminId);
  }
}
