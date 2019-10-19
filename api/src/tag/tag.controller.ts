import { Controller, Get } from '@nestjs/common';
import { ApiBearerAuth, ApiUseTags, ApiOperation } from '@nestjs/swagger';
import { TagService } from './tag.service';

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
}
