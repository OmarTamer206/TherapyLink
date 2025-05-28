import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { io, Socket } from 'socket.io-client';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class EmergencyTeamSocketService {
 private socket!: Socket;

  connect(): void {
    if (!this.socket || !this.socket.connected) {
      this.socket = io('http://localhost:3000');
    }
  }

  sendEmergencyRequest(patientData: any): void {
    this.socket.emit('requestEmergency', patientData);
  }

  cancelEmergencyRequest(requestId: string): void {
    this.socket.emit('cancelEmergencyRequest', requestId);
  }

  acceptEmergencyRequest(requestId: any, teamMember: any): void {
    this.socket.emit('acceptEmergencyRequest', { requestId, teamMember });
  }

  onNewRequest(): Observable<any> {
    return new Observable((observer) => {
      this.socket.on('newEmergencyRequest', (data) => observer.next(data));
    });
  }

  onRequestRemoved(): Observable<string> {
    return new Observable((observer) => {
      this.socket.on('removeEmergencyRequest', (id) => observer.next(id));
    });
  }

  onRequestAccepted(): Observable<any> {
    return new Observable((observer) => {
      this.socket.on('emergencyAccepted', (data) => observer.next(data));
    });
  }

}
