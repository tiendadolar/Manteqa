const { Given, When, Then, Before } = require('@cucumber/cucumber');
const { expect } = require('chai');
const request = require('supertest');
const fs = require('fs');
const path = require('path');
import { validateEntity, validateEntitySyntheticOrder, validateEntitySyntheticWithdraw } from '../../../../support/helpers/entityHelper';
import logger from '../../../../support/utils/logger';
import { CustomWorld } from '../../../../support/world';

Then('validate aggregator propierties', { timeout: 50 * 2500 }, async function (this: CustomWorld) {
  const endpoint = CustomWorld.getStoreData('endpoint');
  logger.warn(endpoint);
  const response: any = this.response;
  let asset: string = '';
  let against: string = '';
  let legalEntity: string = '';
  const order: any = Object.values(response.body.stages).find((stage: any) => stage.stageType === 'ORDER');
  const withdraw: any = Object.values(response.body.stages).find((stage: any) => stage.stageType === 'WITHDRAW');

  switch (endpoint) {
    case '/v2/withdraws':
      asset = response.body.asset;
      legalEntity = response.body.legalEntity;

      validateEntity(asset, legalEntity);
      break;

    case '/v2/orders':
      against = response.body.against;
      legalEntity = response.body.legalEntity;

      validateEntity(against, legalEntity);
      break;

    case '/v2/synthetics/ramp-off':
      validateEntitySyntheticOrder(order.against, order.legalEntity);
      validateEntitySyntheticWithdraw(withdraw.asset, withdraw.legalEntity);
      break;

    default:
      break;
  }
});
