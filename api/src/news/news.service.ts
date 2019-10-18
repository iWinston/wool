import { Injectable } from '@nestjs/common';
import { NewsDto } from './news.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { News } from './news.entity';
import { Repository } from 'typeorm';
import { TagService } from '@src/tag/tag.service';

@Injectable()
export class NewsService {
  constructor(
    @InjectRepository(News) readonly repo: Repository<News>,
    readonly tagService: TagService,
  ) {}

  async create(userId: number, dto: NewsDto) {
    const tags = await this.tagService.repo.findByIds(dto.tagIds);
    return await this.repo.save({
      userId,
      tags,
      content: dto.content,
      location: dto.location,
      photoPath: dto.photoPath,
    });
  }
}
