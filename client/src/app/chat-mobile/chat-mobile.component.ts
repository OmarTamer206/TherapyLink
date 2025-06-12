import { Component, Input, OnInit, OnDestroy, ViewChild, ElementRef } from '@angular/core';
import { SocketService } from '../services/chat/chat.service';
import { Subscription } from 'rxjs';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
@Component({
  selector: 'app-chat-mobile',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './chat-mobile.component.html',
  styleUrl: './chat-mobile.component.css'
})
export class ChatMobileComponent implements OnInit, OnDestroy {
   chatId!: any
   userId!:any
   userType!:any
   receiverId!:any
   receiverType!:any

  @ViewChild('messageContainer') messageContainer!: ElementRef;

  message = '';
  messages: any[] = [];
  typingStatus = '';
  sessionStarted = false;
  sessionEnded = false;
  isSendDisabled = true;  // Disable send button initially

  private subscriptions: Subscription[] = [];

  constructor(private socketService: SocketService , private route: ActivatedRoute , private router: Router) {}

  async getDataFromUrl(){
    this.route.paramMap.subscribe((params) => {
      this.chatId = +params.get('chatId')!;
      this.userId = +params.get('userId')!;
      this.userType = params.get('userType');
      this.receiverId = +params.get('receiverId')!;
      this.receiverType = params.get('receiverType');
      console.log('Chat ID:', this.chatId);

      console.log('User ID:', this.userId);
      console.log('User Type:', this.userType);
      console.log('Receiver ID:', this.receiverId);
      console.log('Receiver Type:', this.receiverType);

      if (!this.chatId || !this.userId || !this.userType || !this.receiverId || !this.receiverType) {
       this.router.navigate(["/not-found"]);
      }
    });
  }

  async ngOnInit() {

    //get the chatId, userId, and userType from the url params
    await this.getDataFromUrl();


    this.socketService.connect();
    this.socketService.enterChat(this.chatId!, this.userId!, this.userType!);


    this.subscriptions.push(
      this.socketService.onSessionStart().subscribe(() => {
        this.sessionStarted = true;
        window.parent.postMessage({ type: 'sessionStarted' }, '*');

        console.log('Session started by doctor or patient');
      })
    );

    this.subscriptions.push(
      this.socketService.onSessionEnded().subscribe(() => {
        this.sessionStarted = false;
        window.parent.postMessage({ type: 'sessionEnded' }, '*');

        console.log("sdasdasd");

        console.log('Session ended');
        // this.router.navigate(['/patient/session-ended'],{ state: { session:this.session } ,replaceUrl: true });
        window.location.href = '/patient/session-ended';

      })
    );

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
        window.parent.postMessage({ type: 'sessionStarted' }, '*');

        console.log('Session started!');
      })
    );

    this.subscriptions.push(
      this.socketService.onSessionEnded().subscribe(() => {
        this.sessionEnded = true;
        this.sessionStarted = false;
        window.parent.postMessage({ type: 'sessionEnded' }, '*');

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
      this.chatId!,
      this.userId!,
      this.userType!,
      this.receiverId!,
      this.receiverType!,
      this.message
    );
    this.message = '';
    this.isSendDisabled = true; // Disable send button after sending the message
    this.stopTyping();
  }

  onTyping() {
    this.socketService.typing(this.chatId!, this.userId!);
  }

  stopTyping() {
    this.socketService.stopTyping(this.chatId!, this.userId!);
  }

  ngOnDestroy() {
    this.socketService.exitChat(this.chatId!, this.userId!);
    this.subscriptions.forEach((s) => s.unsubscribe());
    this.socketService.disconnect();
  }
}
