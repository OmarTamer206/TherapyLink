import { Component } from '@angular/core';
import { Router, RouterModule } from '@angular/router';
import { AuthService } from '../services/auth/auth.service';

@Component({
  selector: 'app-doctor',
  standalone: true,
  imports: [RouterModule],
  templateUrl: './doctor.component.html',
  styleUrl: './doctor.component.css',
})
export class DoctorComponent {

    constructor(private router: Router,private authService : AuthService){

    }

  logout(){

    this.authService.logout()
    this.router.navigate(['/login']);

  }
}
