import logger from '../utils/logger';

export const getCredentials = (companyId: string) => {
  const secret = companyId;
  const creds = process.env.CREDENTIALS_MAP;

  if (creds) {
    const map = JSON.parse(creds);
    const credentials = map[secret];
    if (!credentials) {
      logger.warn(`Credentials for company: ${companyId} not configured in CREDENTIALS_MAP`);
      return '';
    }
    return credentials;
  }

  let credentials = process.env[secret];

  if (!credentials) {
    logger.warn(`Credentials for company: ${companyId} not configured`);
    credentials = '';
  }

  return credentials;
};
