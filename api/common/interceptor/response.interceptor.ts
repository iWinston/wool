import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';
import { InsertResult, UpdateResult } from 'typeorm';

import { RespFail, RespOk } from '@common/helper/http-response';
import {
  CallHandler,
  ExecutionContext,
  Injectable,
  NestInterceptor,
  NotFoundException,
} from '@nestjs/common';

@Injectable()
export class ResponseInterceptor implements NestInterceptor {
  public intercept(
    context: ExecutionContext,
    next: CallHandler,
  ): Observable<any> {
    return next.handle().pipe(
      map(data => {
        if (data instanceof UpdateResult) {
          if (data.raw.affectedRows === 0) {
            throw new NotFoundException();
          }
          return new RespOk('修改成功');
        }
        if (data instanceof InsertResult) {
          if (data.raw.affectedRows === 0) {
            throw new NotFoundException();
          }
          return new RespOk('创建成功');
        }
        if (data instanceof RespFail || data instanceof RespOk) {
          return data;
        }

        return new RespOk(data);
      }),
    );
  }
}
