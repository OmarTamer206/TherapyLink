import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class TherapistService {
  private apiUrl = 'http://localhost:3000/therapist'; // Adjust URL to your backend API

  constructor(private http: HttpClient) {}

  // Get today's sessions for a specific doctor or life coach
  getTodaySessions(): Observable<any> {
    return this.http.get(`${this.apiUrl}/today-sessions`);
  }

  // Get new patients registered this month for a specific doctor or life coach
  getNewPatientsThisMonth(): Observable<any> {
    return this.http.get(`${this.apiUrl}/new-patients-this-month`);
  }

  // Get total patients for a specific doctor or life coach
  getTotalPatients(): Observable<any> {
    return this.http.get(`${this.apiUrl}/total-patients`);
  }

  // Get patient list for a doctor or life coach
  getPatientsData(): Observable<any> {
    return this.http.get(`${this.apiUrl}/patients-data`);
  }

  // Get detailed reports and journal entries for a specific patient
  getPatientData(patientId: string): Observable<any> {
    return this.http.get(`${this.apiUrl}/patient-data/${patientId}`);
  }

  // Update patient report after a session
  updatePatientReport( sessionData: any): Observable<any> {
    return this.http.put(`${this.apiUrl}/update-patient-report`, {  session_data: sessionData });
  }

  // View available time slots for a specific date
  viewAvailableTime(date: string): Observable<any> {
    return this.http.get(`${this.apiUrl}/available-time/${date}`);
  }

  // Update available time for a doctor or life coach
  updateAvailableTime(timestamp: string): Observable<any> {
    return this.http.put(`${this.apiUrl}/update-available-time`, { timestamp });
  }

  // Get patient analytics (e.g., total patients, overall rating, returning patients)
  getPatientAnalytics(): Observable<any> {
    return this.http.get(`${this.apiUrl}/patient-analytics`);
  }

  // View all doctors of a specific type (e.g., therapists, life coaches)
  viewAllDoctors(doctorType: string): Observable<any> {
    return this.http.get(`${this.apiUrl}/all-doctors/${doctorType}`);
  }
}
