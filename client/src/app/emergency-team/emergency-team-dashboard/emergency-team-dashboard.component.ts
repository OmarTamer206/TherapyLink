import { Component, OnInit, OnDestroy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { EmergencyTeamSocketService } from '../../services/emergencySocket/emergency-socket.service';
import { Router } from '@angular/router';
import { EmergencyTeamService } from '../../services/emergency/emergency.service';

@Component({
  selector: 'app-emergency-team-dashboard',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './emergency-team-dashboard.component.html',
  styleUrls: ['./emergency-team-dashboard.component.css']
})
export class EmergencyTeamDashboardComponent implements OnInit, OnDestroy {
  requests: any[] = [];
  profileData: any;

  constructor(
    private emergencySocket: EmergencyTeamSocketService,
    private router: Router,
    private emergencyService: EmergencyTeamService
  ) {}

  ngOnInit(): void {

    this.getEmergencyTeamData();

    this.emergencySocket.connect();

    this.emergencySocket.onAllPendingRequests().subscribe((requests) => {
      console.log("All pending requests:", requests);
      this.requests = requests;
    });

    this.emergencySocket.onNewRequest().subscribe((request) => {
      console.log(request);

      this.requests.push(request);
    });

    this.emergencySocket.onRequestRemoved().subscribe((requestId) => {
      this.requests = this.requests.filter(req => req.requestId !== requestId);
    });

    this.emergencySocket.onRequestAccepted().subscribe((sessionData) => {
      console.log("wroking");

      this.router.navigate(['emergency-team/emergency-team-session'], {
        state: {
          callId: sessionData.callId,
          patientId: sessionData.patientId,
          emergencyMember: sessionData.emergencyMember
        }
      });
    });



  }

  async getEmergencyTeamData(){

    this.emergencyService.getEmergencyTeamData().subscribe((response)=>{

      this.profileData = response.data[0]
      console.log(this.profileData);



    })

  }


  acceptRequest(request: any): void {
    const teamMember = {
      id: this.profileData.id, // Replace with real logged-in team member ID
      name: this.profileData.Name // Replace with real name
    };
    this.emergencySocket.acceptEmergencyRequest(request.id, teamMember);
  }

  ngOnDestroy(): void {
    // Optional: disconnect socket on destroy
    this.emergencySocket.disconnect();
  }
}
