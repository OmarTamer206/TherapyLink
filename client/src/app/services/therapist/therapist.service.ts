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
  getTodaySessions(doctorId: string, type: string): Observable<any> {
    return this.http.get(`${this.apiUrl}/today-sessions/${doctorId}/${type}`);
  }

  // Get new patients registered this month for a specific doctor or life coach
  getNewPatientsThisMonth(doctorId: string, type: string): Observable<any> {
    return this.http.get(`${this.apiUrl}/new-patients-this-month/${doctorId}/${type}`);
  }

  // Get total patients for a specific doctor or life coach
  getTotalPatients(doctorId: string, type: string): Observable<any> {
    return this.http.get(`${this.apiUrl}/total-patients/${doctorId}/${type}`);
  }

  // Get patient list for a doctor or life coach
  getPatientsData(doctorId: string, type: string): Observable<any> {
    return this.http.get(`${this.apiUrl}/patients-data/${doctorId}/${type}`);
  }

  // Get detailed reports and journal entries for a specific patient
  getPatientData(patientId: string): Observable<any> {
    return this.http.get(`${this.apiUrl}/patient-data/${patientId}`);
  }

  // Update patient report after a session
  updatePatientReport(doctorId: string, sessionData: any): Observable<any> {
    return this.http.put(`${this.apiUrl}/update-patient-report`, { doctor_id: doctorId, session_data: sessionData });
  }

  // View available time slots for a specific date
  viewAvailableTime(date: string, doctorId: string, doctorType: string): Observable<any> {
    return this.http.get(`${this.apiUrl}/available-time/${date}/${doctorId}/${doctorType}`);
  }

  // Update available time for a doctor or life coach
  updateAvailableTime(timestamp: string, doctorId: string): Observable<any> {
    return this.http.put(`${this.apiUrl}/update-available-time`, { timestamp, doctor_id: doctorId });
  }

  // Get patient analytics (e.g., total patients, overall rating, returning patients)
  getPatientAnalytics(doctorId: string, type: string): Observable<any> {
    return this.http.get(`${this.apiUrl}/patient-analytics/${doctorId}/${type}`);
  }

  // View all doctors of a specific type (e.g., therapists, life coaches)
  viewAllDoctors(doctorType: string): Observable<any> {
    return this.http.get(`${this.apiUrl}/all-doctors/${doctorType}`);
  }
}
