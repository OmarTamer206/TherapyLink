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
  getUpcomingSessions(): Observable<any> {
    return this.http.get(`${this.apiUrl}/upcoming-sessions`);
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
  getPatientsData(session_ID:any): Observable<any> {
    return this.http.get(`${this.apiUrl}/patients-data/${session_ID}` );
  }

  // Get detailed reports and journal entries for a specific patient
  getPatientData(patientId: string): Observable<any> {
    return this.http.get(`${this.apiUrl}/patient-data/${patientId}`);
  }

  // Update patient report after a session
  updatePatientReport( report:any ,sessionData: any): Observable<any> {
    return this.http.put(`${this.apiUrl}/update-patient-report`, {  session_data: sessionData , report});
  }

  // View available time slots for a specific date
  viewAvailableTime(date: any , id?: any,type?:any): Observable<any> {
    if(id && type)
      return this.http.get(`${this.apiUrl}/available-time/${date}/${id}/${type}`);


    else
    return this.http.get(`${this.apiUrl}/available-time/${date}`);
  }

  viewAvailableDays(id: any,type:any): Observable<any> {

      return this.http.get(`${this.apiUrl}/available-days/${id}/${type}`);


    }

  // Update available time for a doctor or life coach
  updateAvailableTime(timestamp: string[] , topic = null ): Observable<any> {
    return this.http.put(`${this.apiUrl}/update-available-time`, { timestamp ,topic });
  }
  deleteAvailableTime(timestamp: string): Observable<any> {
    return this.http.delete(`${this.apiUrl}/delete-available-time`, { body: { timestamp } });
  }

  // Get patient analytics (e.g., total patients, overall rating, returning patients)
  getPatientAnalytics(): Observable<any> {
    return this.http.get(`${this.apiUrl}/patient-analytics`);
  }
  getTherapistData(): Observable<any> {
    return this.http.get(`${this.apiUrl}/get-therapist-data`);
  }
  // View all doctors of a specific type (e.g., therapists, life coaches)
  viewAllDoctors(doctorType: string , doctor_specialization:string): Observable<any> {
    return this.http.get(`${this.apiUrl}/all-doctors/${doctorType}/${doctor_specialization}`);
  }
}
