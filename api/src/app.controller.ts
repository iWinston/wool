import { Controller, Get } from '@nestjs/common';
import { AppService } from './app.service';
import { ApiBearerAuth } from '@nestjs/swagger';

@ApiBearerAuth()
@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}
  @Get('open')
  root() {
    const faker = require('faker');
    // faker.locale = 'zh_CN'; // 默认英文
    return faker.fake('{{name.findName}}');
  }
}
