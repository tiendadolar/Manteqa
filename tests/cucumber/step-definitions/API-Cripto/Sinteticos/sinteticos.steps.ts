const { Given, When, Then, Before } = require('@cucumber/cucumber');
const { expect } = require('chai');
const request = require('supertest');
import { timeoutsBySynthetic } from '../../../../support/constants/constants.timeouts';
import { getSyntheticStatus } from '../../../../support/helpers/syntheticHelper';
import logger from '../../../../support/utils/logger';
import { delay } from '../../../../support/utils/utils';
import { CustomWorld, UserData } from '../../../../support/world';

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
  const ms = timeoutsBySynthetic[syntheticType] ?? timeoutsBySynthetic['default'];

  await delay(ms);
  await getSyntheticStatus(urlBase, endpoint, apiKEY, statusCode, statusName);
});
