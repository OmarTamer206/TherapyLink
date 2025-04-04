import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Chart } from 'chart.js/auto';

@Component({
  selector: 'app-patient-analytics',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './patient-analytics.component.html',
  styleUrl: './patient-analytics.component.css'
})
export class lifePatientAnalyticsComponent {
 activeTab: string = 'rating';
  selectedRating: number = 4;  // Static rating, no functionality
  chart!: Chart;

  ratings = [
    { label: 'Excellent', value: 90, color: 'green' },
    { label: 'Good', value: 70, color: 'lightgreen' },
    { label: 'Average', value: 50, color: 'gold' },
    { label: 'Bad', value: 30, color: 'coral' },
    { label: 'Poor', value: 10, color: 'red' }
  ];

  switchTab(tab: string) {
    this.activeTab = tab;
    if (tab !== 'rating') {
      setTimeout(() => this.createChart(), 100);
    }
  }

  createChart() {
    if (this.chart) this.chart.destroy();

    const ctx = document.getElementById('patientChart') as HTMLCanvasElement;
    this.chart = new Chart(ctx, {
      type: 'bar',
      data: {
        labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
        datasets: [{
          label: 'Patients',
          data: [90, 70, 20, 50, 60, 80, 100, 75, 40, 110, 65, 85],
          backgroundColor: ['#0099a8', '#003b49']
        }]
      },
      options: { responsive: true, maintainAspectRatio: false }
    });
  }
}
