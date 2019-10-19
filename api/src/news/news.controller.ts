import {
  Controller,
  Post,
  Body,
  Param,
  ParseIntPipe,
  Delete,
  Get,
  Query,
  UseInterceptors,
  UploadedFile,
} from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import {
  ApiBearerAuth,
  ApiUseTags,
  ApiOperation,
  ApiImplicitFile,
} from '@nestjs/swagger';
import { NewsService } from './news.service';
import { NewsDto } from './news.dto';
import { userParam } from '@common/decorator/user.decorator';
import { PaginateDto } from '@common/dto/paginate.dto';
import { AddPointInterceptor } from '@common/interceptor/add-point.interceptor';
import { InjectConfig, ConfigService } from 'nestjs-config';

@ApiBearerAuth()
@ApiUseTags('羊毛帖')
@Controller('news')
export class NewsController {
  constructor(
    readonly newsService: NewsService,
    @InjectConfig() readonly config: ConfigService,
  ) {}

  @ApiOperation({ title: '发帖' })
  @Post()
  @UseInterceptors(AddPointInterceptor)
  create(@Body() dto: NewsDto, @userParam('id') userId: number) {
    return this.newsService.create(userId, dto);
  }

  @ApiOperation({ title: '删帖' })
  @Delete(':id')
  delete(@Param('id', new ParseIntPipe()) id: number) {
    return this.newsService.delete(id);
  }

  @ApiOperation({ title: '贴子列表' })
  @Get()
  findAll(@Query() paginateDto: PaginateDto) {
    return this.newsService.findAll(paginateDto);
  }

  @ApiOperation({ title: '根据标签获取贴子列表' })
  @Get('tag/:tagId')
  findByTag(
    @Param('tagId', new ParseIntPipe()) tagId: number,
    @Query() paginateDto: PaginateDto,
  ) {
    return this.newsService.findByTag(tagId, paginateDto);
  }

  @ApiOperation({ title: '添加照片' })
  @ApiImplicitFile({ name: 'file' })
  @UseInterceptors(FileInterceptor('file'))
  @Post('upload')
  upload(@UploadedFile() file) {
    return `${this.config.get('app.storageUrl')}/${file.filename}`;
  }
}
