import { NgIf } from '@angular/common';
import { Component } from '@angular/core';
import { Router } from '@angular/router';


@Component({
  selector: 'app-life-coach-checkout',
  standalone: true,
  imports: [NgIf],
  templateUrl: './doctor-checkout.component.html',
  styleUrls: ['./doctor-checkout.component.css']
})
export class DoctorCheckoutComponent {
  showSuccess = false;

  constructor(private router: Router) {}

  handleCheckout(): void {
    this.showSuccess = true;

    // After 5 seconds, redirect
    setTimeout(() => {
      this.router.navigate(['patient/home']); // Change to actual route
    }, 3000);
  }
}
