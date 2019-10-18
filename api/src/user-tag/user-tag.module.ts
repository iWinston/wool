import { Module } from '@nestjs/common';
import { UserTagController } from './user-tag.controller';
import { UserTagService } from './user-tag.service';
import { UserModule } from '@src/user/user.module';
import { TagModule } from '@src/tag/tag.module';

@Module({
  imports: [UserModule, TagModule],
  controllers: [UserTagController],
  providers: [UserTagService],
  exports: [UserTagService],
})
export class UserTagModule {}
