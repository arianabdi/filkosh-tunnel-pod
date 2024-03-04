/* eslint-disable prettier/prettier */
import { Body, Controller, Get, Post, Res } from '@nestjs/common';
import { AppService } from './app.service';
import {ApiTags} from "@nestjs/swagger";


@ApiTags('App')
@Controller('api')
export class AppController {
  constructor(private readonly appService: AppService) {}



  @Post('set_users')
  async set_users(@Res() res, @Body() body: TestModel2 ) {
      try {
          const data = await this.appService.set_users(body.users, body.port);
          await AppService.httpResponseHelper({res: res, data: {message: '', data: {data}}, message: ""});

      }catch (e){
          await AppService.errorHelper(res, e);
      }
  }
}
