import { Component, Input, OnInit } from '@angular/core';
import { SocketService } from '../services/chat/chat.service';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-chat-section',
  standalone: true,
  imports: [CommonModule,FormsModule],
  templateUrl: './chat-section.component.html',
  styleUrls: ['./chat-section.component.css'],
})
export class ChatSectionComponent implements OnInit {
  @Input() chatId!: string;
  @Input() userId!: string;
  @Input() userType!: string;
  @Input() receiverId!: string;
  @Input() receiverType!: string;

  message = '';
  messages: any[] = [];
  typingStatus = '';

  constructor(private socketService: SocketService) {}

  ngOnInit() {
    this.socketService.joinChat(this.chatId, this.userId, this.userType);

    this.socketService.onMessage((msg) => {
      this.messages.push(msg);
    });

    this.socketService.onTyping(({ userId, typing }) => {
      this.typingStatus = typing ? `User ${userId} is typing...` : '';
    });
  }

  sendMessage() {
    if (!this.message.trim()) return;

    this.socketService.sendMessage({
      chatId: this.chatId,
      senderId: this.userId,
      senderType: this.userType,
      receiverId: this.receiverId,
      receiverType: this.receiverType,
      message: this.message
    });

    this.message = '';
    this.stopTyping();
  }

  onTyping() {
    this.socketService.typing(this.chatId, this.userId);
  }

  stopTyping() {
    this.socketService.stopTyping(this.chatId, this.userId);
  }

  ngOnDestroy() {
    this.socketService.exitChat(this.chatId, this.userId);
    this.socketService.off('receiveMessage');
    this.socketService.off('participantTyping');
  }
}
