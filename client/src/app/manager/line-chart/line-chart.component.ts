import { Component, ElementRef, ViewChild, AfterViewInit } from '@angular/core';
import { Chart, registerables } from 'chart.js';

@Component({
  selector: 'app-line-chart-manager',
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
            label: 'Revenue',
            borderColor: '#00B8B8',
            backgroundColor: 'rgba(0, 184, 184, 0.1)',
            data: [100, 120, 130, 140, 150, 160, 140, 130, 110, 120, 140, 160],
            fill: true,
          },
          {
            label: 'Expenses',
            borderColor: '#000000',
            backgroundColor: 'rgba(0, 0, 0, 0.1)',
            data: [90, 100, 110, 120, 130, 140, 120, 110, 100, 110, 130, 140],
            fill: true,
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
