const { Given, When, Then, Before } = require('@cucumber/cucumber');
const { expect } = require('chai');
const request = require('supertest');
import { LockPaymentResponse } from '../../../../../support/interfaces/LockPayment.interface';
import logger from '../../../../../support/utils/logger';
import { validateResponse } from '../../../../../support/validators/synthetics/lockPaymentValidators';
import { CustomWorld, UserData } from '../../../../../support/world';

Then('Validate lock payment response attributes', { timeout: 50 * 1000 }, async function (this: CustomWorld) {
  const res = this.response;

  expect(this.response).to.exist;
  expect(this.response.body).to.exist;

  const validateLockPayment: LockPaymentResponse = validateResponse(res.body);
});
