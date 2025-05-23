import { Component, Input, OnInit, OnDestroy, ViewChild, ElementRef } from '@angular/core';
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
export class ChatSectionComponent implements OnInit, OnDestroy {
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
  isSendDisabled = true;  // Disable send button initially

  private subscriptions: Subscription[] = [];

  constructor(private socketService: SocketService) {}

  ngOnInit() {
    this.socketService.connect();
    this.socketService.enterChat(this.chatId, this.userId, this.userType);

    this.subscriptions.push(
      this.socketService.onPreviousMessages().subscribe((prevMessages) => {
        this.messages = [...prevMessages];
        setTimeout(() => this.scrollToBottom(), 0);
      })
    );

    this.subscriptions.push(
      this.socketService.onSystemMessage().subscribe((msg) => {
        this.messages.push(msg);
        setTimeout(() => this.scrollToBottom(), 0);
      })
    );

    this.subscriptions.push(
      this.socketService.onMessage().subscribe((msg) => {
        this.messages.push(msg);
        setTimeout(() => this.scrollToBottom(), 0);
      })
    );

    this.subscriptions.push(
  this.socketService.onTyping().subscribe(({ userId, userName, typing }) => {
    this.typingStatus = typing ? `${userName} is typing...` : ''; // Use userName here
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

  scrollToBottom(): void {
    try {
      this.messageContainer.nativeElement.scrollTop =
        this.messageContainer.nativeElement.scrollHeight;
    } catch (error) {
      console.error(error);
    }
  }

  // Update the button state based on the input message content
  onInputChange() {
    this.isSendDisabled = !this.message.trim();  // Disable button if message is empty
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
    this.isSendDisabled = true; // Disable send button after sending the message
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
