import { Component, ElementRef, ViewChild, AfterViewInit, Input, SimpleChanges } from '@angular/core';
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

    @Input({ required: true }) revenue!: any;
    @Input({ required: true }) expenses!: any;

      ngOnChanges(changes: SimpleChanges): void {
        if (changes['revenue'] || changes['expenses']) {
          // Handle the new data here
          console.log('Data received:', this.revenue);
          console.log('Data received:', this.expenses);
        }
      }

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
            data: this.revenue,
            fill: true,
          },
          {
            label: 'Expenses',
            borderColor: '#000000',
            backgroundColor: 'rgba(0, 0, 0, 0.1)',
            data: this.expenses,
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
