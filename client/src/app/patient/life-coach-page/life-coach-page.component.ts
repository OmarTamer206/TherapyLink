import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { PatientService } from '../../services/patient/patient.service';
import { TherapistService } from '../../services/therapist/therapist.service';

@Component({
  selector: 'app-life-coach-page',
  standalone: true,
  imports: [],
  templateUrl: './life-coach-page.component.html',
  styleUrl: './life-coach-page.component.css',
})
export class LifeCoachPageComponent {

  specialization:any;
  doctors:any

  selectedDoctor:any;

  constructor(private router: Router ,private patientService:PatientService , private therapistService:TherapistService) {

    this.getDoctorsData();

  }

  getDoctorsData(){
    this.patientService.getProfileData().subscribe((response) => {
      this.specialization = response.data.patient[0].Therapist_Preference;
      console.log(this.specialization);
      this.therapistService.viewAllDoctors("life_coach",this.specialization).subscribe((response) => {
      console.log(response);
      this.doctors = response.data;
      this.selectedDoctor = this.doctors[0];
    });
    });
  }

selectDoctor(doctor:any){
  this.selectedDoctor = doctor;
}



  goToMakeAppointmentPage(id:any) {
    this.router.navigate([`patient/life-coach-appointment`],{ state: { selectedDoctor: this.selectedDoctor} });
  }
}

