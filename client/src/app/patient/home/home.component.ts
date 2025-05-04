import { Component, OnInit } from '@angular/core';
import { Router, RouterModule } from '@angular/router';
import { Chart } from 'chart.js';

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [],
  templateUrl: './home.component.html',
  styleUrl: './home.component.css',
})
export class HomeComponent {
  constructor(private router: Router) {}
  goToChatbot() {
    this.router.navigate(['patient/chatbot']);
  }
  goToDoctorsPage() {
    this.router.navigate(['patient/doctors-page']);
  }
  goToUpcomingSessionPage() {
    this.router.navigate(['patient/session-page']);
  }
}
