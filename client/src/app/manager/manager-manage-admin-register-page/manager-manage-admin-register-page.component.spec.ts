import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ManagerManageAdminRegisterPageComponent } from './manager-manage-admin-register-page.component';

describe('ManagerManageAdminRegisterPageComponent', () => {
  let component: ManagerManageAdminRegisterPageComponent;
  let fixture: ComponentFixture<ManagerManageAdminRegisterPageComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ManagerManageAdminRegisterPageComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ManagerManageAdminRegisterPageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
