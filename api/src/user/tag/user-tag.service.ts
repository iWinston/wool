import { Injectable, Inject, forwardRef } from '@nestjs/common';
import { User } from '@src/user/user.entity';
import { UserService } from '@src/user/user.service';
import { TagService } from '@src/tag/tag.service';
import { Tag } from '@src/tag/tag.entity';

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

  async getUserWithTags(user: User) {
    return await this.userService.repo.findOneOrFail({
      where: {
        id: user.id,
      },
      relations: ['tags'],
    });
  }

  async getTags(user: User) {
    user = await this.getUserWithTags(user);
    const userTags = user.tags;
    const tags: Tag[] = await this.tagService.repo.find();
    for (const tag of tags) {
      if (!userTags.some(userTag => userTag.id === tag.id)) {
        userTags.push(tag);
      }
    }
    return userTags;
  }
}
