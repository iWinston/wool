import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from './user.entity';
import { Repository } from 'typeorm';

@Injectable()
export class UserService {
  constructor(@InjectRepository(User) readonly repo: Repository<User>) {}

  async findOneByPhone(phone: string): Promise<User | undefined> {
    return this.repo.findOne({ phone });
  }
}
