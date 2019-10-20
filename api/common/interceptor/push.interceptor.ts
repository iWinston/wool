import {
  Injectable,
  NestInterceptor,
  ExecutionContext,
  CallHandler,
} from '@nestjs/common';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';
import { News } from '@src/news/news.entity';
import { PushService } from '@src/push/push.service';

@Injectable()
export class PushInterceptor implements NestInterceptor {
  constructor(readonly pushService: PushService) {}
  intercept(context: ExecutionContext, next: CallHandler): Observable<any> {
    return next.handle().pipe(
      map((data: News) => {
        const req = context.switchToHttp().getRequest();
        const user = req.user;
        this.pushService.push(data);
        return data;
      }),
    );
  }
}
