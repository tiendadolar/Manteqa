import { expect } from 'chai';
import logger from '../utils/logger';
import { CustomWorld } from '../world';
import { getActivities } from '../helpers/activitiesHelper';

const register: Record<string, string> = {
  'direct currency payment': 'PAYMENT_CREATION'
};

export const checkActivities = (data: any, activity: string): any => {
  // Get all entries in a period date
  const entries = getActivities(data);
  // Filter entries for payments
  const entry = entries.filter((item) => item.reason === register[activity]);

  logger.debug(JSON.stringify(entries, null, 2));
  logger.debug(JSON.stringify(entry, null, 2));

  expect(entry).to.be.an('array').that.is.not.empty;
};
