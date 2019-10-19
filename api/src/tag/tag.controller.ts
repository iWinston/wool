import { Controller, Get, Post, Param, Body } from '@nestjs/common';
import { ApiBearerAuth, ApiUseTags, ApiOperation } from '@nestjs/swagger';
import { TagService } from './tag.service';
import { TagDto } from './tag.dto';

@ApiBearerAuth()
@ApiUseTags('标签')
@Controller('tag')
export class TagController {
  constructor(readonly tagService: TagService) {}

  @ApiOperation({ title: '获取标签列表' })
  @Get()
  findAll() {
    return this.tagService.findAll();
  }

  @ApiOperation({ title: '添加标签' })
  @Post()
  create(@Body() dto: TagDto) {
    return this.tagService.create(dto);
  }
}
