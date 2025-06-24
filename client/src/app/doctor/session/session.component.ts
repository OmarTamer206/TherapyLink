import { SessionService } from './../../services/session/session.service';
import { Component, Input, OnDestroy, OnInit } from '@angular/core';
import { ReportComponent } from './report/report.component';
import { JournalComponent } from './journal/journal.component';
import { CommonModule, NgFor, NgIf } from '@angular/common';
import { ActivatedRoute, Router } from '@angular/router';
import { TherapistService } from '../../services/therapist/therapist.service';
import { ChatSectionComponent } from '../../chat-section/chat-section.component';
import { SocketService } from '../../services/chat/chat.service';
import { Subscription } from 'rxjs';
import { FormsModule } from '@angular/forms';
import { CallComponent } from '../../call/call.component';
import { CallService } from '../../services/call/call.service';

@Component({
  standalone: true,
  imports: [ReportComponent, JournalComponent, NgIf, ChatSectionComponent , CommonModule , FormsModule , CallComponent],
  selector: 'app-session',
  templateUrl: './session.component.html',
  styleUrls: ['./session.component.css'],
})
export class SessionComponent implements OnInit, OnDestroy {
  sessionID: any;
  showReport = false;
  showJournal = false;
  sessionData: any;
  patientData: any;

  loading = false;
  check1 = false;
  check2 = false;

  countInit = false;

  scheduledTime: string = ''; // ISO string
  timeLeft: string = '';
  isExpired = false;
  private intervalId: any;

  startButtonState = false;

  chatId: string = '';
  callId: string = '';
  userId: string = '';
  userType = 'doctor';
  userName = '';
  receiverId: string = '';
  receiverType = 'patient';

  sessionStarted = false;
  sessionEnded = false;

  doctorReport = '';
  reportSubmitted = false;

  private subscriptions: Subscription[] = [];
  duration: any;
  comm_type: any;

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private therapistService: TherapistService,
    private sessionService: SessionService,
    private socketService: SocketService,
    private callService: CallService
  ) {}

  ngOnInit(): void {
    this.route.paramMap.subscribe((params) => {
      const id = params.get('id');
      if (id) {
        this.sessionID = +id; // convert string to number
        console.log('Session ID:', this.sessionID);
      }
    });

    this.getDoctorData();

    this.gatherSessionData();

    // Connect to socket server and join chat
    this.socketService.connect();

    // Wait until chatId and userId are set (from gatherSessionData), so we add a small delay
    const initCheck = setInterval(() => {
      if (this.chatId!=null && this.userId) {
        this.socketService.enterChat(this.chatId, this.userId, this.userType );

        this.subscriptions.push(
          this.socketService.onSessionStart().subscribe(() => {
            this.sessionStarted = true;
            this.isExpired = false;
            console.log('Session started (socket event)');
          })
        );

        this.subscriptions.push(
          this.socketService.onSessionEnded().subscribe(() => {
            this.sessionStarted = false;
            this.sessionEnded = true;
            this.isExpired = true;
            console.log('Session ended (socket event)');
          })
        );

        clearInterval(initCheck);
      }
      else if (this.callId != null && this.userId) {
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

    if (this.chatId!=null) {
      this.socketService.exitChat(this.chatId, this.userId);
      this.socketService.disconnect();
    }

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

  gatherSessionData() {
    this.sessionService.viewSessionDetails(this.sessionID).subscribe(
      (response) => {
        console.log('Session Data:', response);
        if(response.success == false){
          window.location.href = '/doctor/dashboard';

        }
        this.sessionData = response.data;
        this.comm_type = this.sessionData.communication_type;
        this.callId = this.sessionData.call_ID;

        if(this.sessionData.ended == 1){
          this.router.navigate(['/doctor/dashboard']);
        }
        if(this.sessionData.doctor_ID != this.userId){
          window.location.href = '/doctor/dashboard';

        }

        this.therapistService.getPatientData(response.data.patient_ID).subscribe(
          (response) => {
            this.patientData = response.data;
            console.log('Patient Data:', this.patientData);
            this.receiverId = this.patientData.patient[0].id;
            console.log('ReceiverId set to:', this.receiverId);

            const date = new Date(this.sessionData.scheduled_time);
            this.scheduledTime = this.sessionData.scheduled_time;
            this.duration = this.sessionData.Duration;
            this.chatId = this.sessionData.chat_ID;

            this.sessionData.date = `${date.getDate()}/${date.getMonth() + 1}/${date.getFullYear()}`;
            const hours24 = date.getHours();
            const minutes = date.getMinutes();

            const hours12 = hours24 % 12 || 12;
            const ampm = hours24 >= 12 ? 'PM' : 'AM';
            const paddedMinutes = minutes.toString().padStart(2, '0');

            this.sessionData.time = `${hours12}:${paddedMinutes} ${ampm}`;

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
      },
      (error) => {
        console.error('Error getting session data:', error);

      }
    );
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

  private updateCountdown(): void {
    if (this.scheduledTime === '') return;

    const now = new Date();
    const target = new Date(this.scheduledTime);
    const diff = target.getTime() - now.getTime();

    if (diff <= 0) {
      this.timeLeft = '';
      this.isExpired = true;
      this.startButtonState = true;
      this.check2 = true;
      this.checkLoading();
      clearInterval(this.intervalId);
      return;
    }
// Enable start button only within last 60 minutes and if session not started
    this.startButtonState = diff <= 60 * 60 * 1000;

    const days = Math.floor(diff / (1000 * 60 * 60 * 24));
    const hours = Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
    const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
    const seconds = Math.floor((diff % (1000 * 60)) / 1000);

    this.timeLeft = `${this.pad(days)}d ${this.pad(hours)}h:${this.pad(minutes)}m:${this.pad(seconds)}s`;

    if (!this.countInit) {
      this.countInit = true;
      this.check2 = true;
      this.checkLoading();
    }
  }

  private pad(num: number): string {
    return num < 10 ? '0' + num : num.toString();
  }

  startSession() {
    // Notify server that doctor is ready to start session
    ; // fallback to 30
    if(this.chatId!= null){
      this.socketService.doctorReady(this.chatId, this.duration);
      this.sessionStarted = true;
    }
    if(this.callId!= null){
      console.log(this.userName);
      console.log(this.comm_type);

      this.callService.joinCall(this.callId, this.userId, this.userType, this.userName);
      this.sessionStarted = true;
      this.callService.emitSessionStarted(this.callId,"doctor",this.duration);


    }
  }
    endSession() {
    // Notify server that doctor is ready to start session
    ; // fallback to 30
    if(this.chatId!= null){
      this.socketService.doctorEndSession(this.chatId,this.userId);
    }
    if(this.callId!= null){
      this.callService.endCall(this.callId, this.userId);
    }
    this.sessionEnded = true;
  }


   submitReport() {
    if (!this.doctorReport.trim()) return;

    this.therapistService.updatePatientReport(this.doctorReport,this.sessionData).subscribe({
      next: () => {

      // this.router.navigate(['/doctor/dashboard']);
      window.location.href = '/doctor/dashboard';

      },
      error: (err) => {
        console.error('Failed to submit report:', err);
        alert('Failed to submit report. Please try again.');
      }
    });
  }

  checkLoading() {
    if (this.check1 && this.check2) {
      this.loading = true;
    }
  }
}
