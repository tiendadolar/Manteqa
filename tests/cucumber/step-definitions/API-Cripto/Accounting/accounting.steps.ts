const { Given, When, Then, Before } = require('@cucumber/cucumber');
const { expect } = require('chai');
const request = require('supertest');
import logger from '../../../../support/utils/logger';
import { CustomWorld, UserData } from '../../../../support/world';

Then('Obtain a company debt {string} balance', { timeout: 500 * 1000 }, async function (this: CustomWorld, fiat: string) {
  const response: any = this.response.body;
  const coin: any = fiat.toUpperCase();
  let aquiredDebt: number = 0;
  let instantDebt: number = 0;
  let thereIsDepositStage: Boolean = CustomWorld.getStoreData('depositStage') === undefined ? false : CustomWorld.getStoreData('depositStage');

  if (CustomWorld.getStoreData('againstAmountOperated') !== undefined || CustomWorld.getStoreData('paymentAgainstAmount') !== undefined) {
    if (thereIsDepositStage) {
      expect(parseFloat(response[coin])).to.be.closeTo(parseFloat(CustomWorld.getStoreData('companyAccountingInfo')), 0.02);
      logger.info(`Expected Debt Balance: ${CustomWorld.getStoreData('companyAccountingInfo')}, Actual Debt Balance: ${response[coin]}`);
      return;
    }

    CustomWorld.getStoreData('againstAmountOperated') !== undefined
      ? (instantDebt = parseFloat(CustomWorld.getStoreData('againstAmountOperated')))
      : (instantDebt = parseFloat(CustomWorld.getStoreData('paymentAgainstAmount')));

    aquiredDebt = parseFloat(CustomWorld.getStoreData('companyAccountingInfo')) + instantDebt;
    logger.info(`Expected Debt Balance: ${aquiredDebt}, Payment Amount: ${instantDebt}, Actual Debt Balance: ${response[coin]}`);
    expect(parseFloat(response[coin])).to.be.closeTo(aquiredDebt, 0.02);

    CustomWorld.clearStoreData();
  } else {
    if (response.hasOwnProperty(coin)) {
      CustomWorld.setStoreData('companyAccountingInfo', response[coin]);
    } else {
      throw new Error(`La moneda ${coin} no está presente en la response`);
    }
  }

  // if (CustomWorld.getStoreData('againstAmountOperated') === undefined) {
  //   console.log('ENTRAAAAAAA AL PRIMER IF');

  //   if (response.hasOwnProperty(coin)) {
  //     CustomWorld.setStoreData('companyAccountingInfo', response[coin]);
  //   } else {
  //     throw new Error(`La moneda ${coin} no está presente en la response`);
  //   }
  // } else if (CustomWorld.getStoreData('paymentAgainstAmount') === undefined) {
  //   if (response.hasOwnProperty(coin)) {
  //     CustomWorld.setStoreData('companyAccountingInfo', response[coin]);
  //   } else {
  //     throw new Error(`La moneda ${coin} no está presente en la response`);
  //   }
  // } else {
  //   console.log('ENTRAAAAAAA AL SEGUNDO IF');
  //   CustomWorld.getStoreData('againstAmountOperated') !== undefined
  //     ? (instantDebt = parseFloat(CustomWorld.getStoreData('againstAmountOperated')))
  //     : (instantDebt = parseFloat(CustomWorld.getStoreData('paymentAgainstAmount')));

  //   aquiredDebt = parseFloat(CustomWorld.getStoreData('companyAccountingInfo')) + instantDebt;
  //   console.log(CustomWorld.getStoreData('companyAccountingInfo'));
  //   console.log(aquiredDebt);

  //   expect(parseFloat(response[coin])).to.be.closeTo(aquiredDebt, 0.02);

  //   CustomWorld.clearStoreData();
  // }
});

