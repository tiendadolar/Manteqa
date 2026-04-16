import { After, Before } from '@cucumber/cucumber';
import { CustomWorld } from '../support/world';
import logger from '../support/utils/logger';

Before(function (scenario: any) {
  logger.warn(`Escenario: ${scenario.pickle.name}`);
});

After(function () {
  CustomWorld.clearStoreData(true);
  logger.info('🧈 Isolating stage...');

  const now = new Date();

  const timezone = -3;
  const argentina = new Date(now.getTime() + timezone * 60 * 60 * 1000);

  const isoString = argentina.toISOString();

  const date = isoString.slice(0, 10);
  const time = isoString.slice(11, 23);

  const timestamp = `${date} ${time}`;

  console.log(`Track: ${timestamp}`);
});
