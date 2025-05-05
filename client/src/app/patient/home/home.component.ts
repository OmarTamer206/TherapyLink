import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css'],
})
export class HomeComponent {
  showTherapistPreference = false;
  selectedIndex: number | null = null;
  selectedTherapist: string | null = null; // <-- NEW VARIABLE

  therapists = [
    { name: 'Clinical Psychologist', image: 'Clinical Psychologist.png' },
    { name: 'Child and Adolescent Therapist', image: 'Child and Adolescent Therapist.png' },
    { name: 'Counseling Psychologist', image: 'Counseling Psychologist.png' },
    { name: 'Couple Therapy', image: 'Couple Therapy.png' },
    { name: 'Trauma Therapist', image: 'Trauma Therapist.png' },
  ];

  goToChatbot(): void {
    console.log('Go to Chatbot');
  }

  goToDoctorsPage(): void {
    console.log('Go to Doctors Page');
  }

  goToUpcomingSessionPage(): void {
    console.log('Go to Session Page');
  }

  toggleTherapistPreference(): void {
    this.showTherapistPreference = !this.showTherapistPreference;
  }

  selectTherapist(index: number): void {
    this.selectedIndex = index;
    this.selectedTherapist = this.therapists[index].name; // <-- Save selected name
    console.log('Selected therapist:', this.selectedTherapist);
  }
}
