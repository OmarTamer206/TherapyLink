import { Component, Input } from '@angular/core';
import { CommonModule, NgFor } from '@angular/common';

@Component({
  selector: 'app-reports',
  standalone: true,
  imports: [CommonModule, NgFor],
  templateUrl: './report.component.html',
  styleUrls: ['./report.component.css'],
})
export class ReportComponent {
  @Input() patientName: string | null = null;

  allReports: Record<string, { name: string; concern: string }[]> = {
    'Yara Magdy': [
      { name: 'Dr. Shalaby', concern: 'Report for Yara...' }
    ],
    'Sara Morsi': [
      { name: 'Dr. Shalaby', concern: 'Report for Sara...' }
    ],
    // Add more...
  };

  get reportEntries() {
    return this.patientName && this.allReports[this.patientName]
      ? this.allReports[this.patientName]
      : [];
  }
}
