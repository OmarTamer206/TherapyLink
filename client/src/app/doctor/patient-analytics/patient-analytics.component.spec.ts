import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PatientAnalyticsComponent } from './patient-analytics.component';

describe('PatientAnalyticsComponent', () => {
  let component: PatientAnalyticsComponent;
  let fixture: ComponentFixture<PatientAnalyticsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [PatientAnalyticsComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(PatientAnalyticsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
