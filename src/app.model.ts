/* eslint-disable prettier/prettier */

import {ApiProperty} from "@nestjs/swagger";

export class TestModel2{
    @ApiProperty({type: String, default: 'arian_abdi_4'})
    username: string

    @ApiProperty({type: String, default: '123'})
    password: string
}
