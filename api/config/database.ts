import { envNumber, env, envBoolean } from '../common/helper/env-unit';
import { TypeOrmModuleOptions } from '@nestjs/typeorm';
import { MysqlConnectionOptions } from 'typeorm/driver/mysql/MysqlConnectionOptions';

export default {
  type: 'mysql',
  host: env('DB_HOST', '127.0.0.1'),
  port: envNumber('DB_PORT', 3306),
  database: env('DB_NAME', 'wool'),
  username: env('DB_USERNAME', 'root'),
  password: env('DB_PASSWORD', '123456'),
  synchronize: envBoolean('DB_SYNC', false),
  entities: ['dist/**/**.entity{.ts,.js}'],
};
