import logger from '../utils/logger';

export const getCredentials = (companyId: string) => {
  logger.warn(companyId.trim().toUpperCase());
  let normalized = companyId.trim().toUpperCase();
  let secret = `CREDS_${normalized}`;
  let credentials = process.env[secret];
  logger.warn(credentials);
  if (!credentials) {
    logger.warn(`Credentials for company: ${companyId} not configured`);
    credentials = '';
  }

  return credentials;
};
