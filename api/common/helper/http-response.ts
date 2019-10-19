import { ApiResponseModelProperty } from '@nestjs/swagger';

class RespBase {
  @ApiResponseModelProperty()
  public data: any;

  @ApiResponseModelProperty()
  public status: string;
  constructor() {}
}

export class RespOk extends RespBase {
  constructor(public readonly data, public readonly meta?) {
    super();
    this.status = 'succ';
  }
}

export class RespFail extends RespBase {
  constructor(
    public readonly data,
    public readonly statusCode: number | string,
  ) {
    super();
    this.status = 'fail';
  }
}
