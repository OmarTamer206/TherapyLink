import { Component, OnInit, OnDestroy, Input, ViewChild, ElementRef } from '@angular/core';
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

  @Input() call_ID!: string;
  @Input() userId!: string;
  @Input() userType!: string;
  @Input() userName!: string;

@ViewChild('localVideo', { static: false }) localVideoRef!: ElementRef<HTMLVideoElement>;
@ViewChild('remoteVideo', { static: false }) remoteVideoRef!: ElementRef<HTMLVideoElement>;


  localStream!: MediaStream;
  peerConnection!: RTCPeerConnection;

  constructor(private callService: CallService) {}

  ngOnInit(): void {
    this.callService.connect();
    this.callService.joinCall(this.call_ID, this.userId, this.userType, this.userName);

    this.callService.onParticipantsUpdate().subscribe(participants => {
      this.participants = participants;
    });

    this.callService.onCallEnded().subscribe(() => {
      this.callEnded = true;
      alert('Call has been ended.');
      this.leave();
    });

    this.callService.onSessionStarted().subscribe(() => {
      console.log('Session started, initializing call');
      this.startMediaAndConnect();
    });

    this.callService.onWebRTCOffer().subscribe(async ({ offer }) => {
      await this.startMediaAndConnect();
      await this.peerConnection.setRemoteDescription(new RTCSessionDescription(offer));
      const answer = await this.peerConnection.createAnswer();
      await this.peerConnection.setLocalDescription(answer);
      this.callService.sendWebRTCAnswer(this.call_ID, answer, this.userId);
    });

    this.callService.onWebRTCAnswer().subscribe(async ({ answer }) => {
      await this.peerConnection.setRemoteDescription(new RTCSessionDescription(answer));
    });

    this.callService.onIceCandidate().subscribe(async ({ candidate }) => {
      if (candidate) {
        await this.peerConnection.addIceCandidate(new RTCIceCandidate(candidate));
      }
    });
  }



  toggleMute(): void {
    if (this.localStream) {
      this.localStream.getAudioTracks().forEach(track => track.enabled = this.muted);
    }
    this.muted = !this.muted;
    this.callService.toggleMute(this.call_ID, this.userId, this.muted);
  }

  toggleVideo(): void {
    if (this.localStream) {
      this.localStream.getVideoTracks().forEach(track => track.enabled = !this.videoOn);
    }
    this.videoOn = !this.videoOn;
    this.callService.toggleVideo(this.call_ID, this.userId, this.videoOn);
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
    // 1. Get local media stream
    this.localStream = await navigator.mediaDevices.getUserMedia({ video: true, audio: true });
    this.localVideoRef.nativeElement.srcObject = this.localStream;

    // 2. Create peer connection
    this.peerConnection = new RTCPeerConnection({
      iceServers: [{ urls: 'stun:stun.l.google.com:19302' }]
    });

    // 3. Add local tracks to peer connection
    this.localStream.getTracks().forEach(track => {
      this.peerConnection.addTrack(track, this.localStream);
    });

    // 4. Handle remote track
    this.peerConnection.ontrack = (event) => {
      if (event.streams && event.streams[0]) {
        this.remoteVideoRef.nativeElement.srcObject = event.streams[0];
      }
    };

    // 5. Handle ICE candidate
    this.peerConnection.onicecandidate = (event) => {
      if (event.candidate) {
        this.callService.sendIceCandidate(this.call_ID, event.candidate.toJSON(), this.userId);
      }
    };

    // 6. If user is initiator (doctor, life coach, emergency team), create offer
    if (['doctor', 'life_coach', 'emergency_team'].includes(this.userType)) {
      const offer = await this.peerConnection.createOffer();
      await this.peerConnection.setLocalDescription(offer);
      this.callService.sendWebRTCOffer(this.call_ID, offer, this.userId);
    }
  } catch (error) {
    console.error('Error initializing media or peer connection:', error);
    alert('Failed to access camera or microphone.');
  }
}


  ngOnDestroy(): void {
    this.leave();
    this.callService.disconnect();
  }
}
