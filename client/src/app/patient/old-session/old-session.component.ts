import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-old-session',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './old-session.component.html',
  styleUrls: ['./old-session.component.css']
})
export class OldSessionComponent {
  showFeedback = false;
  rating = 0;
  stars = Array(5).fill(0);
  feedbackText = '';

  toggleFeedback(): void {
    this.showFeedback = !this.showFeedback;
  }

  setRating(value: number): void {
    this.rating = value;
  }

  submitFeedback(): void {
    console.log('Rating:', this.rating);
    console.log('Feedback:', this.feedbackText);
    this.toggleFeedback();
  }
}
