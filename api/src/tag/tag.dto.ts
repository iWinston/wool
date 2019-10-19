import { ApiModelProperty } from '@nestjs/swagger';
import {
  IsArray,
  ArrayNotEmpty,
  ArrayUnique,
  IsInt,
  IsPositive,
  IsString,
  IsNotEmpty,
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

export class TagDto {
  @ApiModelProperty({
    example: '官方',
  })
  @IsString()
  @IsNotEmpty()
  name: string;
}
