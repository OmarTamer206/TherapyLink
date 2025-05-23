import { Component, OnInit, OnDestroy } from '@angular/core';
import { SessionService } from '../../services/session/session.service';
import { Router } from '@angular/router';
import { ChatSectionComponent } from '../../chat-section/chat-section.component';
import { CommonModule } from '@angular/common';
import { SocketService } from '../../services/chat/chat.service';
import { Subscription } from 'rxjs';

@Component({
  selector: 'app-session-page',
  standalone: true,
  imports: [ChatSectionComponent, CommonModule],
  templateUrl: './session-page.component.html',
  styleUrls: ['./session-page.component.css']
})
export class SessionPageComponent implements OnInit, OnDestroy {
  session: any;
  loading = false;
  check1 = false;
  timeLeft: any;
  isExpired = false;
  startButtonState = false;
  intervalId: any;
  countInit: any;
  check2 = false;

  sessionStarted = false;
  sessionEnded = false;

  chatId: string = '';
  userId: string = '';
  userType = 'patient';
  receiverId: string = '';
  receiverType: any;

  private subscriptions: Subscription[] = [];

  constructor(
    private sessionService: SessionService,
    private router: Router,
    private socketService: SocketService
  ) {}

  ngOnInit(): void {
    // Access the state data from window.history
    const state = window.history.state;

    if (state) {
      this.session = state.session;

      if (!this.session) {
        this.router.navigate(['/patient/home']);
      }

      this.chatId = this.session.chat_ID;
      this.userId = this.session.patient_ID;
      this.receiverId = this.session.doctor_ID;
      this.receiverType = this.session.session_type;

      console.log('Session : ', this.session);
      console.log('Chat ID : ', this.chatId);
      console.log('User ID : ', this.userId);
      console.log('Receiver ID : ', this.receiverId);
      console.log('Receiver Type : ', this.receiverType);
    }

    this.socketService.connect();

    this.socketService.enterChat(this.chatId, this.userId, this.userType);

    this.subscriptions.push(
      this.socketService.onSessionStart().subscribe(() => {
        this.sessionStarted = true;
        this.isExpired = false;
        console.log('Session started by doctor or patient');
      })
    );

    this.subscriptions.push(
      this.socketService.onSessionEnded().subscribe(() => {
        this.sessionStarted = false;
        console.log("sdasdasd");

        this.isExpired = true;
        console.log('Session ended');
        this.router.navigate(['/patient/session-ended'],{ state: { session:this.session } ,replaceUrl: true });
      })
    );

    this.updateCountdown();
    this.intervalId = setInterval(() => this.updateCountdown(), 1000);
  }

  ngOnDestroy(): void {
    this.subscriptions.forEach(sub => sub.unsubscribe());
    this.socketService.exitChat(this.chatId, this.userId);
    this.socketService.disconnect();
    clearInterval(this.intervalId);
  }

  private updateCountdown(): void {
    if (!this.session || this.session.scheduled_time === '') return;

    const now = new Date();
    const target = new Date(this.session.scheduled_time);
    const diff = target.getTime() - now.getTime();

    if (diff <= 0) {
      this.timeLeft = '';
      this.isExpired = true;
      this.startButtonState = false;
      clearInterval(this.intervalId);
      return;
    }

    // Enable start button only within last 60 minutes and if session not started
    this.startButtonState = diff <= 60 * 60 * 1000 && !this.sessionStarted;

    const days = Math.floor(diff / (1000 * 60 * 60 * 24));
    const hours = Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
    const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
    const seconds = Math.floor((diff % (1000 * 60)) / 1000);

    this.timeLeft = `${this.pad(days)} days : ${this.pad(hours)} Hours : ${this.pad(minutes)} Minutes : ${this.pad(seconds)} Seconds`;



    if (!this.countInit) {
      this.countInit = true;
      this.check2 = true;
      this.checkLoading();
    }
  }

  private pad(num: number): string {
    return num < 10 ? '0' + num : num.toString();
  }

  startSession(): void {
    if (this.userType === 'patient') {
      this.socketService.patientReady(this.chatId);
    } else if (this.userType === 'doctor') {
      const durationMinutes = this.session.time || 30; // fallback duration
      this.socketService.doctorReady(this.chatId, durationMinutes);
    }
  }

  goHome() {
  this.router.navigate(['patient/home']); // adjust route path as needed
}

  checkLoading(): void {
    if (this.check1 && this.check2) {
      this.loading = true;
    }
  }
}
