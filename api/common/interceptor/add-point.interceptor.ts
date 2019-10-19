import {
  Injectable,
  NestInterceptor,
  ExecutionContext,
  CallHandler,
} from '@nestjs/common';
import { Observable } from 'rxjs';
import { tap } from 'rxjs/operators';
import { UserService } from '@src/user/user.service';

@Injectable()
export class AddPointInterceptor implements NestInterceptor {
  constructor(readonly userService: UserService) {}
  intercept(context: ExecutionContext, next: CallHandler): Observable<any> {
    return next.handle().pipe(
      tap(() => {
        const user = context.switchToHttp().getRequest().user;
        if (user) {
          this.userService.updatePoint(user, 10);
        }
      }),
    );
  }
}
