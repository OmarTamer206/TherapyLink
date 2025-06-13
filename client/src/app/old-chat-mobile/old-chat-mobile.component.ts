import { CommonModule } from '@angular/common';
import { Component, ElementRef, Input, ViewChild } from '@angular/core';
import { SocketService } from '../services/chat/chat.service';
import { SessionService } from '../services/session/session.service';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-old-chat-mobile',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './old-chat-mobile.component.html',
  styleUrl: './old-chat-mobile.component.css'
})
export class OldChatMobileComponent {
chatId!: any;  // The chatId will be passed to the component to fetch the messages
userId!: any;


  @ViewChild('messageContainer') messageContainer!: ElementRef;

  messages: any[] = [];
  typingStatus = '';
  sessionEnded = true;  // Since this is for old chat, the session is considered ended



  constructor(private socketService: SocketService, private sessionService: SessionService, private route: ActivatedRoute , private router: Router) {}

    async getDataFromUrl(){
    this.route.paramMap.subscribe((params) => {
      this.chatId = +params.get('chatId')!;
      this.userId = +params.get('userId')!;

      console.log('Chat ID:', this.chatId);

      console.log('User ID:', this.userId);


      if (!this.chatId || !this.userId ) {
       this.router.navigate(["/not-found"]);
      }
    });
  }

  async ngOnInit() {
    await this.getDataFromUrl();

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

