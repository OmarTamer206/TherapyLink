import { Component } from '@angular/core';
import { CommonModule, NgFor } from '@angular/common';

@Component({
  selector: 'app-reports',
  standalone: true,
  imports: [CommonModule,NgFor],
  templateUrl: './report.component.html',
  styleUrls: ['./report.component.css'],
})
export class ReportComponent {
  doctorReport = [
    { name:"Dr.shalaby",
      concern: 'The patient is making progress in managing their anxiety, but they still experience some difficulties during certain situations. I recommend continued practice of the breathing exercises and adding mindfulness techniques to their routine.' 
    },
    { name:"Dr.shalaby",
      concern: 'The patient continues to do well, showing improved coping skills. The gratitude list has been helpful in shifting their perspective. I will focus more on exploring underlying causes for some of their anxiety.' 
    },
    { name:"Dr.shalaby",
      concern: 'The patient has had a tough time, but they are showing resilience. I’m going to adjust the plan to allow for more relaxation techniques and work on reframing negative thoughts.' 
    },
    { name:"Dr.shalaby",
      concern: 'We’ve made good progress with boundary-setting. I’ll continue to help the patient recognize signs of stress and maintain their progress by reinforcing healthy relationships and self-care practices.' 
    }
  ];
}
