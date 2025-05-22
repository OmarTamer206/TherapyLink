import { SessionService } from './../../services/session/session.service';
import { Component, Input, OnDestroy, OnInit } from '@angular/core';
import { ReportComponent } from './report/report.component';
import { JournalComponent } from './journal/journal.component';
import { NgFor, NgIf } from '@angular/common';
import { ActivatedRoute } from '@angular/router';
import { TherapistService } from '../../services/therapist/therapist.service';
import { ChatSectionComponent } from '../../chat-section/chat-section.component';

@Component({
  standalone: true,
  imports: [ReportComponent, JournalComponent, NgIf , ChatSectionComponent],
  selector: 'app-session',
  templateUrl: './session.component.html',
  styleUrls: ['./session.component.css'],
})
export class SessionComponent implements OnInit ,OnDestroy {
  sessionID : any;
  showReport = false;
  showJournal = false;
  sessionData: any;
  patientData: any;

  loading = false;
  check1=false;
  check2=false;

  countInit = false;

  scheduledTime: string =""; // ISO string
  timeLeft: string = '';
  isExpired = false;
  private intervalId: any;

  startButtonState = false;


  chatId: string ="";
  userId: string ="";
  userType = 'doctor';
  receiverId: string="";
  receiverType = 'patient';
  sessionStarted= false;


  constructor(private route:ActivatedRoute, private therapistService:TherapistService , private sessionService:SessionService) {

  }

  ngOnInit(): void {
    this.route.paramMap.subscribe(params => {
      const id = params.get('id');
      if (id) {
        this.sessionID = +id; // convert string to number
        console.log('Session ID:', this.sessionID);
      }
    });

    this.getDoctorData();

    this.gatherSessionData();

    this.updateCountdown();
    this.intervalId = setInterval(() => this.updateCountdown(), 1000);


  }

// Hatet8yr fl lifecoach

getDoctorData(){
  this.therapistService.getTherapistData().subscribe((response) => {
    console.log(response);
    this.userId = response.data[0].id;
    console.log(this.userId);
  },(error)=>{
    console.log("error",error);
  });
}

  gatherSessionData(){
    this.sessionService.viewSessionDetails(this.sessionID).subscribe((response) => {
      console.log(response);
      this.sessionData = response.data;
        this.therapistService.getPatientData(response.data.patient_ID).subscribe((response) => {
          this.patientData = response.data;
          this.receiverId = this.patientData.patient[0].id;
          console.log(this.receiverId);

          console.log(response);

          this.scheduledTime = this.sessionData.scheduled_time;
          this.chatId = this.sessionData.chat_ID;

          const date = new Date(this.sessionData.scheduled_time)
          this.sessionData.date = `${date.getDate()}/${date.getMonth()+1}/${date.getFullYear()}`
          const hours24 = date.getHours();
          const minutes = date.getMinutes();

          const hours12 = hours24 % 12 || 12; // Converts 0 to 12 for midnight
          const ampm = hours24 >= 12 ? 'PM' : 'AM';
          const paddedMinutes = minutes.toString().padStart(2, '0');

          this.sessionData.time = `${hours12}:${paddedMinutes} ${ampm}`;

          this.patientData.journals.map((journal:any)=>{
            const date = new Date(journal.time)
            journal.date = `${date.getDate()}/${date.getMonth()+1}/${date.getFullYear()}`
            const hours24 = date.getHours();
            const minutes = date.getMinutes();

            const hours12 = hours24 % 12 || 12; // Converts 0 to 12 for midnight
            const ampm = hours24 >= 12 ? 'PM' : 'AM';
            const paddedMinutes = minutes.toString().padStart(2, '0');

            journal.time = `${hours12}:${paddedMinutes} ${ampm}`;
          })
          this.check1=true;
          this.checkLoading()
        });




    },(error)=>{
      console.log("error",error);
    });

  }

  // Toggle visibility for the Report
  toggleReport() {
    this.showReport = !this.showReport;
    if (this.showReport) {
      this.showJournal = false; // Close Journal if Report is shown
    }
  }

  // Toggle visibility for the Journal
  toggleJournal() {
    this.showJournal = !this.showJournal;
    console.log(this.showJournal);

    if (this.showJournal) {
      this.showReport = false; // Close Report if Journal is shown
    }
  }



  ngOnDestroy(): void {
    clearInterval(this.intervalId);
  }

  private updateCountdown(): void {
    if(this.scheduledTime=="")
      return;

    const now = new Date();
    const target = new Date(this.scheduledTime);
    const diff = target.getTime() - now.getTime();

    if (diff <= 0) {
      this.timeLeft = '';
      this.isExpired = true;
      this.startButtonState = false;
      clearInterval(this.intervalId);
      return;
    }

    // Set startButtonState to true if less than 5 minutes left (5 * 60 * 1000 ms)
    this.startButtonState = diff <= 5 * 60 * 1000;

    const days = Math.floor(diff / (1000 * 60 * 60 * 24));
    const hours = Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
    const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
    const seconds = Math.floor((diff % (1000 * 60)) / 1000);

    this.timeLeft = `${this.pad(days)}d ${this.pad(hours)}h:${this.pad(minutes)}m:${this.pad(seconds)}s`;

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
    this.sessionStarted =true
  }

  checkLoading(){


    if(this.check1 && this.check2){
      this.loading = true;
    }
  }

}
