import { ComponentFixture, TestBed } from '@angular/core/testing';

import { EmergencySessionComponent } from './emergency-session.component';

describe('EmergencySessionComponent', () => {
  let component: EmergencySessionComponent;
  let fixture: ComponentFixture<EmergencySessionComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [EmergencySessionComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(EmergencySessionComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
