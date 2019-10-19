import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Tag } from './tag.entity';
import { User } from '@src/user/user.entity';

@Injectable()
export class TagService {
  constructor(@InjectRepository(Tag) readonly repo: Repository<Tag>) {}

  async findAll(userId: number) {
    const userTags: Tag[] = await this.repo
      .createQueryBuilder('it')
      .leftJoin('it.users', 'user')
      .where('user.id = :userId', { userId })
      .getMany();
    const tags: Tag[] = await this.repo.find();
    for (const tag of tags) {
      if (!userTags.some(userTag => userTag.id === tag.id)) {
        userTags.push(tag);
      }
    }
    return userTags;
  }
}
