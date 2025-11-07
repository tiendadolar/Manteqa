import { After, Before } from '@cucumber/cucumber';
import { CustomWorld } from '../support/world';
import logger from '../support/utils/logger';

Before(function (scenario: any) {
  logger.warn(`Escenario: ${scenario.pickle.name}`);
});

After(function () {
  CustomWorld.clearStoreData(true);
  logger.info('🧹Isolating stage...');
});
