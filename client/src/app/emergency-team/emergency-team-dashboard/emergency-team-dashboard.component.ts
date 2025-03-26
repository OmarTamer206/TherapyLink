import { Component } from '@angular/core';
import { CommonModule } from '@angular/common'; // Import CommonModule

@Component({
  selector: 'app-emergency-team-dashboard',
  standalone: true,
  imports: [CommonModule], // Add CommonModule here
  templateUrl: './emergency-team-dashboard.component.html',
  styleUrls: ['./emergency-team-dashboard.component.css']
})
export class EmergencyTeamDashboardComponent {
  requests = [
    { name: 'Yasser Ahmed', image: 'assets/images/image.png' },
    { name: 'Mahmoud Moustafa', image: 'assets/images/image.png' },
    { name: 'Yasser Amgad', image: 'assets/images/image.png' },
    { name: 'Akram Yousri', image: 'assets/images/image.png' },
    { name: 'Mahitab Maged', image: 'assets/images/image.png' },
    { name: 'Nora Samy', image: 'assets/images/image.png' },
    { name: 'Doaa Abdelma3bod', image: 'assets/images/image.png' },
    { name: 'Hussien Barada', image: 'assets/images/image.png' }
  ];
}
