import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CallMobileComponent } from './call-mobile.component';

describe('CallMobileComponent', () => {
  let component: CallMobileComponent;
  let fixture: ComponentFixture<CallMobileComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [CallMobileComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(CallMobileComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
