import { Component } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-life-coach-page',
  standalone: true,
  imports: [],
  templateUrl: './life-coach-page.component.html',
  styleUrl: './life-coach-page.component.css',
})
export class LifeCoachPageComponent {
  constructor(private router: Router) {}
  goToMakeAppointmentCoachPage() {
    this.router.navigate(['patient/life-coach-appointment']);
  }
}
