import { Component, Input } from '@angular/core';
import { CommonModule, NgFor } from '@angular/common';

@Component({
  selector: 'app-journal',
  standalone: true,
  imports: [CommonModule, NgFor],
  templateUrl: './journal.component.html',
  styleUrls: ['./journal.component.css'],
})
export class JournalComponent {
  @Input() patientName: string | null = null;

  allJournals: Record<string, { date: string; content: string }[]> = {
    'Yara Magdy': [
      {
        date: '2/4/2024',
        content: 'Yara journal content goes here...'
      }
    ],
    'Sara Morsi': [
      {
        date: '3/4/2024',
        content: 'Sara journal content goes here...'
      }
    ],
    // Add other patients
  };

  get journalEntries() {
    return this.patientName && this.allJournals[this.patientName]
      ? this.allJournals[this.patientName]
      : [];
  }
}
