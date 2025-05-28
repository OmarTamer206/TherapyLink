import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { io, Socket } from 'socket.io-client';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class EmergencyTeamService {
  private baseUrl = 'http://localhost:3000/emergency'; // Adjust if needed


  constructor(private http: HttpClient) {}



  // --- API Calls ---

  getEmergencyTeamData(): Observable<any> {
    return this.http.get(`${this.baseUrl}/data`);
  }

  getEmergencyTeamChats(): Observable<any> {
    return this.http.get(`${this.baseUrl}/chats`);
  }


}
