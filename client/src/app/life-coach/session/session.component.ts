import { Component, OnDestroy, OnInit } from '@angular/core';

import { NgIf, NgFor, CommonModule } from '@angular/common';
import { ActivatedRoute, Router } from '@angular/router';
import { TherapistService } from '../../services/therapist/therapist.service';
import { SessionService } from '../../services/session/session.service';
import { ReportComponent } from '../../doctor/session/report/report.component';
import { JournalComponent } from '../../doctor/session/journal/journal.component';
import { Subscription } from 'rxjs';
import { CallService } from '../../services/call/call.service';
import { CallComponent } from '../../call/call.component';

@Component({
  standalone: true,
  imports: [ReportComponent,JournalComponent, NgIf, NgFor ,CallComponent,CommonModule],
  selector: 'app-session',
  templateUrl: './session.component.html',
  styleUrls: ['./session.component.css'],
})
export class lifeSessionComponent implements OnInit, OnDestroy {
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


  callId: string = '';
  userId: string = '';
  userType = 'life_coach';
  userName = '';
  receiverId: string = '';
  receiverType = 'patient';

  sessionStarted = false;
  sessionEnded = false;
  private subscriptions: Subscription[] = [];
  duration: any;


    constructor(private route:ActivatedRoute, private therapistService:TherapistService , private sessionService:SessionService ,private callService: CallService , private router:Router) {

    }

    ngOnInit(): void {
      this.route.paramMap.subscribe(params => {
        const id = params.get('id');
        if (id) {
          this.sessionID = +id; // convert string to number
          console.log('Session ID:', this.sessionID);
        }
      });

      this.getDoctorData();
      this.gatherSessionData();

         const initCheck = setInterval(() => {
      if (this.callId != null && this.userId) {
        this.callService.connect();

        this.callService.checkCallStatus(this.callId, this.userId).then(rejoin => {
          if (rejoin) {
            this.callService.joinCall(this.callId, this.userId, this.userType, this.userName);
            this.sessionStarted = true;

           setTimeout(() => {
              const comp = document.querySelector('app-call') as any;
              comp?.startMediaAndConnect?.();

              // 👇 Force initiator to re-send offer
              if (['doctor', 'life_coach', 'emergency_team'].includes(this.userType)) {
                setTimeout(() => comp?.forceOffer?.(), 800); // slight delay to ensure connection is up
              }
            }, 300);
          } else {
            console.log('Call is not active or already ended.');
          }
        });

        this.callService.joinCall(this.callId, this.userId, this.userType, this.userName);

        this.subscriptions.push(
          this.callService.onCallEnded().subscribe(() => {
            this.sessionEnded = true;

          })
        );

        // Optional: handle participant updates for real-time UI updates
        this.subscriptions.push(
          this.callService.onParticipantsUpdate().subscribe((participants) => {
            console.log('Participants updated:', participants);
            // You can add additional UI handling here if required
          })
        );

        clearInterval(initCheck);
      }

    }, 100);

      this.updateCountdown();
      this.intervalId = setInterval(() => this.updateCountdown(), 1000);


    }

      ngOnDestroy(): void {
    this.subscriptions.forEach((sub) => sub.unsubscribe());


    if (this.callId!=null) {
      this.callService.leaveCall(this.callId, this.userId);
      this.callService.disconnect();
    }

    clearInterval(this.intervalId);
  }

      getDoctorData() {
    this.therapistService.getTherapistData().subscribe(
      (response) => {
        console.log('Doctor Data:', response);
        this.userId = response.data[0].id;
        this.userName = response.data[0].Name;

        console.log('UserId set to:', this.userId);
      },
      (error) => {
        console.error('Error getting doctor data:', error);
      }
    );
  }


  // Hatet8yr fl lifecoach
    gatherSessionData(){
      this.sessionService.viewSessionDetails(this.sessionID).subscribe((response) => {
        console.log("session : ",response);
        this.sessionData = response.data;


        this.callId = this.sessionData.call_ID;
        console.log(this.callId);

        if(this.sessionData.ended == 1){
          this.router.navigate(['/life-coach/dashboard']);
        }

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






    private updateCountdown(): void {
      if(this.scheduledTime=="")
        return;

      const now = new Date();
      const target = new Date(this.scheduledTime);
      const diff = target.getTime() - now.getTime();

      if (diff <= 0) {
        this.timeLeft = '';
        this.isExpired = true;
        this.startButtonState = true;
        clearInterval(this.intervalId);
        this.check2 = true;
        this.checkLoading();
        return;
      }

      // Set startButtonState to true if less than 60 minutes left (5 * 60 * 1000 ms)
      this.startButtonState = diff <= 60 * 60 * 1000;

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


  startSession() {
    // Notify server that doctor is ready to start session
 // fallback to 30

    if(this.callId!= null){
      console.log(this.userName);

      this.callService.joinCall(this.callId, this.userId, this.userType, this.userName);
      this.sessionStarted = true;
      this.callService.emitSessionStarted(this.callId,"doctor",this.duration);


    }
  }
    endSession() {
    // Notify server that doctor is ready to start session
    ; // fallback to 30
    if(this.callId!= null){
      this.callService.endCall(this.callId, this.userId);
    }
    this.sessionEnded = true;

    window.location.href = '/life-coach/session-ended';
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
