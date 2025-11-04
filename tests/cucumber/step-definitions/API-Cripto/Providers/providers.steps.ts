const { Given, When, Then, Before } = require('@cucumber/cucumber');
const { expect } = require('chai');
const request = require('supertest');
import logger from '../../../../support/utils/logger';
import { delay } from '../../../../support/utils/utils';
import { checkProvider } from '../../../../support/validators/providerValidators';
import { CustomWorld, UserData } from '../../../../support/world';

Then('Validate withdraw provider for {string} payment', { timeout: 125000 }, async function (this: CustomWorld, synthetic: string) {
  const response: any = this.response?.body;
  const provider: string = response.withdraws?.at(-1).bank;
  const exchange: string = response.exchangeCountry;

  logger.info(provider);
  logger.info(exchange);

  checkProvider(provider, exchange, synthetic);
});
