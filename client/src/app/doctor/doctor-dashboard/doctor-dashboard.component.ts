import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { TherapistService } from '../../services/therapist/therapist.service';

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
  upcomingSessions = [
    { name: 'Yara Maged', specialization: 'Trauma', date: '20 Nov', time: '11:00 AM' },
    { name: 'Mona Eid', specialization: 'Trauma', date: '20 Nov', time: '1:00 PM' },
    { name: 'Sameh Mohamad', specialization: 'Trauma', date: '20 Nov', time: '3:00 PM' },
    { name: 'Yasser Elissa', specialization: 'Trauma', date: '20 Nov', time: '4:00 PM' },
  ];


  constructor(private therapistService:TherapistService){
    this.getTodaySessions()
  }

  getTodaySessions(){

    this.therapistService.getTodaySessions().subscribe((response)=>{
      console.log(response);

    },(error)=>{
      console.log("error",error);

    })

  }


}
