import { createParamDecorator, SetMetadata } from '@nestjs/common';

export const userParam = createParamDecorator((prop, req) => {
  if (prop) {
    return req.user[prop];
  }
  return req.user;
});
