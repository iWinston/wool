import { Module, NestModule, MiddlewareConsumer } from '@nestjs/common';
import { AppController } from './app.controller';
import { ConfigModule, InjectConfig, ConfigService } from 'nestjs-config';
import { AppService } from './app.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AuthModule } from './auth/auth.module';
import { UserModule } from './user/user.module';
import * as path from 'path';
import * as DatabaseConfig from '@config/database';
import { AuthMiddleware } from './auth/auth.middleware';
import { NewsModule } from './news/news.module';
import { TagModule } from './tag/tag.module';
import { globalInterceptorProvider } from '@common/provider/interceptor.provider';
import { ServeStaticMiddleware } from '@nest-middlewares/serve-static';
import { DiskStorageModule } from '@common/module/disk-storage.module';

@Module({
  imports: [
    TypeOrmModule.forRoot(DatabaseConfig.default as any),
    ConfigModule.load(
      path.resolve(__dirname, '../config', '**/!(*.d).{ts,js}'),
    ),
    AuthModule,
    UserModule,
    NewsModule,
    TagModule,
    DiskStorageModule,
  ],
  controllers: [AppController],
  providers: [AppService, ...globalInterceptorProvider],
})
export class AppModule implements NestModule {
  constructor(@InjectConfig() readonly config: ConfigService) {}
  public configure(consumer: MiddlewareConsumer): void {
    // IMPORTANT! Call Middleware.configure BEFORE using it for routes
    ServeStaticMiddleware.configure(this.config.get('app.multerDest'));
    consumer.apply(AuthMiddleware, ServeStaticMiddleware).forRoutes('/');
  }
}
