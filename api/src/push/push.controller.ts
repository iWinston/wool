import { Controller, Get } from '@nestjs/common';
import { ApiOperation, ApiBearerAuth } from '@nestjs/swagger';
import { PushService } from './push.service';

@ApiBearerAuth()
@Controller('push')
export class PushController {
  constructor(readonly pushService: PushService) {}

  @ApiOperation({ title: '测试推送' })
  @Get()
  push() {
    // return this.pushService.push();
  }
}
