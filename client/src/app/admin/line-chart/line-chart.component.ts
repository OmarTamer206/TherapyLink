import { Component, ElementRef, ViewChild, AfterViewInit } from '@angular/core';
import { Chart, registerables } from 'chart.js';

Chart.register(...registerables); // 📝 Register chart.js components!
@Component({
  selector: 'app-line-chart',
  standalone: true,
  imports: [],
  templateUrl: './line-chart.component.html',
  styleUrl: './line-chart.component.css',
})
export class LineChartComponent implements AfterViewInit {
  @ViewChild('lineCanvas') private lineCanvas!: ElementRef<HTMLCanvasElement>;
  private lineChart!: Chart;

  constructor() {
    // Register Chart.js components globally
    Chart.register(...registerables);
  }

  ngAfterViewInit() {
    this.createLineChart();
  }

  private createLineChart(): void {
    this.lineChart = new Chart(this.lineCanvas.nativeElement, {
      type: 'line',
      data: {
        labels: [
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'May',
          'Jun',
          'Jul',
          'Aug',
          'Sep',
          'Oct',
          'Nov',
          'Dec',
        ],
        datasets: [
          {
            label: 'Patient Visits',
            data: [50, 180, 30, 20, 40, 100, 180, 30, 60, 130, 180, 40],
            borderColor: '#00838f',
            backgroundColor: 'rgba(0, 131, 143, 0.1)',
            pointBackgroundColor: '#00838f',
            pointBorderColor: '#fff',
            pointHoverBackgroundColor: '#fff',
            pointHoverBorderColor: '#00838f',
            fill: true,
            tension: 0.5, // smooth lines
          },
        ],
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: {
            display: true,
            labels: {
              color: '#333',
              font: {
                size: 14,
              },
            },
          },
          tooltip: {
            mode: 'index',
            intersect: false,
          },
        },
        interaction: {
          mode: 'nearest',
          axis: 'x',
          intersect: false,
        },
        scales: {
          x: {
            ticks: {
              color: '#666',
            },
            grid: {
              display: false,
            },
          },
          y: {
            ticks: {
              color: '#666',
            },
            grid: {
              color: '#eee',
            },
          },
        },
      },
    });
  }
}
