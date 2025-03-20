import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ManagerReportsGeneratorComponent } from './manager-reports-generator.component';

describe('ManagerReportsGeneratorComponent', () => {
  let component: ManagerReportsGeneratorComponent;
  let fixture: ComponentFixture<ManagerReportsGeneratorComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ManagerReportsGeneratorComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ManagerReportsGeneratorComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
