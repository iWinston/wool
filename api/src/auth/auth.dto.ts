import { IsMobilePhone, IsNumber, IsString, Length } from 'class-validator';

import { ApiModelProperty } from '@nestjs/swagger';

export class AuthDto {
  @ApiModelProperty({
    example: '18719139474',
    description: '手机号码',
  })
  @IsMobilePhone('zh-CN')
  phone: string;

  @ApiModelProperty({
    example: '8888',
    description: '验证码',
  })
  @Length(4, 4)
  @IsString()
  code: string;
}
