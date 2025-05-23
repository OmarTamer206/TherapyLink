import { CommonModule } from '@angular/common';
import { Component, ElementRef, Input, ViewChild } from '@angular/core';
import { SocketService } from '../services/chat/chat.service';
import { SessionService } from '../services/session/session.service';

@Component({
  selector: 'app-old-chat',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './old-chat.component.html',
  styleUrl: './old-chat.component.css'
})
export class OldChatComponent  {
   @Input() chatId!: string;  // The chatId will be passed to the component to fetch the messages
  @Input() userId!: string;


  @ViewChild('messageContainer') messageContainer!: ElementRef;

  messages: any[] = [];
  typingStatus = '';
  sessionEnded = true;  // Since this is for old chat, the session is considered ended



  constructor(private socketService: SocketService, private sessionService: SessionService) {}

  ngOnInit() {

    this.loadMessages();
  }

  ngOnDestroy() {

  }

  // Fetch previous messages from the server using session service
  loadMessages() {
    this.sessionService.getSessionMessages(this.chatId).subscribe((response) => {
      this.messages = response;

      setTimeout(() => this.scrollToBottom(), 0);
    });
  }

  scrollToBottom(): void {
    try {
      this.messageContainer.nativeElement.scrollTop =
        this.messageContainer.nativeElement.scrollHeight;
    } catch (error) {
      console.error(error);
    }
  }
}
