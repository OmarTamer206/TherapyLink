import { ComponentFixture, TestBed } from '@angular/core/testing';

import { OldChatMobileComponent } from './old-chat-mobile.component';

describe('OldChatMobileComponent', () => {
  let component: OldChatMobileComponent;
  let fixture: ComponentFixture<OldChatMobileComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [OldChatMobileComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(OldChatMobileComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
