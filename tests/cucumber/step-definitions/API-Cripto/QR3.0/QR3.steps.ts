const { Given, When, Then, Before } = require('@cucumber/cucumber');
const { expect } = require('chai');
const request = require('supertest');
import { CustomWorld, UserData } from '../../../../support/world';
import { refundPollingWithDeposit, refundsPolling } from '../../../../support/utils/utils';
import logger from '../../../../support/utils/logger';
import { adminRefundHelper, getSyntheticStatus } from '../../../../support/helpers/syntheticHelper';
import { validateRes } from '../../../../support/helpers/requestHelper';

Then('The attributes of the QR USDT synthetic are validated', async function (this: CustomWorld) {
  const response: any = this.response;
  const body: any = response.body;
  const details: any = response.body.details;

  expect(details.paymentAgainst).equal('USDT');
  // expect(body.stages).lengthOf;
});

Then('The attributes of the QR ARS synthetic are validated', async function (this: CustomWorld) {
  const response: any = this.response;
  const body: any = response.body;
  const details: any = response.body.details;

  expect(details.paymentAgainst).equal('ARS');
  // expect(body.currentStage).equal(1);
});

Then('Execute the refund synthetic {string}', { timeout: 500 * 1000 }, async function (this: CustomWorld, flag: string) {
  try {
    if (flag === 'descubierto') this.response = await refundsPolling(this, this.userData);
    if (flag === 'no descubierto') this.response = await refundPollingWithDeposit(this, this.userData);
  } catch (error: any) {
    // if (error.response) {
    //   this.attach(`API Error Response: ${JSON.stringify(error.response.body || error.response.text || {}, null, 2)}`, 'text/plain');
    //   this.response = error.response;
    // }
    // throw error;
  }
});

Then('Obtain a response {int} y status {string} for payment synthetics', { timeout: 500 * 1000 }, async function (this: CustomWorld, statusCode: number, statusName: string) {
  const response = this.response;
  const stages = response.body.stages;

  if (response.body.status !== statusName) CustomWorld.clearStoreData();

  logger.debug(`Response Status: ${response.status}`);
  logger.debug(`Response Body Status: ${response.body.status}`);

  expect(response.status).to.equal(statusCode);
  expect(response.body.status).to.equal(statusName);
  expect(Object.values(stages).find((stage: any) => stage.stageType === 'WITHDRAW')).to.have.property('withdrawId');

  // if (response.body.status === statusName) {
  //   expect(response.status).to.equal(statusCode);
  //   expect(response.body.status).to.equal(statusName);
  //   console.log('E2E Exitoso');
  // } else if (response.body.status === 'ACTIVE') {
  //   console.log('Transfero_PIX FALLIDO o E2E PENDIENTE');
  //   expect(response.status).to.equal(statusCode);
  //   // expect(response.body.status).to.equal(statusName);
  //   expect(Object.values(stages).some((stage: any) => stage.withdrawId !== null && stage.withdrawId !== undefined));
  // } else {
  //   expect(response.status).to.equal(statusCode);
  //   expect(response.body.status).to.equal(statusName);
  // }
});

Then('Obtain a response {int} for lock payment', { timeout: 500 * 1000 }, async function (this: CustomWorld, statusCode: number) {
  const response = this.response;
  if (this.response.body.code) CustomWorld.setStoreData('pixCode', this.response.body.code);

  expect(response.status).to.equal(statusCode);
  expect(response.body).to.not.have.property('payload');

  CustomWorld.setStoreData('paymentAgainstAmount', response.body.paymentAgainstAmount);
  logger.debug(`Response Status: ${response.status}`);
});

Then('Execute admin refund', { timeout: 500 * 1000 }, async function (this: CustomWorld) {
  const response = this.response.body;
  const apiKEY = this.apiKey;
  const urlBase = `https://api-qa.tiendacrypto.com`;
  const endpoint = `/v1/admin/synthetics/${response.id}/refund`;
  const token = CustomWorld.getStoreData('JWT');
  const refundReason = `Manual Refund ${CustomWorld.getSessionId('-')}`;
  const amount = response.details.paymentAgainstAmount;

  const result = await adminRefundHelper(urlBase, endpoint, token, refundReason, amount);
  validateRes(result, 204);
  // await getSyntheticStatus(urlBase, endpoint, apiKEY, 200, 'CANCELLED');
});
