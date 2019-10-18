import {
  Controller,
  Post,
  Body,
  Param,
  ParseIntPipe,
  Delete,
  Get,
  Query,
} from '@nestjs/common';
import { ApiBearerAuth, ApiUseTags, ApiOperation } from '@nestjs/swagger';
import { NewsService } from './news.service';
import { NewsDto } from './news.dto';
import { userParam } from '@common/decorator/user.decorator';
import { PaginateDto } from '@common/dto/paginate.dto';

@ApiBearerAuth()
@ApiUseTags('羊毛帖')
@Controller('news')
export class NewsController {
  constructor(readonly newsService: NewsService) {}

  @ApiOperation({ title: '发帖' })
  @Post()
  create(@Body() dto: NewsDto, @userParam('id') userId: number) {
    return this.newsService.create(userId, dto);
  }

  @ApiOperation({ title: '删帖' })
  @Delete(':id')
  delete(@Param('id', new ParseIntPipe()) id: number) {
    return this.newsService.delete(id);
  }

  @ApiOperation({ title: '贴子列表' })
  @Get()
  findAll() {
    return this.newsService.findAll();
  }

  @ApiOperation({ title: '根据标签获取贴子列表' })
  @Get('tag/:tagId')
  findByTag(
    @Param('tagId', new ParseIntPipe()) tagId: number,
    @Query() paginateDto: PaginateDto,
  ) {
    return this.newsService.findByTag(tagId, paginateDto);
  }
}
