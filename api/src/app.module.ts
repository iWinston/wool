import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { ConfigModule } from 'nestjs-config';
import { AppService } from './app.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import * as path from 'path';
import * as DatabaseConfig from '@config/database';

@Module({
  imports: [
    TypeOrmModule.forRoot(DatabaseConfig.default as any),
    ConfigModule.load(
      path.resolve(__dirname, '../config', '**/!(*.d).{ts,js}'),
    ),
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
