import { Injectable } from '@angular/core';
import { io, Socket } from 'socket.io-client';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class SocketService {
  private socket!: Socket;

  connect(): void {
    if (!this.socket || !this.socket.connected) {
      this.socket = io('http://localhost:3000'); // Adjust URL as needed
      console.log('Socket connected:', this.socket.id);
    }
  }

  disconnect(): void {
    if (this.socket) {
      this.socket.disconnect();
      console.log('Socket disconnected');
    }
  }

  // Enter chat with userId and userType
  enterChat(chatId: string, userId: string, userType: string): void {
    this.socket.emit('enterChat', { chatId, userId, userType });
  }

  exitChat(chatId: string, userId: string): void {
    this.socket.emit('exitChat', { chatId, userId });
  }

  // Send message with senderId, senderType, and receiver details
  sendMessage(
    chatId: string,
    senderId: string,
    senderType: string,
    receiverId: string,
    receiverType: string,
    message: string
  ): void {
    this.socket.emit('sendMessage', {
      chatId,
      senderId,
      senderType,
      receiverId,
      receiverType,
      message,
    });
  }

  typing(chatId: string, userId: string): void {
    this.socket.emit('typing', { chatId, userId });
  }

  stopTyping(chatId: string, userId: string): void {
    this.socket.emit('stopTyping', { chatId, userId });
  }

  patientReady(chatId: string): void {
    this.socket.emit('patientReady', { chatId });
  }

  doctorReady(chatId: string, sessionDurationMinutes: number): void {
    this.socket.emit('doctorReady', { chatId, sessionDurationMinutes });
  }

  // Observable to get messages
  onMessage(): Observable<any> {
    return new Observable((observer) => {
      const handler = (data: any) => observer.next(data);
      this.socket.on('receiveMessage', handler);
      return () => this.socket.off('receiveMessage', handler);
    });
  }

  // Get previous messages for the chat
  onPreviousMessages(): Observable<any[]> {
    return new Observable((observer) => {
      const handler = (messages: any[]) => observer.next(messages);
      this.socket.on('previousMessages', handler);
      return () => this.socket.off('previousMessages', handler);
    });
  }

  // Get system messages (like errors or session updates)
  onSystemMessage(): Observable<any> {
    return new Observable((observer) => {
      const handler = (msg: any) => observer.next(msg);
      this.socket.on('systemMessage', handler);
      return () => this.socket.off('systemMessage', handler);
    });
  }

  // Typing status for participants
onTyping(): Observable<{ userId: string; userName: string; typing: boolean }> {
  return new Observable((observer) => {
    const handler = (data: { userId: string; userName: string; typing: boolean }) => observer.next(data);
    this.socket.on('participantTyping', handler);
    return () => this.socket.off('participantTyping', handler);
  });
}

  // Session start event
  onSessionStart(): Observable<void> {
    return new Observable((observer) => {
      const handler = () => observer.next();
      this.socket.on('sessionStart', handler);
      return () => this.socket.off('sessionStart', handler);
    });
  }

  // Session ended event
  onSessionEnded(): Observable<void> {
    return new Observable((observer) => {
      const handler = () => observer.next();
      this.socket.on('sessionEnded', handler);
      return () => this.socket.off('sessionEnded', handler);
    });
  }

  // Error handling event
  onErrorChat(): Observable<string> {
    return new Observable((observer) => {
      const handler = (msg: string) => observer.next(msg);
      this.socket.on('errorChat', handler);
      return () => this.socket.off('errorChat', handler);
    });
  }

  // Emit doctor end session
  doctorEndSession(chatId: string, userId: string): void {
    this.socket.emit('doctorEndSession', { chatId, userId });
  }
}
