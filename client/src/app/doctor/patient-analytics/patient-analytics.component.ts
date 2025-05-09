import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Chart } from 'chart.js/auto';
import { TherapistService } from '../../services/therapist/therapist.service';
import { PieChartComponent } from '../../manager/pie-chart/pie-chart.component';

@Component({
  selector: 'app-patient-analytics',
  standalone: true,
  imports: [CommonModule,PieChartComponent],
  templateUrl: './patient-analytics.component.html',
  styleUrl: './patient-analytics.component.css'
})
export class PatientAnalyticsComponent {
  activeTab: string = 'rating';
  selectedRating: number = 4;  // Static rating, no functionality
  chart1!: Chart;
  chart2!: Chart;
  averageRating:any=0;
  totalRatingCount:any=0;
  ratingPercentages:any;


  ratings = [
    { label: 'Excellent', value: 5, percentage:0, color: 'green' },
    { label: 'Good', value: 4, percentage:0, color: 'lightgreen' },
    { label: 'Average', value: 3, percentage:0, color: 'gold' },
    { label: 'Bad', value: 2, percentage:0, color: 'coral' },
    { label: 'Poor', value: 1, percentage:0, color: 'red' }
  ];

  totalPatients: any;
  ReturningPatients: any;
  pieChartLabels:any = ["Single-Visit Patients","Returning Patients"];
  pieChartData:any;


  constructor(private therapistService: TherapistService) {
    this.getPatientAnalytics();
  }

  getPatientAnalytics() {
    this.therapistService.getPatientAnalytics().subscribe((response) => {
      console.log(response);
      this.totalPatients = response.TotalPatientsByMonth;  // Assuming this is the structure of the response
      this.ReturningPatients = response.returningPatientsResult[0];  // Assuming this is the structure of the response

      this.pieChartData = [(this.ReturningPatients.total_patients - this.ReturningPatients.returning_patients ), this.ReturningPatients.returning_patients]


      let ratingCounts = response.ratingCounts;  // Assuming this is the structure of the response

      let actualRatingSum :any = 0;
      let bestRatingSum :any = 0;

      // Loop through the ratingCounts to calculate the total count and total sum
      for (let rating in ratingCounts) {
        const count = ratingCounts[rating];

        // Skip the rating 0
        if (rating !== '0') {
          actualRatingSum += (count * +rating);  // Add to total count (excluding 0 rating)
          bestRatingSum += count;  // Add to total sum (rating * count)
          this.totalRatingCount += count
        }
      }

      console.log(actualRatingSum, bestRatingSum);


      // Calculate the average rating, avoiding division by 0
       this.averageRating = this.averageRating = bestRatingSum > 0 ? (actualRatingSum / bestRatingSum).toFixed(1) : 0.0;

      console.log(this.averageRating);

      // Calculate the percentage of each rating
        this.ratingPercentages = this.calculateRatingPercentages(ratingCounts);
      console.log(this.ratingPercentages);



// Attach the percentage to the rating object
      this.ratings = this.ratings.map((rating) => {
        // If the rating value exists in the ratingPercentages, add the percentage
        if (this.ratingPercentages[rating.value]) {
          return {
            ...rating,
            percentage: this.ratingPercentages[rating.value]  // Add percentage to the rating
          };
        }
        return {...rating};
        // If the value doesn't exist in ratingPercentages (like `0`), set percentage to `0`

      });


    }, (error) => {
      console.error("Error fetching patient analytics", error);
    });
  }

  calculateRatingPercentages(ratingCounts: { [key: number]: number }) {
    let totalCount = 0;

    // Calculate the total count of all ratings
    for (let rating in ratingCounts) {
      if(rating !== "0" )
      totalCount += ratingCounts[rating];
    }

    // Create an object to hold the percentages of each rating
    let ratingPercentages : any = {};

    // Calculate the percentage for each rating
    for (let rating in ratingCounts) {
      if(rating !== "0" ){
        const count = ratingCounts[rating];
        const percentage = totalCount > 0 ? ((count / totalCount) * 100).toFixed(2) : 0;
        ratingPercentages[rating] = percentage;
      }
    }

    return ratingPercentages;
  }

  switchTab(tab: string) {
    this.activeTab = tab;
    if (tab === 'count') {
      setTimeout(() => this.createChart1(), 100);
    }

  }

  createChart1() {
    if (this.chart1) this.chart1.destroy();

    let data = new Array(12).fill(0);
    data.map((_, index) => {
      if(this.totalPatients[index]){
        data[index-1] = this.totalPatients[index];
      }

    });
    console.log("data : "+data);

    const ctx = document.getElementById('patientChart') as HTMLCanvasElement;
    this.chart1 = new Chart(ctx, {
      type: 'bar',
      data: {
        labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
        datasets: [{
          label: 'Patients',
          data: data,
          backgroundColor: ['#0099a8', '#003b49']
        }]
      },
      options: { responsive: true, maintainAspectRatio: false }
    });
  }


}
