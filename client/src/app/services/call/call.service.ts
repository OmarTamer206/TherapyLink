// src/app/services/call.service.ts

import { Injectable } from '@angular/core';
import { io, Socket } from 'socket.io-client';
import { Observable } from 'rxjs';

@Injectable({ providedIn: 'root' })
export class CallService {
  private socket!: Socket;

  connect(): void {
    if (!this.socket || !this.socket.connected) {
      this.socket = io('http://localhost:3000');
    }
  }

  disconnect(): void {
    if (this.socket) {
      this.socket.disconnect();
    }
  }

  joinCall(call_ID: string, userId: string, userType: string, userName: string): void {
    this.socket.emit('joinCall', { call_ID, userId, userType, userName });
  }

  leaveCall(call_ID: string, userId: string): void {
    this.socket.emit('leaveCall', { call_ID, userId });
  }

  endCall(call_ID: string, userId: string): void {
    this.socket.emit('endCall', { call_ID, userId });
  }

  emitSessionStarted(call_ID: string,durationMinutes: any): void {
    this.socket.emit('startSession', { call_ID });
  }

  toggleMute(call_ID: string, userId: string, muted: boolean): void {
    this.socket.emit('toggleMute', { call_ID, userId, muted });
  }

  toggleVideo(call_ID: string, userId: string, videoOn: boolean): void {
    this.socket.emit('toggleVideo', { call_ID, userId, videoOn });
  }

  onParticipantsUpdate(): Observable<any> {
    return new Observable(observer => {
      this.socket.on('participantsUpdate', data => observer.next(data));
    });
  }

  onCallEnded(): Observable<void> {
    return new Observable(observer => {
      this.socket.on('callEnded', () => observer.next());
    });
  }

  onSessionStarted(): Observable<void> {
    return new Observable(observer => {
      this.socket.on('sessionStarted', () => observer.next());
    });
  }

  checkCallStatus(callId: string, userId: string): Promise<boolean> {
  return new Promise(resolve => {
    this.socket.emit('checkCallStatus', { call_ID: callId, userId }, (response: { rejoinAllowed: boolean }) => {
      resolve(response.rejoinAllowed);
    });
  });
}

  sendWebRTCOffer(call_ID: string, offer: RTCSessionDescriptionInit, senderId: string): void {
    this.socket.emit('webrtc-offer', { call_ID, offer, senderId });
  }

  sendWebRTCAnswer(call_ID: string, answer: RTCSessionDescriptionInit, senderId: string): void {
    this.socket.emit('webrtc-answer', { call_ID, answer, senderId });
  }

  sendIceCandidate(call_ID: string, candidate: RTCIceCandidateInit, senderId: string): void {
    this.socket.emit('webrtc-ice-candidate', { call_ID, candidate, senderId });
  }

  onWebRTCOffer(): Observable<{ offer: RTCSessionDescriptionInit; senderId: string }> {
    return new Observable(observer => {
      this.socket.on('webrtc-offer', data => observer.next(data));
    });
  }

  onWebRTCAnswer(): Observable<{ answer: RTCSessionDescriptionInit; senderId: string }> {
    return new Observable(observer => {
      this.socket.on('webrtc-answer', data => observer.next(data));
    });
  }

  onIceCandidate(): Observable<{ candidate: RTCIceCandidateInit; senderId: string }> {
    return new Observable(observer => {
      this.socket.on('webrtc-ice-candidate', data => observer.next(data));
    });
  }

  onRejoinRequest(): Observable<{ call_ID: string; targetId: string }> {
  return new Observable(observer => {
    const handler = (data: any) => observer.next(data);
    this.socket.on('rejoinRequest', handler);
    return () => this.socket.off('rejoinRequest', handler);
  });
}

}
