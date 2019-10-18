import { Controller, Post, UseGuards, Param, Body } from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthGuard } from '@nestjs/passport';
import { AuthDto } from './auth.dto';
import { userParam } from '@common/decorator/user.decorator';
import { User } from '@src/user/user.entity';
import { ApiBearerAuth, ApiOperation, ApiUseTags } from '@nestjs/swagger';

@ApiBearerAuth()
@ApiUseTags('认证')
@Controller('auth')
export class AuthController {
  constructor(readonly authService: AuthService) {}

  @ApiOperation({ title: '登录/注册' })
  @UseGuards(AuthGuard('local'))
  @Post()
  loginOrRegister(@Body() authDto: AuthDto, @userParam() user: User) {
    return user;
  }
}
