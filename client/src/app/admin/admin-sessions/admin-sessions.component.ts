import { Component, OnInit } from '@angular/core';
import { RouterModule } from '@angular/router';
import { Chart } from 'chart.js';
import { AdminService } from '../../services/admin/admin.service';
import { NgFor } from '@angular/common';

@Component({
  selector: 'app-admin-sessions',
  standalone: true,
  imports: [RouterModule , NgFor],
  templateUrl: './admin-sessions.component.html',
  styleUrls: ['./admin-sessions.component.css']
})
export class AdminSessionsComponent implements OnInit {
  bookedSessions: number = 50;
  bookedSessionsByMonth: number[] = []
  cancelledSessionsByMonth: number[] = []
  availableSessions: number = 10;
  cancelledSessions: number = 5;

  loading=false;
  check1=false;
  check2=false;
  check3=false;
  check4=false;
  months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
  fullMonths: string[] = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  constructor(private adminService:AdminService) {
    this.getBookedSessionData();
    this.getAvailableSessionData();
    this.getCancelledSessionData();
  }


getBookedSessionData(){
  this.adminService.getBookedSessionData().subscribe((response)=>{
    this.getBookedSessionDataByMonth(response.data);
    let date = new Date(Date.now());

    this.bookedSessions = this.bookedSessionsByMonth[date.getMonth()];
    console.log("Booked Sessions Count : ",response);
    this.check1 = true;
    this.createSessionChart();
    this.checkLoading();
  }
  ,(error)=>{
    console.error("Error fetching booked session count: ", error);
  });
}
getAvailableSessionData(){
  this.adminService.getAvailableSessionData().subscribe((response)=>{
    this.availableSessions = response.data;
    console.log("Available Sessions Count : ",response);
    this.check2 = true;
    this.createSessionChart();

    this.checkLoading();
  }
  ,(error)=>{
    console.error("Error fetching available session count: ", error);
  });
}
getCancelledSessionData(){
  this.adminService.getCancelledSessionData().subscribe((response)=>{
    console.log("Cancelled Sessions Count : ",response);
    this.getCancelledSessionDataByMonth(response.data);
    let date = new Date(Date.now());

    this.cancelledSessions = this.cancelledSessionsByMonth[date.getMonth()];
    this.check3 = true;
    this.createSessionChart();

    this.checkLoading();
  }
  ,(error)=>{
    console.error("Error fetching cancelled session count: ", error);
  });
}

getBookedSessionDataByMonth(data: any[]) {

  const months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];
   this.bookedSessionsByMonth = new Array(12).fill(0);


    data.forEach(item => {
    // Find the index of the month in the 'months' array
      const monthIndex = months.indexOf(item.month);

    // If the month exists in the array, assign the count to the respective index
    if (monthIndex !== -1) {
      this.bookedSessionsByMonth[monthIndex] = item.count;
    }
  });



  console.log("Booked Sessions By Month : ",this.bookedSessionsByMonth);

}

getCancelledSessionDataByMonth(data: any[]) {

  const months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];
   this.cancelledSessionsByMonth = new Array(12).fill(0);


    data.forEach(item => {
    // Find the index of the month in the 'months' array
      const monthIndex = months.indexOf(item.month);

    // If the month exists in the array, assign the count to the respective index
    if (monthIndex !== -1) {
      this.cancelledSessionsByMonth[monthIndex] = item.count;
    }
  });



  console.log("Booked Sessions By Month : ",this.bookedSessionsByMonth);

}




  checkLoading(){
    if(this.check1 && this.check2 && this.check3 && this.check4 ){
      this.loading = true;
    }
  }


  ngOnInit() {
    this.createSessionChart();
  }

  createSessionChart() {

    if(this.check1 && this.check2 && this.check3 ){
      console.log("Booked Sessions By Month : ",this.bookedSessionsByMonth);
      console.log("Cancelled Sessions By Month : ",this.cancelledSessionsByMonth);

      const ctx = document.getElementById('sessionChart') as HTMLCanvasElement;
      const sessionChart = new Chart(ctx, {
        type: 'bar',
        data: {
          labels: this.months,
          datasets: [
            {
              label: 'Booked Sessions',
              data: this.bookedSessionsByMonth,
              backgroundColor: 'rgba(0, 131, 143, 0.5)',
            },
            {
              label: 'Cancelled Sessions',
              data: this.cancelledSessionsByMonth,
              backgroundColor: 'rgba(255, 99, 132, 0.5)',
            },

          ],
        },
        options: {
          responsive: true,
          scales: {
            y: {
              beginAtZero: true,
            },
          },
        },
      });
    }


    this.check4=true;
    this.checkLoading();
  }

}
