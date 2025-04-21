import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DoctorCheckoutComponent } from './doctor-checkout.component';

describe('DoctorCheckoutComponent', () => {
  let component: DoctorCheckoutComponent;
  let fixture: ComponentFixture<DoctorCheckoutComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [DoctorCheckoutComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(DoctorCheckoutComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
