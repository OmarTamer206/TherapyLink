import { TestBed } from '@angular/core/testing';

import { EmergencySocketService } from './emergency-socket.service';

describe('EmergencySocketService', () => {
  let service: EmergencySocketService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(EmergencySocketService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
