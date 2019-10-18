import { Controller, Post, Body } from '@nestjs/common';
import { ApiBearerAuth, ApiUseTags } from '@nestjs/swagger';
import { NewsService } from './news.service';
import { NewsDto } from './news.dto';
import { userParam } from '@common/decorator/user.decorator';
import { User } from '@src/user/user.entity';

@ApiBearerAuth()
@ApiUseTags('羊毛帖')
@Controller('news')
export class NewsController {
  constructor(readonly newsService: NewsService) {}
  @Post()
  create(@Body() dto: NewsDto, @userParam('id') userId: number) {
    return this.newsService.create(userId, dto);
  }
}
