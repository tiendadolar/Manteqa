const request = require('supertest');
const { expect } = require('chai');
import logger from '../utils/logger';
import { CustomWorld } from '../world';

const getInicialDebtBalance = (response: any, coin: string) => {
  if (response.hasOwnProperty(coin)) {
    CustomWorld.setStoreData('companyAccountingInfo', response[coin]);
  } else {
    CustomWorld.setStoreData('companyAccountingInfo', '0');
  }
};

const compareDebtBalance = (thereIsDepositStage: Boolean, response: any, coin: string, againstAmountOperated: string, paymentAgainstAmount: string) => {
  const companyAccountingInfo = CustomWorld.getStoreData('companyAccountingInfo');
  let aquiredDebt: number = 0;
  let instantDebt: number = 0;

  if (thereIsDepositStage) {
    expect(parseFloat(response[coin])).to.be.closeTo(parseFloat(CustomWorld.getStoreData('companyAccountingInfo')), 0.02);
    logger.info(`Expected Debt Balance: ${CustomWorld.getStoreData('companyAccountingInfo')}, Actual Debt Balance: ${response[coin]}`);
    return;
  }

  againstAmountOperated !== undefined ? (instantDebt = parseFloat(againstAmountOperated)) : (instantDebt = parseFloat(paymentAgainstAmount));

  aquiredDebt = parseFloat(companyAccountingInfo) + instantDebt;
  logger.info(`Expected Debt Balance: ${aquiredDebt}, Payment Amount: ${instantDebt}, Actual Debt Balance: ${response[coin]}`);
  expect(parseFloat(response[coin])).to.be.closeTo(aquiredDebt, 0.02);

  CustomWorld.clearStoreData();
};

export const getCompanyDebtBalance = async (
  urlBase: string,
  endpoint: string,
  apiKEY: string,
  againstAmountOperated: string,
  paymentAgainstAmount: string,
  thereIsDepositStage: Boolean,
  coin: string
): Promise<any> => {
  const response = await request(urlBase).get(endpoint).set('User-Agent', 'PostmanRuntime/7.44.1').set('md-api-key', apiKEY);

  if (againstAmountOperated !== undefined || paymentAgainstAmount !== undefined) {
    await compareDebtBalance(thereIsDepositStage, response.body, coin, againstAmountOperated, paymentAgainstAmount);
    return;
  } else {
    await getInicialDebtBalance(response.body, coin);
  }
};

export const getUserDebtBalance = async (
  urlBase: string,
  endpoint: string,
  apiKEY: string,
  paymentAmount: any,
  currency: string,
  isSpecialCurrency: Boolean,
  notDepositStage: Boolean
): Promise<any> => {
  const response = await request(urlBase).get(endpoint).set('User-Agent', 'PostmanRuntime/7.44.1').set('md-api-key', apiKEY);
  const { balance } = response.body;

  if (CustomWorld.getStoreData('userBalance') === undefined && paymentAmount !== undefined) paymentAmount = undefined;

  if (!(currency in balance)) {
    CustomWorld.setStoreData('userBalance', '0');
    return;
  }

  if (paymentAmount === undefined) {
    CustomWorld.setStoreData('userBalance', String(balance[currency]));
    logger.info(`User balance for ${currency}: ${CustomWorld.getStoreData('userBalance')}`);
    return;
  }

  const initialBalance = parseFloat(CustomWorld.getStoreData('userBalance') || 0);
  const currentBalance = parseFloat(String(balance[currency]));
  const expectedBalance = isSpecialCurrency || notDepositStage ? initialBalance - parseFloat(paymentAmount) : initialBalance;
  logger.info(`Initial Balance: ${initialBalance}, Payment Amount: ${paymentAmount}, Current Balance: ${currentBalance}, Expected Balance: ${expectedBalance}`);
  expect(currentBalance).to.be.closeTo(expectedBalance, 0.02);
  CustomWorld.clearStoreData();
};
