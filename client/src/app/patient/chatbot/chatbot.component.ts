import { Component, ElementRef, OnInit, ViewChild } from '@angular/core';
import { AgentService } from '../../services/agent/agent.service';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { PieChartComponent } from '../../manager/pie-chart/pie-chart.component';
import { Router } from '@angular/router';
import { PatientService } from '../../services/patient/patient.service';

@Component({
  selector: 'app-chatbot',
  standalone: true,
  imports: [CommonModule, FormsModule , PieChartComponent],
  templateUrl: './chatbot.component.html',
  styleUrls: ['./chatbot.component.css'],
})
export class ChatbotComponent implements OnInit {
  chatButtonState = false;
  sessionId = Math.random().toString(36).substring(2);
  messages: { from: 'bot' | 'user'; text: string }[] = [];
  userInput = '';
  loading = false;
  showResults = false
pieChartData: any[]=[];
pieChartLabels: any[]=[];
probablePreference: any;

  constructor(private agentService: AgentService ,private patientService: PatientService , private router:Router) {}




  ngOnInit() {

  }

  changeChatState() {
    this.chatButtonState = true;
    this.startChat();
  }

  startChat() {
    this.agentService.startSession(this.sessionId).subscribe(() => {
      this.askQuestion();

    });
  }

  askQuestion() {
    this.loading = true;
    this.agentService.getQuestion(this.sessionId).subscribe(
      (res) => {


        this.loading = false;
        if (res.done) {
          this.messages.push({ from: 'bot', text: 'End of questions.' });
          this.agentService.getSummary(this.sessionId).subscribe((summary) => {

            this.pieChartLabels = Object.keys(summary.final_scores)
            this.pieChartData = Object.values(summary.final_scores)
              if(summary.most_probable_status =="Normal")
            this.probablePreference = "General Psychological Support"
              if(summary.most_probable_status =="Mood and Anxiety Disorders")
            this.probablePreference = "Mood and Anxiety Disorder Specialist"
              if(summary.most_probable_status =="Depression and Suicidal")
            this.probablePreference = "Clinical Depression and Crisis Prevention Specialist"


            this.patientService.changeTherapistPreference(this.probablePreference).subscribe((response)=>{

            console.log(response);

            },(error)=>{
              console.log(error);

            })


            this.showResults=true;

          });
          return;
        }
        this.messages.push({ from: 'bot', text: res.question });
      },
      (error) => {
        this.loading = false;
        this.messages.push({
          from: 'bot',
          text: 'Error retrieving question. Please try again.',
        });
      }
    );
  }

  sendMessage() {
    const text = this.userInput.trim();
    if (!text) return;

    this.messages.push({ from: 'user', text });
    this.userInput = '';
    this.loading = true;

    this.agentService.sendResponse(this.sessionId, text).subscribe(
      () => {
        this.loading = false;
        this.askQuestion();
      },
      (error) => {
        this.loading = false;
        this.messages.push({
          from: 'bot',
          text: 'Error sending message. Please try again.',
        });
      }
    );
  }

  goToHome(): void {
    this.router.navigate(['patient/home']);
  }
}
