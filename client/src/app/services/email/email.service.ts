// src/app/services/email.service.ts
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

interface EmailPayload {
  to: string;
  subject: string;
  message: string;
}

@Injectable({
  providedIn: 'root'
})
export class EmailService {
  private baseUrl = 'http://localhost:3000/email'; // Change to your backend URL

  constructor(private http: HttpClient) {}

  sendEmail(to: string, subject: string, message: string): Observable<any> {
    return this.http.post(`${this.baseUrl}/send`, { to, subject, message });
  }
}
