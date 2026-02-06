const request = require('supertest');
const { expect } = require('chai');
import logger from '../utils/logger';
import { compareBalanceFlowValidator, compareBalanceTypeValidator, thereIsBalanceCurrencyValidator, thereIsFinalBalanceCurrencyValidator } from '../validators/userBalanceValidators';
import { CustomWorld } from '../world';
import { apiRequest } from './requestHelper';
import { getUserInfoHelper } from './userHelper';

const getInicialDebtBalance = (response: any, coin: string) => {
  if (response.hasOwnProperty(coin)) {
    CustomWorld.setStoreData('companyAccountingInfo', response[coin]);
  } else {
    CustomWorld.setStoreData('companyAccountingInfo', '0');
  }
  logger.info(`Initial Company Debt Balance for ${coin}: ${CustomWorld.getStoreData('companyAccountingInfo')}`);
};

const compareDebtBalance = (thereIsDepositStage: Boolean, response: any, coin: string, againstAmountOperated: string, paymentAgainstAmount: string) => {
  const companyAccountingInfo = CustomWorld.getStoreData('companyAccountingInfo');
  let aquiredDebt: number = 0;
  let instantDebt: number = 0;

  if (thereIsDepositStage) {
    expect(parseFloat(response[coin])).to.be.closeTo(parseFloat(CustomWorld.getStoreData('companyAccountingInfo')), 0.02);
    logger.info(`Expected Debt Balance: ${CustomWorld.getStoreData('companyAccountingInfo')}, Actual Debt Balance: ${response[coin]}`);
    CustomWorld.clearStoreData();
    return;
  }

  logger.warn(paymentAgainstAmount);
  logger.warn(againstAmountOperated);

  againstAmountOperated !== undefined ? (instantDebt = parseFloat(againstAmountOperated)) : (instantDebt = parseFloat(paymentAgainstAmount));

  aquiredDebt = parseFloat(companyAccountingInfo) + instantDebt;
  logger.info(`Expected Debt Balance: ${aquiredDebt}, Payment Amount: ${instantDebt}, Actual Debt Balance: ${response[coin]}`);
  expect(parseFloat(response[coin])).to.be.closeTo(aquiredDebt, 0.02);

  CustomWorld.clearStoreData();
};

export const getCompanyDebtBalance = async (
  urlBase: string,
  endpoint: string,
  apiKey: string,
  againstAmountOperated: string,
  paymentAgainstAmount: string,
  thereIsDepositStage: Boolean,
  coin: string
): Promise<any> => {
  const response = await apiRequest({ urlBase, endpoint, method: 'get', apiKey });
  // const response = await request(urlBase).get(endpoint).set('User-Agent', 'PostmanRuntime/7.44.1').set('md-api-key', apiKey);

  if (againstAmountOperated !== undefined || paymentAgainstAmount !== undefined) {
    await compareDebtBalance(thereIsDepositStage, response.body, coin, againstAmountOperated, paymentAgainstAmount);
    return response;
  } else {
    await getInicialDebtBalance(response.body, coin);
  }
  return response;
};

