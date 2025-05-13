import { Injectable } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class AuthService {
  private apiUrl = 'http://localhost:3000/auth'; // Adjust the URL based on your backend

  constructor(private http: HttpClient) {}

  // User Login
  // login(data: { email: string, password: string }): Observable<any> {
  //   return this.http.post(`${this.apiUrl}/login`, data);
  // }

  // Login for staff (doctors, managers, etc.)
  loginStaff(data: { email: string, password: string }): Observable<any> {
    return this.http.post(`${this.apiUrl}/login-staff`, data);
  }

  // User Registration
  registerPatient(data: any): Observable<any> {
    return this.http.post(`${this.apiUrl}/register`, data);
  }

  // Register therapist (doctor, life coach)
  registerTherapist(data: any): Observable<any> {
    return this.http.post(`${this.apiUrl}/register-therapist`, data);
  }

  // Register admin
  registerAdmin(data: any): Observable<any> {
    return this.http.post(`${this.apiUrl}/register-admin`, data);
  }

  // Register emergency team member
  registerEmergencyTeamMember(data: any): Observable<any> {
    return this.http.post(`${this.apiUrl}/register-emergency-member`, data);
  }

  // Update patient information
  updatePatient(data: any): Observable<any> {
    return this.http.put(`${this.apiUrl}/update`, data);
  }

  // Update therapist information
  updateTherapist(data: any): Observable<any> {
    return this.http.put(`${this.apiUrl}/update-therapist`, data);
  }

  // Update admin information
  updateAdmin(data: any): Observable<any> {
    return this.http.put(`${this.apiUrl}/update-admin`, data);
  }

  // Update emergency team member
  updateEmergencyTeamMember(data: any): Observable<any> {
    return this.http.put(`${this.apiUrl}/update-emergency-member`, data);
  }

  // Delete a user
  deleteUser(data: { id: number, role: string }): Observable<any> {
    return this.http.delete(`${this.apiUrl}/delete-user`, { body: data });
  }
  checkEmail(data: any): Observable<any> {
    return this.http.post(`${this.apiUrl}/check-email`, data);
  }

  refreshToken(refreshToken:any): Observable<any> {
    return this.http.post(`${this.apiUrl}/refresh-token`, refreshToken);
  }
  logout() {
    localStorage.removeItem('accessToken');
    localStorage.removeItem('refreshToken');
    // Redirect the user to the login page or handle accordingly
  }

   uploadProfilePic(file: File): Observable<any> {
    const formData = new FormData();
    formData.append('file', file, file.name); // Append the file to FormData

    // Assuming your backend URL for file upload is '/api/auth/upload-profile-pic'
    return this.http.post(`${this.apiUrl}/upload-profile-pic`, formData);
  }

}
