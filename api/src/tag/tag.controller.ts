import { Controller, Post, Body } from '@nestjs/common';
import { ApiBearerAuth, ApiUseTags, ApiOperation } from '@nestjs/swagger';
import { TagIdsDto } from './tag.dto';
import { userParam } from '@common/decorator/user.decorator';
import { User } from '@src/user/user.entity';
import { TagService } from './tag.service';

@ApiBearerAuth()
@ApiUseTags('标签')
@Controller('tag')
export class TagController {
  constructor(readonly tagService: TagService) {}
}
