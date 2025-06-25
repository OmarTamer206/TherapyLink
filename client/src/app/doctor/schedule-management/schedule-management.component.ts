import { Component } from '@angular/core';
import { CommonModule, NgIf } from '@angular/common';
import { TherapistService } from '../../services/therapist/therapist.service';

@Component({
  selector: 'app-schedule-management',
  standalone: true,
  imports: [CommonModule,NgIf],
  templateUrl: './schedule-management.component.html',
  styleUrl: './schedule-management.component.css'
})
export class ScheduleManagementComponent {
  currentDate = new Date();
  selectedDay: number = 1;
  days: number[] = [];

  reports = [
    { time: '09:00am - 11:00am', name: 'Patient Name' },
    { time: '02:00am - 04:00pm', name: 'Patient Name' },
    { time: '04:00am - 06:00pm', name: 'Patient Name' },
  ];


  showModal = false;
  selectedTimes: string[] = [];

availableTimes: string[] = [
  '9 AM', '11 AM', '1 PM', '3 PM',
  '5 PM', '7 PM', '9 PM', '11 PM',
  '1 AM'  // Note: changed "PM" to "AM" based on your list
];

timeTable: any[]=[];

  constructor(private therapistService:TherapistService) {
    this.generateDays();
    this.goToToday();
    this.getAvailableTimes()
  }







  getAvailableTimes() {
    this.timeTable=[];

    const date = `${this.currentDate.getFullYear()}-${String(this.currentDate.getMonth() + 1).padStart(2, '0')}-${String(this.selectedDay).padStart(2, '0')}`;

    this.therapistService.viewAvailableTime(date).subscribe((response) => {
      console.log(response);
      if (response.success) {
        this.timeTable = response.data.map((item: any) => {
          const d = new Date(item.available_date);
          const hours = d.getHours() % 12 || 12;
          const minutes = d.getMinutes().toString().padStart(2, '0');
          const ampm = d.getHours() >= 12 ? 'PM' : 'AM';
          const time = `${hours}:${minutes} ${ampm}`;

          return {
            time,
            isReserved: item.IsReserved, // from backend
            fullTimestamp: item.available_date // useful if needed later
          };
        });
        console.log(this.timeTable);
      } else {
        alert("Failed to fetch available times");
      }
    }, (error) => {
      console.log("error", error);
      alert("Failed to fetch available times");
    });
  }





// Called when checkbox is toggled
toggleTimeSelection(time: string, event: any) {
  if (event.target.checked) {
    this.selectedTimes.push(time);
  } else {
    this.selectedTimes = this.selectedTimes.filter(t => t !== time);
  }
}

// Open modal
addAvailableTime() {
  this.showModal = true;
}

// Submit and close modal
submitTimes() {
  this.showModal = false;
  console.log('Selected Times:', this.selectedTimes);
  console.log('Selected Day:', this.selectedDay);
  console.log("currentDate",this.currentDate);

  const timestampsToSend = this.generateTimestamps();
  console.log(timestampsToSend);


  this.therapistService.updateAvailableTime(timestampsToSend).subscribe((response)=>{
    console.log(response);
    if(response.success === true){
      console.log("Available time updated successfully")
    }
    else{
      alert("Failed to update available time")
    }
    this.selectedTimes = []; // Reset selected times after submission
    this.getAvailableTimes();
  },(error)=>{
    console.log("error",error);
    alert("Failed to update available time")
  });

}

generateTimestamps(): string[] {
  const timestamps: string[] = [];
  const year = this.currentDate.getFullYear();
  const month = this.currentDate.getMonth();
  const day = this.selectedDay;

  this.selectedTimes.forEach(timeStr => {
    const [hourStr, meridian] = timeStr.split(' ');
    let hour = parseInt(hourStr);
    if (meridian === 'PM' && hour !== 12) hour += 12;
    if (meridian === 'AM' && hour === 12) hour = 0;

    const date = new Date(year, month, day, hour, 0, 0);

    const timestamp =
      `${year}-${String(month + 1).padStart(2, '0')}-${String(day).padStart(2, '0')} ` +
      `${String(hour).padStart(2, '0')}:00:00`;

    timestamps.push(timestamp);
  });

  return timestamps;
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
    this.getAvailableTimes();

  }

  prevMonth() {
    this.currentDate.setMonth(this.currentDate.getMonth() - 1);
    this.generateDays();
    this.selectedDay = 1;
    this.getAvailableTimes();

  }

  getMonthYear() {
    return this.currentDate.toLocaleString('default', { month: 'long', year: 'numeric' });
  }

  goToToday() {
    this.currentDate = new Date();
    this.generateDays();
    this.selectedDay = this.currentDate.getDate();
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


  deleteAvailableTime(timeStr: string) {
    const [hourStr, minuteStrWithAMPM] = timeStr.split(':');
    const [minuteStr, ampm] = minuteStrWithAMPM.split(' ');

    let hour = parseInt(hourStr);
    const minute = parseInt(minuteStr);
    if (ampm === 'PM' && hour !== 12) hour += 12;
    if (ampm === 'AM' && hour === 12) hour = 0;

    const year = this.currentDate.getFullYear();
    const month = this.currentDate.getMonth() + 1; // 1-based for string formatting
    const day = this.selectedDay;

    // Construct LOCAL timestamp string to match what's in DB
    const timestamp = `${year}-${String(month).padStart(2, '0')}-${String(day).padStart(2, '0')} ${String(hour).padStart(2, '0')}:${String(minute).padStart(2, '0')}:00`;
    console.log(timestamp);

    this.therapistService.deleteAvailableTime(timestamp).subscribe((res) => {
      if (res.success) {
        this.timeTable = this.timeTable.filter(t => t !== timeStr);
      } else {
        alert("Failed to delete time");
      }

      this.getAvailableTimes()

    }, (error) => {
      console.error(error);
      alert("Error deleting time");
    });
  }

  isPastDay(): boolean {
  const today = new Date();
  const selectedDate = new Date(
    this.currentDate.getFullYear(),
    this.currentDate.getMonth(),
    this.selectedDay
  );

  // Compare only date parts (year, month, day)
  return selectedDate < new Date(today.getFullYear(), today.getMonth(), today.getDate());
}




}
