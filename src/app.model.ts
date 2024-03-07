/* eslint-disable prettier/prettier */

import {ApiProperty} from "@nestjs/swagger";

export class SetupModel{
    @ApiProperty({type: String, default: '45.95.174.177'})
    ip: string

    @ApiProperty({type: String, default: 'bY5L8egy3B6rM3cU2X'})
    password: string
}
