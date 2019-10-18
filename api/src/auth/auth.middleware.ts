import { Request, Response } from 'express';

import {
  Injectable,
  NestMiddleware,
  UnauthorizedException,
} from '@nestjs/common';

import { AuthService } from './auth.service';

@Injectable()
export class AuthMiddleware implements NestMiddleware {
  constructor(private readonly authService: AuthService) {}

  public async use(req, res, next) {
    let token = req.query.token || req.body.token || req.headers.authorization;
    // token获取顺序：1.query  2.body 3.header 4.cookie
    if (!token) {
      const cookies = req.headers.cookie;
      const cookieArray = {} as any;
      if (cookies) {
        cookies.split(';').map(item => {
          const kv = item.split('=');
          cookieArray[kv[0]] = kv[1];
        });
      }
      if (cookieArray.token) {
        token = cookieArray.token;
      }
    }

    req.user = await this.authService.getUserByToken(token);
    // 认证接口和开放接口不需要认证
    if (['/auth', '/open'].find(path => req.path.includes(path))) {
      next();
    } else {
      if (!req.user) {
        throw new UnauthorizedException('登录失效，请重新登录');
      }
      next();
    }
  }
}
