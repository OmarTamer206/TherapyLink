import { Component } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { TherapistService } from '../../services/therapist/therapist.service';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-life-coach-appointment',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './life-coach-appointment.component.html',
  styleUrl: './life-coach-appointment.component.css',
})
export class LifeCoachAppointmentComponent {

  loading=false;

  doctor_id:any;

  selectedTime: any = "";

  currentDate = new Date();
  selectedDay: number = 1;
  days: number[] = [];

  availableTimes: any[] = [
  '9:00 AM', '11:00 AM', '1:00 PM', '3:00 PM',
  '5:00 PM', '7:00 PM', '9:00 PM', '11:00 PM',
  '1:00 AM' // Note: changed "PM" to "AM" based on your list
];
  timeTable: any[]=[];
  selectedDoctor: any;
  avgRating: number = 1;
  sessionTopic = "";
  availableDays: any;



     ngOnInit(): void {
    // Access the state data from window.history
    const state = window.history.state;

    if (state) {
      this.selectedDoctor = state.selectedDoctor;
      this.doctor_id = state.selectedDoctor.doctor_data.id;
      this.avgRating = parseInt(this.selectedDoctor.avgRating)

      console.log('Selected Doctor:', this.selectedDoctor);
      console.log('Doctor ID:', this.doctor_id);
    }
      this.generateDays();
      this.goToToday();
      this.getAvailableDays();
      this.loading = true;
  }


  constructor(private router: Router ,private route: ActivatedRoute , private therapistService:TherapistService) {

  }

    getAvailableDays() {
    this.therapistService.viewAvailableDays(this.doctor_id, "life_coach").subscribe(
      (response) => {
        console.log("Days : ", response);
        if (response.success) {
          const availableDates = response.data;

          this.availableDays = []; // reset

          availableDates.forEach((item: any) => {
            const date = new Date(item.available_date);
            if (
              date.getMonth() === this.currentDate.getMonth() &&
              date.getFullYear() === this.currentDate.getFullYear()
            ) {
              const day = date.getDate();
              if (!this.availableDays.includes(day)) {
                this.availableDays.push(day);
              }
            }
          });

        } else {
          alert("Failed to fetch available days");
        }
      },
      (error) => {
        console.log("error", error);
        alert("Failed to fetch available days");
      }
    );
  }

getAvailableTimes(){
  this.timeTable=[];
  this.selectedTime = ""
  this.sessionTopic = ""
    const date = `${this.currentDate.getFullYear()}-${String(this.currentDate.getMonth() + 1).padStart(2, '0')}-${String(this.selectedDay).padStart(2, '0')}`;

    this.therapistService.viewAvailableTime(date,this.doctor_id,"life_coach").subscribe((response) => {
      console.log(response);
      if (response.success) {
        this.timeTable = response.data.map((item: any) => {
          const d = new Date(item.available_date);
          const hours = d.getHours() % 12 || 12;
          const minutes = d.getMinutes().toString().padStart(2, '0');
          const ampm = d.getHours() >= 12 ? 'PM' : 'AM';
          const time = `${hours}:${minutes} ${ampm}`;

          this.sessionTopic = item.topic;

          return {
            time,
            full:item.full,
            isReserved: item.IsReserved, // from backend
            fullTimestamp: item.available_date // useful if needed later
          };
        });

        this.availableTimes.forEach(time => {
        const exists = this.timeTable.some(slot => slot.time === time);
        if (!exists) {
          this.timeTable.push({ time, disabled: true, fullTimestamp: '' });  // Adding the time to the list with default isReserved and empty timestamp
        }
      });

      this.timeTable = this.sortTimeSlots(this.timeTable)

        console.log(this.timeTable);
      } else {
        alert("Failed to fetch available times");
      }
    }, (error) => {
      console.log("error", error);
      alert("Failed to fetch available times");
    });
}

 private convertTo24HourFormat(time: string): string {
  const [hourStr, minuteStrWithMeridian] = time.split(':');
  const [minuteStr, meridian] = minuteStrWithMeridian.split(' ');

  let hour = parseInt(hourStr);
  const minute = parseInt(minuteStr);

  if (meridian === 'PM' && hour !== 12) hour += 12;
  if (meridian === 'AM' && hour === 12) hour = 0;

  return `${String(hour).padStart(2, '0')}:${String(minute).padStart(2, '0')}`;
}

// Function to sort the array based on time
 private sortTimeSlots(timeSlots: any[]): any[] {
  return timeSlots.sort((a, b) => {
    const timeA = this.convertTo24HourFormat(a.time);
    const timeB = this.convertTo24HourFormat(b.time);
    return timeA.localeCompare(timeB);
  });
}


  generateDays() {
    const year = this.currentDate.getFullYear();
    const month = this.currentDate.getMonth();
    const lastDay = new Date(year, month + 1, 0).getDate();
    this.days = Array.from({ length: lastDay }, (_, i) => i + 1);
  }

  selectDay(day: number) {
    this.selectedDay = day;
    this.getAvailableTimes();
  }

  nextMonth() {
    this.currentDate.setMonth(this.currentDate.getMonth() + 1);
    this.generateDays();
    this.selectedDay = 1;
      this.getAvailableDays();

    this.getAvailableTimes();

  }

  prevMonth() {
    this.currentDate.setMonth(this.currentDate.getMonth() - 1);
    this.generateDays();
    this.selectedDay = 1;
      this.getAvailableDays();

    this.getAvailableTimes();

  }

  getMonthYear() {
    return this.currentDate.toLocaleString('emad', { month: 'long', year: 'numeric' });
  }

  goToToday() {
    this.currentDate = new Date();
    this.generateDays();
    this.selectedDay = this.currentDate.getDate();
      this.getAvailableDays();

    this.getAvailableTimes();

  }

  getSelectedDayInfo(): { dayName: string, dayNumber: number } {
    const year = this.currentDate.getFullYear();
    const month = this.currentDate.getMonth(); // 0-based
    const date = new Date(year, month, this.selectedDay);

    const dayName = date.toLocaleDateString('en-US', { weekday: 'short' }); // e.g., "Sat"
    const dayNumber = date.getDate(); // e.g., 8

    return { dayName, dayNumber };
  }



selectTime(time: string) {
    this.selectedTime = time; // Update selected time
    console.log("Selected Time:", this.selectedTime);
  }


  generateTimestamp(): string {

    const year = this.currentDate.getFullYear();
    const month = this.currentDate.getMonth();
    const day = this.selectedDay;


    const [hourStr, meridian] = this.selectedTime.split(' ');
    let hour = parseInt(hourStr);
    if (meridian === 'PM' && hour !== 12) hour += 12;
    if (meridian === 'AM' && hour === 12) hour = 0;

    const date = new Date(year, month, day, hour, 0, 0);

    const timestamp =
    `${year}-${String(month + 1).padStart(2, '0')}-${String(day).padStart(2, '0')} ` +
    `${String(hour).padStart(2, '0')}:00:00`;


    console.log(timestamp);


    return timestamp;
  }


  goToCheckoutPage() {
    if(this.selectedTime != ""){
      let timestamp = this.generateTimestamp();

      this.router.navigate(
        ['patient/life-coach-checkout'],
        { state: { selectedTime: timestamp, selectedDoctor: this.selectedDoctor , sessionTopic: this.sessionTopic } }
      );
    }
    }
}
