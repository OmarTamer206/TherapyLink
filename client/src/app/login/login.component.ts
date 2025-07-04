import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { AuthService } from '../services/auth/auth.service';
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [FormsModule , CommonModule],
  templateUrl: './login.component.html',
  styleUrl: './login.component.css',
})
export class LoginComponent {

email: string = '';
password: string = '';
errorFlag: string = '';


  constructor(private router: Router , private authService:AuthService) {

    this.checkLoggedIn()

  }
  goToSignup() {
    this.router.navigate(['/signup']);
  }


checkLoggedIn(){
  const accessToken = localStorage.getItem('accessToken');

  if(accessToken){
    const payload = JSON.parse(atob(accessToken.split('.')[1]));
    const role = payload.role
    if(role === "patient"){
            this.router.navigate(['/patient/home']);

          }
          else if(role === "doctor"){
            this.router.navigate(['/doctor/dashboard']);
          }
          else if(role === "life_coach"){
            this.router.navigate(['/life-coach/dashboard']);
          }
          else if(role === "admin"){
            this.router.navigate(['/admin/dashboard']);
          }
          else if(role === "manager"){
            this.router.navigate(['/manager/dashboard']);
          }
          else if(role === "emergency_team"){
            this.router.navigate(['/emergency-team/emergency-team-dashboard']);
          }
          else{
            console.log("Invalid role");
          }

  }

}

  onSubmit() {

    if(this.email && this.password) {
      const data = {
        email: this.email,
        password: this.password,
      };
      this.authService.loginStaff(data).subscribe(
        (response) => {
          console.log('Login successful', response);

          this.storeTokens(response.token, response.refreshToken);

          if(response.role === "patient"){
            this.router.navigate(['/patient/home']);

          }
          else if(response.role === "doctor"){
            this.router.navigate(['/doctor/dashboard']);
          }
          else if(response.role === "life_coach"){
            this.router.navigate(['/life-coach/dashboard']);
          }
          else if(response.role === "admin"){
            this.router.navigate(['/admin/dashboard']);
          }
          else if(response.role === "manager"){
            this.router.navigate(['/manager/dashboard']);
          }
          else if(response.role === "emergency_team"){
            this.router.navigate(['/emergency-team/emergency-team-dashboard']);
          }
          else{
            console.log("Invalid role");
          }

          // Handle successful login
          // this.router.navigate(['/dashboard']);
        },
        (error) => {
          console.error('Login failed', error);
          this.errorFlag = 'Invalid email or password'; // Set error message
          // Handle login error, e.g., show an error message
        }
      );
    }



  }

   storeTokens(accessToken:any, refreshToken:any) {
    // Store the access token in memory or localStorage (depending on security preference)
    localStorage.setItem('accessToken', accessToken);
console.log("Access Token: ", accessToken);
console.log("Refresh Token: ", refreshToken);


    // Store the refresh token in a HttpOnly cookie (ideal for security)
    document.cookie = `refreshToken=${refreshToken}; HttpOnly;  SameSite=Strict;`;
  }
}
