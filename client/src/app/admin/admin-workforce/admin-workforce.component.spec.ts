import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AdminWorkforceComponent } from './admin-workforce.component';

describe('AdminWorkforceComponent', () => {
  let component: AdminWorkforceComponent;
  let fixture: ComponentFixture<AdminWorkforceComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AdminWorkforceComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AdminWorkforceComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
