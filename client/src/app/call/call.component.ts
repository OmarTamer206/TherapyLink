import {
  Component, OnInit, OnDestroy, Input, ViewChild, ElementRef
} from '@angular/core';
import { CallService } from '../services/call/call.service';
import { CommonModule } from '@angular/common';

interface Participant {
  userType: string;
  userName: string;
  muted: boolean;
  videoOn: boolean;
}

@Component({
  selector: 'app-call',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './call.component.html',
  styleUrls: ['./call.component.css'],
})
export class CallComponent implements OnInit, OnDestroy {
  participants: Record<string, Participant> = {};
  muted = false;
  videoOn = false;
  callEnded = false;

  pendingCandidates: RTCIceCandidateInit[] = [];
  remoteDescriptionSet = false;

  @Input() call_ID!: string;
  @Input() userId!: string;
  @Input() userType!: string;
  @Input() userName!: string;

  @ViewChild('localVideo', { static: false }) localVideoRef!: ElementRef<HTMLVideoElement>;
  @ViewChild('remoteVideo', { static: false }) remoteVideoRef!: ElementRef<HTMLVideoElement>;

  localStream!: MediaStream;
  peerConnection!: RTCPeerConnection;

  constructor(private callService: CallService) {}

  async ngOnInit(): Promise<void> {
    this.callService.connect();
    this.callService.joinCall(this.call_ID, this.userId, this.userType, this.userName);

    this.callService.onParticipantsUpdate().subscribe(p => this.participants = p);
    this.callService.onCallEnded().subscribe(() => {
      this.callEnded = true;
      alert('Call ended');
      this.leave();
    });

    this.callService.onSessionStarted().subscribe(() => {
      console.log('Session started');
      this.startMediaAndConnect();
    });

    this.callService.onRejoinRequest().subscribe(async ({ call_ID, targetId }) => {
      if (
        this.call_ID === call_ID &&
        ['doctor', 'life_coach', 'emergency_team'].includes(this.userType)
      ) {
        console.log('Rejoin request received');
        if (!this.peerConnection || this.peerConnection.connectionState === 'closed') {
          await this.startMediaAndConnect();
        }
        this.forceOffer();
      }
    });

    this.callService.onWebRTCOffer().subscribe(async ({ offer, senderId }) => {
      console.log('Offer received');
      if (!this.peerConnection) {
        await this.startMediaAndConnect();
      }

      try {
        await this.peerConnection.setRemoteDescription(new RTCSessionDescription(offer));
        this.remoteDescriptionSet = true;

        const answer = await this.peerConnection.createAnswer();
        await this.peerConnection.setLocalDescription(answer);
        this.callService.sendWebRTCAnswer(this.call_ID, answer, this.userId);
        this.flushPendingCandidates();
      } catch (err) {
        console.error('Error handling offer:', err);
      }
    });

    this.callService.onWebRTCAnswer().subscribe(async ({ answer }) => {
      if (this.peerConnection) {
        try {
          await this.peerConnection.setRemoteDescription(new RTCSessionDescription(answer));
          this.remoteDescriptionSet = true;
          this.flushPendingCandidates();
        } catch (err) {
          console.error('Error setting answer:', err);
        }
      }
    });

    this.callService.onIceCandidate().subscribe(async ({ candidate }) => {
      if (this.peerConnection && this.remoteDescriptionSet) {
        try {
          await this.peerConnection.addIceCandidate(new RTCIceCandidate(candidate));
        } catch (err) {
          console.error('ICE error:', err);
        }
      } else {
        this.pendingCandidates.push(candidate);
      }
    });

    await this.startMediaAndConnect();
  }

  async startMediaAndConnect(): Promise<void> {
    try {
      if (this.peerConnection) this.peerConnection.close();
      if (this.localStream) this.localStream.getTracks().forEach(t => t.stop());

      this.localStream = await navigator.mediaDevices.getUserMedia({ video: true, audio: true });
      this.localStream.getVideoTracks().forEach(track => track.enabled = false);
      this.localStream.getAudioTracks().forEach(track => track.enabled = true);
      this.videoOn = false;
      this.muted = false;

      this.localVideoRef.nativeElement.srcObject = this.localStream;

      this.peerConnection = new RTCPeerConnection({
        iceServers: [{ urls: 'stun:stun.l.google.com:19302' }]
      });

      this.localStream.getTracks().forEach(track =>
        this.peerConnection.addTrack(track, this.localStream)
      );

      this.peerConnection.ontrack = (event) => {
        if (event.streams.length > 0) {
          this.remoteVideoRef.nativeElement.srcObject = event.streams[0];
        }
      };

      this.peerConnection.onicecandidate = (event) => {
        if (event.candidate) {
          this.callService.sendIceCandidate(this.call_ID, event.candidate.toJSON(), this.userId);
        }
      };
    } catch (err) {
      console.error('Failed to start media:', err);
    }
  }

  public async forceOffer(): Promise<void> {
    if (!this.peerConnection || !this.localStream) return;
    try {
      const offer = await this.peerConnection.createOffer();
      await this.peerConnection.setLocalDescription(offer);
      this.callService.sendWebRTCOffer(this.call_ID, offer, this.userId);
    } catch (err) {
      console.error('forceOffer error:', err);
    }
  }

  flushPendingCandidates(): void {
    if (!this.peerConnection || !this.remoteDescriptionSet) return;
    this.pendingCandidates.forEach(async candidate => {
      try {
        await this.peerConnection!.addIceCandidate(new RTCIceCandidate(candidate));
      } catch (err) {
        console.error('Flush ICE error:', err);
      }
    });
    this.pendingCandidates = [];
  }

  toggleMute(): void {
    if (this.localStream) {
      this.muted = !this.muted;
      this.localStream.getAudioTracks().forEach(track => track.enabled = !this.muted);
      this.callService.toggleMute(this.call_ID, this.userId, this.muted);
    }
  }

  toggleVideo(): void {
    if (this.localStream) {
      this.videoOn = !this.videoOn;
      this.localStream.getVideoTracks().forEach(track => track.enabled = this.videoOn);
      this.callService.toggleVideo(this.call_ID, this.userId, this.videoOn);
    }
  }

  leave(): void {
    this.callService.leaveCall(this.call_ID, this.userId);
    if (this.peerConnection) this.peerConnection.close();
    if (this.localStream) this.localStream.getTracks().forEach(track => track.stop());
    this.localVideoRef.nativeElement.srcObject = null;
    this.remoteVideoRef.nativeElement.srcObject = null;
  }

  endCall(): void {
    if (['doctor', 'life_coach', 'emergency_team'].includes(this.userType)) {
      this.callService.endCall(this.call_ID, this.userId);
    }
  }

  ngOnDestroy(): void {
    this.leave();
    this.callService.disconnect();
  }
}
