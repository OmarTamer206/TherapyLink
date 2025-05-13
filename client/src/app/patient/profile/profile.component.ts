import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { AuthService } from '../../services/auth/auth.service';
import { PatientService } from '../../services/patient/patient.service';

@Component({
  selector: 'app-profile',
  standalone: true,
  imports: [],
  templateUrl: './profile.component.html',
  styleUrl: './profile.component.css',
})
export class PatientProfileComponent {

  user:any
  name:any;
  joinedAt:any
  wallet:any
  therapySessions:any
  groupSessions:any
  emergencySessions:any
  profilePic:any;
  constructor(private router: Router,private authService: AuthService , private patientService:PatientService) {
    this.getProfileData();
  }



getProfileData(){

    // Call the service to get the profile data
    this.patientService.getProfileData().subscribe(
      (response) => {
        console.log(response);

        this.user = response.data.patient[0];
        // Handle the response and populate the form fields
        this.name = this.user.Name;
        this.wallet = this.user.wallet;

        if(this.user.Profile_pic_url !== null) {
          this.profilePic = `http://localhost:3000/uploads/${this.user.Profile_pic_url}`;
        }
        else{
          this.profilePic = "profileDefault.png";

        }

          const date = new Date(this.user.Created_at)
          this.joinedAt = `${date.getDate()}/${date.getMonth()+1}/${date.getFullYear()}`




      },
      (error) => {
        console.error('Error fetching profile data:', error);
      }
    );


    this.patientService.getDoctorSessions().subscribe((response)=>{
      console.log(response);
      this.therapySessions = response.data.length
    })
    this.patientService.getGroupSessions().subscribe((response)=>{
      console.log(response);
      this.groupSessions = response.data.length
    })
    this.patientService.getEmergencyTeamSessions().subscribe((response)=>{
      console.log(response);
      this.emergencySessions = response.data.length
    })


  }



  goToEditProfilePage() {
    this.router.navigate(['patient/edit-profile']);
  }
  goToJournalPage() {
    this.router.navigate(['patient/journal']);
  }
  logout(){
    this.authService.logout()
    this.router.navigate(['/login']);
  }

}
