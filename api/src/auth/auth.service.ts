import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from '@src/user/user.entity';
import { Repository } from 'typeorm';
import redis from '@plugin/redis/redis';
import { UserService } from '@src/user/user.service';

@Injectable()
export class AuthService {
  private readonly redisClient;
  constructor(
    @InjectRepository(User) readonly repo: Repository<User>,
    readonly userService: UserService,
  ) {
    this.redisClient = redis.createClient();
  }

  async validateUser(phone: string, code: string): Promise<User> {
    const user = await this.userService.findOneByPhone(phone);
    if (user && code === '8888') {
      return user;
    }
    return null;
  }

  getUserInfo() {}

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
