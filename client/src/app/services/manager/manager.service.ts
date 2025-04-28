import { Injectable } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class ManagerService {
  private apiUrl = 'http://localhost:3000/manager'; // Adjust URL as per your backend

  constructor(private http: HttpClient) {}

  // Get average patient count per day
  getAveragePatientsCountPerDay(): Observable<any> {
    return this.http.get(`${this.apiUrl}/average-patients-count-per-day`);
  }

  // Get total profit count
  getTotalProfitCount(): Observable<any> {
    return this.http.get(`${this.apiUrl}/total-profit-count`);
  }

  // Get total salaries expense count
  getTotalSalariesExpenseCount(): Observable<any> {
    return this.http.get(`${this.apiUrl}/total-salaries-expense-count`);
  }

  // Get total revenue count
  getTotalRevenueCount(): Observable<any> {
    return this.http.get(`${this.apiUrl}/total-revenue-count`);
  }

  // Search admin by name
  searchAdmin(name: string): Observable<any> {
    const params = new HttpParams().set('name', name);
    return this.http.get(`${this.apiUrl}/search-admin`, { params });
  }

  // Get total revenue by month
  getTotalRevenueByMonth(): Observable<any> {
    return this.http.get(`${this.apiUrl}/total-revenue-by-month`);
  }

  // Get total expenses by month
  getTotalExpenseByMonth(): Observable<any> {
    return this.http.get(`${this.apiUrl}/total-expense-by-month`);
  }

  // Generate report based on factor and date range
  generateReport(
    report_type: string,
    date_from: string,
    date_to: string
  ): Observable<any> {
    const params = new HttpParams()
      .set('report_type', report_type)
      .set('date_from', date_from)
      .set('date_to', date_to);
    return this.http.get(`${this.apiUrl}/report`, { params });
  }
  getManagerData(): Observable<any> {
    return this.http.get(`${this.apiUrl}/get-manager-data`);
  }

  getAdmin(id: number): Observable<any> {
    const params = new HttpParams().set('id', id);
    return this.http.get(`${this.apiUrl}/get-admin-data`, { params });
  }
  getTotalCoachesCount(): Observable<any> {
    return this.http.get(`${this.apiUrl}/total-coaches-count`);
  }
  getTotalEmergencyTeamCount(): Observable<any> {
    return this.http.get(`${this.apiUrl}/total-emergency-team-count`);
  }
}
