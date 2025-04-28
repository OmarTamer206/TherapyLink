import { Component, ElementRef, ViewChild, AfterViewInit, OnChanges, SimpleChanges, Input, ChangeDetectorRef } from '@angular/core';
import { Chart, registerables } from 'chart.js';

Chart.register(...registerables);

@Component({
  selector: 'app-line-chart',
  standalone: true,
  imports: [],
  templateUrl: './line-chart.component.html',
  styleUrls: ['./line-chart.component.css'],
})
export class LineChartComponent implements AfterViewInit, OnChanges {
  @ViewChild('lineCanvas') private lineCanvas!: ElementRef<HTMLCanvasElement>;
  private lineChart!: Chart;

  @Input() data!: any;

  constructor(private cdRef: ChangeDetectorRef) {
    // Register Chart.js components globally
    Chart.register(...registerables);
  }

  // This lifecycle hook gets called when any input properties change
  ngOnChanges(changes: SimpleChanges): void {
    if (changes['data']) {
      // If the input data changes, destroy the existing chart and recreate it
      this.destroyChart();  // Destroy the previous chart
      this.createLineChart();  // Create a new chart with the updated data
    }
  }

  ngAfterViewInit() {
    this.createLineChart();
  }

  private createLineChart(): void {
    if (this.lineCanvas) {
      this.lineChart = new Chart(this.lineCanvas.nativeElement, {
        type: 'line',
        data: {
          labels: [
            'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
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

  // This function will destroy the existing chart if it's already created
   public destroyChart(): void {
    if (this.lineChart) {
      this.lineChart.destroy();
    }
  }
}