export const getUserDebtBalance = async (
  urlBase: string,
  endpoint: string,
  apiKey: string,
  paymentAmount: any,
  currency: string,
  isSpecialCurrency: Boolean,
  notDepositStage: Boolean
): Promise<any> => {
  const response = await apiRequest({ urlBase, endpoint, method: 'get', apiKey });
  // const response = await request(urlBase).get(endpoint).set('User-Agent', 'PostmanRuntime/7.44.1').set('md-api-key', apiKEY);
  const { balance } = response.body;
  // We ser userExchange to compare with type payment (user exchange arg paying pix e.j.)
  // CustomWorld.setStoreData('userExchange', response.body.exchange, true);
  // logger.error(CustomWorld.getStoreData('userExchange'));

  if (CustomWorld.getStoreData('userBalance') === undefined && paymentAmount !== undefined) paymentAmount = undefined;

  if (!(currency in balance)) {
    CustomWorld.setStoreData('userBalance', '0');
    return;
  }

  if (paymentAmount === undefined) {
    CustomWorld.setStoreData('userBalance', String(balance[currency]));
    logger.info(`User balance for ${currency}: ${CustomWorld.getStoreData('userBalance')}`);
    CustomWorld.clearStoreData();
    return response;
  }

  const initialBalance = parseFloat(CustomWorld.getStoreData('userBalance') || 0);
  const currentBalance = parseFloat(String(balance[currency]));
  const expectedBalance = isSpecialCurrency || notDepositStage ? initialBalance - parseFloat(paymentAmount) : initialBalance;
  logger.info(`Initial Balance: ${initialBalance}, Payment Amount: ${paymentAmount}, Current Balance: ${currentBalance}, Expected Balance: ${expectedBalance}`);
  expect(currentBalance).to.be.closeTo(expectedBalance, 0.02);
  CustomWorld.clearStoreData();
  return response;
};

export const getCompanyCreditBalanceHelper = async (urlBase: string, endpoint: string, apiKey: string, currency: string) => {
  // call API endpoint to get company debt balance
  const response = await apiRequest({ urlBase, endpoint, method: 'get', apiKey });
  // take only balance property from response
  const balance = response.body;

  // validate if we have inicial balance stored and set final balance accordingly
  thereIsFinalBalanceCurrencyValidator(balance, currency, 'inicialCreditBalance', 'finalCreditBalance');

  // validate if currency exists in balance object and set userBalance accordingly
  thereIsBalanceCurrencyValidator(balance, currency, 'inicialCreditBalance', 'finalCreditBalance');

  return response;
};

export const getCompanyDebtBalanceHelper = async (urlBase: string, endpoint: string, apiKey: string, currency: string) => {
  // call API endpoint to get company debt balance
  const response = await apiRequest({ urlBase, endpoint, method: 'get', apiKey });
  // take only balance property from response
  const balance = response.body;

  // validate if we have inicial balance stored and set final balance accordingly
  thereIsFinalBalanceCurrencyValidator(balance, currency, 'inicialDebtBalance', 'finalDebtBalance');

  // validate if currency exists in balance object and set userBalance accordingly
  thereIsBalanceCurrencyValidator(balance, currency, 'inicialDebtBalance', 'finalDebtBalance');

  return response;
};

export const getUserBalanceHelper = async (urlBase: string, endpoint: string, apiKey: string, currency: string): Promise<any> => {
  // call API endpoint to get user balance
  const response = await apiRequest({ urlBase, endpoint, method: 'get', apiKey });
  // take only balance property from response
  const { balance } = response.body;
  // We ser userExchange to compare with type payment (user exchange arg paying pix e.j.)
  // CustomWorld.setStoreData('userExchange', response.body.exchange, true);
  // logger.error(CustomWorld.getStoreData('userExchange'));

  // validate if we have inicial balance stored and set final balance accordingly
  thereIsFinalBalanceCurrencyValidator(balance, currency, 'inicialUserBalance', 'finalUserBalance');

  // validate if currency exists in balance object and set userBalance accordingly
  thereIsBalanceCurrencyValidator(balance, currency, 'inicialUserBalance', 'finalUserBalance');

  return response;
};

export const analizeBalances = (charge?: string, inicial?: string, final?: string): any => {
  const balances = compareBalanceTypeValidator(charge, inicial, final);
  compareBalanceFlowValidator(balances.inicialBalance, balances.finalBalance);
};

export const compareBalance = (compareType: string, res: any): any => {
  if ((compareType = 'user')) {
    const finalUserBalance = parseFloat(CustomWorld.getStoreData('finalUserBalance'));
    const balance = parseFloat(CustomWorld.getStoreData('inicialUserBalance')) - parseFloat(res.body.stages['1'].amount);

    expect(finalUserBalance).to.be.closeTo(balance, 0.02);
    logger.info(`In this case we operated onto user balance`);
  }
};
