import { ComponentFixture, TestBed } from '@angular/core/testing';

import { LifeCoachPageComponent } from './life-coach-page.component';

describe('LifeCoachPageComponent', () => {
  let component: LifeCoachPageComponent;
  let fixture: ComponentFixture<LifeCoachPageComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [LifeCoachPageComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(LifeCoachPageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
