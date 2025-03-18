import { Component } from '@angular/core';

@Component({
  selector: 'app-patient-reports',
  standalone: true,
  templateUrl: './patient-reports.component.html',
  styleUrls: ['./patient-reports.component.css']
})
export class PatientReportsComponent {
  reports = [
    { no: 1, name: 'Ahmed Eid', doctor: 'Dr.Youssef Mokhtar', admitDate: '27/05/2024' },
    { no: 2, name: 'Mona Ahmed', doctor: 'Dr.Yasser Mahmoud', admitDate: '27/05/2024' },
    { no: 3, name: 'Yasser Eissa', doctor: 'Dr.Moustafa Mahmoud', admitDate: '27/05/2024' },
    { no: 4, name: 'Mostafa Fahmy', doctor: 'Dr.Manar Ashraf', admitDate: '27/05/2024' },
    { no: 5, name: 'Amgad Basha', doctor: 'Dr.Maged Mohamed', admitDate: '27/05/2024' },
    { no: 6, name: 'Mahmoud Wael', doctor: 'Dr.Rushdy Maged', admitDate: '27/05/2024' },
    { no: 7, name: 'Malak Magdy', doctor: 'Dr.Hagar Ahmed', admitDate: '27/05/2024' },
  ];

  sendReportToMail(patient: any) {
    console.log('Sending report to:', patient.name);
    // Your logic for sending the report
  }
}
