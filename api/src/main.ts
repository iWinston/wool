import './alias';
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';
import { ConfigService } from 'nestjs-config';
import { ValidationPipe } from '@nestjs/common';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.setGlobalPrefix('api');

  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: false, // 不使用装饰器进行限制的属性不允许通过
      transform: true,
      skipMissingProperties: false, // 不允许跳过已定义且不为optional的属性
      forbidUnknownValues: true, // 未定义的属性不允许通过
    }),
  );

  const config = app.get(ConfigService);
  const options = new DocumentBuilder()
    .setTitle('Wool Api Doc')
    .setDescription('The Wool API description')
    .setBasePath('/api')
    .setSchemes(config.get('app.secure') ? 'https' : 'http')
    .addBearerAuth()
    .build();
  const document = SwaggerModule.createDocument(app, options);
  SwaggerModule.setup('docs', app, document, {
    explorer: true,
    customSiteTitle: '小马哥api文档',
    swaggerOptions: {
      validatorUrl: null,
    },
    customCss: `.swagger-ui .topbar { display: none }
    .information-container{display: none} *{font-size: 13px !important}
    .parameter__name,.parameter__type,.parameter__deprecated,.parameter__in {display: inline-block; padding:0 5px}
    .swagger-ui .execute-wrapper { padding: 10px }`,
  });

  await app.listen(config.get('app.port'));
}
bootstrap();
