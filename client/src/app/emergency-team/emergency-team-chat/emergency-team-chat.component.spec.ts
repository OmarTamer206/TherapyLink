import { ComponentFixture, TestBed } from '@angular/core/testing';

import { EmergencyTeamChatComponent } from './emergency-team-chat.component';

describe('EmergencyTeamChatComponent', () => {
  let component: EmergencyTeamChatComponent;
  let fixture: ComponentFixture<EmergencyTeamChatComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [EmergencyTeamChatComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(EmergencyTeamChatComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
