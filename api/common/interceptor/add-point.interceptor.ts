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
        const req = context.switchToHttp().getRequest();
        const user = req.user;
        const point = 10;
        if (user) {
          this.userService.updatePoint(user, point);
        }
      }),
    );
  }
}
