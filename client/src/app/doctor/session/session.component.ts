import { Component } from '@angular/core';
import { ReportComponent } from './report/report.component';
import { JournalComponent } from './journal/journal.component';
import { NgFor, NgIf } from '@angular/common';

@Component({
  standalone: true,
  imports: [ReportComponent, JournalComponent, NgIf],
  selector: 'app-session',
  templateUrl: './session.component.html',
  styleUrls: ['./session.component.css'],
})
export class SessionComponent {
  showReport = false;
  showJournal = false;

  // Toggle visibility for the Report
  toggleReport() {
    this.showReport = !this.showReport;
    if (this.showReport) {
      this.showJournal = false; // Close Journal if Report is shown
    }
  }

  // Toggle visibility for the Journal
  toggleJournal() {
    this.showJournal = !this.showJournal;
    console.log(this.showJournal);

    if (this.showJournal) {
      this.showReport = false; // Close Report if Journal is shown
    }
  }
}
