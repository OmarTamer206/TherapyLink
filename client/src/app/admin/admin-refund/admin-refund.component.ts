import { Component } from '@angular/core';
import { RouterModule } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { AdminService } from '../../services/admin/admin.service';
import { EmailService } from '../../services/email/email.service';
import { PatientService } from '../../services/patient/patient.service';

@Component({
  selector: 'app-admin-refund',
  standalone: true,
  imports: [RouterModule, FormsModule, CommonModule],
  templateUrl: './admin-refund.component.html',
  styleUrls: ['./admin-refund.component.css'],
})
export class AdminRefundComponent {
  selectedReportIndex: number = -1;
  responseText: string = '';

  refundButtonText: string[] = ['Refund Session', 'Session Refunded'];
  cancelRefundButtonState = false;

  reports: any[] = [];
  doctor: any;

  loading= false
  patientEmail: any;

  constructor(private adminService: AdminService ,private patientService: PatientService, private emailService: EmailService) {
    this.getAllFeedbacks();
  }

  getAllFeedbacks() {
    this.adminService.getAllFeedbacks().subscribe(
      (response) => {
        console.log('Feedbacks: ', response);
        this.reports = response.data;


         this.reports.map((report:any)=>{
            const date = new Date(report.time)
            report.date = `${date.getDate()}/${date.getMonth()+1}/${date.getFullYear()}`
            const hours24 = date.getHours();
            const minutes = date.getMinutes();

            const hours12 = hours24 % 12 || 12; // Converts 0 to 12 for midnight
            const ampm = hours24 >= 12 ? 'PM' : 'AM';
            const paddedMinutes = minutes.toString().padStart(2, '0');

            report.time = `${hours12}:${paddedMinutes} ${ampm}`;
          })

          this.loading=true;
      },
      (error) => {
        console.error('Error fetching feedbacks: ', error);
      }
    );
  }

  replyFeedback(index: any) {
    let data = {
      feedback_ID: this.reports[index].feedback_ID,
      session_ID: this.reports[index].session_id,
      patient_ID: this.reports[index].patient_id,
      doctor_type: this.reports[index].doctor_type,
      response: this.responseText,
      IsRefunded: this.reports[index].isRefunded,
    };

    console.log(data);

    this.patientService.getProfileDataByID(data.patient_ID).subscribe((response) => {
      console.log('Patient Profile Data:', response);
      this.patientEmail = response.data.patient[0].Email;
      console.log('Patient Email:', this.patientEmail);

      this.emailService.sendEmail(this.patientEmail , `Feedback Response For Session with Dr.${this.reports[index].doctor_info.Name}` , this.responseText).subscribe((response) => {
        console.log('Email sent successfully:', response);
      }

      , (error) => {
        console.error('Error sending email:', error);
      });
    }
    , (error) => {
      console.error('Error fetching patient profile data:', error);
    });


    this.adminService.replyFeedback(data).subscribe((response) => {
      console.log(response);

      this.reports = [];
      this.responseText = '';
      this.cancelRefundButtonState = false;

      this.selectedReportIndex = -1;
      this.getAllFeedbacks();
    });
  }

  selectReport(index: number) {
    this.selectedReportIndex = index;

    this.responseText = '';
    this.cancelRefundButtonState = false;

    console.log('Selected report:', index + 1);
  }

  setRefundOrder() {
    this.cancelRefundButtonState = true;
    this.reports[this.selectedReportIndex].isRefunded = 1;
  }
  cancelRefundOrder() {
    this.cancelRefundButtonState = false;
    this.reports[this.selectedReportIndex].isRefunded = 0;
  }
}
