const { Given, When, Then, Before } = require('@cucumber/cucumber');
const { expect } = require('chai');
const request = require('supertest');
import { CustomWorld, UserData } from '../../../../support/world';
import {
  bankingOnboardingApiCambio,
  criptoDepositApiCrypto,
  fiatDepositApiCambio,
  fiatDepositApiCrypto,
  inicialOnboardingApiCambio,
  validateOnboardingApiCambio,
  fiatWithdrawApiCrypto,
  inicialOnboardingApiCrypto,
  inicialOnboardingApiCryptoV2,
  bankingOnboardingApiCrypto,
  fiatWithdrawApiCryptoV2,
  withdrawLockApiCryptoV2,
  twoFAAuthApiCambio,
  rampOffExchange,
  senderPaymentSynthetic
} from '../../../../support/utils/utils';
import logger from '../../../../support/utils/logger';
import { EndpointHandlerFactory } from '../../../../support/factory/endpointHandlerFactory';

const chainArray = ['WORLDCHAIN', 'BSC', 'ETHEREUM', 'POLYGON', 'BINANCE', 'BASE', 'ARBITRUM', 'OPTIMISM'];

Given('The API key is available {string}', function (this: CustomWorld, APIkey: string) {
  // this.apiKey = "BM2YZT6-MR5M5YY-QYZ5CY4-E8E9HYB";
  this.apiKey = APIkey;
});

Given('The API secret is available {string}', function (this: CustomWorld, APIsecret: string) {
  this.apiSecret = APIsecret;
});

Given('The token is available {string}', function (this: CustomWorld, token: string) {
  this.token = CustomWorld.getStoreData('accessToken') || token;
});

Given('The urlBase is available {string}', function (this: CustomWorld, urlBase: string) {
  this.urlBase = urlBase;
});

When('Assign the value {string} to the variable {string}', function (this: CustomWorld, value: string, variable: string) {
  if (!this.userData) {
    this.userData = {} as UserData;
  }

  // Si se pide sessionId en el step, se autoincrementa
  if (variable === 'sessionId') {
    this.userData[variable] = CustomWorld.getSessionId(value);
    return;
  }

  if (variable === 'hash') {
    this.userData[variable] = CustomWorld.getHashCrypto();
    // console.log(this.userData[variable]);
    return;
  }

  if (variable === 'externalId') {
    if (value === 'externalIdRepeat') {
      this.userData[variable] = 'externalIdRepeat';
      return;
    }
    if (value === '') {
      this.userData[variable] = '123';
      return;
    }
    if (value === 'true') {
      this.userData[variable] = true;
      return;
    }

    this.userData[variable] = CustomWorld.getExternalId(value);
    CustomWorld.setStoreData(variable, this.userData[variable]);
    return;
  }

  if (variable === 'networkId') {
    this.userData[variable] = CustomWorld.getNetworkId();
    return;
  }

  if (variable === 'billId') {
    this.userData[variable] = CustomWorld.getStoreData('billId');
    return;
  }

  // Se utiliza pixCode tambien para lockCode
  if (value === 'pixCode') {
    // console.log(CustomWorld.getStoreData("pixCode"));
    this.userData[variable] = CustomWorld.getStoreData('pixCode') || '';
  } else {
    this.userData[variable] = value;
    CustomWorld.setStoreData(variable, value);
  }
});

When('Assign the value {int} to the variable {string}', function (this: CustomWorld, value: number, variable: string) {
  if (!this.userData) {
    this.userData = {} as UserData;
  }
  this.userData[variable] = value;
});

When('Assign the value to the variable', function (this: CustomWorld, dataTable: any) {
  if (!this.userData) {
    this.userData = {} as UserData;
  }

  // Si no existe userData se leen los examples
  dataTable.rawTable.forEach(([key, value]: [string, string]) => {
    this.userData[key] = value;
    if (key === 'sessionId') {
      this.userData[key] = CustomWorld.getSessionId(value);
      return;
    }
  });
});

