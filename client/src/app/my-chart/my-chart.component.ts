import { Component } from '@angular/core';
import { NgIf } from '@angular/common';
import { ChartOptions, ChartType } from 'chart.js';
import { ChartDataSets, Label } from 'ng2-charts';
import { ChartsModule } from 'ng2-charts';

@Component({
  selector: 'app-my-chart',
  standalone: true,
  imports: [NgIf, ChartsModule],  // ✅ Import ChartsModule here
  templateUrl: './myChart.component.html',
  styleUrls: ['./myChart.component.css']
})
export class MyChartComponent {
  lineChartData: ChartDataSets[] = [
    {
      data: [50, 180, 30, 20, 40, 100, 180, 30, 60, 130, 180, 40],
      label: 'Patient Visits',
      borderColor: '#00838f',
      fill: false
    }
  ];
  
  lineChartLabels: Label[] = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  
  lineChartOptions: ChartOptions = {
    responsive: true
  };
  
  lineChartLegend = false;
  lineChartType: ChartType = 'line';
  lineChartPlugins = [];
}
