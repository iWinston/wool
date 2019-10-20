import { Injectable } from '@nestjs/common';
import { InjectConfig, ConfigService } from 'nestjs-config';
import { JPushAsync } from 'jpush-async';
import { News } from '@src/news/news.entity';
import { User } from '@src/user/user.entity';
import { UserService } from '@src/user/user.service';
import { Not } from 'typeorm';

@Injectable()
export class PushService {
  constructor(
    @InjectConfig() readonly config: ConfigService,
    readonly userService: UserService,
  ) {}
  async push(news: News) {
    const summary = news.content;
    const title = '有一条新鲜羊毛等你来薅';
    const users: User[] = await this.userService.repo
      .createQueryBuilder('it')
      .leftJoin('it.tags', 'tag')
      .where('it.id != :userId', { userId: news.userId })
      // .andWhere('tag.id = :tagId', { tagId: news.tags[0].id })
      .getMany();
    const jPushTags = users.map(user => user.phone);

    const JPushKey = this.config.get('jpush.JPushKey');
    const JPushSecret = this.config.get('jpush.JPushSecret');
    const client = JPushAsync.buildClient(JPushKey, JPushSecret);
    client
      .push()
      .setPlatform(JPushAsync.ALL)
      .setAudience(JPushAsync.tag(jPushTags.join(',')))
      .setNotification(
        'Hi, JPush',
        JPushAsync.ios(summary, title),
        JPushAsync.android(summary, title, 1),
      )
      .send()
      .then(result => {
        console.log(result);
      })
      .catch(err => {
        console.log(err);
      });
  }
}
