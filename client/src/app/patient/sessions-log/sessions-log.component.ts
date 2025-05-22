import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { SessionService } from '../../services/session/session.service';

@Component({
  selector: 'app-sessions-log',
  standalone: true,
  imports: [],
  templateUrl: './sessions-log.component.html',
  styleUrl: './sessions-log.component.css',
})
export class SessionsLogComponent {
  upcomingSessions: any;
  previousSessions: any;
  check1= false;
  check2= false;
  loading= false;
  constructor(private router: Router,private sessionService:SessionService) {
    this.getUpcomingSessions()
    this.getPreviousSessions()
  }


   getUpcomingSessions(){
    this.sessionService.viewUpcomingSessionsPatient().subscribe((response)=>{
      console.log(response);


      this.upcomingSessions = response.data

      if(this.upcomingSessions){



      this.upcomingSessions.map((upcomingSession:any)=>{
        const date = new Date(upcomingSession.scheduled_time)
          upcomingSession.date = `${date.getDate()}/${date.getMonth()+1}/${date.getFullYear()}`
          const hours24 = date.getHours();
          const minutes = date.getMinutes();

          const hours12 = hours24 % 12 || 12; // Converts 0 to 12 for midnight
          const ampm = hours24 >= 12 ? 'PM' : 'AM';
          const paddedMinutes = minutes.toString().padStart(2, '0');

          upcomingSession.time = `${hours12}:${paddedMinutes} ${ampm}`;
      })

      }



      this.check1 = true;
      this.checkLoading();

    },(error)=>{
      console.log(error);

    })
  }


 getPreviousSessions(){
    this.sessionService.viewPreviousSessionsPatient().subscribe((response)=>{
      console.log(response);


      this.previousSessions = response.data

      if(this.previousSessions){



      this.previousSessions.map((previousSession:any)=>{
        const date = new Date(previousSession.scheduled_time)
          previousSession.date = `${date.getDate()}/${date.getMonth()+1}/${date.getFullYear()}`
          const hours24 = date.getHours();
          const minutes = date.getMinutes();

          const hours12 = hours24 % 12 || 12; // Converts 0 to 12 for midnight
          const ampm = hours24 >= 12 ? 'PM' : 'AM';
          const paddedMinutes = minutes.toString().padStart(2, '0');

          previousSession.time = `${hours12}:${paddedMinutes} ${ampm}`;
      })

      }



      this.check2 = true;
      this.checkLoading();

    },(error)=>{
      console.log(error);

    })
  }

  goToSessionPage(session:any) {
    this.router.navigate([`patient/session-page`],{ state: { session:session } });

  }
  goToOldSessionPage(session:any) {
    this.router.navigate(['patient/old-session'],{ state: { session:session } });
  }

  checkLoading(){
  if(this.check1 && this.check2  ){
    this.loading = true;
  }
}

}
