import { Component } from '@angular/core';
import { LineChartComponent } from '../line-chart/line-chart.component';
import { ManagerService } from '../../services/manager/manager.service';
import { AdminService } from '../../services/admin/admin.service';

@Component({
  selector: 'app-manager-dashboard',
  standalone: true,
  imports: [LineChartComponent],
  templateUrl: './manager-dashboard.component.html',
  styleUrl: './manager-dashboard.component.css',
})
export class ManagerDashboardComponent {
  loading=false;
  check1=false;
  check2=false;
  check3=false;
  check4=false;
  check5=false;
  check6=false;
  check7=false;
  check8=false;
  check9=false;
  check10=false;

  total_doctors:any;
  total_appointments:any;
  average_patients:any;
  total_profit:any;
  total_salaries:any;
  total_revenue:any;
  total_coaches:any;
  total_emergency_team:any;

  monthRevenueCounts: any[] = [];
  monthExpenseCounts: any[] = [];


constructor(private adminService: AdminService , private managerService: ManagerService) {
  this.getTotalDoctors();
  this.getTotalAppoitments();
  this.getAveragePatientsCountPerDay();
  this.getTotalProfitCount();
  this.getTotalSalariesExpenseCount();
  this.getTotalRevenueCount();
  this.getTotalCoachesCount();
  this.getTotalEmergencyTeamCount();
  this.getTotalRevenueByMonth();
  this.getTotalExpenseByMonth();


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

getAveragePatientsCountPerDay(){
  this.managerService.getAveragePatientsCountPerDay().subscribe((response)=>{
    console.log("Average Patients Count Per Day : ",response);
    this.average_patients = response.data;
    this.check3 = true;
    this.checkLoading();
  },(error)=>{
    console.error("Error fetching Average Patients Count Per Day: ", error);
  });
}
getTotalProfitCount(){
  this.managerService.getTotalProfitCount().subscribe((response)=>{
    console.log("Total Profit Count : ",response);
    this.total_profit = response.data;
    this.check4 = true;
    this.checkLoading();
  },(error)=>{
    console.error("Error fetching Total Profit Count: ", error);
  });
}
getTotalSalariesExpenseCount(){
  this.managerService.getTotalSalariesExpenseCount().subscribe((response)=>{
    console.log("Total Salaries Expense Count : ",response);
    this.total_salaries = response.data;
    this.check5 = true;
    this.checkLoading();
  },(error)=>{
    console.error("Error fetching Total Salaries Expense Count: ", error);
  });
}

getTotalRevenueCount(){
  this.managerService.getTotalRevenueCount().subscribe((response)=>{
    console.log("Total Revenue Count : ",response);
    this.total_revenue = response.data;
    this.check6 = true;
    this.checkLoading();
  },(error)=>{
    console.error("Error fetching Total Revenue Count: ", error);
  });
}
getTotalCoachesCount(){
  this.managerService.getTotalCoachesCount().subscribe((response)=>{
    console.log("Total Coaches Count : ",response);
    this.total_coaches = response.data;
    this.check7 = true;
    this.checkLoading();
  },(error)=>{
    console.error("Error fetching Total Coaches Count: ", error);
  });
}
getTotalEmergencyTeamCount(){
  this.managerService.getTotalEmergencyTeamCount().subscribe((response)=>{
    console.log("Total Emergency Team Count : ",response);
    this.total_emergency_team = response.data;
    this.check8 = true;
    this.checkLoading();
  },(error)=>{
    console.error("Error fetching Total Emergency Team Count: ", error);
  });
}

getTotalRevenueByMonth(){
  this.managerService.getTotalRevenueByMonth().subscribe((response)=>{
    console.log("Total Revenue By Month : ",response);
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
     this.monthRevenueCounts = new Array(12).fill(0);
     let data:any[] = response.data;


      data.forEach(item => {
      // Find the index of the month in the 'months' array
        const monthIndex = months.indexOf(item.month);

      // If the month exists in the array, assign the count to the respective index
      if (monthIndex !== -1) {
        this.monthRevenueCounts[monthIndex] = item.revenue;
      }
    });
    this.check9 = true;
    this.checkLoading();
    console.log("Month Revenue Counts : ",this.monthRevenueCounts);

  },(error)=>{
    console.error("Error fetching Total Revenue By Month: ", error);
  });
}
getTotalExpenseByMonth(){
  this.managerService.getTotalExpenseByMonth().subscribe((response)=>{
    console.log("Total Expense By Month : ",response);
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
     this.monthExpenseCounts = new Array(12).fill(0);

    let data:any[] = response.data;
     data.forEach(item => {
      // Find the index of the month in the 'months' array
        const monthIndex = months.indexOf(item.month);

      // If the month exists in the array, assign the count to the respective index
      if (monthIndex !== -1) {
        this.monthExpenseCounts[monthIndex] = item.expenses;
      }
    });
    this.check10 = true;
    this.checkLoading();
    console.log("Month Expense Counts : ",this.monthExpenseCounts);
  },(error)=>{
    console.error("Error fetching Total Expense By Month: ", error);
  });
}



checkLoading(){
  if(this.check1 && this.check2 && this.check3 && this.check4 && this.check5 && this.check6 && this.check7 && this.check8 && this.check9 && this.check10){
    this.loading = true;
  }
}



}
