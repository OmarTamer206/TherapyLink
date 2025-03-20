import { Component, OnInit } from '@angular/core';
import { RouterModule } from '@angular/router';
import { Chart } from 'chart.js';

@Component({
  selector: 'app-admin-sessions',
  standalone: true,
  imports: [RouterModule],
  templateUrl: './admin-sessions.component.html',
  styleUrls: ['./admin-sessions.component.css']
})
export class AdminSessionsComponent implements OnInit {
  bookedSessions: number = 50;
  availableSessions: number = 10;
  cancelledSessions: number = 5;

  ngOnInit() {
    this.createSessionChart();
  }

  createSessionChart() {
    new Chart('sessionChart', {
      type: 'bar',
      data: {
        labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sept', 'Oct', 'Nov', 'Dec'],
        datasets: [{
          label: 'Session Analytics',
          data: [100, 60, 45, 50, 55, 90, 40, 30, 75, 110, 50, 35], // Sample data from the chart you shared
          backgroundColor: '#1e88e5',
          borderColor: '#1e88e5',
          borderWidth: 1
        }]
      },
      options: {
        responsive: true,
        scales: {
          y: {
            beginAtZero: true
          }
        }
      }
    });
  }
}
