import { Component } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [],
  templateUrl: './login.component.html',
  styleUrl: './login.component.css',
})
export class LoginComponent {
  constructor(private router: Router) {}
  goToSignup() {
    this.router.navigate(['/signup']);
  }

  onSubmit() {
    throw new Error('Method not implemented.');
  }
}
