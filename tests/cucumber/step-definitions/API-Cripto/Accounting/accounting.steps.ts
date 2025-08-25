const { Given, When, Then, Before } = require('@cucumber/cucumber');
const { expect } = require('chai');
const request = require('supertest');
import { getCompanyDebtBalance, getUserDebtBalance } from '../../../../support/helpers/accountingHelper';
import logger from '../../../../support/utils/logger';
import { CustomWorld, UserData } from '../../../../support/world';

Then('Obtain a company debt {string} balance', { timeout: 500 * 1000 }, async function (this: CustomWorld, fiat: string) {
  const urlBase = this.urlBase;
  const endpoint = '/v2/accounting/debt';
  const apiKEY = this.apiKey;
  const coin: any = fiat.toUpperCase();
  const againstAmountOperated = CustomWorld.getStoreData('againstAmountOperated');
  const paymentAgainstAmount = CustomWorld.getStoreData('paymentAgainstAmount');
  let thereIsDepositStage: Boolean = CustomWorld.getStoreData('depositStage') === undefined ? false : CustomWorld.getStoreData('depositStage');

  await getCompanyDebtBalance(urlBase, endpoint, apiKEY, againstAmountOperated, paymentAgainstAmount, thereIsDepositStage, coin);
});

Then('Obtain {string} balance for {string} user', { timeout: 500 * 1000 }, async function (this: CustomWorld, fiat: string, userAnyId: string) {
  const urlBase = this.urlBase;
  const endpoint = `/v2/user-balances/${userAnyId}`;
  const apiKEY = this.apiKey;
  const currency: any = fiat.toUpperCase();
  const isSpecialCurrency = currency === 'PEN'; // Add other special currencies if needed
  let notDepositStage: Boolean = CustomWorld.getStoreData('notDepositStage') === undefined ? false : CustomWorld.getStoreData('notDepositStage');
  let paymentAmount = CustomWorld.getStoreData('paymentAgainstAmount') === undefined ? CustomWorld.getStoreData('againstAmountOperated') : CustomWorld.getStoreData('paymentAgainstAmount');

  await getUserDebtBalance(urlBase, endpoint, apiKEY, paymentAmount, currency, isSpecialCurrency, notDepositStage);
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
