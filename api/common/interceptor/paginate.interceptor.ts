import { RespOk } from '@common/helper/http-response';
import {
  CallHandler,
  ExecutionContext,
  Injectable,
  NestInterceptor,
} from '@nestjs/common';
import { Request } from 'express';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';

@Injectable()
export class PaginateInterceptor implements NestInterceptor {
  public intercept(
    context: ExecutionContext,
    next: CallHandler,
  ): Observable<any> {
    return next.handle().pipe(
      // 规定返回的数据格式必须为[分页列表，总条数]
      map((data: [any[], number]) => {
        const req: Request = context.switchToHttp().getRequest();
        const query = req.query;
        // 判断是否一个分页请求
        const isPaginateRequest =
          req.method === 'GET' && query.current && query.size;
        // 判断data是否符合格式
        const isValidData =
          Array.isArray(data) && data.length === 2 && Array.isArray(data[0]);

        if (isValidData && isPaginateRequest) {
          const [list, total] = data;
          return new RespOk(list, {
            total,
            size: parseInt(query.size, 10),
            current: parseInt(query.current, 10),
          });
        }
        return data;
      }),
    );
  }
}
