import { Injectable } from '@nestjs/common';
import { NewsDto } from './news.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { News } from './news.entity';
import { Repository } from 'typeorm';
import { TagService } from '@src/tag/tag.service';
import { PaginateDto } from '@common/dto/paginate.dto';

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

  async delete(newsId: number) {
    return await this.repo.softDelete(newsId);
  }

  async findAll(paginateDto: PaginateDto) {
    return await this.repo.findAndCount({
      current: paginateDto.current,
      size: paginateDto.size,
    });
  }

  async findByTag(tagId: number, paginateDto: PaginateDto) {
    return await this.repo
      .createQueryBuilder('it')
      .leftJoin('it.tags', 'tag')
      .leftJoinAndSelect('it.user', 'user')
      .where('tag.id = :tagId', { tagId })
      .paginate(paginateDto.current, paginateDto.size)
      .getMany();
  }
}
