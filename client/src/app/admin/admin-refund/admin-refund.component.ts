import { Component } from '@angular/core';
import { RouterModule } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-admin-refund',
  standalone: true,
  imports: [RouterModule, FormsModule, CommonModule],
  templateUrl: './admin-refund.component.html',
  styleUrls: ['./admin-refund.component.css']
})
export class AdminRefundComponent {
  selectedReportIndex: number = -1;
  responseText: string = '';

  doctor = {
    name: 'Dr. Sarah Hassan',
    email: 'shassan@exammmple.com',
    phone: '+20112345678' // formatted for tel: link
  };

  reports = [
    { id: 1, reason: 'Long waiting time' },
    { id: 2, reason: 'Doctor unavailable' },
    { id: 3, reason: 'Technical issues' },
    { id: 4, reason: 'Wrong session booked' }
  ];

  selectReport(index: number) {
    this.selectedReportIndex = index;
    this.responseText = '';
    console.log('Selected report:', index + 1);
  }
}
