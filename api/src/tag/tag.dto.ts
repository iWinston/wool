import { ApiModelProperty } from '@nestjs/swagger';
import {
  IsArray,
  ArrayNotEmpty,
  ArrayUnique,
  IsInt,
  IsPositive,
} from 'class-validator';

export class TagIdsDto {
  @ApiModelProperty({
    example: [1, 2],
  })
  @IsArray()
  @ArrayNotEmpty()
  @ArrayUnique()
  @IsInt({ each: true })
  @IsPositive({ each: true })
  tagIds: number[];
}
