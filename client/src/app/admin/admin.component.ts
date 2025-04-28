import { Component } from '@angular/core';
import { Router, RouterLink, RouterModule, RouterOutlet } from '@angular/router';
import { AuthService } from '../services/auth/auth.service';

@Component({
  selector: 'app-admin',
  standalone: true,
  imports: [RouterModule],
  templateUrl: './admin.component.html',
  styleUrl: './admin.component.css',
})
export class AdminComponent {

  constructor(private router: Router,private authService : AuthService){

  }

logout(){

  this.authService.logout()
  this.router.navigate(['/login']);

}

}
