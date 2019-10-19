import { APP_INTERCEPTOR } from '@nestjs/core';

import { PaginateInterceptor } from '@common/interceptor/paginate.interceptor';
import { ResponseInterceptor } from '../interceptor/response.interceptor';

export const globalInterceptorProvider = [
  {
    provide: APP_INTERCEPTOR,
    useFactory: () => {
      return new ResponseInterceptor();
    },
  },
  {
    provide: APP_INTERCEPTOR,
    useFactory: () => {
      return new PaginateInterceptor();
    },
  },
];
