import { Test, TestingModule } from '@nestjs/testing';
import { UserTagController } from '../../user-tag/user-tag.controller';

describe('UserTag Controller', () => {
  let controller: UserTagController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [UserTagController],
    }).compile();

    controller = module.get<UserTagController>(UserTagController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
