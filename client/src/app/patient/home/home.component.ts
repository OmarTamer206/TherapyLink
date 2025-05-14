import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';
import { PatientService } from '../../services/patient/patient.service';

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css'],
})
export class HomeComponent {
  showTherapistPreference = false;
  selectedIndex: number | null = null;
  selectedTherapist: any // <-- NEW VARIABLE

  therapists = [
    { name: 'General Psychological Support', image: 'Clinical Psychologist.png' },
    {
      name: 'Mood and Anxiety Disorder Specialist',
      image: 'Child and Adolescent Therapist.png',
    },
    { name: 'Clinical Depression Specialist', image: 'Counseling Psychologist.png' },
    { name: 'Suicide Prevention and Crisis Specialist', image: 'Trauma Therapist.png' },
  ];

  constructor(private router: Router,private patientService:PatientService) {
    this.getProfileData()
  }

  getProfileData(){
    this.patientService.getProfileData().subscribe((response)=>{
      console.log(response);

      this.selectedTherapist = response.data.patient[0].Therapist_Preference

      console.log(this.selectedTherapist);

       this.selectedIndex = this.therapists.findIndex(
        (therapist) => therapist.name === this.selectedTherapist
      );

    })

  }

  goToChatbot(): void {
    this.router.navigate(['patient/chatbot']);
  }

  goToDoctorsPage(): void {
    this.router.navigate(['patient/doctors-page']);
  }

  goToUpcomingSessionPage(): void {
    this.router.navigate(['patient/session-page']);
  }

  toggleTherapistPreference(): void {
    this.showTherapistPreference = !this.showTherapistPreference;
  }

  selectTherapist(index: number): void {
    this.selectedIndex = index;
    this.selectedTherapist = this.therapists[index].name; // <-- Save selected name
    console.log('Selected therapist:', this.selectedTherapist);
  }

  saveTherapistPreference(){
    this.patientService.changeTherapistPreference(this.selectedTherapist).subscribe((response)=>{
      console.log(response);

    },(error)=>{
      console.log(error);

    })
    this.showTherapistPreference = !this.showTherapistPreference;

  }

}
