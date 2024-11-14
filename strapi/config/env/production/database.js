// path: /config/env/production/database.ts
import fs from 'fs';
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
        ca: fs.readFileSync('./config/env/production/ca-certificat.crt').toString(),      
      },
    },
    debug: false,
  },
});
