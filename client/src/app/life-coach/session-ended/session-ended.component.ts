import { Component } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-session-ended',
  standalone: true,
  imports: [],
  templateUrl: './session-ended.component.html',
  styleUrl: './session-ended.component.css'
})
export class LifeCoachSessionEndedComponent {

  countdown = 5


  constructor(private router:Router) {
    this.startCountdown()
  }


    startCountdown(){
    const interval = setInterval(() => {
      this.countdown--;
      if (this.countdown <= 0) {
        clearInterval(interval);
        this.router.navigate(['/life-coach/dashboard']);
      }
    }, 1000)


  }
}
