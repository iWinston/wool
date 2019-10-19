import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Tag } from './tag.entity';
import { TagDto } from './tag.dto';

@Injectable()
export class TagService {
  constructor(@InjectRepository(Tag) readonly repo: Repository<Tag>) {}

  async findAll() {
    return await this.repo.find();
  }
  async create(dto: TagDto) {
    return await this.repo.save(dto);
  }
}
