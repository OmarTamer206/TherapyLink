import { Injectable } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class AdminService {
  private apiUrl = 'http://localhost:3000/admin'; // Adjust this to your backend URL

  constructor(private http: HttpClient) {}

  // Get total doctors count
  getTotalDoctorsCount(): Observable<any> {
    return this.http.get(`${this.apiUrl}/total-doctors-count`);
  }

  // Get total appointments count
  getTotalAppointmentsCount(): Observable<any> {
    return this.http.get(`${this.apiUrl}/total-appointments-count`);
  }

  // Get total patients count
  getTotalPatientCount(): Observable<any> {
    return this.http.get(`${this.apiUrl}/total-patient-count`);
  }

  // Get total earnings count
  getTotalEarningsCount(): Observable<any> {
    return this.http.get(`${this.apiUrl}/total-earnings-count`);
  }

  // Get patient visit data by month
  getPatientVisitDataByMonth(): Observable<any> {
    return this.http.get(`${this.apiUrl}/patient-visit-data-by-month`);
  }

  // Search workforce by name and type
  searchWorkforce(name: string, type: string): Observable<any> {
    const params = new HttpParams().set('name', name).set('type', type);
    return this.http.get(`${this.apiUrl}/search-workforce`, { params });
  }

  getWorkforce(id: number, type: string): Observable<any> {
    const params = new HttpParams().set('id', id).set('type', type);
    return this.http.get(`${this.apiUrl}/get-workforce-data`, { params });
  }

  // Get booked session data
  getBookedSessionData(): Observable<any> {
    return this.http.get(`${this.apiUrl}/booked-session-data`);
  }
  getCancelledSessionData(): Observable<any> {
    return this.http.get(`${this.apiUrl}/cancelled-session-data`);
  }

  // Get available session data
  getAvailableSessionData(): Observable<any> {
    return this.http.get(`${this.apiUrl}/available-session-data`);
  }
  getAdminData(): Observable<any> {
    return this.http.get(`${this.apiUrl}/get-admin-data`);
  }
}
