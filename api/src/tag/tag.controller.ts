import { Controller, Post, Body, Get } from '@nestjs/common';
import { ApiBearerAuth, ApiUseTags, ApiOperation } from '@nestjs/swagger';
import { TagIdsDto } from './tag.dto';
import { userParam } from '@common/decorator/user.decorator';
import { TagService } from './tag.service';

@ApiBearerAuth()
@ApiUseTags('标签')
@Controller('tag')
export class TagController {
  constructor(readonly tagService: TagService) {}

  @ApiOperation({ title: '获取标签列表' })
  @Get()
  findAll(@userParam('id') userId: number) {
    return this.tagService.findAll(userId);
  }
}
