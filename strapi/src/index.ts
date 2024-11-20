// import type { Core } from '@strapi/strapi';
import fs from 'fs';
import path from 'path';

/**
 * Load environment variables from Docker secrets.
 */
function loadEnvFromDockerSecrets() {
  const secretsPath = '/run/secrets';

  try {
    if (fs.existsSync(secretsPath)) {
      const files = fs.readdirSync(secretsPath);

      files.forEach((file) => {
        const secretPath = path.join(secretsPath, file);
        const secretValue = fs.readFileSync(secretPath, 'utf8').trim();
        const envVarName = file.toUpperCase().replace('_FILE', '');
        process.env[envVarName] = secretValue;
      });
    } else {
      console.warn(`Secrets path ${secretsPath} does not exist. Skipping Docker secrets loading.`);
    }
  } catch (error) {
    console.error('Erro ao carregar Docker secrets:', error);
  }
}

export default {
  /**
   * An asynchronous register function that runs before
   * your application is initialized.
   *
   * This gives you an opportunity to extend code.
   */
  register(/* { strapi }: { strapi: Core.Strapi } */) {
    // Load environment variables from Docker secrets only in production
    if (process.env.NODE_ENV === 'production') {
      loadEnvFromDockerSecrets();
    }

    console.log(`NODE_ENV: ${process.env.NODE_ENV}`);
    if (process.env.NODE_ENV === 'production') {
      console.log(`DATABASE_CONNECTION: ${process.env.DATABASE_CONNECTION ? 'Loaded' : 'Not Loaded'}`);
    }
  },

  /**
   * An asynchronous bootstrap function that runs before
   * your application gets started.
   *
   * This gives you an opportunity to set up your data model,
   * run jobs, or perform some special logic.
   */
  bootstrap(/* { strapi }: { strapi: Core.Strapi } */) {},
};
