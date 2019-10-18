import { Controller, Post, Body } from '@nestjs/common';
import { ApiBearerAuth, ApiUseTags, ApiOperation } from '@nestjs/swagger';
import { TagIdsDto } from '@src/tag/tag.dto';
import { User } from '@src/user/user.entity';
import { userParam } from '@common/decorator/user.decorator';
import { UserTagService } from './user-tag.service';

@ApiBearerAuth()
@ApiUseTags('用户标签')
@Controller('user-tag')
export class UserTagController {
  constructor(readonly userTagService: UserTagService) {}
  @ApiOperation({ title: '给用户打标签' })
  @Post()
  bindTagsToUser(@Body() dto: TagIdsDto, @userParam() user: User) {
    return this.userTagService.bindTagsToUser(user, dto.tagIds);
  }
}
