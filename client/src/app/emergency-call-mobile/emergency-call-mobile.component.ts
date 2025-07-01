// emergency-call-mobile.component.ts
import {
  Component,
  OnInit,
  OnDestroy,
  ElementRef,
  ViewChild
} from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { CommonModule } from '@angular/common';
import { Subscription, firstValueFrom } from 'rxjs';
import { EmergencyTeamSocketService } from '../services/emergencySocket/emergency-socket.service';
import { PatientService } from '../services/patient/patient.service';

@Component({
  selector: 'app-emergency-call-mobile',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './emergency-call-mobile.component.html',
  styleUrl: './emergency-call-mobile.component.css'
})
export class EmergencyCallMobileComponent implements OnInit, OnDestroy {
  userId: string = '';
  patientID: any;
  patientData: any;
  token: any;
  iframe: HTMLIFrameElement | null = null;
  private subscriptions: Subscription[] = [];
  private messageListenerAdded = false;
  sessionStarted = false;;

  constructor(
    private route: ActivatedRoute,
    private emergencySocketService: EmergencyTeamSocketService,
    private patientService: PatientService
  ) {}

  async getDataFromUrl(): Promise<any> {
    const params = await firstValueFrom(this.route.paramMap);
    const idParam = params.get('userId');
    this.userId = idParam || '';
    this.patientID = +idParam!;
    return this.patientID;
  }

  async getProfileData(patientID: any): Promise<void> {
    return new Promise((resolve, reject) => {
      this.patientService.getProfileDataByID(patientID).subscribe({
        next: (response) => {
          this.patientData = response.data.patient[0];
          resolve();
        },
        error: (err) => reject(err)
      });
    });
  }

  async ngOnInit(): Promise<void> {
    if (!this.messageListenerAdded) {
      window.addEventListener('message', async (event) => {
        this.token = event.data?.token;
        if (this.token) {
          localStorage.setItem('accessToken', this.token);
          await this.getDataFromUrl();
          await this.getProfileData(this.patientID);

          this.emergencySocketService.connect();
          this.emergencySocketService.sendEmergencyRequest(this.patientData);

          const sub = this.emergencySocketService.onRequestAccepted().subscribe((data: any) => {
                window.parent.postMessage({ type: 'sessionStarted' }, '*');

            const callId = data.callId;
            this.sessionStarted = true;
            const callUrl = `/call/${callId}/${this.userId}/patient/${this.patientData.Name}`;
            window.addEventListener('message', (event) => {
              if (event.data?.type === 'sessionEnded') {
                console.log('Session ended recived from call iframe');
                window.top!.postMessage({ type: 'sessionEnded' }, '*');

              }
            });

            this.iframe = document.createElement('iframe');
            this.iframe.src = callUrl;
            this.iframe.style.width = '100%';
            this.iframe.style.height = '100%';
            this.iframe.style.border = 'none';

            document.body.innerHTML = ''; // Clear page
            document.body.appendChild(this.iframe);

            // Forward messages from call iframe to Flutter
          });

          this.subscriptions.push(sub);
        }
      });
      this.messageListenerAdded = true;
    }
  }

  ngOnDestroy(): void {
    console.log('EmergencyCallMobileComponent destroyed');

    this.subscriptions.forEach(sub => sub.unsubscribe());
    this.emergencySocketService.cancelEmergencyRequest(this.userId);
  }
}
