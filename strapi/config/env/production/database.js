// path: /config/env/production/database.ts

const parse = require("pg-connection-string").parse;

const { host, port, database, user, password } = parse(
   process.env.DATABASE_URL
 );

export default ({ env }) => ({
  connection: {  
    client: 'postgres',
    connection: {
      host,
      port,
      database,
      user,
      password,
      ssl: {
        key: env('DATABASE_CA'),
      },
    },
    pool: {
      min: 0,
      max: 22,
    },    
    debug: false,
  },
});
