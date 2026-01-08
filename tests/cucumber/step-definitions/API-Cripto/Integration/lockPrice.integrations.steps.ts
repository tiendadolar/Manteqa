const { expect } = require('chai');
const request = require('supertest');
const { Given, When, Then, Before } = require('@cucumber/cucumber');
import { LockPriceResponse } from '../../../../support/interfaces/lockPrice.interface';
import logger from '../../../../support/utils/logger';
import { validateResponse } from '../../../../support/validators/lockPrice.validators';
import { CustomWorld } from '../../../../support/world';

Then('Validate lock price response attributes', { timeout: 50 * 1000 }, async function (this: CustomWorld) {
  const res = this.response;
  // console.log(JSON.stringify(res.body, null, 2));

  const validateLockPrice: LockPriceResponse = validateResponse(res.body);
});
