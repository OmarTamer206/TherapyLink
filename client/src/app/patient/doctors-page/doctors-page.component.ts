import { Component } from '@angular/core';
import { Router, RouterModule } from '@angular/router';
import { PatientService } from '../../services/patient/patient.service';
import { TherapistService } from '../../services/therapist/therapist.service';

@Component({
  selector: 'app-doctors-page',
  standalone: true,
  imports: [],
  templateUrl: './doctors-page.component.html',
  styleUrl: './doctors-page.component.css',
})
export class DoctorsPageComponent {

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
      this.therapistService.viewAllDoctors("doctor",this.specialization).subscribe((response) => {
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
    this.router.navigate([`patient/doctor-appointment`],{ state: { selectedDoctor: this.selectedDoctor} });
  }
}
