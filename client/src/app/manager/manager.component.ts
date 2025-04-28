import { Component } from '@angular/core';
import { RouterOutlet, RouterModule, Router } from '@angular/router';
import { AuthService } from '../services/auth/auth.service';

@Component({
  selector: 'app-manager',
  standalone: true,
  imports: [RouterModule],
  templateUrl: './manager.component.html',
  styleUrl: './manager.component.css',
})
export class ManagerComponent {
    constructor(private router: Router,private authService : AuthService){

    }

  logout(){

    this.authService.logout()
    this.router.navigate(['/login']);

  }
}
