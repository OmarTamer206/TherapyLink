import { Injectable } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class PatientService {
  private apiUrl = 'http://localhost:3000/patient'; // Adjust URL to your backend API

  constructor(private http: HttpClient) {}

  // Change therapist preference for a patient
  changeTherapistPreference(user: any, choice: string): Observable<any> {
    return this.http.put(`${this.apiUrl}/change-therapist-preference`, { user, choice });
  }

  // Submit feedback for a session
  submitFeedback(session: any, rating: number, feedback: string): Observable<any> {
    return this.http.post(`${this.apiUrl}/submit-feedback`, { session, rating, feedback });
  }

  // Create a new appointment for a patient
  makeAppointment(patientData: any, sessionData: any): Observable<any> {
    return this.http.post(`${this.apiUrl}/make-appointment`, { patientData, sessionData });
  }

  // Get all doctor sessions a patient has taken
  getDoctorSessions(patientId: string): Observable<any> {
    return this.http.get(`${this.apiUrl}/doctor-sessions/${patientId}`);
  }

  // Get all group sessions a patient has participated in
  getGroupSessions(patientId: string): Observable<any> {
    return this.http.get(`${this.apiUrl}/group-sessions/${patientId}`);
  }

  // Get all emergency team sessions a patient has attended
  getEmergencyTeamSessions(patientId: string): Observable<any> {
    return this.http.get(`${this.apiUrl}/emergency-team-sessions/${patientId}`);
  }

  // Add a journal entry for a patient
  writeJournal(entryContent: string): Observable<any> {
    return this.http.post(`${this.apiUrl}/write-journal`, {entry_content: entryContent });
  }

  // Delete a journal entry for a patient
  deleteJournalEntry(journalId: string): Observable<any> {
    return this.http.delete(`${this.apiUrl}/delete-journal-entry/${journalId}`);
  }
  getProfileData(): Observable<any> {
    return this.http.get(`${this.apiUrl}/get-profile-data`);
  }
}
