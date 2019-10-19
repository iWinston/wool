import { Injectable } from '@nestjs/common';
import { InjectConfig, ConfigService } from 'nestjs-config';
import { JPushAsync } from 'jpush-async';

@Injectable()
export class PushService {
  constructor(@InjectConfig() readonly config: ConfigService) {}
  push(summary: string, title: string) {
    const JPushKey = this.config.get('jpush.JPushKey');
    const JPushSecret = this.config.get('jpush.JPushSecret');
    const client = JPushAsync.buildClient(JPushKey, JPushSecret);
    client
      .push()
      .setPlatform(JPushAsync.ALL)
      .setAudience(JPushAsync.ALL)
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
