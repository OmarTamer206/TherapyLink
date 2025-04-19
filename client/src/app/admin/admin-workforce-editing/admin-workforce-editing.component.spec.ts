import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AdminWorkforceEditingComponent } from './admin-workforce-editing.component';

describe('AdminWorkforceEditingComponent', () => {
  let component: AdminWorkforceEditingComponent;
  let fixture: ComponentFixture<AdminWorkforceEditingComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AdminWorkforceEditingComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AdminWorkforceEditingComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
