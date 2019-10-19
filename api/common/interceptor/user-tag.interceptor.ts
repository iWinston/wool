import {
  Injectable,
  NestInterceptor,
  ExecutionContext,
  CallHandler,
} from '@nestjs/common';
import { Observable } from 'rxjs';
import { tap } from 'rxjs/operators';
import { UserTagService } from '@src/user/tag/user-tag.service';

@Injectable()
export class UserTagInterceptor implements NestInterceptor {
  constructor(readonly userTagService: UserTagService) {}
  intercept(context: ExecutionContext, next: CallHandler): Observable<any> {
    const req = context.switchToHttp().getRequest();
    req.user = this.userTagService.getUserWithTags(req.user);
    return next.handle().pipe(tap(() => {}));
  }
}
