import { Global, Module } from '@nestjs/common';
import { ConfigModule, ConfigService } from 'nestjs-config';
import { diskStorage } from 'multer';
import { MulterModule } from '@nestjs/platform-express';

async function storageFactory(configService: ConfigService) {
  const storage = diskStorage({
    destination(req, file, cb) {
      cb(null, configService.get('app.multerDest'));
    },
    filename(req, file, cb) {
      const nameArr = file.originalname.split('.');
      const ext = nameArr[nameArr.length - 1];
      cb(null, Date.now() + '.' + ext);
    },
  });
  return {
    storage,
  };
}

@Global()
@Module({
  imports: [
    MulterModule.registerAsync({
      imports: [ConfigModule],
      useFactory: storageFactory,
      inject: [ConfigService],
    }),
  ],
  exports: [
    MulterModule.registerAsync({
      imports: [ConfigModule],
      useFactory: storageFactory,
      inject: [ConfigService],
    }),
  ],
})
export class DiskStorageModule {}
