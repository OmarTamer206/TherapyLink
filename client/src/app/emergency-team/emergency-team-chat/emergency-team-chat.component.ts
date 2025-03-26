import { Component } from '@angular/core';
import { RouterModule } from '@angular/router';
import { CommonModule } from '@angular/common'; // Import CommonModule

@Component({
  selector: 'app-emergency-team-chat',
  standalone: true,
  imports: [RouterModule, CommonModule], // Include CommonModule
  templateUrl: './emergency-team-chat.component.html',
  styleUrls: ['./emergency-team-chat.component.css']
})
export class EmergencyTeamChatComponent {
  chats = [
    { name: 'Yasser Ahmed', date: '24 Jan, 2023'},
    { name: 'Yasser Ahmed', date: '24 Jan, 2023'},
    { name: 'Yasser Ahmed', date: '24 Jan, 2023'},
    { name: 'Yasser Ahmed', date: '24 Jan, 2023'},
    { name: 'Yasser Ahmed', date: '24 Jan, 2023'},
    { name: 'Yasser Ahmed', date: '24 Jan, 2023'},
  ];
}
