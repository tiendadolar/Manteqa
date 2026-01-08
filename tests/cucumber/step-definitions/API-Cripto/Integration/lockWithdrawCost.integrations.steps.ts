const { expect } = require('chai');
const request = require('supertest');
const { Given, When, Then, Before } = require('@cucumber/cucumber');
import { LockWithdrawCostResponse } from '../../../../support/interfaces/lockWithdrawCost.interface';
import { validateResponse } from '../../../../support/validators/lockWithdrawCost.validators';
import { CustomWorld } from '../../../../support/world';

Then('Validate lock withdraw cost response attributes', { timeout: 50 * 1000 }, async function (this: CustomWorld) {
  const res = this.response;
  console.log('AQUI');

  console.log(JSON.stringify(res.body, null, 2));

  const validateLockWithdrawCost: LockWithdrawCostResponse = validateResponse(res.body);
});
