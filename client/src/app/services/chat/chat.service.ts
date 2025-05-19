import { Injectable } from '@angular/core';
import { io, Socket } from 'socket.io-client';


@Injectable({
  providedIn: 'root'
})
export class SocketService {
  private socket: Socket;

  constructor() {
    this.socket = io('http://localhost:3000'); // backend URL
  }

  // Join Chat
  joinChat(chatId: string, userId: string, userType: string) {
    this.socket.emit('enterChat', { chatId, userId, userType });
  }

  // Send Message
  sendMessage(data: {
    chatId: string;
    senderId: string;
    senderType: string;
    receiverId: string;
    receiverType: string;
    message: string;
  }) {
    this.socket.emit('sendMessage', data);
  }

  // Typing Indicators
  typing(chatId: string, userId: string) {
    this.socket.emit('typing', { chatId, userId });
  }

  stopTyping(chatId: string, userId: string) {
    this.socket.emit('stopTyping', { chatId, userId });
  }

  // Exit
  exitChat(chatId: string, userId: string) {
    this.socket.emit('exitChat', { chatId, userId });
  }

  // Listeners
  onMessage(callback: (data: any) => void) {
    this.socket.on('receiveMessage', callback);
  }

  onTyping(callback: (data: { userId: string; typing: boolean }) => void) {
    this.socket.on('participantTyping', callback);
  }

  off(eventName: string) {
    this.socket.off(eventName);
  }
}
