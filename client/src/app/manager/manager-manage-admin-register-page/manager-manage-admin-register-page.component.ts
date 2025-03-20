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
  registerElementClass: string = 'hide';
  editElementClass: string = '';
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
}
