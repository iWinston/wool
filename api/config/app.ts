import { envNumber, env, envBoolean } from '@common/helper/env-unit';

export default {
  host: env('APP_HOST', '127.0.0.1'), // 用于生成链接
  port: envNumber('APP_PORT', 3007),
};
