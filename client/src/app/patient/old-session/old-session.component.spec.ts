import { ComponentFixture, TestBed } from '@angular/core/testing';

import { OldSessionComponent } from './old-session.component';

describe('OldSessionComponent', () => {
  let component: OldSessionComponent;
  let fixture: ComponentFixture<OldSessionComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [OldSessionComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(OldSessionComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
