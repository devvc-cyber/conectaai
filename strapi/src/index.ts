// import type { Core } from '@strapi/strapi';
import fs from 'fs';
import path from 'path';

/**
 * Load environment variables from Docker secrets.
 */
function loadEnvFromDockerSecrets() {
  const secretsPath = '/run/secrets';

  try {
    console.debug('Checking if secrets path exists:', secretsPath);
    if (fs.existsSync(secretsPath)) {
      const files = fs.readdirSync(secretsPath);
      console.debug(`Secrets found: ${files.length} files`);

      files.forEach((file) => {
        const secretPath = path.join(secretsPath, file);
        console.debug(`Reading secret file: ${secretPath}`);
        const secretValue = fs.readFileSync(secretPath, 'utf8').trim();
        const envVarName = file.toUpperCase().replace('_FILE', '');
        process.env[envVarName] = secretValue;
        console.debug(`Loaded secret: ${envVarName}`);
      });
    } else {
      console.warn(`Secrets path ${secretsPath} does not exist. Skipping Docker secrets loading.`);
    }
  } catch (error) {
    console.error('Erro ao carregar Docker secrets:', error);
  }
}

/**
 * Log all environment variables.
 */
function logEnvironmentVariables() {
  console.log('Debugging environment variables:');
  Object.keys(process.env).forEach((key) => {
    // Avoid logging sensitive data directly
    console.log(`${key}: ${process.env[key]}`);
    //if (['PASSWORD', 'SECRET', 'KEY'].some((sensitive) => key.includes(sensitive))) {
    //console.log(`${key}: [SENSITIVE VALUE HIDDEN]`);
    //} else {
    //}
  });
}

export default {
  /**
   * An asynchronous register function that runs before
   * your application is initialized.
   *
   * This gives you an opportunity to extend code.
   */
  register(/* { strapi }: { strapi: Core.Strapi } */) {
    // Load environment variables from Docker secrets
    loadEnvFromDockerSecrets();

    // Log environment variables for debugging
    logEnvironmentVariables();

    console.log(`NODE_ENV: ${process.env.NODE_ENV}`);
    console.log(`DATABASE_CONNECTION: ${process.env.DATABASE_CONNECTION ? 'Loaded' : 'Not Loaded'}`);
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