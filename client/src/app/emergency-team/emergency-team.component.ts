import { Component } from '@angular/core';
import { Router, RouterModule } from '@angular/router';
import { AuthService } from '../services/auth/auth.service';
@Component({
  selector: 'app-emergency-team',
  standalone: true,
  imports: [RouterModule],
  templateUrl: './emergency-team.component.html',
  styleUrl: './emergency-team.component.css'
})
export class EmergencyTeamComponent {


    constructor(private router: Router,private authService : AuthService){

    }

  logout(){

    this.authService.logout()
    this.router.navigate(['/login']);

  }
}
