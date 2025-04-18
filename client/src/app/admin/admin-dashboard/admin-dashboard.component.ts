import { Component, inject } from '@angular/core';
import { RouterModule } from '@angular/router';
import { LineChartComponent } from '../line-chart/line-chart.component';
import { AdminService } from '../../services/admin/admin.service';
import { HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-admin-dashboard',
  standalone: true,
  imports: [RouterModule, LineChartComponent],
  templateUrl: './admin-dashboard.component.html',
  styleUrl: './admin-dashboard.component.css',
})
export class AdminDashboardComponent {
check1=false;
check2=false;
check3=false;
check4=false;
check5=false;
loading = false;

total_doctors:any;
total_appointments:any;
total_patients:any;
total_earnings:any;

patientDataByMonth: any[] = [];
monthCounts: any[] = [];

constructor(private adminService: AdminService) {
  this.getTotalDoctors();
  this.getTotalAppoitments();
  this.getTotalPatients();
  this.getTotalEarnings();
  this.getTotalPatientsByMonth()

}

getTotalDoctors(){
  this.adminService.getTotalDoctorsCount().subscribe((response)=>{
    this.total_doctors = response.data;
    console.log("doctor Count : ",this.total_doctors);
    this.check1 = true;
    this.checkLoading();
  },(error)=>{
    console.error("Error fetching doctor count: ", error);
  });

}

getTotalAppoitments(){
  this.adminService.getTotalAppointmentsCount().subscribe((response)=>{
    this.total_appointments = response.data;
    console.log("Appointments Count : ",this.total_appointments);
    this.check2 = true;
    this.checkLoading();
  },(error)=>{
    console.error("Error fetching Appointments count: ", error);
  });

}

getTotalPatients(){
  this.adminService.getTotalPatientCount().subscribe((response)=>{
    this.total_patients = response.data;
    console.log("patients Count : ",this.total_patients);
    this.check3 = true;
    this.checkLoading();
  },(error)=>{
    console.error("Error fetching patient count: ", error);
  });

}

getTotalEarnings(){
  this.adminService.getTotalEarningsCount().subscribe((response)=>{
    this.total_earnings = response.data.total_cost;
    console.log("total_earnings Count : ",response.data.total_cost);
    this.check4 = true;
    this.checkLoading();
  },(error)=>{
    console.error("Error fetching total_earnings count: ", error);
  });

}

getTotalPatientsByMonth(){
  this.adminService.getPatientVisitDataByMonth().subscribe((response)=>{
    this.patientDataByMonth = response.data;
    console.log("patientDataByMonth Count : ",this.patientDataByMonth);

    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
     this.monthCounts = new Array(12).fill(0);


    this.patientDataByMonth.forEach(item => {
      // Find the index of the month in the 'months' array
        const monthIndex = months.indexOf(item.month);

      // If the month exists in the array, assign the count to the respective index
      if (monthIndex !== -1) {
        this.monthCounts[monthIndex] = item.count;
      }
    });

    console.log("Month Counts : ",this.monthCounts);

    this.check5= true;
    this.checkLoading();
  },(error)=>{
    console.error("Error fetching patientDataByMonth count: ", error);
  });

}


checkLoading(){
  if(this.check1 && this.check2 && this.check3 && this.check4 && this.check5){
    this.loading = true;
  }
}




}
