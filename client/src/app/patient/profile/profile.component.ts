import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { AuthService } from '../../services/auth/auth.service';

@Component({
  selector: 'app-profile',
  standalone: true,
  imports: [],
  templateUrl: './profile.component.html',
  styleUrl: './profile.component.css',
})
export class PatientProfileComponent {

  constructor(private router: Router,private authService: AuthService) {}
  goToEditProfilePage() {
    this.router.navigate(['patient/edit-profile']);
  }
  goToJournalPage() {
    this.router.navigate(['patient/journal']);
  }
  logout(){
    this.authService.logout()
    this.router.navigate(['/login']);
  }

}
