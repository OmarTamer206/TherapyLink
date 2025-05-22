import { Component, OnInit } from '@angular/core';
import { SessionService } from '../../services/session/session.service';
import { Router } from '@angular/router';
import { ChatSectionComponent } from '../../chat-section/chat-section.component';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-session-page',
  standalone: true,
  imports: [ChatSectionComponent,CommonModule],
  templateUrl: './session-page.component.html',
  styleUrl: './session-page.component.css'
})
export class SessionPageComponent implements OnInit{
  session: any;
  loading= false;
  check1= false;
  timeLeft: any;
  isExpired = false;
  startButtonState= false;
  intervalId:any;
  countInit: any;
  check2=false;

  sessionStarted = false;

  chatId: string ="";
  userId: string ="";
  userType = 'patient';
  receiverId: string="";
  receiverType:any;

    ngOnInit(): void {
    // Access the state data from window.history
    const state = window.history.state;

    if (state) {
      this.session = state.session;

      if(!this.session){
        this.router.navigate(['/patient/home']);
      }

      this.chatId =this.session.chat_ID;
      this.userId =this.session.patient_ID;
      this.receiverId=this.session.doctor_ID;
      this.receiverType=this.session.session_type;


      console.log('Session : ', this.session);
      console.log('Chat ID : ', this.chatId);
      console.log('User ID : ', this.userId);
      console.log('Reciver ID : ', this.receiverId);
      console.log('Reciver Type : ', this.receiverType);
    }

    this.updateCountdown();
    this.intervalId = setInterval(() => this.updateCountdown(), 1000);


  }

constructor(private sessionService: SessionService , private router: Router) {



}


  private updateCountdown(): void {
    if(this.session.scheduled_time=="")
      return;

    const now = new Date();
    const target = new Date(this.session.scheduled_time);
    const diff = target.getTime() - now.getTime();

    if (diff <= 0) {
      this.timeLeft = '';
      this.isExpired = true;
      clearInterval(this.intervalId);
      return;
    }

    // Set startButtonState to true if less than 5 minutes left (5 * 60 * 1000 ms)
    this.startButtonState = diff <= 5 * 60 * 1000;

    const days = Math.floor(diff / (1000 * 60 * 60 * 24));
    const hours = Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
    const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
    const seconds = Math.floor((diff % (1000 * 60)) / 1000);

    this.timeLeft = `${this.pad(days)} days : ${this.pad(hours)} Hours : ${this.pad(minutes)} Minutes : ${this.pad(seconds)} Seconds`;

    if(!this.countInit){
      this.countInit = true
      this.check2 = true;
      this.checkLoading();
    }
  }


  private pad(num: number): string {
    return num < 10 ? '0' + num : num.toString();
  }



  startSession(){
    this.sessionStarted=true
  }


  checkLoading(){


    if(this.check1 && this.check2 ){
      this.loading = true;
    }
  }

}
