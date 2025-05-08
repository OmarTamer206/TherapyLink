import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { TherapistService } from '../../services/therapist/therapist.service';
import { isEmpty } from 'rxjs';
import { CountdownComponent } from '../countdown/countdown.component';

@Component({
  selector: 'app-doctor-dashboard',
  standalone: true,
  imports: [CommonModule , CountdownComponent],
  templateUrl: './doctor-dashboard.component.html',
  styleUrl: './doctor-dashboard.component.css'
})
export class DoctorDashboardComponent {
  patients:any[] = [];


  todaySession : any;
  newPatients:any;
  totalPatiets:any;
  upcomingSessions:any[]=[];
  upcomingSessionID:any;
  upcomingSessionDate:any;
  upcomingSessionState:any;

  loading = false;
  check1=false;
  check2=false;
  check3=false;
  check4=false;
  check5=false;


  constructor(private therapistService:TherapistService){
    this.getTodaySessions()
    this.getNewPatients()
    this.getTotalPatients()
    this.getPatientsData()
    this.getUpcomingSessions()
  }

  getTodaySessions(){

    this.therapistService.getTodaySessions().subscribe((response)=>{
      console.log(response);
      if(response.data.length === 0){
        this.todaySession = "No Sessions Today"
      }
      else{
        this.todaySession = response.data.length

      }

      this.check1=true;
        this.checkLoading();
    },(error)=>{
      console.log("error",error);

    })
  }

  getUpcomingSessions(){

    this.therapistService.getUpcomingSessions().subscribe((response)=>{
      console.log(response);
      if(response.data.length === 0){
        this.upcomingSessionState = "No Upcoming Sessions"
      }
      else{
        this.upcomingSessionID = response.data[0].session_ID
        this.upcomingSessionDate = response.data[0].scheduled_time

        this.upcomingSessions = response.data
        this.upcomingSessions.map((session)=>{
          const date = new Date(session.scheduled_time)
          session.date = `${date.getDate()}/${date.getMonth()+1}/${date.getFullYear()}`
          const hours24 = date.getHours();
          const minutes = date.getMinutes();

          const hours12 = hours24 % 12 || 12; // Converts 0 to 12 for midnight
          const ampm = hours24 >= 12 ? 'PM' : 'AM';
          const paddedMinutes = minutes.toString().padStart(2, '0');

          session.time = `${hours12}:${paddedMinutes} ${ampm}`;
        })

      }
      this.check2=true;
      this.checkLoading();
    },(error)=>{
      console.log("error",error);


    })
  }

  getNewPatients(){

    this.therapistService.getNewPatientsThisMonth().subscribe((response)=>{
      console.log(response);
      this.newPatients= response.data.new_patients;

      this.check3=true;
        this.checkLoading();
    },(error)=>{
      console.log("error",error);


    })


  }

  getTotalPatients(){

    this.therapistService.getTotalPatients().subscribe((response)=>{
      console.log(response);
      this.totalPatiets= response.data.total_patients;

      this.check4=true;
        this.checkLoading();
    },(error)=>{
      console.log("error",error);


    })


  }


  getPatientsData(){
    this.therapistService.getPatientsData().subscribe((response)=>{
      console.log(response);
      this.patients = response.data;

      this.patients.map((patient)=>{
        const date = new Date(patient.scheduled_time)
        patient.date = `${date.getDate()}/${date.getMonth()+1}/${date.getFullYear()}`
        const hours24 = date.getHours();
        const minutes = date.getMinutes();

        const hours12 = hours24 % 12 || 12; // Converts 0 to 12 for midnight
        const ampm = hours24 >= 12 ? 'PM' : 'AM';
        const paddedMinutes = minutes.toString().padStart(2, '0');

        patient.time = `${hours12}:${paddedMinutes} ${ampm}`;

      })
      this.check5=true;
      this.checkLoading();

    },(error)=>{
      console.log("error",error);


    })
  }

  checkLoading(){
    console.log(this.check1 , this.check2 , this.check3 , this.check4 , this.check5);
    
    if(this.check1 && this.check2 && this.check3 && this.check4 && this.check5){
      this.loading = true;
    }
  }

}
