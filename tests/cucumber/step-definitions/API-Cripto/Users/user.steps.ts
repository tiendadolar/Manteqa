const { Given, When, Then, Before } = require('@cucumber/cucumber');
const { expect } = require('chai');
const request = require('supertest');
import { getUserInfoHelper } from '../../../../support/helpers/userHelper';
import logger from '../../../../support/utils/logger';
// import logger from '../../support/utils/logger';
import { CustomWorld } from '../../../../support/world';

Then('Get user {string} info for {string} id', async function (this: CustomWorld, data: string, userAnyId: string) {
  await getUserInfoHelper(this.apiKey, data, userAnyId);
});
