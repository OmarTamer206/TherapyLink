import { SessionService } from './../../services/session/session.service';
import { Component, Input, OnDestroy, OnInit } from '@angular/core';
import { ReportComponent } from './report/report.component';
import { JournalComponent } from './journal/journal.component';
import { NgFor, NgIf } from '@angular/common';
import { ActivatedRoute } from '@angular/router';
import { TherapistService } from '../../services/therapist/therapist.service';
import { ChatSectionComponent } from '../../chat-section/chat-section.component';
import { SocketService } from '../../services/chat/chat.service';
import { Subscription } from 'rxjs';

@Component({
  standalone: true,
  imports: [ReportComponent, JournalComponent, NgIf, ChatSectionComponent],
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
  userId: string = '';
  userType = 'doctor';
  receiverId: string = '';
  receiverType = 'patient';

  sessionStarted = false;

  private subscriptions: Subscription[] = [];
  duration: any;

  constructor(
    private route: ActivatedRoute,
    private therapistService: TherapistService,
    private sessionService: SessionService,
    private socketService: SocketService
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
      if (this.chatId && this.userId) {
        this.socketService.enterChat(this.chatId, this.userId, this.userType);

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
            this.isExpired = true;
            console.log('Session ended (socket event)');
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
    this.socketService.exitChat(this.chatId, this.userId);
    this.socketService.disconnect();
    clearInterval(this.intervalId);
  }

  getDoctorData() {
    this.therapistService.getTherapistData().subscribe(
      (response) => {
        console.log('Doctor Data:', response);
        this.userId = response.data[0].id;
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
        this.sessionData = response.data;
        this.therapistService.getPatientData(response.data.patient_ID).subscribe(
          (response) => {
            this.patientData = response.data;
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
      this.startButtonState = false;
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
    this.socketService.doctorReady(this.chatId, this.duration);
  }

  checkLoading() {
    if (this.check1 && this.check2) {
      this.loading = true;
    }
  }
}
