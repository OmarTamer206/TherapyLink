import { Component } from '@angular/core';

@Component({
  selector: 'app-emergency-team-dashboard',
  standalone: true,
  imports: [],
  templateUrl: './emergency-team-dashboard.component.html',
  styleUrls: ['./emergency-team-dashboard.component.css']
})
export class EmergencyTeamDashboardComponent {
  requests = [
    { name: 'Yasser Ahmed', image: 'image.png' },
    { name: 'Mahmoud Moustafa', image: 'image.png' },
    { name: 'Yasser Amgad', image: 'image.png' },
    { name: 'Akram Yousri', image: 'image.png' },
    { name: 'Mahitab Maged', image: 'image.png' },
    { name: 'Nora Samy', image: 'image.png' },
    { name: 'Doaa Abdelma3bod', image: 'image.png' },
    { name: 'Hussien Barada', image: 'image.png' }
  ];
}
