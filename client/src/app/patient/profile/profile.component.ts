import { Component } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-profile',
  standalone: true,
  imports: [],
  templateUrl: './profile.component.html',
  styleUrl: './profile.component.css',
})
export class PatientProfileComponent {
  constructor(private router: Router) {}
  goToEditProfilePage() {
    this.router.navigate(['patient/edit-profile']);
  }
  goToJournalPage() {
    this.router.navigate(['patient/journal']);
  }
}
