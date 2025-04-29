import { Component } from '@angular/core';
import { Router, RouterModule } from '@angular/router';

@Component({
  selector: 'app-doctors-page',
  standalone: true,
  imports: [],
  templateUrl: './doctors-page.component.html',
  styleUrl: './doctors-page.component.css',
})
export class DoctorsPageComponent {
  constructor(private router: Router) {}
  goToMakeAppointmentPage() {
    this.router.navigate(['patient/doctor-appointment']);
  }
}
