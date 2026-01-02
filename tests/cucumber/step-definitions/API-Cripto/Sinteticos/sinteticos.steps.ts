const { Given, When, Then, Before } = require('@cucumber/cucumber');
const { expect } = require('chai');
const request = require('supertest');
import { timeoutsBySynthetic } from '../../../../support/constants/constants.timeouts';
import { validateRes } from '../../../../support/helpers/requestHelper';
import { getSyntheticStatus, lockPaymentHelper, syntheticPaymentHelper, validateSyntheticRefundStage, validateSyntheticStatus } from '../../../../support/helpers/syntheticHelper';
import { getUserInfoHelper } from '../../../../support/helpers/userHelper';
import logger from '../../../../support/utils/logger';
import { delay } from '../../../../support/utils/utils';
import { CustomWorld, UserData } from '../../../../support/world';

const payType: Record<string, string> = {
  ARS: 'ARS_ARS',
  USDT: 'USDT_ARS',
  BRL: 'BRL_ARS',
  ARS_BRL: 'ARS_BRL',
  USDT_BRL: 'USDT_BRL',
  BRL_BRL: 'BRL_BRL',
  uBRL_BRL: 'uBRL_BRL'
};

Then('Se validan atributos para sintético ramp-on operado en no descubierto', async function (this: CustomWorld) {
  const response: any = this.response;
  const body: any = response.body;
  const stages: any = response.body.stages;
  const stage1 = body.stages?.['1'];
  const stage2 = body.stages?.['2'];
  const stage3 = body.stages?.['3'];
  const stageKeys: object = Object.keys(stages);
  const currentStage: number = response.body.currentStage;
  const details: any = response.body.details;

  expect(body.id).to.be.a('string').and.not.empty;
  expect(body.numberId).to.be.a('string').and.not.empty;
  expect(body.userId).to.be.a('string').and.not.empty;
  expect(body.userNumberId).to.be.a('string').and.not.empty;
  if ('sessionId' in body) expect(body.sessionId).to.be.a('string').and.not.empty;
  expect(body.status).equal('STARTING');
  expect(body.type).to.be.a('string').and.not.empty;

  expect(details.depositAddress).to.be.a('string').and.not.empty;
  expect(details.depositAlias).to.be.a('string').and.not.empty;
  expect(details.withdrawCostInAgainst).to.be.a('string').and.not.empty;
  expect(details.withdrawCostInAsset).to.be.a('string').and.not.empty;
  expect(details.price).to.be.a('string').and.not.empty;
  expect(details.priceExpireAt).to.be.a('string').and.not.empty;

  expect(response).to.not.be.undefined;
  expect(stages).to.be.an('object');
  expect(stageKeys).to.have.members(['1', '2', '3']);
  expect(stageKeys).to.have.lengthOf(3);
  expect(currentStage).to.equal(1);

  expect(stage1).to.be.an('object');
  expect(stage1.stageType).to.equal('DEPOSIT');
  expect(stage1.asset).to.be.a('string').and.not.empty;
  expect(stage1.thresholdAmount).to.be.a('string').and.not.empty;
  expect(stage1.useOverflow).to.be.a('boolean');
  expect(stage1.expireAt).to.be.a('string').and.not.empty;

  expect(stage2).to.be.an('object');
  expect(stage2.stageType).to.equal('ORDER');
  expect(stage2.side).to.equal('BUY');
  expect(stage2.type).to.be.a('string').and.not.empty;
  expect(stage2.asset).to.be.a('string').and.not.empty;
  expect(stage2.against).to.be.a('string').and.not.empty;
  expect(stage2.assetAmount).to.be.a('string').and.not.empty;
  expect(stage2.price).to.be.a('string').and.not.empty;
  expect(stage2.priceCode).to.be.a('string').and.not.empty;

  expect(stage3).to.be.an('object');
  expect(stage3.stageType).to.equal('WITHDRAW');
  expect(stage3.network).to.be.a('string').and.not.empty;
  expect(stage3.asset).to.be.a('string').and.not.empty;
  expect(stage3.amount).to.be.a('string').and.not.empty;
  expect(stage3.to).to.be.a('string').and.not.empty;

  // const price = parseFloat(details.price);
  // const expectedThreshold = (
  //   price * CustomWorld.getUserData("assetAmount")
  // ).toFixed(2);
  // const actualThreshold = parseFloat(stage1.thresholdAmount).toFixed(2);

  // expect(actualThreshold).to.equal(expectedThreshold);
});

