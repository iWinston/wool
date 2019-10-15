import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { ConfigModule } from 'nestjs-config';
import { AppService } from './app.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import * as path from 'path';
import { DataBaseConfig } from '../config/database';
console.log(DataBaseConfig);
@Module({
  imports: [
    TypeOrmModule.forRoot(DataBaseConfig),
    ConfigModule.load(
      path.resolve(__dirname, '../config', '**/!(*.d).{ts,js}'),
    ),
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
