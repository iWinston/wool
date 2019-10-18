import { ApiModelProperty } from '@nestjs/swagger';
import { Max, IsInt, IsPositive } from 'class-validator';
import { Transform } from 'class-transformer';

export class PaginateDto {
  @ApiModelProperty({
    required: false,
    example: 10,
    description: '每页行数',
    maximum: 30,
  })
  @Max(30)
  @IsInt()
  @IsPositive()
  @Transform(value => parseInt(value, 10))
  public readonly size?: number;

  @ApiModelProperty({ required: false, example: 1, description: '页码' })
  @IsInt()
  @IsPositive()
  @Transform(value => parseInt(value, 10))
  public readonly current?: number;
}
