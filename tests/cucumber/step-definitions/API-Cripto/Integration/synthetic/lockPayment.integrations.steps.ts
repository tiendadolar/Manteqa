const { Given, When, Then, Before } = require('@cucumber/cucumber');
const { expect } = require('chai');
const request = require('supertest');
import { apiRequest } from '../../../../../support/helpers/requestHelper';
import { LockPaymentResponse } from '../../../../../support/interfaces/LockPayment.interface';
import logger from '../../../../../support/utils/logger';
import { validateResponse } from '../../../../../support/validators/synthetics/lockPaymentValidators';
import { validateResponseRouting } from '../../../../../support/validators/synthetics/lockPaymentRoutingValidators';
import { CustomWorld, UserData } from '../../../../../support/world';

Then('Validate lock payment response attributes', { timeout: 50 * 1000 }, async function (this: CustomWorld) {
  const res = this.response;

  expect(this.response).to.exist;
  expect(this.response.body).to.exist;

  const validateLockPayment: LockPaymentResponse = validateResponse(res.body);
});

Then('Validate lock payment routing response attributes', { timeout: 50 * 1000 }, async function (this: CustomWorld) {
  const urlBase = 'https://api-qa.tiendacrypto.com/v1';
  const endpoint = `/admin/user/${CustomWorld.getStoreData('userAnyId')}/doug`;
  const token = CustomWorld.getStoreData('JWT');
  const principalAccount = await apiRequest({ urlBase, endpoint, method: 'get', token });

  const res = this.response;

  expect(this.response).to.exist;
  expect(this.response.body).to.exist;

  const validateLockPayment: LockPaymentResponse = validateResponseRouting(res.body, principalAccount.body);
});
