import { ComponentFixture, TestBed } from '@angular/core/testing';

import { SessionsLogComponent } from './sessions-log.component';

describe('SessionsLogComponent', () => {
  let component: SessionsLogComponent;
  let fixture: ComponentFixture<SessionsLogComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [SessionsLogComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(SessionsLogComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
