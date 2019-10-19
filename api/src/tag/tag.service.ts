import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Tag } from './tag.entity';
import { User } from '@src/user/user.entity';

@Injectable()
export class TagService {
  constructor(@InjectRepository(Tag) readonly repo: Repository<Tag>) {}
}