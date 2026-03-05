import logger from '../utils/logger';

export const getCredentials = (companyId: string) => {
  let secret = companyId;
  logger.warn(secret);

  const creds = process.env.CREDENTIALS_MAP;

  if (creds) {
    const map = JSON.parse(creds);
    const credentials = map[secret];
    if (!credentials) {
      logger.warn(`Credentials for company: ${companyId} not configured in CREDENTIALS_MAP`);
      return '';
    }
  }

  // let secret = `CREDS_${normalized}`;
  let credentials = process.env[secret];
  logger.warn(credentials);
  if (!credentials) {
    logger.warn(`Credentials for company: ${companyId} not configured`);
    credentials = '';
  }

  return credentials;
};
