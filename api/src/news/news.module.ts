import { Module } from '@nestjs/common';
import { NewsController } from './news.controller';
import { NewsService } from './news.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { News } from './news.entity';
import { TagModule } from '@src/tag/tag.module';
import { UserModule } from '@src/user/user.module';
import { PushModule } from '@src/push/push.module';

@Module({
  imports: [
    TypeOrmModule.forFeature([News]),
    TagModule,
    UserModule,
    PushModule,
  ],
  controllers: [NewsController],
  providers: [NewsService],
})
export class NewsModule {}