When(
  'Execute the POST method on the endpoint {string}',
  {
    timeout: 70 * 1000
  },
  async function (this: CustomWorld, endpoint: string) {
    try {
      // if (CustomWorld.getStoreData('userId') !== undefined && endpoint !== '/v3/api/onboarding-actions/upload-identity-image') {
      //   paramEndpoint = paramEndpoint.replace('{userId}', CustomWorld.getStoreData('userId') || '');
      //   // CustomWorld.setStoreData("userId", "");
      // }
      // // API-Cripto
      // if (endpoint === '/onboarding-actions/initial') {
      //   // Onboarding inicial V1
      //   this.userData = inicialOnboardingApiCrypto(this.userData);
      // } else if (endpoint === '/v2/onboarding-actions/initial') {
      //   // Onboarding inicial V2
      //   this.userData = inicialOnboardingApiCryptoV2(this.userData);
      // } else if (endpoint === '/v2/onboarding-actions/add-bank-account') {
      //   this.userData = bankingOnboardingApiCrypto(this.userData);
      // } else if (endpoint === '/v1/transaction/deposit') {
      //   // Deposito cripto
      //   this.userData = criptoDepositApiCrypto(this.userData);
      // } else if (endpoint === '/v1/fiat/deposit') {
      //   // Deposito fiat
      //   this.userData = fiatDepositApiCrypto(this.userData);
      // } else if (endpoint === '/v1/transaction/withdraw') {
      //   this.userData = fiatWithdrawApiCrypto(this.userData);
      // } else if (endpoint === '/v1/synthetics/ramp-on' || endpoint === '/v2/payment-locks' || endpoint === '/v2/synthetics/qr-payment') {
      //   logger.debug(this.userData.exchange);
      //   if (this.userData.exchange) this.userData = senderPaymentSynthetic(this.userData);
      //   this.userData.userAnyId = this.userData.userAnyId ?? CustomWorld.getStoreData('userId');
      // } else if (endpoint === '/v1/synthetics/ramp-off' && this.userData.against !== 'ARS') {
      //   this.userData = rampOffExchange(this.userData);
      // } else if (endpoint === '/v1/fiat/withdraw' && this.userData.coin === 'CRC') {
      //   // V2
      //   this.userData.cbu = '';
      // } else if (endpoint === '/v2/withdraws') {
      //   this.userData = fiatWithdrawApiCryptoV2(this.userData);
      // } else if (endpoint === '/v2/withdraw-locks') {
      //   this.userData = withdrawLockApiCryptoV2(this.userData);
      //   // API-Cambio
      // } else if (endpoint === '/v3/api/onboarding-actions/initial') {
      //   // Onboarding inicial
      //   this.userData = inicialOnboardingApiCambio(this.userData);
      // } else if (
      //   endpoint === '/v3/api/onboarding-actions/upload-identity-image' ||
      //   endpoint === '/v3/api/onboarding-actions/upload-selfie-image' ||
      //   endpoint === '/v3/api/onboarding-actions/upload-pep-documentation' ||
      //   endpoint === '/onboarding-actions/upload-identity-image' ||
      //   endpoint === '/onboarding-actions/upload-selfie-image' ||
      //   endpoint === '/v2/onboarding-actions/upload-identity-image' ||
      //   endpoint === '/v2/onboarding-actions/upload-selfie-image'
      // ) {
      //   // Onboarding Docs Validate
      //   this.userData = validateOnboardingApiCambio(this.userData);
      // } else if (endpoint === '/v3/onboarding-actions/add-bank-account') {
      //   // Onboarding Add Bank Account
      //   this.userData = bankingOnboardingApiCambio(this.userData);
      // } else if (endpoint === '/v3/admin/banking/deposit') {
      //   // Deposito fiat API-Cambio
      //   console.log(CustomWorld.getStoreData('thresholdAmount'));

      //   this.userData = fiatDepositApiCambio(this.userData);
      // } else if (endpoint === '/v3/{twoFaCode}') {
      //   paramEndpoint = paramEndpoint.replace('{twoFaCode}', CustomWorld.getStoreData('redirectUrl') || '');
      //   this.userData = twoFAAuthApiCambio(this.userData);
      //   console.log(this.userData);
      // }

      let paramEndpoint = endpoint;
      const factory = new EndpointHandlerFactory();
      const handlers = factory.getHandlers(endpoint, this.userData);

      for (const handler of handlers) {
        if (handler.modifyEndpoint) {
          paramEndpoint = handler.modifyEndpoint(paramEndpoint, this);
        }
        this.userData = handler.handle(this.userData, this);
      }

      console.log('API payload:', JSON.stringify(this.userData, null, 2));

      if (/admin/.test(endpoint)) this.urlBase = 'https://api-qa.tiendacrypto.com';
      console.log(this.urlBase);
      console.log(paramEndpoint);

      this.response = await request(this.urlBase)
        .post(paramEndpoint)
        .set('md-api-key', this.apiKey)
        .set('x-api-secret', this.apiSecret)
        .set('x-access-token', CustomWorld.getStoreData('JWT') ?? this.token)
        .set('User-Agent', 'PostmanRuntime/7.44.1')
        .send(this.userData);

      CustomWorld.setStoreData('responseBDD', this.response.body);

      console.log(this.response.status);
      // console.log('API response:', JSON.stringify(this.response.body, null, 2));
      console.log(this.response.body);

      this.userData = {};
      this.urlBase = 'https://sandbox.manteca.dev/crypto';
    } catch (error: any) {
      //   if (error.response) {
      //     // this.attach(`API Error Response: ${JSON.stringify(error.response.body || error.response.text || {}, null, 2)}`, 'text/plain');
      //     // this.response = error.response;
      //   }
      //   throw error;
    }
  }
);

