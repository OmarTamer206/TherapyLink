import { Component } from '@angular/core';
import { RouterModule } from '@angular/router';
import { LineChartComponent } from '../line-chart/line-chart.component';

@Component({
  selector: 'app-admin-sessions',
  standalone: true,
  imports: [RouterModule],
  templateUrl: './admin-sessions.component.html',
  styleUrl: './admin-sessions.component.css'
})
export class AdminSessionsComponent {
  bookedSessions: number = 50;
  availableSessions: number = 10;
  cancelledSessions: number = 5;
}
