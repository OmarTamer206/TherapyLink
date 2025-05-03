import { Component } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-doctor-appointment',
  standalone: true,
  imports: [],
  templateUrl: './doctor-appointment.component.html',
  styleUrl: './doctor-appointment.component.css',
})
export class DoctorAppointmentComponent {
  constructor(private router: Router) {}
  goToCheckoutPage() {
    this.router.navigate(['patient/doctor-checkout']);
  }
}
