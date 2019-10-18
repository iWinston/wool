import { ApiModelProperty } from '@nestjs/swagger';
import {
  IsString,
  IsNotEmpty,
  IsArray,
  ArrayNotEmpty,
  ArrayUnique,
  IsInt,
  IsPositive,
} from 'class-validator';

export class UserProfileDto {
  @ApiModelProperty({ example: 'Winston' })
  @IsString()
  @IsNotEmpty()
  name: string;

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