When(
  'Execute the GET method on the endpoint {string}',
  {
    timeout: 50 * 1000
  },

  async function (this: CustomWorld, endpoint: string) {
    const paramEndpoint = endpoint
      .replace('{syntheticId}', CustomWorld.getStoreData('syntheticId') || '')
      .replace('{withdrawAnyId}', CustomWorld.getStoreData('withdrawId') || '')
      .replace('{orderNumberId}', CustomWorld.getStoreData('withdrawId') || '');
    try {
      console.log('API endpoint:', paramEndpoint);

      this.response = await request(this.urlBase)
        .get(paramEndpoint)
        .set('md-api-key', this.apiKey)
        .set('x-access-token', CustomWorld.getStoreData('JWT') ?? this.token)
        .set('User-Agent', 'PostmanRuntime/7.44.1');
      // console.log('API response:', JSON.stringify(this.response.body, null, 2));
    } catch (error: unknown) {
      const err = error as {
        response?: any;
      };
      this.response = err.response || {
        status: 500,
        body: {
          message: 'Error desconocido'
        }
      };
      console.error('Error en GET:', this.response.body);
      throw error;
    }
  }
);

Then('Obtain a response {int}', function t(this: CustomWorld, statusCode: number) {
  if (statusCode === 206) {
    expect(this.response.status).to.equal(statusCode);
    expect(this.response.body.code).to.equal('');
    return;
  }

  expect(this.response.status).to.equal(statusCode);

  // console.log("Response body:", this.response.body);

  if (this.response.body.code) {
    CustomWorld.setStoreData('pixCode', this.response.body.code);
    // console.log(CustomWorld.getStoreData("pixCode"));
  }

  if (chainArray.includes(Object.keys(this.response.body)[0]) && this.response.body[Object.keys(this.response.body)[0]].code) {
    CustomWorld.setStoreData('code', this.response.body[Object.keys(this.response.body)[0]].code);
  }

  // POSIBLE ERROR EN OTROS MODULOS
  if (this.response.body.id && this.response.body.status === 'STARTING') CustomWorld.setStoreData('syntheticId', this.response.body.id);

  if (this.response.body.userId) {
    CustomWorld.setStoreData('userId', this.response.body.userId);
  }

  if (this.response.body.userNumberId) {
    CustomWorld.setStoreData('userNumberId', this.response.body.userNumberId);
  }

  if (this.response.body.numberId) {
    CustomWorld.setStoreData('withdrawId', this.response.body.numberId);
  }

  if (Array.isArray(this.response.body) && this.response.body[0]?.numberId) {
    CustomWorld.setStoreData('withdrawId', this.response.body[0].numberId);
  }

  if (this.response.body.stages && this.response.body.stages.withdrawId) {
    const stage = this.response.body.stages[1];
    CustomWorld.setStoreData('withdrawId', stage.withdrawId);
  }
  if (this.response.body.status === 'STARTING' && this.response.body.details.depositAddress) {
    CustomWorld.setStoreData('depositAddress', this.response.body.details.depositAddress);
  }
  if (this.response.body.url) {
    CustomWorld.setStoreData('awsUrl', this.response.body.url);
  }
  if (this.response.body.status === 'STARTING' && this.response.body.stages && this.response.body.stages['1'] && this.response.body.stages['1'].thresholdAmount) {
    CustomWorld.setStoreData('thresholdAmount', this.response.body.stages['1'].thresholdAmount);
  }
  if (this.response.body.stages && this.response.body.stages['1'] && this.response.body.stages['1'].asset) {
    CustomWorld.setStoreData('coin', this.response.body.stages['1'].asset);
  }
  if (this.response.body.user && this.response.body.user.id) {
    console.log(this.response.body.user.id);
    CustomWorld.setStoreData('userId', this.response.body.user.id);
    console.log(CustomWorld.getStoreData('userId'));
  }
  if (this.response.body.redirectUrl) {
    CustomWorld.setStoreData('redirectUrl', this.response.body.redirectUrl);
  }
  if (this.response.body.accessToken) {
    CustomWorld.setStoreData('accessToken', this.response.body.accessToken);
  }
});

Then('The price LockPix is created', function (this: CustomWorld) {
  expect(this.response.body).to.be.an('object');

  const body = this.response.body;

  expect(body).to.have.property('code').that.is.a('string');
  expect(body).to.have.property('companyId').that.is.a('string');
  expect(body).to.have.property('userId').that.is.a('string');
  expect(body).to.have.property('userNumberId').that.is.a('string');
  if (body.hasOwnProperty('userExternalId')) expect(body.userExternalId).to.be.a('string');
  expect(body).to.have.property('paymentRecipientName').that.is.a('string');
  expect(body).to.have.property('paymentRecipientLegalId').that.is.a('string');
  expect(body).to.have.property('paymentAssetAmount').that.is.a('string');
  expect(body).to.have.property('paymentAsset').that.is.a('string');
  expect(body).to.have.property('paymentPrice').that.is.a('string');
  expect(body).to.have.property('paymentAgainstAmount').that.is.a('string');
  expect(body).to.have.property('expireAt').that.is.a('string');
  expect(body).to.have.property('creationTime').that.is.a('string');
});

Then('The payment synthetic is created', function (this: CustomWorld) {
  expect(this.response.body).to.be.an('object');
  // expect(this.response.body.stages).to.be.an("array").that.is.not.empty;
});
