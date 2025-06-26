import { LineChartComponent } from './../../admin/line-chart/line-chart.component';
import { CommonModule } from '@angular/common';
import { Component, ViewChild } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { ManagerService } from '../../services/manager/manager.service';
import { Chart } from 'chart.js';
import { PieChartComponent } from '../pie-chart/pie-chart.component';

@Component({
  selector: 'app-manager-reports-generator',
  standalone: true,
  imports: [FormsModule , CommonModule , LineChartComponent,PieChartComponent],
  templateUrl: './manager-reports-generator.component.html',
  styleUrl: './manager-reports-generator.component.css'
})
export class ManagerReportsGeneratorComponent {
  @ViewChild(LineChartComponent) lineChartComponent!: LineChartComponent;
  @ViewChild(PieChartComponent) pieChartComponent!: PieChartComponent;

  loading = true;
   queryOption = 'Revenue'; // For example, revenue report
   dateFrom = '2025-03';
   dateTo = '2025-06';
   chartType = 'line';
   lineChartData: any; // Data for the chart
   pieChartData: any; // Data for the chart
   pieChartLabels: string[] = []
  isAllZeros: any;

   constructor(private managerService : ManagerService){
    this.generateReport()
   }

   generateReport() {


    this.managerService.generateReport(this.queryOption, this.dateFrom, this.dateTo).subscribe(
      (response) => {
        console.log('Report generated:', response);
        this.displayReport(response.data); // Assuming the response contains the data for the chart
      },
      (error) => {
        console.error('Error generating report:', error);
      }
    );
  }


  displayReport(data:any[]) {

    const lineTypes = [
      "Revenue",
       "Salaries Expenses",
       "Total Profit",
       "Emergency Requests",
       "Average Patients Monthly Use Count"
      ];

    // Validate user type
    if (lineTypes.includes(this.queryOption)) {
      if(this.chartType == "pie"){

        this.pieChartComponent.destroyChart()
      }
      this.chartType = 'line'; // Set to line chart for revenue and other types of reports



    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
     this.lineChartData = new Array(12).fill(0);


      data.forEach(item => {
      // Find the index of the month in the 'months' array
        const monthIndex = months.indexOf(item.month);

      // If the month exists in the array, assign the count to the respective index
      if (monthIndex !== -1) {
        this.lineChartData[monthIndex] = item.count;
      }
    });

    console.log("Chart Data : ",this.lineChartData);
  }
  else{
    if(this.chartType == "line"){

      this.lineChartComponent.destroyChart();
    }
    console.log(data[0].specialization);

    if(data[0].specialization){
      this.pieChartLabels = data.map(item => item.specialization); // Extract the specialization
    }
    else{
      this.pieChartLabels = data.map(item => item.type); // Extract the specialization

    }
    this.pieChartData = data.map(item => item.count);
    console.log(this.pieChartData);
    console.log(this.pieChartLabels);

    this.isAllZeros = this.pieChartData.every((num:any)=> num == 0);
    console.log("is all zeros",this.isAllZeros);


    this.chartType = 'pie'; // Set to pie chart for other types of reports

  }




  }


}
