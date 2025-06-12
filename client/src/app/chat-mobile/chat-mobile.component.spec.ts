import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ChatMobileComponent } from './chat-mobile.component';

describe('ChatMobileComponent', () => {
  let component: ChatMobileComponent;
  let fixture: ComponentFixture<ChatMobileComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ChatMobileComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ChatMobileComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