Then('Wait for the processing of the {string} por {int} seconds', { timeout: 125000 }, async function (this: CustomWorld, stage: string, seconds: number) {
  logger.info(`Waiting for the processing of the stage: ${stage}`);
  logger.info(`Starting wait of ${seconds} seconds...`);
  await new Promise((resolve) => setTimeout(resolve, seconds * 1000));
  console.log(`Espera de ${seconds} seconds completada`);
});

Then('Obtain a response {int} y status {string}', function (this: CustomWorld, statusCode: number, statusName: string) {
  const response: any = this.response;
  const body: any = response.body;

  if (body.status !== statusName) CustomWorld.clearStoreData();

  expect(this.response.status).to.equal(statusCode);
  expect(body.status).to.equal(statusName);

  if (body?.stages?.['1'].stageType === 'DEPOSIT') CustomWorld.setStoreData('depositStage', true);
  if (body?.stages?.['1'].stageType !== 'DEPOSIT') CustomWorld.setStoreData('notDepositStage', true);
  if (body.hasOwnProperty('details')) CustomWorld.setStoreData('againstAmountOperated', body.details.againstAmountOperated);
});

Then('Obtain a response {int} and status {string} for {string} synthetic', { timeout: 125000 }, async function (this: CustomWorld, statusCode: number, statusName: string, syntheticType: string) {
  const urlBase = this.urlBase;
  const endpoint = `/v2/synthetics/${CustomWorld.getStoreData('syntheticId')}`;
  const apiKEY = this.apiKey;
  const userAnyId = CustomWorld.getStoreData('userAnyId');
  const ms = timeoutsBySynthetic[syntheticType] ?? timeoutsBySynthetic['default'];

  const user = await getUserInfoHelper(apiKEY, undefined, userAnyId);
  CustomWorld.setStoreData('userExchange', user.body.exchange);

  await delay(ms);
  const response = await getSyntheticStatus(urlBase, endpoint, apiKEY, statusCode, statusName);
  validateRes(response, 200);
  validateSyntheticStatus(response.body, response.status, statusCode, statusName);
});

Then('Validate sender info', { timeout: 125000 }, async function (this: CustomWorld) {
  const response = this.response.body;

  expect(response.details).to.have.property('sender');
  expect(response.details.sender).to.include.all.keys('exchange', 'legalId', 'name');
});

Then('Execute overdrawn {string} synthetic lock against {string} for user {string}', { timeout: 125000 }, async function (this: CustomWorld, type: string, against: string, userAnyId: string) {
  const urlBase: string = 'https://sandbox.manteca.dev/crypto';
  const apiKEY: string = 'F4EZSEW-AMC4Z24-G5CNFS4-880BSHJ';
  const apiSecret: string = '1RpvdT7Vc7ukKeGKdU';
  const endpointLock: string = '/v2/payment-locks';
  const par: string = payType[against];

  this.response = await lockPaymentHelper(urlBase, apiKEY, endpointLock, type, par, userAnyId);
});

Then('Execute overdrawn synthetic payment', { timeout: 125000 }, async function (this: CustomWorld) {
  const userAnyId: string = this.response.body.userNumberId;
  const qrCode = this.response.body.code;
  const urlBase: string = 'https://sandbox.manteca.dev/crypto';
  const apiKEY: string = 'F4EZSEW-AMC4Z24-G5CNFS4-880BSHJ';
  const endpointPayment: string = '/v2/synthetics/qr-payment';

  this.response = await syntheticPaymentHelper(urlBase, apiKEY, endpointPayment, qrCode, userAnyId);
  await delay(10000);
});

Then('Validate refund stages', { timeout: 125000 }, async function (this: CustomWorld) {
  const urlBase = this.urlBase;
  const endpoint = `/v2/synthetics/${CustomWorld.getStoreData('syntheticId')}`;
  const apiKEY = this.apiKey;
  const ms = 25000;

  await delay(ms);
  const response = await getSyntheticStatus(urlBase, endpoint, apiKEY);
  validateSyntheticStatus(response.body, response.status, 200, 'CANCELLED');
  validateSyntheticRefundStage(response.body);
});
