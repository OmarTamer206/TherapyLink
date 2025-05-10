import { Component } from '@angular/core';

import { NgIf, NgFor } from '@angular/common';
import { ActivatedRoute } from '@angular/router';
import { TherapistService } from '../../services/therapist/therapist.service';
import { SessionService } from '../../services/session/session.service';
import { ReportComponent } from '../../doctor/session/report/report.component';
import { JournalComponent } from '../../doctor/session/journal/journal.component';

@Component({
  standalone: true,
  imports: [ReportComponent,JournalComponent, NgIf, NgFor],
  selector: 'app-session',
  templateUrl: './session.component.html',
  styleUrls: ['./session.component.css'],
})
export class lifeSessionComponent {
  selectedPatient: any;
  sessionID : any;
    showReport = false;
    showJournal = false;
    sessionData: any;
    patients: any;

    loading = false;
    check1=false;
    check2=false;

    countInit = false;

    scheduledTime: string =""; // ISO string
    timeLeft: string = '';
    isExpired = false;
    private intervalId: any;

    startButtonState = false;


    constructor(private route:ActivatedRoute, private therapistService:TherapistService , private sessionService:SessionService) {

    }

    ngOnInit(): void {
      this.route.paramMap.subscribe(params => {
        const id = params.get('id');
        if (id) {
          this.sessionID = +id; // convert string to number
          console.log('Session ID:', this.sessionID);
        }
      });


      this.gatherSessionData();

      this.updateCountdown();
      this.intervalId = setInterval(() => this.updateCountdown(), 1000);


    }

  // Hatet8yr fl lifecoach
    gatherSessionData(){
      this.sessionService.viewSessionDetails(this.sessionID).subscribe((response) => {
        console.log("session : ",response);
        this.sessionData = response.data;
          this.therapistService.getPatientsData(this.sessionID).subscribe((response) => {
            this.patients = response.data;
            console.log("patients : ",response);

            this.scheduledTime = this.sessionData.scheduled_time;

            const date = new Date(this.sessionData.scheduled_time)
            this.sessionData.date = `${date.getDate()}/${date.getMonth()+1}/${date.getFullYear()}`
            const hours24 = date.getHours();
            const minutes = date.getMinutes();

            const hours12 = hours24 % 12 || 12; // Converts 0 to 12 for midnight
            const ampm = hours24 >= 12 ? 'PM' : 'AM';
            const paddedMinutes = minutes.toString().padStart(2, '0');

            this.sessionData.time = `${hours12}:${paddedMinutes} ${ampm}`;

            this.patients.forEach((patient: any) => {
            // Check if patient has journals
            if (patient.journals && patient.journals.length > 0) {
              // Iterate over each journal of the current patient
              patient.journals.forEach((journal: any) => {
                const date = new Date(journal.time);
                journal.date = `${date.getDate()}/${date.getMonth() + 1}/${date.getFullYear()}`;

                const hours24 = date.getHours();
                const minutes = date.getMinutes();

                const hours12 = hours24 % 12 || 12; // Converts 0 to 12 for midnight
                const ampm = hours24 >= 12 ? 'PM' : 'AM';
                const paddedMinutes = minutes.toString().padStart(2, '0');

                journal.time = `${hours12}:${paddedMinutes} ${ampm}`; // Update the time format
              });
            }
          });

            this.check1=true;
            this.checkLoading()
          });




      },(error)=>{
        console.log("error",error);
      });

    }




    ngOnDestroy(): void {
      clearInterval(this.intervalId);
    }

    private updateCountdown(): void {
      if(this.scheduledTime=="")
        return;

      const now = new Date();
      const target = new Date(this.scheduledTime);
      const diff = target.getTime() - now.getTime();

      if (diff <= 0) {
        this.timeLeft = '';
        this.isExpired = true;
        this.startButtonState = false;
        clearInterval(this.intervalId);
        return;
      }

      // Set startButtonState to true if less than 5 minutes left (5 * 60 * 1000 ms)
      this.startButtonState = diff <= 5 * 60 * 1000;

      const days = Math.floor(diff / (1000 * 60 * 60 * 24));
      const hours = Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
      const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
      const seconds = Math.floor((diff % (1000 * 60)) / 1000);

      this.timeLeft = `${this.pad(days)}d ${this.pad(hours)}h:${this.pad(minutes)}m:${this.pad(seconds)}s`;

      if(!this.countInit){
        this.countInit = true
        this.check2 = true;
        this.checkLoading();
      }
    }


    private pad(num: number): string {
      return num < 10 ? '0' + num : num.toString();
    }


    checkLoading(){


      if(this.check1 && this.check2){
        this.loading = true;
      }
    }




  toggleReport(patient:any) {
    this.selectedPatient = patient;
    this.showReport = true;
    this.showJournal = false;
  }

  toggleJournal(patient: any) {
    this.selectedPatient = patient;
    this.showJournal = true;
    this.showReport = false;
  }
}
