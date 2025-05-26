import { ComponentFixture, TestBed } from '@angular/core/testing';

import { SessionEndedComponent } from './session-ended.component';

describe('SessionEndedComponent', () => {
  let component: SessionEndedComponent;
  let fixture: ComponentFixture<SessionEndedComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [SessionEndedComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(SessionEndedComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
