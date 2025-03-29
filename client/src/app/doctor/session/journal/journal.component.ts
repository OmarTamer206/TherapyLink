import { Component } from '@angular/core';
import { CommonModule, NgFor } from '@angular/common';

@Component({
  selector: 'app-journal',
  standalone: true,
  imports: [CommonModule,NgFor],
  templateUrl: './journal.component.html',
  styleUrls: ['./journal.component.css'],
})
export class JournalComponent {

  journalEntries = [
    { 
      date: '2/4/2024', 
      content: 'Today, I realized how much progress I’ve made in managing my anxiety. The breathing exercises my therapist recommended are starting to feel natural, and I’m proud of myself for sticking with them.' 
    },
    { 
      date: '3/2/2024', 
      content: 'I’m grateful for having someone to talk to who truly listens and understands me. My therapist suggested keeping a gratitude list, so here’s my first entry: grateful for sunny mornings, my supportive sister, and cozy blankets.' 
    },
    { 
      date: '4/5/2024', 
      content: 'It was a tough day. My old fears crept back in, and I felt overwhelmed. But I’m reminding myself that healing isn’t linear. It’s okay to have hard days as long as I keep trying. Small wins, but they matter.' 
    },
    { 
      date: '6/7/2024', 
      content: 'I’ve decided to work on setting better boundaries in my relationships. My therapist says this will help me feel more in control and less drained. This week’s goal: say "no" to things that don’t align with my priorities.' 
    }
  ];
}
