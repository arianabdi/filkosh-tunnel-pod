/* eslint-disable prettier/prettier */
import { Body, Controller, Get, Post, Res } from '@nestjs/common';
import { AppService } from './app.service';
import {ApiTags} from "@nestjs/swagger";
import {SetupModel} from './app.model';


@ApiTags('App')
@Controller('api')
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get('pid')
  async getSSHTunnelPID(@Res() res) {
      try {
        const data = await this.appService.getSSHTunnelPID();
        await AppService.httpResponseHelper({res: res, data: {message: '', data: data}, message: ""});
      }catch (e){
          await AppService.errorHelper(res, e);
      }
  }
  @Post('setup')
  async setupSSHTunnel(@Res() res, @Body() body: SetupModel) {
      try {
        const data = await this.appService.setupSshTunnel(body.ip, body.password);
        await AppService.httpResponseHelper({res: res, data: {message: '', data: data}, message: ""});
      }catch (e){
          await AppService.errorHelper(res, e);
      }
  }


}
