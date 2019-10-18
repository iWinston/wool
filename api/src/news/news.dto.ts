import { ApiModelProperty } from '@nestjs/swagger';
import {
  IsString,
  IsNotEmpty,
  MaxLength,
  IsArray,
  IsInt,
  IsPositive,
  ArrayNotEmpty,
  ArrayUnique,
} from 'class-validator';

export class NewsDto {
  @ApiModelProperty({
    example: '帖子内容',
  })
  @IsString()
  @IsNotEmpty()
  @MaxLength(500)
  content: string;

  @ApiModelProperty({
    description: '照片路径',
    example: 'example.jpg',
  })
  @IsString()
  @IsNotEmpty()
  photoPath: string;

  @ApiModelProperty({
    example: '深圳市南山区',
  })
  @IsString()
  @IsNotEmpty()
  location: string;

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
