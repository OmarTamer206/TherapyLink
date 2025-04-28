import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { LineChartComponent } from '../../admin/line-chart/line-chart.component';
import { ManagerService } from '../../services/manager/manager.service';

@Component({
  selector: 'app-manager-reports-generator',
  standalone: true,
  imports: [FormsModule , CommonModule , LineChartComponent],
  templateUrl: './manager-reports-generator.component.html',
  styleUrl: './manager-reports-generator.component.css'
})
export class ManagerReportsGeneratorComponent {

  loading = true;
   queryOption = 'Revenue'; // For example, revenue report
   dateFrom = '2023-01-01';
   dateTo = '2023-12-31';


   constructor(private managerService : ManagerService){

   }

   generateReport() {
    const queryOption = 'Revenue'; // For example, revenue report
    const dateFrom = '2023-01-01';
    const dateTo = '2023-12-31';

    this.managerService.generateReport(queryOption, dateFrom, dateTo).subscribe(
      (response) => {
        console.log('Report generated:', response);
        // Handle the response, e.g., display the report data
      },
      (error) => {
        console.error('Error generating report:', error);
      }
    );
  }

}
