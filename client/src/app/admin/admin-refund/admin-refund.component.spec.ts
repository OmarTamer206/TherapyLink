import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AdminRefundComponent } from './admin-refund.component';

describe('AdminRefundComponent', () => {
  let component: AdminRefundComponent;
  let fixture: ComponentFixture<AdminRefundComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AdminRefundComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AdminRefundComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
