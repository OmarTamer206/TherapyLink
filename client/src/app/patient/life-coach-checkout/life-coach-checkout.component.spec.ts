import { ComponentFixture, TestBed } from '@angular/core/testing';

import { LifeCoachCheckoutComponent } from './life-coach-checkout.component';

describe('LifeCoachCheckoutComponent', () => {
  let component: LifeCoachCheckoutComponent;
  let fixture: ComponentFixture<LifeCoachCheckoutComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [LifeCoachCheckoutComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(LifeCoachCheckoutComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
