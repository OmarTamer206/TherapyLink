import { Component } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-sessions-log',
  standalone: true,
  imports: [],
  templateUrl: './sessions-log.component.html',
  styleUrl: './sessions-log.component.css',
})
export class SessionsLogComponent {
  constructor(private router: Router) {}
  goToSessionPage() {
    this.router.navigate(['patient/session-page']);
  }
  goToOldSessionPage() {
    this.router.navigate(['patient/old-session']);
  }
}
