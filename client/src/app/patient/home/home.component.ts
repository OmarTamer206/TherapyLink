import { AfterViewInit, Component, ElementRef, OnDestroy, OnInit, ViewChild } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';
import { PatientService } from '../../services/patient/patient.service';
import { SessionService } from '../../services/session/session.service';

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css'],
})
export class HomeComponent implements OnDestroy  {
  showTherapistPreference = false;
  selectedIndex: number | null = null;
  selectedTherapist: any // <-- NEW VARIABLE

  therapists = [
    { name: 'General Psychological Support', image: 'Clinical Psychologist.png' },
    {
      name: 'Mood and Anxiety Disorder Specialist',
      image: 'Child and Adolescent Therapist.png',
    },
    { name: 'Clinical Depression and Crisis Prevention Specialist', image: 'Trauma Therapist.png' },
  ];

  upcomingSession: any;

 FULL_DASH_ARRAY = 283;
 WARNING_THRESHOLD = 900000;
 ALERT_THRESHOLD = 300000;

 COLOR_CODES = {
  info: {
    color: "blue"
  },
  warning: {
    color: "orange",
    threshold: this.WARNING_THRESHOLD
  },
  alert: {
    color: "green",
    threshold: this.ALERT_THRESHOLD
  }
};

TIME_LIMIT:any = null;
timePassed = 0;
timeLeft = this.TIME_LIMIT;
timerInterval:any = null;
remainingPathColor = this.COLOR_CODES.info.color;

loading = false;

check1=false;
check2=false;
check3=false;

startTimer() {

  console.log(this.TIME_LIMIT);


  if(this.upcomingSession){
      this.timerInterval = setInterval(() => {

    if( this.check3 == false){
      this.check3 = true
      this.checkLoading();
    }

    if(this.TIME_LIMIT)
    {
      this.timePassed = this.timePassed += 1000;
    this.timeLeft = this.TIME_LIMIT - this.timePassed;
    document.getElementById("base-timer-label")!.innerHTML = this.formatTime(
      this.timeLeft
    );
    this.setCircleDasharray();
    this.setRemainingPathColor(this.timeLeft);

    if (this.timeLeft === 0) {
      this.onTimesUp();
    }
    }
  }, 1000);
  }
  else{
    this.check3 = true
      this.checkLoading();
  }


}

formatTime(time:any) {
  const days = Math.floor(time / (1000 * 60 * 60 * 24)); // Calculate days
  const hours = Math.floor((time % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60)); // Calculate hours
  const minutes = Math.floor((time % (1000 * 60 * 60)) / (1000 * 60)); // Calculate minutes
  let seconds:any = Math.floor((time % (1000 * 60)) / 1000); // Calculate seconds

  if (seconds < 10) {
    seconds = `0${seconds}`;
  }

   return `${days}d ${hours}h ${minutes}m ${seconds}s`;
}

setRemainingPathColor(timeLeft:any) {
  const { alert, warning, info } = this.COLOR_CODES;
  if (timeLeft <= alert.threshold) {
    document
      .getElementById("base-timer-path-remaining")!
      .classList.remove(warning.color);
    document
      .getElementById("base-timer-path-remaining")!
      .classList.add(alert.color);
  } else if (timeLeft <= warning.threshold) {
    document
      .getElementById("base-timer-path-remaining")!
      .classList.remove(info.color);
    document
      .getElementById("base-timer-path-remaining")!
      .classList.add(warning.color);
  }
  else{
    document
      .getElementById("base-timer-path-remaining")!
      .classList.add(info.color);
  }
}

calculateTimeFraction() {
  const rawTimeFraction = this.timeLeft / this.TIME_LIMIT;
  return rawTimeFraction - (1 / this.TIME_LIMIT) * (1 - rawTimeFraction);
}

setCircleDasharray() {
  const circleDasharray = `${(
    this.calculateTimeFraction() * this.FULL_DASH_ARRAY
  ).toFixed(0)} 283`;
  document
    .getElementById("base-timer-path-remaining")!
    .setAttribute("stroke-dasharray", circleDasharray);
}


  constructor(private router: Router,private patientService:PatientService , private sessionService:SessionService) {
    this.getProfileData()
    this.getUpcomingSessions();



  }

  onTimesUp() {
    clearInterval(this.timerInterval);
  }



  getProfileData(){
    this.patientService.getProfileData().subscribe((response)=>{
      console.log(response);

      this.selectedTherapist = response.data.patient[0].Therapist_Preference

      console.log(this.selectedTherapist);

       this.selectedIndex = this.therapists.findIndex(
        (therapist) => therapist.name === this.selectedTherapist
      );

      this.check1 = true;
      this.checkLoading();

    })

  }

  getUpcomingSessions(){
    this.sessionService.viewUpcomingSessionsPatient().subscribe((response)=>{
      console.log(response);


      this.upcomingSession = response.data[0]

      if(this.upcomingSession){
              const currentTimestamp = Date.now(); // Get current date in milliseconds
      const givenTimestamp = new Date(this.upcomingSession.scheduled_time).getTime();
      this.TIME_LIMIT = givenTimestamp - currentTimestamp; // Calculate the difference in milliseconds


      const date = new Date(this.upcomingSession.scheduled_time)
          this.upcomingSession.date = `${date.getDate()}/${date.getMonth()+1}/${date.getFullYear()}`
          const hours24 = date.getHours();
          const minutes = date.getMinutes();

          const hours12 = hours24 % 12 || 12; // Converts 0 to 12 for midnight
          const ampm = hours24 >= 12 ? 'PM' : 'AM';
          const paddedMinutes = minutes.toString().padStart(2, '0');

          this.upcomingSession.time = `${hours12}:${paddedMinutes} ${ampm}`;

      }

    this.startTimer();


      this.check2 = true;
      this.checkLoading();

    },(error)=>{
      console.log(error);

    })
  }

  goToChatbot(): void {
    this.router.navigate(['patient/chatbot']);
  }

  goToDoctorsPage(): void {
    this.router.navigate(['patient/doctors-page']);
  }

  goToUpcomingSessionPage(): void {
    this.router.navigate([`patient/session-page`],{ state: { session:this.upcomingSession } });
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

  ngOnDestroy(): void {
  if (this.timerInterval) {
    clearInterval(this.timerInterval);
    this.timerInterval = null;
  }
}

checkLoading(){
  if(this.check1 && this.check2 && this.check3 ){
    this.loading = true;
  }
}




}
