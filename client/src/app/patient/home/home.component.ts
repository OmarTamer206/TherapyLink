import { Component } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css'],
})
export class HomeComponent {
  showTherapistPreference: boolean = false;

  constructor(private router: Router) {}

  goToChatbot(): void {
    this.router.navigate(['patient/chatbot']);
  }

  goToDoctorsPage(): void {
    this.router.navigate(['patient/doctors-page']);
  }

  goToUpcomingSessionPage(): void {
    this.router.navigate(['patient/session-page']);
  }

  toggleTherapistPreference(): void {
    this.showTherapistPreference = !this.showTherapistPreference;
  }
}
