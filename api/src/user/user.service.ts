import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from './user.entity';
import { Repository } from 'typeorm';
import { UserProfileDto } from './user-profile.dto';
import { UserTagService } from '@src/user-tag/user-tag.service';

@Injectable()
export class UserService {
  constructor(
    @InjectRepository(User) readonly repo: Repository<User>,
    readonly userTagService: UserTagService,
  ) {}

  async findOneByPhone(phone: string): Promise<User | undefined> {
    return this.repo.findOne({ phone });
  }

  async register(phone: string) {
    return this.repo.save({ phone });
  }

  async patch(user: User, dto: UserProfileDto) {
    user.name = dto.name;
    return this.userTagService.bindTagsToUser(user, dto.tagIds);
  }
}
