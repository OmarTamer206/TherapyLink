import { Component } from '@angular/core';
import { RouterModule } from '@angular/router';
import { FormsModule } from '@angular/forms';  // Import FormsModule for ngModel

@Component({
  selector: 'app-admin-refund',
  standalone: true,
  imports: [RouterModule, FormsModule],  // Include FormsModule for ngModel
  templateUrl: './admin-refund.component.html',
  styleUrls: ['./admin-refund.component.css']  // Corrected to styleUrls
})
export class AdminRefundComponent {
  sessionId: string = '';
  refundReason: string = '';
  refundHistory = [
    { name: 'Yara Maged', date: '20 Nov', reason: 'Have meeting' },
    { name: 'Nour Yasser', date: '20 Nov', reason: 'My son is sick' },
    { name: 'Malek Yasser', date: '20 Nov', reason: 'I have quiz in uni' },
    { name: 'Mohamed Ashraf', date: '20 Nov', reason: 'I have a lot of work & meetings' },
    { name: 'Mahmoud Eissa', date: '20 Nov', reason: 'My mom is sick' },
    { name: 'Farida Yasser', date: '20 Nov', reason: 'I will be instructor this day' }
  ];

  submitRefund() {
    console.log('Refund submitted:', this.sessionId, this.refundReason);
    // Add logic to store the refund info or call a backend API
  }
}
