import { Strategy } from 'passport-local';
import { PassportStrategy } from '@nestjs/passport';
import { Injectable, UnauthorizedException } from '@nestjs/common';
import { AuthService } from './auth.service';

@Injectable()
export class LocalStrategy extends PassportStrategy(Strategy) {
  constructor(private readonly authService: AuthService) {
    super({
      usernameField: 'phone',
      passwordField: 'code',
    });
  }

  async validate(phone: string, code: string): Promise<any> {
    const user = await this.authService.validateUser(phone, code);
    if (!user) {
      throw new UnauthorizedException();
    }
    return user;
  }
}
