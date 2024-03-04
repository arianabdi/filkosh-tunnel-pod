/* eslint-disable prettier/prettier */
import { Injectable } from '@nestjs/common';
import {exec} from 'child_process';
import {promisify} from 'util';
import axios from "axios";


@Injectable()
export class AppService {
  getHello(): string {
    return 'Hello World!';
  }

  static async httpResponseHelper(response: httpResponseHelperModel) {
    return response.res.status(HttpStatus.OK).json({
        data: response.data,
        statusCode: HttpStatus.OK,
        message: response.message,
        meta: {
            date: new Date()
        }
    })

}


static async errorHelper(res, error) {
    return res.status(error.status ? error.status : HttpStatus.BAD_REQUEST).json(
        {
            "statusCode": error.status,
            "message": error.message,
            "meta": {
                date: new Date()
            }
        }
    )
}

}
