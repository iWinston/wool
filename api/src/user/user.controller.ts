import { Controller, Patch, Body } from '@nestjs/common';
import { ApiBearerAuth, ApiUseTags, ApiOperation } from '@nestjs/swagger';
import { UserService } from './user.service';
import { userParam } from '@common/decorator/user.decorator';
import { User } from './user.entity';
import { UserProfileDto } from './user-profile.dto';

@ApiBearerAuth()
@ApiUseTags('用户')
@Controller('user')
export class UserController {
  constructor(readonly userService: UserService) {}
  @ApiOperation({ title: '修改用户信息' })
  @Patch()
  patch(@userParam() user: User, @Body() dto: UserProfileDto) {
    return this.userService.patch(user, dto);
  }
}
