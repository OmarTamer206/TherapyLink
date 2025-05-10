import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { TherapistService } from '../../services/therapist/therapist.service';
import { SessionService } from '../../services/session/session.service';
import { Router } from '@angular/router';
import { ReportComponent } from '../../doctor/session/report/report.component';
import { JournalComponent } from '../../doctor/session/journal/journal.component';

@Component({
  selector: 'app-reports',
  standalone: true,
  imports: [CommonModule,ReportComponent,JournalComponent],
  templateUrl: './reports.component.html',
  styleUrl: './reports.component.css'
})
export class lifeReportsComponent {


  patients: any[] = [];

  selectedPatient: any = {};  // To hold the currently selected patient data
  modalVisible: boolean = false; // Controls the visibility of the modal
  modalType: 'report' | 'journal' | "delete" = 'report'; // Tracks whether the modal should show the Report or Journal

  deleteSessionID:any;



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


  async openModal( type:  "delete" ,session_ID:any=null) {
      this.deleteSessionID = session_ID;

    this.modalType = type;  // Set which content to show in the modal (Report or Journal)
    this.modalVisible = true;  // Show the modal

  }

  closeModal() {
    this.modalVisible = false; // Close the modal
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
  this.router.navigate([`/life-coach/session/${session_ID}`])
}

  checkLoading(){

    if(this.check1){
      this.loading = true;
    }
  }


}

