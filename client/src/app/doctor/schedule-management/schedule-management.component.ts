import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-schedule-management',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './schedule-management.component.html',
  styleUrl: './schedule-management.component.css'
})
export class ScheduleManagementComponent {
  currentDate = new Date();
  selectedDay: number | null = null;
  days: number[] = [];

  reports = [
    { time: '09:00am - 11:00am', name: 'Patient Name' },
    { time: '02:00am - 04:00pm', name: 'Patient Name' },
    { time: '04:00am - 06:00pm', name: 'Patient Name' },
  ];

  constructor() {
    this.generateDays();
  }

  generateDays() {
    const year = this.currentDate.getFullYear();
    const month = this.currentDate.getMonth();
    const lastDay = new Date(year, month + 1, 0).getDate();
    this.days = Array.from({ length: lastDay }, (_, i) => i + 1);
  }

  selectDay(day: number) {
    this.selectedDay = day;
  }

  nextMonth() {
    this.currentDate.setMonth(this.currentDate.getMonth() + 1);
    this.generateDays();
    this.selectedDay = null;
  }

  prevMonth() {
    this.currentDate.setMonth(this.currentDate.getMonth() - 1);
    this.generateDays();
    this.selectedDay = null;
  }

  getMonthYear() {
    return this.currentDate.toLocaleString('default', { month: 'long', year: 'numeric' });
  }

  goToToday() {
    this.currentDate = new Date();
    this.generateDays();
    this.selectedDay = this.currentDate.getDate();
  }
}
