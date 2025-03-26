import { ComponentFixture, TestBed } from '@angular/core/testing';

import { EmergencyTeamSettingsComponent } from './emergency-team-settings.component';

describe('EmergencyTeamSettingsComponent', () => {
  let component: EmergencyTeamSettingsComponent;
  let fixture: ComponentFixture<EmergencyTeamSettingsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [EmergencyTeamSettingsComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(EmergencyTeamSettingsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
