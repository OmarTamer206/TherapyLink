import { Component } from '@angular/core';
import { PatientService } from '../../services/patient/patient.service';
import { AuthService } from '../../services/auth/auth.service';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-journal',
  standalone: true,
  imports: [FormsModule],
  templateUrl: './journal.component.html',
  styleUrl: './journal.component.css'
})
export class JournalComponent {

  journals:any
  emptyState = false;
  entryContent: string = ''; // Initialize the entry content variable

 constructor(private patientService: PatientService , private authService : AuthService ) {
    this.getProfileData();
  }

    getProfileData(){

    // Call the service to get the profile data
    this.patientService.getProfileData().subscribe(
      (response) => {
        console.log(response);


        if(response.data.journals.length !==0){
          this.emptyState = false;

          this.journals= response.data.journals;


          this.journals.map((journal:any)=>{
          const date = new Date(journal.time)
          journal.date = `${date.getDate()}/${date.getMonth()+1}/${date.getFullYear()}`
          const hours24 = date.getHours();
          const minutes = date.getMinutes();

          const hours12 = hours24 % 12 || 12; // Converts 0 to 12 for midnight
          const ampm = hours24 >= 12 ? 'PM' : 'AM';
          const paddedMinutes = minutes.toString().padStart(2, '0');

          journal.time = `${hours12}:${paddedMinutes} ${ampm}`;
          })

        }
        else
          this.emptyState = true





      },
      (error) => {
        console.error('Error fetching profile data:', error);
      }
    );

  }


  writeJournal() {

    if(this.entryContent.trim().length !== 0){

    this.patientService.writeJournal(this.entryContent).subscribe(
      (response) => {
        console.log(response);
        this.getProfileData();
      },
      (error) => {
        console.error('Error writing journal entry:', error);
      }
    );

  }
  this.entryContent = ""
  }

  deleteJournal(id:any){
    this.patientService.deleteJournalEntry(id).subscribe(
      (response) => {
        console.log(response);
        this.getProfileData();
      },
      (error) => {
        console.error('Error deleting journal entry:', error);
      }
    );
  }

}
