import { Module } from '@nestjs/common';
import { UserService } from './user.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { User } from './user.entity';
import { UserController } from './user.controller';
import { UserTagController } from './tag/user-tag.controller';
import { UserTagService } from './tag/user-tag.service';
import { TagModule } from '@src/tag/tag.module';

@Module({
  imports: [TypeOrmModule.forFeature([User]), TagModule],
  providers: [UserService, UserTagService],
  exports: [UserService],
  controllers: [UserController, UserTagController],
})
export class UserModule {}
