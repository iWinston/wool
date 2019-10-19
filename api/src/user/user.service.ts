import { Injectable, forwardRef, Inject } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from './user.entity';
import { Repository } from 'typeorm';
import { UserProfileDto } from './user-profile.dto';
import { UserTagService } from './tag/user-tag.service';
import * as faker from 'faker';
import { InjectConfig, ConfigService } from 'nestjs-config';

@Injectable()
export class UserService {
  constructor(
    @InjectRepository(User) readonly repo: Repository<User>,
    @Inject(forwardRef(() => UserTagService))
    readonly userTagService: UserTagService,
    @InjectConfig() readonly config: ConfigService,
  ) {}

  async findOneByPhone(phone: string): Promise<User | undefined> {
    return this.repo.findOne({ phone });
  }

  async getOne(userId: number) {
    return await this.repo.findOneOrFail({
      where: {
        id: userId,
      },
      relations: ['tags'],
    });
  }

  async register(phone: string) {
    const name = this.genName(phone);
    const avatorPath = this.genAvatorPath(name);
    return this.repo.save({ phone, name, avatorPath });
  }

  async patch(user: User, dto: UserProfileDto) {
    user.name = dto.name;
    return this.userTagService.bindTagsToUser(user, dto.tagIds);
  }

  async updatePoint(user: User, num: number) {
    user.point += num;
    return await this.repo.save(user);
  }

  genName(phone: string) {
    if (phone === '18719139474') {
      return '喜羊羊';
    }
    return faker.fake('{{name.findName}}');
  }

  genAvatorPath(name: string) {
    const letter = name === '喜羊羊小队' ? 'X' : name.slice(0, 1);
    return `${this.config.get(
      'app.baseUrl',
    )}/assert/default-avator/${letter}.png`;
  }
}
