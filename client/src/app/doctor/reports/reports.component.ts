import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { TherapistService } from '../../services/therapist/therapist.service';
import { ReportComponent } from '../session/report/report.component';
import { JournalComponent } from '../session/journal/journal.component';
import { SessionService } from '../../services/session/session.service';
import { Router } from '@angular/router';
;

@Component({
  selector: 'app-reports',
  standalone: true,
  imports: [CommonModule , ReportComponent, JournalComponent],
  templateUrl: './reports.component.html',
  styleUrl: './reports.component.css'
})
export class ReportsComponent {

  patients: any[] = [];

  selectedPatient: any = {};  // To hold the currently selected patient data
  modalVisible: boolean = false; // Controls the visibility of the modal
  modalType: 'report' | 'journal' | "delete" = 'report'; // Tracks whether the modal should show the Report or Journal

  deleteSessionID:any;

  patientData:any;

  loading = false;
  check1 = false;




    constructor(private therapistService:TherapistService,private sessionService:SessionService,private router:Router){

      this.getPatientsData()

    }



  getPatientsData(){
    this.therapistService.getUpcomingSessions().subscribe((response)=>{
      console.log("data: dd",response);
      this.patients = response.data;

      this.patients.map((patient)=>{
        const date = new Date(patient.scheduled_time)
        patient.date = `${date.getDate()}/${date.getMonth()+1}/${date.getFullYear()}`
        const hours24 = date.getHours();
        const minutes = date.getMinutes();

        const hours12 = hours24 % 12 || 12; // Converts 0 to 12 for midnight
        const ampm = hours24 >= 12 ? 'PM' : 'AM';
        const paddedMinutes = minutes.toString().padStart(2, '0');

        patient.time = `${hours12}:${paddedMinutes} ${ampm}`;

      })
      this.check1=true;
      this.checkLoading();

    },(error)=>{
      console.log("error",error);


    })
  }


  async openModal(patient: any, type: 'report' | 'journal' | "delete" , patient_ID:any, session_ID:any=null) {



    if(type == "delete"){
      this.deleteSessionID = session_ID;
    }
    await this.getPatientData(patient_ID); // Fetch patient data when opening the modal
    this.selectedPatient = patient;
    this.modalType = type;  // Set which content to show in the modal (Report or Journal)
    this.modalVisible = true;  // Show the modal
    console.log(this.selectedPatient);
    console.log(this.selectedPatient.data.patient[0].Name);

  }

  closeModal() {
    this.modalVisible = false; // Close the modal
  }

async getPatientData(patient_ID: string) {
  console.log(patient_ID);

  this.loading = false;
  this.therapistService.getPatientData(patient_ID).subscribe((response) => {
    this.patientData = response.data;
    console.log(response);


    this.patientData.journals.map((journal:any)=>{
      const date = new Date(journal.time)
      journal.date = `${date.getDate()}/${date.getMonth()+1}/${date.getFullYear()}`
      const hours24 = date.getHours();
      const minutes = date.getMinutes();

      const hours12 = hours24 % 12 || 12; // Converts 0 to 12 for midnight
      const ampm = hours24 >= 12 ? 'PM' : 'AM';
      const paddedMinutes = minutes.toString().padStart(2, '0');

      journal.time = `${hours12}:${paddedMinutes} ${ampm}`;
    })
    this.check1=true;
    this.checkLoading()
  });
}

deleteSession(session_ID:any){
  console.log("session id",session_ID);

  this.sessionService.cancelSession(session_ID).subscribe((response)=>{
    console.log("deleted session",response);
    this.getPatientsData()
    this.closeModal()
  },(error)=>{
    console.log("error",error);
  })
}

goToSession(session_ID:any){
  console.log(session_ID);
  this.router.navigate([`/doctor/session/${session_ID}`])
}

  checkLoading(){

    if(this.check1){
      this.loading = true;
    }
  }


}
