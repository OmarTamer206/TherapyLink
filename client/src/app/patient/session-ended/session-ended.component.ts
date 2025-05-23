import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { SessionService } from '../../services/session/session.service';
import { PatientService } from '../../services/patient/patient.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-session-ended',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './session-ended.component.html',
  styleUrls: ['./session-ended.component.css'],
})
export class SessionEndedComponent {
  showFeedback = false;
  showSuccess = false;
  rating = 0;
  stars = Array(5).fill(0);
  feedbackText = '';

  session: any;
  chatId = '';
  userId = '';
  userType = 'patient';
  receiverId = '';
  receiverType: any;

  feedbackButtonText = 'Submit';
  editState = false;

  constructor(
    private sessionService: SessionService,
    private patientService: PatientService,
    private router: Router
  ) {}

  ngOnInit(): void {
    const state = window.history.state;

    if (state && state.session) {
      this.session = state.session;
      this.chatId = this.session.chat_ID;
      this.userId = this.session.patient_ID;
      this.receiverId = this.session.doctor_ID;
      this.receiverType = this.session.session_type;

      this.checkFeedback();
    } else {
      // Redirect if no session info
      this.router.navigate(['/patient/home']);
    }
  }

  checkFeedback(): void {
    this.patientService.checkFeedback(this.session).subscribe(
      (response) => {
        if (response.data.length !== 0) {
          this.rating = response.data[0].rating;
          this.feedbackText = response.data[0].reason;
          this.showFeedback = false; // Hide form if feedback exists
          this.feedbackButtonText = 'Edit Feedback';
          this.editState = true;
        }
      },
      (error) => {
        console.error('Error checking feedback:', error);
      }
    );
  }

  toggleFeedback(): void {
    this.showFeedback = !this.showFeedback;
  }

  setRating(value: number): void {
    this.rating = value;
  }

  submitFeedback(): void {
    if (this.rating === 0) {
      alert('Please select a rating before submitting feedback.');
      return;
    }
    if (this.feedbackText.trim() === '') {
      alert('Please enter your feedback.');
      return;
    }

    this.patientService
      .submitFeedback(this.session, this.rating, this.feedbackText, this.editState)
      .subscribe(
        (response) => {
          this.editState = true;
          this.feedbackButtonText = 'Edit Feedback';
          this.showFeedback = false;

          this.showSuccess = true;


          setTimeout(() => {
            (this.showSuccess = false)
            this.router.navigate(['/patient/home'],{ replaceUrl: true });

          });

        },
        (error) => {
          console.error(error);
        }
      );
  }
}
