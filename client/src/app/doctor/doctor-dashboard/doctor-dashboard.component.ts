import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-doctor-dashboard',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './doctor-dashboard.component.html',
  styleUrl: './doctor-dashboard.component.css'
})
export class DoctorDashboardComponent {
  patients = [
    { name: 'Jens Brincker', date: '27/12/2024', duration: '60 minutes' },
    { name: 'Mark Hay', date: '27/12/2024', duration: '60 minutes' },
    { name: 'Anthony Davie', date: '27/12/2024', duration: '60 minutes' },
    { name: 'David Perry', date: '27/12/2024', duration: '60 minutes' },
    { name: 'Anthony Davie', date: '27/12/2024', duration: '60 minutes' },
    { name: 'Alan Gilchrist', date: '27/12/2024', duration: '60 minutes' },
    { name: 'Mark Hay', date: '27/12/2024', duration: '60 minutes' },
    { name: 'Mark Hay', date: '27/12/2024', duration: '60 minutes' },
    { name: 'Mark Hay', date: '27/12/2024', duration: '60 minutes' },
    { name: 'Mark Hay', date: '27/12/2024', duration: '60 minutes' },
    { name: 'Mark Hay', date: '27/12/2024', duration: '60 minutes' }
  ];
}
