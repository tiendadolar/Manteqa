import { After, Before } from '@cucumber/cucumber';
import { CustomWorld } from '../support/world';
import logger from '../support/utils/logger';

let inicialTimestamp: string = '';
let finalTimestamp: string = '';

const getInitialTimestamp = () => {
  const now = new Date();

  const timezone = -3;
  const argentina = new Date(now.getTime() + timezone * 60 * 60 * 1000);

  const isoString = argentina.toISOString();

  const date = isoString.slice(0, 10);
  const time = isoString.slice(11, 23);

  const timestamp = `${date} ${time}`;

  return timestamp;
};

const getFinalTimestamp = () => {
  const now = new Date();

  const timezone = -3;
  const argentina = new Date(now.getTime() + timezone * 60 * 60 * 1000);

  const isoString = argentina.toISOString();

  const date = isoString.slice(0, 10);
  const time = isoString.slice(11, 23);

  const timestamp = `${date} ${time}`;

  return timestamp;
};

Before(function (scenario: any) {
  logger.warn(`Escenario: ${scenario.pickle.name}`);
  inicialTimestamp = getInitialTimestamp();
});

After(function () {
  CustomWorld.clearStoreData(true);
  logger.info('🧈 Isolating stage...');

  finalTimestamp = getFinalTimestamp();

  // const now = new Date();

  // const timezone = -3;
  // const argentina = new Date(now.getTime() + timezone * 60 * 60 * 1000);

  // const isoString = argentina.toISOString();

  // const date = isoString.slice(0, 10);
  // const time = isoString.slice(11, 23);

  // const timestamp = `${date} ${time}`;

  console.log(`Initial Track: ${inicialTimestamp}`);
  console.log(`Final Track: ${finalTimestamp}`);
});
