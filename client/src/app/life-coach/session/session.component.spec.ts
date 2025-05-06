import { ComponentFixture, TestBed } from '@angular/core/testing';

import { lifeSessionComponent } from './session.component';

describe('SessionComponent', () => {
  let component: lifeSessionComponent;
  let fixture: ComponentFixture<lifeSessionComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [lifeSessionComponent],
    }).compileComponents();

    fixture = TestBed.createComponent(lifeSessionComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
