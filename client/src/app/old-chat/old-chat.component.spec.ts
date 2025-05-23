import { ComponentFixture, TestBed } from '@angular/core/testing';

import { OldChatComponent } from './old-chat.component';

describe('OldChatComponent', () => {
  let component: OldChatComponent;
  let fixture: ComponentFixture<OldChatComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [OldChatComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(OldChatComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
