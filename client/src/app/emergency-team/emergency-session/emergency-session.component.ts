import { SessionService } from './../../services/session/session.service';
import { Component, Input, OnDestroy, OnInit } from '@angular/core';

import { CommonModule, NgFor, NgIf } from '@angular/common';
import { ActivatedRoute, Router } from '@angular/router';
import { TherapistService } from '../../services/therapist/therapist.service';
import { ChatSectionComponent } from '../../chat-section/chat-section.component';
import { SocketService } from '../../services/chat/chat.service';
import { Subscription } from 'rxjs';
import { FormsModule } from '@angular/forms';
import { CallComponent } from '../../call/call.component';
import { CallService } from '../../services/call/call.service';
import { ReportComponent } from '../../doctor/session/report/report.component';
import { JournalComponent } from '../../doctor/session/journal/journal.component';
@Component({
  selector: 'app-emergency-session',
  standalone: true,
  imports: [ReportComponent, JournalComponent, NgIf, ChatSectionComponent , CommonModule , FormsModule , CallComponent],
  templateUrl: './emergency-session.component.html',
  styleUrl: './emergency-session.component.css'
})
export class EmergencySessionComponent implements OnInit, OnDestroy {
  sessionID: any;
  showReport = false;
  showJournal = false;
  sessionData: any;
  patientData: any;

  loading = false;
  check1 = false;

  countInit = false;

  scheduledTime: string = ''; // ISO string
  timeLeft: string = '';
  isExpired = false;
  private intervalId: any;

  startButtonState = true;

  chatId: string = '';
  callId: string = '';
  userId: string = '';
  userType = 'emergency_team';
  userName = '';
  receiverId: string = '';
  receiverType = 'patient';

  sessionStarted = true;
  sessionEnded = false;

  doctorReport = '';
  reportSubmitted = false;

  private subscriptions: Subscription[] = [];
  duration: any;
  comm_type: any;
  patientId: any;
  emergencyMemberName: any;
  teamMemberId: any;

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private therapistService: TherapistService,
    private sessionService: SessionService,
    private socketService: SocketService,
    private callService: CallService
  ) {}

  ngOnInit(): void {
      const state = window.history.state;

    if (state) {

      this.callId= state.callId;
      this.patientId= state.patientId;
      console.log(state.patientId);

      this.teamMemberId= state.emergencyMember.id;
      this.emergencyMemberName= state.emergencyMember.name;


      if (!this.callId) {
        this.router.navigate(['/emergency-team']);
        console.log(this.callId);

      }



    // Connect to socket server and join chat


    this.callService.connect();
    // Wait until chatId and userId are set (from gatherSessionData), so we add a small delay
    const initCheck = setInterval(() => {
      if (this.callId != null && this.emergencyMemberName) {

        this.callService.checkCallStatus(this.callId, this.teamMemberId).then(rejoin => {
          if (rejoin) {
            this.callService.joinCall(this.callId, this.teamMemberId, this.userType, this.emergencyMemberName);
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

        this.callService.joinCall(this.callId, this.teamMemberId, this.userType, this.emergencyMemberName);



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


    this.therapistService.getPatientData(this.patientId).subscribe(
          (response) => {
            this.patientData = response.data;
            console.log(this.patientData);

            this.patientData.journals.forEach((journal: any) => {
              const jd = new Date(journal.time);
              journal.date = `${jd.getDate()}/${jd.getMonth() + 1}/${jd.getFullYear()}`;
              const jHours24 = jd.getHours();
              const jMinutes = jd.getMinutes();

              const jHours12 = jHours24 % 12 || 12;
              const jAmpm = jHours24 >= 12 ? 'PM' : 'AM';
              const jPaddedMinutes = jMinutes.toString().padStart(2, '0');

              journal.time = `${jHours12}:${jPaddedMinutes} ${jAmpm}`;
            });

            this.check1 = true;
            this.checkLoading();
          }
        );


  }
}

  ngOnDestroy(): void {
    this.subscriptions.forEach((sub) => sub.unsubscribe());



    if (this.callId!=null) {
      this.callService.leaveCall(this.callId, this.userId);
      this.callService.disconnect();
    }

    clearInterval(this.intervalId);
  }





  toggleReport() {
    this.showReport = !this.showReport;
    if (this.showReport) {
      this.showJournal = false;
    }
  }

  toggleJournal() {
    this.showJournal = !this.showJournal;
    console.log('Show Journal:', this.showJournal);

    if (this.showJournal) {
      this.showReport = false;
    }
  }


  startSession() {
    // Notify server that doctor is ready to start session
    ; // fallback to 30

    if(this.callId!= null){
      console.log(this.userName);
      console.log(this.callId, this.teamMemberId, this.userType, this.emergencyMemberName);

      this.callService.joinCall(this.callId, this.teamMemberId, this.userType, this.emergencyMemberName);
      this.sessionStarted = true;
      this.callService.emitSessionStarted(this.callId,"emergency_team","no");


    }
  }
    endSession() {
    // Notify server that doctor is ready to start session
    if(this.callId!= null){
      this.callService.endCall(this.callId, this.teamMemberId);
    }
    this.sessionEnded = true;
  }


   submitReport() {
    if (!this.doctorReport.trim()) return;
    this.sessionData = {
      patient_ID : this.patientId,
      doctor_ID:this.teamMemberId,

    }
    this.therapistService.updatePatientReport(this.doctorReport,this.sessionData).subscribe({
      next: (response) => {
        console.log(response);

      // this.router.navigate(['/doctor/dashboard']);
      this.router.navigate(['/emergency-team/emergency-team-dashboard'], { replaceUrl: true });


      },
      error: (err) => {
        console.error('Failed to submit report:', err);
        alert('Failed to submit report. Please try again.');
      }
    });
  }

  checkLoading() {
    if (this.check1 ) {
      this.loading = true;
      this.startSession()

    }
  }
}

