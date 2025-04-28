import { Component } from '@angular/core';
import { Router, RouterModule } from '@angular/router';
import { AuthService } from '../services/auth/auth.service';

@Component({
  selector: 'app-patient',
  standalone: true,
  imports: [RouterModule],
  templateUrl: './patient.component.html',
  styleUrl: './patient.component.css',
})
export class PatientComponent {
    constructor(private router: Router,private authService : AuthService){

    }

  logout(){

    this.authService.logout()
    this.router.navigate(['/login']);

  }
}
