import { CommonModule, NgIf } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { PatientService } from '../../services/patient/patient.service';


@Component({
  selector: 'app-life-coach-checkout',
  standalone: true,
  imports: [NgIf , CommonModule , FormsModule],
  templateUrl: './doctor-checkout.component.html',
  styleUrls: ['./doctor-checkout.component.css']
})
export class DoctorCheckoutComponent implements OnInit {
  showSuccess = false;

    selectedTime: any="";

  selectedDuration: any = "60";
  communication_type:any = "Voice / Video Call";
  selectedDoctor: any;
  doctor_id: any;
  avgRating: number=1;
  sessionPrice: number =1;
  multiplier: number =1 ;

   ngOnInit(): void {
    // Access the state data from window.history
    const state = window.history.state;

    if (state) {
      this.selectedTime = state.selectedTime;
      this.selectedDoctor = state.selectedDoctor;
      this.doctor_id = state.selectedDoctor.doctor_data.id;
      this.avgRating = parseInt(this.selectedDoctor.avgRating)
      this.sessionPrice = parseInt(this.selectedDoctor.doctor_data.Session_price)

      console.log('Selected Time:', this.selectedDoctor);
      console.log('Doctor ID:', this.doctor_id);
    }
  }


  constructor(private router: Router,private route: ActivatedRoute , private patientService:PatientService) {}


  selectDuration(duration: string): void {
    this.selectedDuration = duration;

    if(+duration == 30)
      this.multiplier = 0.5
    if(+duration == 60)
      this.multiplier = 1
    if(+duration == 120)
      this.multiplier = 2
    console.log('Selected Duration:', this.selectedDuration); // You can use this value as needed
  }
  handleCheckout(): void {

    if(this.selectedDuration !=""){

      // patient_ID,
      // sessionData.doctor_id,
      // sessionData.com_type,
      // sessionData.time,
      // sessionData.cost,
      // sessionData.duration,

      let sessionData = {
      doctor_id: this.doctor_id,
      com_type: this.communication_type,
      time: this.selectedTime,
      type:"doctor",
      cost: this.sessionPrice * this.multiplier,
      duration: this.selectedDuration,
      }

      console.log(sessionData);

      this.patientService.makeAppointment(sessionData).subscribe((response)=>{
        console.log(response);

      })

      this.showSuccess = true;

      // After 5 seconds, redirect
      setTimeout(() => {
        this.router.navigate(['patient/home']); // Change to actual route
      }, 3000);
    }
    }



}
