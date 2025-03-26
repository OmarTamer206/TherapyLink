import { ComponentFixture, TestBed } from '@angular/core/testing';

import { EmergencyTeamOperationsComponent } from './emergency-team-operations.component';

describe('EmergencyTeamOperationsComponent', () => {
  let component: EmergencyTeamOperationsComponent;
  let fixture: ComponentFixture<EmergencyTeamOperationsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [EmergencyTeamOperationsComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(EmergencyTeamOperationsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
