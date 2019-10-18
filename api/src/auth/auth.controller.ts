import { Controller, Post, UseGuards } from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthGuard } from '@nestjs/passport';

@Controller('auth')
export class AuthController {
  constructor(readonly authService: AuthService) {}

  @UseGuards(AuthGuard('local'))
  @Post()
  loginOrRegister() {
    return;
  }
}
