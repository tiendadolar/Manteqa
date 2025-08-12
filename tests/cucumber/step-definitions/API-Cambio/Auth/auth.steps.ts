const { Given, When, Then, Before } = require('@cucumber/cucumber');
const { expect } = require('chai');
const request = require('supertest');
const speakeasy = require('speakeasy');
import { authApiCambio } from '../../../../support/utils/utils';
import { CustomWorld, UserData } from '../../../../support/world';

Then('Send 2FA code', async function (this: CustomWorld) {
  authApiCambio();
});

Then('Obtain a response {int} and twoFaCode url', async function (this: CustomWorld, statusCode: number) {
  const response = this.response;
  const body = response.body;

  CustomWorld.setStoreData('redirectUrl', body.redirectUrl);

  expect(this.response.status).to.equal(statusCode);
});
