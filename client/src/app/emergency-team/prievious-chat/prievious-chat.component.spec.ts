import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PrieviousChatComponent } from './prievious-chat.component';

describe('PrieviousChatComponent', () => {
  let component: PrieviousChatComponent;
  let fixture: ComponentFixture<PrieviousChatComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [PrieviousChatComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(PrieviousChatComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
