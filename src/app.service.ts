/* eslint-disable prettier/prettier */
import {HttpStatus, Injectable} from '@nestjs/common';
import {exec} from 'child_process';
import {promisify} from 'util';


const execute = promisify(exec);

export class httpResponseHelperModel {
    res: any
    data: any;
    message?: string;
}


@Injectable()
export class AppService {
    getHello(): string {
        return 'Hello World!';
    }


    // const {stdout, stderr} = await execute(command);
    // console.log(`Script output: ${JSON.stringify(stdout)}`);
    // console.error(`Script errors: ${stderr}`);

    // // Handle the success and send an appropriate response
    // return {success: true, message: 'Users created and passwords changed successfully.'};


    async getSSHTunnelPID(): Promise<string> {

        try {
            const {stdout, stderr} = await execute('./check_ssh_tunnel_pid.sh');
            if (stderr) {
                console.error(`Error executing script: ${stderr}`);
                throw new Error(stderr);
            }
            console.log(`Script output: ${stdout}`);
            return stdout;
        } catch (error) {
            console.error(`Error executing script: ${error}`);
            throw error;
        }
    }

    async setupSshTunnel(ip: string, password: string): Promise<string> {

        try {
            console.log('ip', ip);
            // Install curl
            await execute(`mkdir -p /var/lib/apt/lists/partial`);
            await execute(`apt-get update`);
            await execute(`apt-get install -y curl`);

            console.log(`Executing command: bash -c "$(curl -Ls https://raw.githubusercontent.com/arianabdi/filkosh-tunnel-pod/main/scripts/setup_ssh_tunnel.sh --ipv4) ${ip} ${password}" ${ip} `);

            const {stdout, stderr} = await execute(`bash -c "$(curl -Ls https://raw.githubusercontent.com/arianabdi/filkosh-tunnel-pod/main/scripts/setup_ssh_tunnel.sh --ipv4) ${ip} ${password}"  `);
            if (stderr) {
                console.error(`Error executing setup_ssh_tunnel.sh: ${stderr}`);
                throw new Error('Failed to set up SSH tunnel.');
            }
            console.log(`Output: ${stdout}`);
            return 'SSH tunnel setup successful.';
        } catch (error) {
            console.error(`Error setting up SSH tunnel: ${error}`);
            throw new Error('Failed to set up SSH tunnel.');
        }
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
