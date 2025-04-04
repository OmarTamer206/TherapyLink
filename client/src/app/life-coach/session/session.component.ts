import { Component } from '@angular/core';
import { ReportComponent } from './report/report.component';
import { JournalComponent } from './journal/journal.component';
import { NgIf, NgFor } from '@angular/common';

@Component({
  standalone: true,
  imports: [ReportComponent, JournalComponent, NgIf, NgFor],
  selector: 'app-session',
  templateUrl: './session.component.html',
  styleUrls: ['./session.component.css'],
})
export class lifeSessionComponent {
  selectedPatient: string | null = null;
  showReport = false;
  showJournal = false;

  patients = [
    'Yara Magdy',
    'Sara Morsi',
    'Jana Safaa',
    'M. Yousef',
    'Sara Magdy',
    'Lara Hosam',
    'Ahmed Ali',
    'Ali Mohamed',
  ];

  toggleReport(patient: string) {
    this.selectedPatient = patient;
    this.showReport = true;
    this.showJournal = false;
  }

  toggleJournal(patient: string) {
    this.selectedPatient = patient;
    this.showJournal = true;
    this.showReport = false;
  }
}
