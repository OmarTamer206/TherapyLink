import { ComponentFixture, TestBed } from '@angular/core/testing';

import { LifeCoachAppointmentComponent } from './life-coach-appointment.component';

describe('LifeCoachAppointmentComponent', () => {
  let component: LifeCoachAppointmentComponent;
  let fixture: ComponentFixture<LifeCoachAppointmentComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [LifeCoachAppointmentComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(LifeCoachAppointmentComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
