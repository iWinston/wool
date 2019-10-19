import { IsPositive, IsInt } from 'class-validator';
import { ApiModelProperty } from '@nestjs/swagger';

export class PointDto {
  @ApiModelProperty({ example: 1 })
  @IsPositive()
  @IsInt()
  point: number;
}
