import { Component, Input, OnInit, OnDestroy } from '@angular/core';
import { Router } from '@angular/router';
import { CommonModule, NgIf } from '@angular/common';

@Component({
  selector: 'app-countdown',
  standalone: true,
  imports: [CommonModule , NgIf],
  templateUrl: './countdown.component.html',
  styleUrls: ['./countdown.component.css']
})
export class CountdownComponent implements OnInit, OnDestroy {
  @Input() scheduledTime!: string; // ISO string
  @Input() sessionId!: number;
  @Input() state!: string;

  timeLeft: string = '';
  isExpired = false;
  private intervalId: any;

  constructor(private router: Router) {}

  ngOnInit(): void {
    if (this.state === 'No Upcoming Sessions') return;

    this.updateCountdown();
    this.intervalId = setInterval(() => this.updateCountdown(), 1000);
  }

  ngOnDestroy(): void {
    clearInterval(this.intervalId);
  }

  private updateCountdown(): void {
    const now = new Date();
    const target = new Date(this.scheduledTime);
    const diff = target.getTime() - now.getTime();

    if (diff <= 0) {
      this.timeLeft = '';
      this.isExpired = true;
      clearInterval(this.intervalId);
      return;
    }

    const days = Math.floor(diff / (1000 * 60 * 60 * 24));
    const hours = Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
    const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
    const seconds = Math.floor((diff % (1000 * 60)) / 1000);

    this.timeLeft = `${this.pad(days)}d ${this.pad(hours)}h:${this.pad(minutes)}m:${this.pad(seconds)}s`;
  }

  private pad(num: number): string {
    return num < 10 ? '0' + num : num.toString();
  }

  navigateToSession(): void {
    if (this.state !== 'No Upcoming Sessions') {
      this.router.navigate(['doctor/session', this.sessionId]);
    }
  }
}
