import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';

@Component({
  selector: 'app-dashboard',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './dashboard.component.html',
  styleUrl: './dashboard.component.css'
})
export class DashboardComponent {
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
  upcomingSessions = [
    { name: 'Yara Maged', specialization: 'Trauma', date: '20 Nov', time: '11:00 AM' },
    { name: 'Mona Eid', specialization: 'Trauma', date: '20 Nov', time: '1:00 PM' },
    { name: 'Sameh Mohamad', specialization: 'Trauma', date: '20 Nov', time: '3:00 PM' },
    { name: 'Yasser Elissa', specialization: 'Trauma', date: '20 Nov', time: '4:00 PM' },
  ];
  
}
