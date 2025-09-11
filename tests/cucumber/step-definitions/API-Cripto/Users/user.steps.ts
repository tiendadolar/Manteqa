const { Given, When, Then, Before } = require('@cucumber/cucumber');
const { expect } = require('chai');
const request = require('supertest');
import { getUserInfoHelper } from '../../../../support/helpers/userHelper';
import logger from '../../../../support/utils/logger';
import { delay } from '../../../../support/utils/utils';
// import logger from '../../support/utils/logger';
import { CustomWorld } from '../../../../support/world';

Then('Get user {string} info for {string} id', async function (this: CustomWorld, data: string, userAnyId: string) {
  await getUserInfoHelper(this.apiKey, data, userAnyId);
});

Then('Validate user status', { timeout: 25000 }, async function (this: CustomWorld) {
  const userAnyId = CustomWorld.getStoreData('userId');
  await delay(10000, 'Validating user identity');
  await getUserInfoHelper(this.apiKey, undefined, userAnyId);
});
