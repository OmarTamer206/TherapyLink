import { Component } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-life-coach-appointment',
  standalone: true,
  imports: [],
  templateUrl: './life-coach-appointment.component.html',
  styleUrl: './life-coach-appointment.component.css',
})
export class LifeCoachAppointmentComponent {
  constructor(private router: Router) {}
  goToCheckoutCoachPage() {
    this.router.navigate(['patient/life-coach-checkout']);
  }
}
