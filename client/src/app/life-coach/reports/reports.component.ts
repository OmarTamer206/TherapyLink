import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';

@Component({
  selector: 'app-reports',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './reports.component.html',
  styleUrl: './reports.component.css'
})
export class lifeReportsComponent {
  reports = [
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
