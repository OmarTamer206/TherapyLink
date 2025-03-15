import { ComponentFixture, TestBed } from '@angular/core/testing';

import { LifeCoachComponent } from './life-coach.component';

describe('LifeCoachComponent', () => {
  let component: LifeCoachComponent;
  let fixture: ComponentFixture<LifeCoachComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [LifeCoachComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(LifeCoachComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
