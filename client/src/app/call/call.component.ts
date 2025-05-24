import {
  Component, OnInit, OnDestroy, Input,
  ViewChild, ElementRef
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
      console.log('Session started (signal)');
      this.startMediaAndConnect();
    });

    await this.startMediaAndConnect(); // always try to start on init

    this.callService.onWebRTCOffer().subscribe(async ({ offer, senderId }) => {
      if (!this.peerConnection) {
        console.warn('PeerConnection not ready');
        return;
      }

      try {
        await this.peerConnection.setRemoteDescription(new RTCSessionDescription(offer));
        this.remoteDescriptionSet = true;

        const answer = await this.peerConnection.createAnswer();
        await this.peerConnection.setLocalDescription(answer);
        this.callService.sendWebRTCAnswer(this.call_ID, answer, this.userId);
        this.flushPendingCandidates();
      } catch (err) {
        console.error('Error setting offer:', err);
      }
    });

    this.callService.onWebRTCAnswer().subscribe(async ({ answer }) => {
      if (!this.peerConnection) return;
      try {
        await this.peerConnection.setRemoteDescription(new RTCSessionDescription(answer));
        this.remoteDescriptionSet = true;
        this.flushPendingCandidates();
      } catch (err) {
        console.error('Error setting answer:', err);
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

    this.callService.onRejoinRequest().subscribe(({ call_ID, targetId }) => {
  if (
    this.call_ID === call_ID &&
    ['doctor', 'life_coach', 'emergency_team'].includes(this.userType)
  ) {
    console.log('Rejoin request received — sending new offer');
    this.forceOffer();
  }
});


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
  }

  endCall(): void {
    if (['doctor', 'life_coach', 'emergency_team'].includes(this.userType)) {
      this.callService.endCall(this.call_ID, this.userId);
    }
  }

  public async startMediaAndConnect(): Promise<void> {
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

      if (['doctor', 'life_coach', 'emergency_team'].includes(this.userType)) {
        const offer = await this.peerConnection.createOffer();
        await this.peerConnection.setLocalDescription(offer);
        this.callService.sendWebRTCOffer(this.call_ID, offer, this.userId);
      }

    } catch (error) {
      console.error('startMediaAndConnect failed:', error);
      alert('Camera/Microphone permission denied or not available.');
    }
  }

  flushPendingCandidates(): void {
    if (!this.peerConnection || !this.remoteDescriptionSet) return;
    this.pendingCandidates.forEach(async candidate => {
      try {
        await this.peerConnection!.addIceCandidate(new RTCIceCandidate(candidate));
      } catch (err) {
        console.error('Error adding ICE:', err);
      }
    });
    this.pendingCandidates = [];
  }

  public async forceOffer(): Promise<void> {
  if (!this.peerConnection || this.peerConnection.connectionState === 'closed') {
    console.warn('Cannot send offer: PeerConnection is not available');
    return;
  }

  try {
    const offer = await this.peerConnection.createOffer();
    await this.peerConnection.setLocalDescription(offer);
    this.callService.sendWebRTCOffer(this.call_ID, offer, this.userId);
    console.log('[WebRTC] Force-offer sent due to rejoin');
  } catch (err) {
    console.error('Error forcing offer:', err);
  }
}


  ngOnDestroy(): void {
    this.leave();
    this.callService.disconnect();
  }
}
