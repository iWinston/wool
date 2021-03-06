import { envNumber, env, envBoolean } from '@common/helper/env-unit';
import * as path from 'path';
export default {
  schema: 'http',
  host: env('APP_HOST', '127.0.0.1'), // 用于生成链接
  port: envNumber('APP_PORT', 3007),
  multerDest: path.resolve(process.cwd(), env('APP_DEST', 'upload')),
  get baseUrl() {
    return `${this.schema}://${this.host}`;
  },
  get storageUrl() {
    return `${this.baseUrl}/${env('APP_DEST', 'upload')}`;
  },
};
