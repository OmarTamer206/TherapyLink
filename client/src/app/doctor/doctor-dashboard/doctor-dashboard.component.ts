import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { TherapistService } from '../../services/therapist/therapist.service';
import { isEmpty } from 'rxjs';

@Component({
  selector: 'app-doctor-dashboard',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './doctor-dashboard.component.html',
  styleUrl: './doctor-dashboard.component.css'
})
export class DoctorDashboardComponent {
  patients = [
    { name: 'Jens Brincker', date: '27/12/2024', duration: '60 minutes' },
    { name: 'Mark Hay', date: '27/12/2024', duration: '60 minutes' },
    { name: 'Anthony Davie', date: '27/12/2024', duration: '60 minutes' },
    { name: 'David Perry', date: '27/12/2024', duration: '60 minutes' },
    { name: 'Anthony Davie', date: '27/12/2024', duration: '60 minutes' },
    { name: 'Alan Gilchrist', date: '27/12/2024', duration: '60 minutes' },
    { name: 'Mark Hay', date: '27/12/2024', duration: '60 minutes' },
    { name: 'Mark Hay', date: '27/12/2024', duration: '60 minutes' },
    { name: 'Mark Hay', date: '27/12/2024', duration: '60 minutes' },
    { name: 'Mark Hay', date: '27/12/2024', duration: '60 minutes' },
    { name: 'Mark Hay', date: '27/12/2024', duration: '60 minutes' }
  ];


  todaySession : any;
  newPatients:any;
  totalPatiets:any;
  upcomingSessions:any[]=[];
  upcomingSessionID:any;
  upcomingSessionDate:any;


  constructor(private therapistService:TherapistService){
    this.getTodaySessions()
  }

  getTodaySessions(){

    this.therapistService.getTodaySessions().subscribe((response)=>{
      console.log(response);
      if(response.data.length === 0){
        this.todaySession = "No Sessions Today"
      }
      else{
        this.todaySession = response.data.length
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
    },(error)=>{
      console.log("error",error);

    })
  }

  getNewPatients(){

  }


}
