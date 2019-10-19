import { Injectable, Inject, forwardRef } from '@nestjs/common';
import { User } from '@src/user/user.entity';
import { UserService } from '@src/user/user.service';
import { TagService } from '@src/tag/tag.service';

@Injectable()
export class UserTagService {
  constructor(
    @Inject(forwardRef(() => UserService))
    readonly userService: UserService,
    readonly tagService: TagService,
  ) {}

  async bindTagsToUser(user: User, tagIds: number[]) {
    const tags = await this.tagService.repo.findByIds(tagIds);
    user.tags = tags;
    return this.userService.repo.save(user);
  }
}
