import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class SessionService {
  private apiUrl = 'http://localhost:3000/session'; // Adjust URL to your backend API

  constructor(private http: HttpClient) {}

  // View upcoming sessions for a patient
  viewUpcomingSessionsPatient(patientId: string): Observable<any> {
    return this.http.get(`${this.apiUrl}/view-upcoming-sessions-patient/${patientId}`);
  }

  // View upcoming sessions for a doctor
  viewUpcomingSessionsDoctor(doctorId: string): Observable<any> {
    return this.http.get(`${this.apiUrl}/view-upcoming-sessions-doctor/${doctorId}`);
  }

  // View past sessions for a patient
  viewOldSessions(patientId: string): Observable<any> {
    return this.http.get(`${this.apiUrl}/view-old-sessions/${patientId}`);
  }

  // View session details for a specific past session
  viewOldSessionDetails(sessionId: string, sessionType: string): Observable<any> {
    return this.http.get(`${this.apiUrl}/view-old-session-details/${sessionId}/${sessionType}`);
  }

  // Initialize communication for a session (chat or video link)
  initializeCommunication(sessionId: string, sessionType: string): Observable<any> {
    return this.http.post(`${this.apiUrl}/initialize-communication`, { session_id: sessionId, session_type: sessionType });
  }

  // Initialize an emergency session for a patient
  initializeEmergencySession(patientId: string): Observable<any> {
    return this.http.post(`${this.apiUrl}/initialize-emergency-session/${patientId}`, {});
  }
}
