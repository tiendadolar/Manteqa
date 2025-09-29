const { Given, When, Then, Before } = require('@cucumber/cucumber');
const { expect } = require('chai');
const request = require('supertest');
const md = require('@md/math');
import { NETWORKS_MAPPINGS } from '../../../../support/constants/constantsNetworks';
import { cryptoDepositHelper, cryptoDepositHelper2, fiatDepositHelper } from '../../../../support/helpers/depositHelper';
import { validateRes } from '../../../../support/helpers/requestHelper';
import logger from '../../../../support/utils/logger';
import { CustomWorld, UserData } from '../../../../support/world';

Then('Execute crypto deposit', { timeout: 500 * 1000 }, async function (this: CustomWorld) {
  const withdrawNetwork = CustomWorld.getStoreData('withdrawNetwork');
  const response = this.response.body;
  const isTron = Object.keys(response.details.depositAddresses).length === 1 && response.details.depositAddresses.hasOwnProperty('TRON');
  const urlBase: string = this.urlBase;
  const endpoint: string = '/v1/transaction/deposit';
  const apiKEY: string = 'C10XB2Z-AG243CS-G42KB2M-4085WTF';
  const apiSecret: string = this.apiSecret;
  const from: string = isTron ? 'TB32aawPahWHakN9YPCnshYXP5WXnByCPm' : '0x9bD31d82B6212dd60a9328CCe7277161e5975fB5';
  const to: string = isTron ? response.details.depositAddresses.TRON : CustomWorld.getStoreData('depositAddress') || this.to || response.details.depositAddress;
  const wei: string = this.wei || md.toWei(response.stages['1'].thresholdAmount);
  const human: string = CustomWorld.getStoreData('thresholdAmount') || this.human || response.stages['1'].thresholdAmount;
  const ticker: string = this.ticker || response.details.paymentAgainstAsset || response.details.paymentAgainst || response.stages['1'].asset;
  const chain: any = isTron ? 9 : NETWORKS_MAPPINGS[withdrawNetwork] || 0;

  logger.info('Executing crypto deposit for synthetic payment...');
  await cryptoDepositHelper(urlBase, endpoint, apiKEY, apiSecret, from, to, wei, human, ticker, chain);
});

Then('Execute crypto admin deposit', { timeout: 500 * 1000 }, async function (this: CustomWorld) {
  const response: any = this.response.body;
  const isTron = Object.keys(response.details.depositAddresses).length === 1 && response.details.depositAddresses.hasOwnProperty('TRON');
  const urlBase: string = 'https://api-qa.tiendacrypto.com';
  const endpoint: string = '/v1/admin/deposit/crypto';
  const token: string = CustomWorld.getStoreData('JWT');
  const from: string = isTron ? 'TB32aawPahWHakN9YPCnshYXP5WXnByCPm' : '0x9bD31d82B6212dd60a9328CCe7277161e5975fB5';
  const to: string = isTron ? response.details.depositAddresses.TRON : CustomWorld.getStoreData('depositAddress') || this.to || response.details.depositAddress;
  const amount: string = CustomWorld.getStoreData('thresholdAmount') || this.human || response.stages['1'].thresholdAmount;
  const ticker: string = this.ticker || response.details.paymentAgainstAsset || response.details.paymentAgainst || response.stages['1'].asset;
  const chain: any = isTron ? 9 : this.chain || 0;
  logger.debug(ticker);

  logger.info('Executing crypto deposit for synthetic payment...');
  await cryptoDepositHelper2(urlBase, endpoint, token, from, to, amount, ticker, chain);
});

Then('Execute fiat deposit', { timeout: 500 * 1000 }, async function (this: CustomWorld) {
  const response = this.response.body;
  const urlBase: string = this.urlBase;
  const endpoint: string = '/v1/fiat/deposit';
  const apiKEY: string = 'C10XB2Z-AG243CS-G42KB2M-4085WTF';
  const apiSecret: string = this.apiSecret;
  const userId: string = CustomWorld.getStoreData('userNumberId') || this.userNumberId || response.userId;
  const amount: string = CustomWorld.getStoreData('thresholdAmount') || this.amount || response.stages['1'].thresholdAmount;
  const coin: string = CustomWorld.getStoreData('coin') || this.coin || response.details.paymentAgainst;

  logger.info('Executing fiat deposit for synthetic payment...');
  await fiatDepositHelper(urlBase, endpoint, apiKEY, apiSecret, userId, amount, coin);
});