Then('Obtain a user in {string} balance', { timeout: 500 * 1000 }, async function (this: CustomWorld, fiat: string) {
  const { balance } = this.response.body;
  const currency = fiat.toUpperCase();
  const isSpecialCurrency = currency === 'PEN'; // Add other special currencies if needed
  let notDepositStage: Boolean = CustomWorld.getStoreData('notDepositStage') === undefined ? false : CustomWorld.getStoreData('notDepositStage');
  let paymentAmount = CustomWorld.getStoreData('paymentAgainstAmount') === undefined ? CustomWorld.getStoreData('againstAmountOperated') : CustomWorld.getStoreData('paymentAgainstAmount');

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
  expect(currentBalance).to.be.equal(expectedBalance);
  CustomWorld.clearStoreData();

  // const response: any = this.response.body;
  // const coin: any = fiat.toUpperCase();
  // let finalUserBalance: number = 0;

  // if (coin === 'PEN') {
  //   if (CustomWorld.getStoreData('paymentAgainstAmount') === undefined) {
  //     if (response.balance.hasOwnProperty(coin)) {
  //       CustomWorld.setStoreData('userBalance', response.balance[coin]);
  //     } else {
  //       throw new Error(`La moneda ${coin} no está presente en la response`);
  //     }
  //   } else {
  //     finalUserBalance = parseFloat(CustomWorld.getStoreData('userBalance')) - parseFloat(CustomWorld.getStoreData('paymentAgainstAmount'));
  //     expect(parseFloat(response.balance[coin])).to.equal(finalUserBalance);
  //     CustomWorld.clearStoreData();
  //   }
  // }

  // if (CustomWorld.getStoreData('paymentAgainstAmount') === undefined) {
  //   if (response.balance.hasOwnProperty(coin)) {
  //     CustomWorld.setStoreData('userBalance', response.balance[coin]);
  //   } else {
  //     throw new Error(`La moneda ${coin} no está presente en la response`);
  //   }
  // } else {
  //   console.log(CustomWorld.getStoreData('userBalance'));
  //   console.log(response.balance[coin]);
  //   // finalUserBalance = parseFloat(CustomWorld.getStoreData('userBalance')) + parseFloat(CustomWorld.getStoreData('paymentAgainstAmount'));
  //   expect(parseFloat(response.balance[coin])).to.equal(parseFloat(CustomWorld.getStoreData('userBalance')));
  //   CustomWorld.clearStoreData();
  // }
});

Then('Obtain refund on user in {string} balance', { timeout: 500 * 1000 }, async function (this: CustomWorld, fiat: string) {
  const response: any = this.response.body;
  const coin: any = fiat.toUpperCase();
  let aquiredCred: number = 0;
  let refundAmount: number = 0;

  if (CustomWorld.getStoreData('againstAmountOperated') !== undefined || CustomWorld.getStoreData('paymentAgainstAmount') !== undefined) {
    CustomWorld.getStoreData('againstAmountOperated') !== undefined
      ? (refundAmount = parseFloat(CustomWorld.getStoreData('againstAmountOperated')))
      : (refundAmount = parseFloat(CustomWorld.getStoreData('paymentAgainstAmount')));

    aquiredCred = parseFloat(CustomWorld.getStoreData('userBalance')) + refundAmount;
    expect(parseFloat(response.balance[coin])).to.be.closeTo(aquiredCred, 0.02);

    CustomWorld.clearStoreData();
  } else {
    if (response.balance.hasOwnProperty(coin)) {
      CustomWorld.setStoreData('userBalance', response.balance[coin]);
    } else {
      throw new Error(`La moneda ${coin} no está presente en la response`);
    }
  }
});

Then('Obtain refund on company cred {string} balance', { timeout: 500 * 1000 }, async function (this: CustomWorld, fiat: string) {
  const response: any = this.response.body;
  const coin: any = fiat.toUpperCase();
  let aquiredCred: number = 0;
  let refundAmount: number = 0;

  if (CustomWorld.getStoreData('againstAmountOperated') !== undefined || CustomWorld.getStoreData('paymentAgainstAmount') !== undefined) {
    CustomWorld.getStoreData('againstAmountOperated') !== undefined
      ? (refundAmount = parseFloat(CustomWorld.getStoreData('againstAmountOperated')))
      : (refundAmount = parseFloat(CustomWorld.getStoreData('paymentAgainstAmount')));

    aquiredCred = parseFloat(CustomWorld.getStoreData('companyAccountingInfo')) + refundAmount;
    console.log(`Expected Cred Balance: ${aquiredCred}, Actual Cred Balance: ${response[coin]}`);

    expect(parseFloat(response[coin])).to.be.closeTo(aquiredCred, 0.02);

    CustomWorld.clearStoreData();
  } else {
    if (response.hasOwnProperty(coin)) {
      CustomWorld.setStoreData('companyAccountingInfo', response[coin]);
    } else {
      throw new Error(`La moneda ${coin} no está presente en la response`);
    }
  }
});
