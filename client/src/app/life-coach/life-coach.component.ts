import { Component } from '@angular/core';
import { Router, RouterModule } from '@angular/router';
import { AuthService } from '../services/auth/auth.service';

@Component({
  selector: 'app-life-coach',
  standalone: true,
  imports: [RouterModule],
  templateUrl: './life-coach.component.html',
  styleUrl: './life-coach.component.css'
})
export class LifeCoachComponent {
  constructor(private router: Router,private authService : AuthService){

  }

logout(){

  this.authService.logout()
  this.router.navigate(['/login']);

}
}
