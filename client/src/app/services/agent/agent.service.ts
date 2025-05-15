import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AgentService {

   private baseUrl = 'http://localhost:3000/agent'; // Express backend URL

  constructor(private http: HttpClient) {}

  startSession(sessionId: string): Observable<any> {
    return this.http.post(`${this.baseUrl}/start`, { sessionId });
  }

  getQuestion(sessionId: string): Observable<any> {
    return this.http.post(`${this.baseUrl}/ask`, { sessionId });
  }

  sendResponse(sessionId: string, userInput: string): Observable<any> {
    return this.http.post(`${this.baseUrl}/respond`, { sessionId, userInput });
  }

  getSummary(sessionId: string): Observable<any> {
    return this.http.post(`${this.baseUrl}/summary`, { sessionId });
  }
}
