import {
  Component,
  Input,
  OnInit,
  OnDestroy,
  ViewChild,
  ElementRef,
  AfterViewChecked,
} from '@angular/core';
import { SocketService } from '../services/chat/chat.service';
import { Subscription } from 'rxjs';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-chat-section',
  templateUrl: './chat-section.component.html',
  styleUrls: ['./chat-section.component.css'],
  standalone: true,
  imports: [CommonModule, FormsModule],
})
export class ChatSectionComponent implements OnInit, OnDestroy, AfterViewChecked {
  @Input() chatId!: string;
  @Input() userId!: string;
  @Input() userType!: string;
  @Input() receiverId!: string;
  @Input() receiverType!: string;

  @ViewChild('messageContainer') messageContainer!: ElementRef;

  message = '';
  messages: any[] = [];
  typingStatus = '';
  sessionStarted = false;
  sessionEnded = false;
  isSendDisabled = true;

  private subscriptions: Subscription[] = [];

  constructor(private socketService: SocketService) {}

  ngOnInit() {
    this.socketService.connect();
    this.socketService.enterChat(this.chatId, this.userId, this.userType);

    this.subscriptions.push(
      this.socketService.onPreviousMessages().subscribe((prevMessages) => {
        this.messages = [...prevMessages];
        this.scrollToBottom();
      })
    );

    this.subscriptions.push(
      this.socketService.onSystemMessage().subscribe((msg) => {
        this.messages.push(msg);
        this.scrollToBottom();
      })
    );

    this.subscriptions.push(
      this.socketService.onMessage().subscribe((msg) => {
        this.messages.push(msg);
        this.scrollToBottom();
      })
    );

    this.subscriptions.push(
      this.socketService.onTyping().subscribe(({ userId, typing }) => {
        this.typingStatus = typing ? `User ${userId} is typing...` : '';
      })
    );

    this.subscriptions.push(
      this.socketService.onSessionStart().subscribe(() => {
        this.sessionStarted = true;
        this.sessionEnded = false;
        console.log('Session started!');
      })
    );

    this.subscriptions.push(
      this.socketService.onSessionEnded().subscribe(() => {
        this.sessionEnded = true;
        this.sessionStarted = false;
        console.log('Session ended!');
      })
    );

    this.subscriptions.push(
      this.socketService.onErrorChat().subscribe((errorMsg) => {
        alert(`Chat error: ${errorMsg}`);
      })
    );
  }

  ngAfterViewChecked() {
    this.scrollToBottom();
  }

  scrollToBottom(): void {
    try {
      this.messageContainer.nativeElement.scrollTop =
        this.messageContainer.nativeElement.scrollHeight;
    } catch {}
  }

  onInputChange() {
    this.isSendDisabled = !this.message.trim();
  }

  sendMessage() {
    if (!this.message.trim() || this.sessionEnded) return;

    this.socketService.sendMessage(
      this.chatId,
      this.userId,
      this.userType,
      this.receiverId,
      this.receiverType,
      this.message
    );
    this.message = '';
    this.isSendDisabled = true;
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
    this.subscriptions.forEach((s) => s.unsubscribe());
    this.socketService.disconnect();
  }
}
