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
  changeTherapistPreference( choice: string): Observable<any> {
    return this.http.put(`${this.apiUrl}/change-therapist-preference`, { choice });
  }

  // Submit feedback for a session
  submitFeedback(session: any, rating: number, feedback: string,editState:boolean): Observable<any> {
    return this.http.post(`${this.apiUrl}/submit-feedback`, { session, rating, feedback ,editState });
  }

  checkFeedback(session: any): Observable<any> {
    return this.http.get(`${this.apiUrl}/check-feedback/${session.session_ID}/${session.session_type}`);
  }

  // Create a new appointment for a patient
  makeAppointment(sessionData: any): Observable<any> {
    return this.http.post(`${this.apiUrl}/make-appointment`, { sessionData });
  }

  // Get all doctor sessions a patient has taken
  getDoctorSessions(): Observable<any> {
    return this.http.get(`${this.apiUrl}/doctor-sessions`);
  }

  // Get all group sessions a patient has participated in
  getGroupSessions(): Observable<any> {
    return this.http.get(`${this.apiUrl}/group-sessions`);
  }

  // Get all emergency team sessions a patient has attended
  getEmergencyTeamSessions(): Observable<any> {
    return this.http.get(`${this.apiUrl}/emergency-team-sessions`);
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
  getProfileDataByID(patientID:any): Observable<any> {
    return this.http.get(`${this.apiUrl}/get-profile-data/${patientID}`);
  }
}
