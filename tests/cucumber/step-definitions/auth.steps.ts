const { Given, When, Then, Before } = require('@cucumber/cucumber');
const { expect } = require('chai');
const request = require('supertest');
import { authHelper, getUserCredentials } from '../../support/helpers/authHelper';
import logger from '../../support/utils/logger';
import { CustomWorld, UserData } from '../../support/world';

Then('login user admin {string}', async function (this: CustomWorld, credential: string) {
  const { password, secret, urlBase, endpoint } = getUserCredentials(credential);
  await authHelper(urlBase, endpoint, credential, password, secret);
});
