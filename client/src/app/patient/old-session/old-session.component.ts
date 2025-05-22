import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { SessionService } from '../../services/session/session.service';
import { Router } from '@angular/router';
import { PatientService } from '../../services/patient/patient.service';

@Component({
  selector: 'app-old-session',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './old-session.component.html',
  styleUrls: ['./old-session.component.css']
})
export class OldSessionComponent {
  showFeedback = false;
  showSuccess = false; // ✅ Added success flag
  rating = 0;
  stars = Array(5).fill(0);
  feedbackText = '';

  session:any
  chatId: string ="";
  userId: string ="";
  userType = 'patient';
  receiverId: string="";
  receiverType:any;

  feedbackButtonText = "Submit"
  editState = false;



  constructor(private sessionService: SessionService ,private patientService: PatientService , private router: Router) {


}

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
      this.checkFeedback();

    }


  }

  checkFeedback(): void {




    this.patientService.checkFeedback(this.session).subscribe((response) => {
      console.log(response);
      if (response.data.length !== 0) {
        this.rating = response.data[0].rating;
        this.feedbackText = response.data[0].reason;
        this.showFeedback = false; // Hide feedback form if feedback already exists
        this.feedbackButtonText = "Edit Feedback"
        this.editState = true;
        console.log('Feedback already submitted:', this.rating, this.feedbackText);

      }
    }, (error) => {
      console.error('Error checking feedback:', error);
    });
  }

  toggleFeedback(): void {
    this.showFeedback = !this.showFeedback;
  }

  setRating(value: number): void {
    this.rating = value;
  }

  submitFeedback(): void {

    this.showFeedback = false;


    if (this.rating === 0) {

      alert('Please select a rating before submitting feedback.');
      return;
    }
    if (this.feedbackText.trim() === '') {
      alert('Please enter your feedback.');
      return;
    }


    console.log('Rating:', this.rating);
    console.log('Feedback:', this.feedbackText);



    this.patientService.submitFeedback(this.session,this.rating, this.feedbackText,this.editState).subscribe((response)=>{

      console.log(response);

      this.editState = true
      this.feedbackButtonText = "Edit Feedback"

    }
    ,(error)=>{
      console.log(error);
    }
    );


      // Show success popup
  this.showSuccess = true;

  // Hide popup after 3 seconds
  setTimeout(() => {
    this.showSuccess = false;
  }, 3000);
  }
}
