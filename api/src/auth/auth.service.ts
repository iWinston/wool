import { Injectable } from '@nestjs/common';
import * as uuid from 'uuid';
import { User } from '@src/user/user.entity';
import { Repository } from 'typeorm';
import redis from '@plugin/redis/redis';
import { UserService } from '@src/user/user.service';

@Injectable()
export class AuthService {
  private readonly redisClient;
  constructor(readonly userService: UserService) {
    this.redisClient = redis.createClient();
  }

  async getLoginInfo(user: User) {
    const tokenInfo = await this.genToken(user.id);
    return Object.assign({}, user, tokenInfo);
  }

  async validateOrRegisterUser(phone: string, code: string): Promise<User> {
    const user = await this.userService.findOneByPhone(phone);
    if (user && code === '8888') {
      return user;
    }
    if (!user) {
      return await this.userService.register(phone);
    }
    return null;
  }

  async genToken(userId: number): Promise<any> {
    const token = uuid();
    const now = new Date().getTime();
    const ttl = 60 * 60 * 24 * 10; // 10天
    const expired = now + ttl * 1000;
    await this.redisClient.set(token, JSON.stringify({ userId }), 'EX', ttl);
    return {
      token,
      expired,
    };
  }

  async getUserByToken(token) {
    if (!token) {
      return null;
    }
    const info = await this.redisClient.getAsync(token);
    if (!info) {
      return null;
    }
    const { userId } = JSON.parse(info);
    return await this.userService.repo.findOne({ id: userId });
  }
}
