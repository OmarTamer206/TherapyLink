import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
@Component({
  selector: 'app-manager-manage-admin-register-page',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './manager-manage-admin-register-page.component.html',
  styleUrl: './manager-manage-admin-register-page.component.css',
})
export class ManagerManageAdminRegisterPageComponent {
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
