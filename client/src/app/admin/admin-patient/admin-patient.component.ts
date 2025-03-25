import { Component, ElementRef, ViewChild } from '@angular/core';
import { RouterModule } from '@angular/router';
import { Chart, LineElement, PointElement, Title, Tooltip, Legend, CategoryScale, LinearScale } from 'chart.js';

Chart.register(LineElement, PointElement, Title, Tooltip, Legend, CategoryScale, LinearScale);

@Component({
  selector: 'app-admin-patient',
  standalone: true,
  imports: [RouterModule],
  templateUrl: './admin-patient.component.html',
  styleUrls: ['./admin-patient.component.css']
})
export class AdminPatientComponent {
  @ViewChild('ageChartCanvas') ageChartCanvas!: ElementRef<HTMLCanvasElement>;

  patientUse: number = 200;
  newPatients: number = 150;
  //patientUseGrowth: number = 10;
  //newPatientsGrowth: number = 10;

  age21to30: number = 50;
  age40to50: number = 50;

  ngOnInit(): void {
    // Chart rendering will be handled in ngAfterViewInit
  }

  ngAfterViewInit(): void {
    // Average Patients Age Doughnut Chart
    const ageCtx = this.ageChartCanvas.nativeElement.getContext('2d');
    if (ageCtx) {
      new Chart(ageCtx, {
        type: 'doughnut',
        data: {
          labels: ['21–30', '40–50'],
          datasets: [{
            data: [this.age21to30, this.age40to50],
            backgroundColor: ['#00b2b2', '#002f3d'],
            borderWidth: 0
          }]
        },
        options: {
          cutout: '70%',
          plugins: {
            legend: {
              display: true,
              position: 'bottom',
              labels: {
                boxWidth: 12,
                color: '#333',
                font: {
                  size: 12
                }
              }
            },
            tooltip: {
              enabled: true
            }
          }
        }
      });
    }
  }
}
