import * as crypto from 'crypto';

export default ({ env }) => ({
    'users-permissions': {
        config: {
            jwtSecret: env('JWT_SECRET') || crypto.randomBytes(16).toString('base64'),
            jwt: {
                expiresIn: '1d',
            },
        },
    },
});
