import { Component, Input, OnChanges, SimpleChanges, ViewChild, ElementRef } from '@angular/core';
import { Chart, registerables } from 'chart.js';

Chart.register(...registerables);

@Component({
  standalone: true,
  selector: 'app-pie-chart',
  templateUrl: './pie-chart.component.html',
  styleUrls: ['./pie-chart.component.css'],
})
export class PieChartComponent implements OnChanges {
  @ViewChild('pieCanvas') private pieCanvas!: ElementRef<HTMLCanvasElement>;
  @Input() chartData: number[] = []; // Pie chart data
  @Input() chartLabels: string[] = []; // Labels for the pie chart

  private pieChart: any;

  constructor() {}

  // Called whenever input data changes
  ngOnChanges(changes: SimpleChanges): void {
    if (changes['chartData']) {
      console.log("chartData ",this.chartData);
      console.log("chartLabels ",this.chartLabels);

      if(this.chartData && this.chartLabels)
        this.createPieChart(); // Recreate the chart when data changes
    }
  }

  ngAfterViewInit(): void {
    this.createPieChart();
  }

  private createPieChart(): void {
    console.log("1",this.pieCanvas);
    console.log("2",this.chartData);
    console.log("3",this.chartLabels);

    if (this.pieCanvas  && this.chartData.length > 0 && this.chartLabels.length > 0) {
      console.log("Creating pie chart...");
      console.log("Chart Data: ", this.chartData);
      console.log("Chart Labels: ", this.chartLabels);

      if (this.pieChart) {
        this.pieChart.destroy();  // Destroy any previous chart
      }
      const total = this.chartData.reduce((sum, value) => sum + value, 0);
      // Create a new Pie chart
      this.pieChart = new Chart(this.pieCanvas.nativeElement, {
        type: 'pie',
        data: {
          labels: this.chartLabels,
          datasets: [{
            data: this.chartData,
            label: 'Pie Chart Dataset',
            backgroundColor: [
              '#FF5733', '#33FF57', '#3357FF', '#F1C40F', '#8E44AD', '#E74C3C',
            ],
            borderColor: '#fff',
            borderWidth: 1,
          }],
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          plugins: {
            legend: {
              position: 'top',
            },
            tooltip: {
              callbacks: {
                label: function (tooltipItem) {
                  const value:any = tooltipItem.raw;
                  const percentage = ((value / total) * 100).toFixed(2); // Calculate percentage
                  return `${tooltipItem.label}: ${percentage}%`; // Show percentage
                },
              },
            },
          },
        },
      });
    } else {
      console.error("Invalid data or canvas not available");
    }
  }


  public destroyChart(): void {
    if (this.pieChart) {
      this.pieChart.destroy();
    }
  }
}
