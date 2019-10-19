import { Test, TestingModule } from '@nestjs/testing';
import { UserTagService } from '../../user-tag/user-tag.service';

describe('UserTagService', () => {
  let service: UserTagService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [UserTagService],
    }).compile();

    service = module.get<UserTagService>(UserTagService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
