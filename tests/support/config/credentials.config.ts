import logger from '../utils/logger';

export const getCredentials = (companyId: string) => {
  let secret = `CREDS_${companyId}`;
  let credentials = process.env[secret];

  if (!credentials) {
    logger.warn(`Credentials for company: ${companyId} not configured`);
    credentials = '';
  }

  return credentials;
};
