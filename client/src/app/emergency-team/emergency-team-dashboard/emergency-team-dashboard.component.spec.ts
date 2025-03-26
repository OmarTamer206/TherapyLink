import { ComponentFixture, TestBed } from '@angular/core/testing';

import { EmergencyTeamDashboardComponent } from './emergency-team-dashboard.component';

describe('EmergencyTeamDashboardComponent', () => {
  let component: EmergencyTeamDashboardComponent;
  let fixture: ComponentFixture<EmergencyTeamDashboardComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [EmergencyTeamDashboardComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(EmergencyTeamDashboardComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
