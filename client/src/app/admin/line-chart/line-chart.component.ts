import { Component, ElementRef, ViewChild, AfterViewInit, input, OnChanges, SimpleChanges, Input } from '@angular/core';
import { Chart, registerables } from 'chart.js';

Chart.register(...registerables); // 📝 Register chart.js components!
@Component({
  selector: 'app-line-chart',
  standalone: true,
  imports: [],
  templateUrl: './line-chart.component.html',
  styleUrl: './line-chart.component.css',
})
export class LineChartComponent implements AfterViewInit,OnChanges {
  @ViewChild('lineCanvas') private lineCanvas!: ElementRef<HTMLCanvasElement>;
  private lineChart!: Chart;

  @Input({ required: true }) data!: any;

  // @input() data: number[] = []; // Input property for data
  ngOnChanges(changes: SimpleChanges): void {
    if (changes['data']) {
      // Handle the new data here
      console.log('Data received:', this.data);
    }
  }
  constructor() {
    // Register Chart.js components globally
    Chart.register(...registerables);
  }


  ngAfterViewInit() {
    console.log("data",this.data);
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
            data: this.data,
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
