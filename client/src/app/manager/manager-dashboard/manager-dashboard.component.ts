import { Component } from '@angular/core';
import { LineChartComponent } from '../line-chart/line-chart.component';

@Component({
  selector: 'app-manager-dashboard',
  standalone: true,
  imports: [LineChartComponent],
  templateUrl: './manager-dashboard.component.html',
  styleUrl: './manager-dashboard.component.css',
})
export class ManagerDashboardComponent {}
