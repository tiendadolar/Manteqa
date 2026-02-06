import { getBillIdInfoHelper, getTopUpIdInfoHelper } from '../../../../support/helpers/billingHelper';
import { validateRes } from '../../../../support/helpers/requestHelper';
import logger from '../../../../support/utils/logger';
import { CustomWorld } from '../../../../support/world';
const { Given, When, Then, Before } = require('@cucumber/cucumber');
const { expect } = require('chai');
const request = require('supertest');

Given('Get billId from billing provider', async function (this: CustomWorld) {
  const res = await getBillIdInfoHelper(this.apiKey);
  const billId = res.body[0].id;
  await validateRes(res, 200);

  CustomWorld.setStoreData('billId', billId, true);
  console.log(CustomWorld.getStoreData('billId'));
});

Given('Get billId from top up provider', async function (this: CustomWorld) {
  const res = await getTopUpIdInfoHelper(this.apiKey);
  const billId = res.body[0].id;
  await validateRes(res, 200);

  CustomWorld.setStoreData('billId', billId, true);
  console.log(CustomWorld.getStoreData('billId'));
});

Then('Obtain a response {int} for bill payment overdraw', { timeout: 500 * 1000 }, async function (this: CustomWorld, statusCode: number) {
  const response = this.response;
  if (this.response.body.code) CustomWorld.setStoreData('pixCode', this.response.body.code);

  expect(response.status).to.equal(statusCode);
  expect(response.body).to.not.have.property('payload');

  CustomWorld.setStoreData('againstAmountOperated', undefined);
  logger.warn(CustomWorld.getStoreData('againstAmountOperated'));
  CustomWorld.setStoreData('paymentAgainstAmount', response.body.paymentAgainstAmount);
  logger.debug(`Response Status: ${response.status}`);
});
