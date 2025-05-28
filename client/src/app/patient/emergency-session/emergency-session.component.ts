import { Component, OnInit, OnDestroy } from '@angular/core';
import { Router } from '@angular/router';
import { CommonModule } from '@angular/common';
import { Subscription } from 'rxjs';
import { CallComponent } from '../../call/call.component';
import { CallService } from '../../services/call/call.service';
import { EmergencyTeamSocketService } from '../../services/emergencySocket/emergency-socket.service';

@Component({
  selector: 'app-emergency-session',
  standalone: true,
  imports: [CommonModule, CallComponent],
  templateUrl: './emergency-session.component.html',
  styleUrl: './emergency-session.component.css'
})
export class EmergencySessionPatientComponent implements OnInit, OnDestroy {
  sessionStarted = false;
  sessionEnded = false;
  callId: string = '';
  userId: string = '';
  userType = 'patient';
  patient_name: string = '';
  patientData: any;

  private subscriptions: Subscription[] = [];
  isExpired = false;

  constructor(
    private router: Router,
    private callService: CallService,
    private emergencySocketService: EmergencyTeamSocketService
  ) {}

  ngOnInit(): void {
    const state = window.history.state;

    if (state && state.patientData) {
      this.patientData = state.patientData;
      this.userId = this.patientData.id;
      this.patient_name = this.patientData.Name;

      this.emergencySocketService.connect();
      this.emergencySocketService.sendEmergencyRequest(this.patientData);

      const sub = this.emergencySocketService.onRequestAccepted().subscribe((data: any) => {
        this.callId = data.callId;
        this.initilizeCall();
        this.isExpired = true;
      });

      this.subscriptions.push(sub);
    }
  }

  ngOnDestroy(): void {
    this.subscriptions.forEach(sub => sub.unsubscribe());

    if (this.callId) {
      this.callService.leaveCall(this.callId, this.userId);
      this.callService.disconnect();
    }

    this.emergencySocketService.cancelEmergencyRequest(this.userId);
  }

  initilizeCall(): void {
    console.log(this.callId);

    this.callService.connect();

    this.callService.checkCallStatus(this.callId, this.userId).then(rejoin => {
      if (rejoin) {
        this.callService.joinCall(this.callId, this.userId, this.userType, this.patient_name);
        this.sessionStarted = true;

        setTimeout(() => {
          const comp = document.querySelector('app-call') as any;
          comp?.startMediaAndConnect?.();
        }, 300);
      } else {
        console.log('Call is not active or already ended.');
      }
    });


     this.callService.joinCall(this.callId, this.userId, this.userType, this.patient_name);
        this.sessionStarted = true;

        setTimeout(() => {
          const comp = document.querySelector('app-call') as any;
          comp?.startMediaAndConnect?.();
        }, 300);

    this.subscriptions.push(
      this.callService.onSessionStarted().subscribe(() => {
        this.callService.joinCall(this.callId, this.userId, this.userType, this.patient_name);
        this.sessionStarted = true;
        setTimeout(() => {
          const comp = document.querySelector('app-call') as any;
          comp?.startMediaAndConnect?.();
        }, 300);
      }),

      this.callService.onCallEnded().subscribe(() => {
        this.sessionEnded = true;

        this.router.navigate(['/patient/home'], { replaceUrl: true });
      })
    );
  }

  goHome(): void {
    this.router.navigate(['patient/home']);
  }
}
