import { ComponentFixture, TestBed } from '@angular/core/testing';

import { EmergencyCallMobileComponent } from './emergency-call-mobile.component';

describe('EmergencyCallMobileComponent', () => {
  let component: EmergencyCallMobileComponent;
  let fixture: ComponentFixture<EmergencyCallMobileComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [EmergencyCallMobileComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(EmergencyCallMobileComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
