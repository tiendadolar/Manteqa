const { Given, When, Then, Before } = require('@cucumber/cucumber');
const { expect } = require('chai');
const request = require('supertest');
import { getUserInfoHelper } from '../../../../support/helpers/userHelper';
import { GetUserV2Response } from '../../../../support/interfaces/userV2.interface';
import logger from '../../../../support/utils/logger';
import { delay } from '../../../../support/utils/utils';
import { validateResponse } from '../../../../support/validators/usersV2/getUserV2Validator';
// import logger from '../../support/utils/logger';
import { CustomWorld } from '../../../../support/world';

Then('Get user {string} info for {string} id', async function (this: CustomWorld, data: string, userAnyId: string) {
  await getUserInfoHelper(this.apiKey, data, userAnyId);
});

Then('Validate user status', { timeout: 200000 }, async function (this: CustomWorld) {
  const userAnyId = CustomWorld.getStoreData('userId');
  const exchange = this.response.body.user.exchange;
  console.log(exchange);

  await delay(10000, 'Validating user identity', exchange);
  const response = await getUserInfoHelper(this.apiKey, undefined, userAnyId);
  logger.info(`User Status: ${response.body.status}`);
  console.log(response.body);

  //Validate response
  const valideteUserV2: GetUserV2Response = validateResponse(response.body, this);

  expect(response.body.status).to.equal('ACTIVE');
});
