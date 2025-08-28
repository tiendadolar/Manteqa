const request = require('supertest');
const qr = require('qrcode');
const md = require('@md/math');
const speakeasy = require('speakeasy');
import { use } from 'chai';
import { CustomWorld } from '../world';
import logger from './logger';
const gp = require('coingecko-api');

const gpClient = new gp();

// Not Implemented
const getUserByLegalId = async (legalId: string, url: string, token: string) => {
  const urlBase = `https://api-qa.tiendacrypto.com`;
  const endpoint = `/v1/admin/user/search?keyword=${legalId}&page=1&limit=10`;

  const response = await request(urlBase).get(endpoint).set('x-access-token', token).set('User-Agent', 'PostmanRuntime/7.44.1');
  return response.body.users.numberId;
};

// Not Implemented
export const generateQRCode = async (text: string): Promise<void> => {
  try {
    await qr.toFile('qr.png', text, {
      color: {
        dark: '#000',
        light: '#FFF'
      }
    });
    console.log('QR guardado como imagen!');
  } catch (err) {
    console.error('Error generando el QR:', err);
    throw err;
  }
};

export const getParPrices = async (coin: string): Promise<any> => {
  try {
    const prices = await gpClient.simple.price({
      ids: [coin],
      vs_currencies: ['usd', 'ars', 'brl', 'clp', 'cop', 'crc', 'mxn', 'pusd', 'php', 'pen']
    });

    console.log(prices.data);
    return prices.data;
  } catch (error) {
    console.error('Error obteniendo precios:', error);
  }
};

export const delay = (ms: number): Promise<void> => {
  logger.info(`Waiting for synthetic processing...`);
  return new Promise((resolve) => setTimeout(resolve, ms));
};

export const deleteOnbUser = async (userData: any) => {
  const urlBase = `https://api-qa.tiendacrypto.com`;
  const endpoint = `/v1/admin/user`;

  let payload = {
    numberId: getUserByLegalId(userData.legalId, userData.url, userData.token)
  };

  const response = await request(urlBase).delete(endpoint).set('x-access-token', userData.token).set('User-Agent', 'PostmanRuntime/7.44.1').send(payload);
};

//-----API CRIPTO-----//
// Deposito cripto
export const inicialOnboardingApiCrypto = (userData: any) => {
  return {
    email: userData.email,
    legalId: userData.legalId,
    exchange: userData.exchange,
    personalData: {
      sex: userData.sex,
      work: userData.work,
      birthDate: userData.birthDate,
      maritalStatus: userData.maritalStatus,
      isPep: userData.isPep === 'true',
      isFep: userData.isFep === 'true',
      isFatca: userData.isFatca === 'true',
      // isUif: userData.isUif === "true",
      // phoneNumber: userData.phoneNumber, // Esta roto por el momento
      nationality: userData.nationality
    },
    banking: {
      accounts: [
        {
          cbu: userData.ARScbu,
          currency: userData.ARScurrency,
          description: userData.ARSdescription
        },
        {
          cbu: userData.USDcbu,
          currency: userData.USDcurrency,
          description: userData.USDdescription
        }
      ]
    }
  };
};

export const inicialOnboardingApiCryptoV2 = (userData: any) => {
  console.log(userData.nationality);

  if (userData.nationality === 'Argentina') {
    return {
      externalId: userData.externalId,
      email: userData.email,
      legalId: userData.legalId,
      // type: 'BUSINESS',
      exchange: userData.exchange,
      personalData: {
        name: userData.name,
        surname: userData.surname,
        sex: userData.sex,
        work: userData.work,
        birthDate: userData.birthDate,
        maritalStatus: userData.maritalStatus,
        isPep: userData.isPep === 'true',
        isFep: userData.isFep === 'true',
        isFatca: userData.isFatca === 'true',
        phoneNumber: userData.phoneNumber, // Esta roto por el momento
        nationality: userData.nationality,
        address: {
          street: userData.street
        }
      },
      banking: {
        // accounts: [
        //   {
        //     cbu: userData.ARScbu,
        //     currency: userData.ARScurrency,
        //     description: userData.ARSdescription,
        //   },
        //   {
        //     cbu: userData.USDcbu,
        //     currency: userData.USDcurrency,
        //     description: userData.USDdescription,
        //   },
        // ],
      }
    };
  } else {
    return {
      externalId: userData.externalId,
      email: userData.email,
      legalId: userData.legalId,
      // type: 'BUSINESS',
      exchange: userData.exchange,
      personalData: {
        name: userData.name,
        surname: userData.surname,
        sex: userData.sex,
        work: userData.work,
        birthDate: userData.birthDate,
        maritalStatus: userData.maritalStatus,
        isPep: userData.isPep === 'true',
        isFep: userData.isFep === 'true',
        isFatca: userData.isFatca === 'true',
        phoneNumber: userData.phoneNumber, // Esta roto por el momento
        nationality: userData.nationality,
        address: {
          street: userData.street
        }
      },
      banking: {
        // accounts: [
        //   {
        //     cbu: userData.ARScbu,
        //     currency: userData.ARScurrency,
        //     description: userData.ARSdescription,
        //     bank: {
        //       code: userData.bankCode,
        //     },
        //     accountType: userData.accountType,
        //   },
        // ],
      }
    };
  }
};

export const criptoDepositApiCrypto = (userData: any) => {
  if (CustomWorld.getStoreData('thresholdAmount') === undefined) {
    return {
      tx: {
        hash: CustomWorld.getNetworkId(),
        from: userData.from || '0x9bD31d82B6212dd60a9328CCe7277161e5975fB5',
        to: CustomWorld.getStoreData('depositAddress') || userData.to || userData.details.depositAddress,
        value: {
          wei: userData.wei || md.toWei(userData.stages['1'].thresholdAmount),
          human: CustomWorld.getStoreData('thresholdAmount') || userData.human || userData.stages['1'].thresholdAmount
        },
        ticker: userData.ticker || userData.details.paymentAgainstAsset,
        chain: userData.chain || 0
      }
    };
  } else {
    return {
      tx: {
        hash: CustomWorld.getNetworkId(),
        from: userData.from || '0x9bD31d82B6212dd60a9328CCe7277161e5975fB5',
        to: CustomWorld.getStoreData('depositAddress') || userData.to || userData.details.depositAddress,
        value: {
          wei: md.toWei(CustomWorld.getStoreData('thresholdAmount')).toString() || userData.wei || md.toWei(userData.stages['1'].thresholdAmount),
          human: CustomWorld.getStoreData('thresholdAmount') || userData.human || userData.stages['1'].thresholdAmount
        },
        ticker: userData.ticker || userData.details.paymentAgainstAsset,
        chain: userData.chain || 0
      }
    };
  }
};

// Deposito fiat
export const fiatDepositApiCrypto = (userData: any) => {
  return {
    userId: CustomWorld.getStoreData('userNumberId') || userData.userNumberId || userData.userId,
    amount: CustomWorld.getStoreData('thresholdAmount') || userData.amount || userData.stages['1'].thresholdAmount,
    coin: CustomWorld.getStoreData('coin') || userData.coin || userData.details.paymentAgainst
  };
};

export const fiatWithdrawApiCrypto = (userData: any) => {
  return {
    tx: {
      coin: userData.coin,
      amount: (userData.amount * 1000000000000000000).toString(),
      to: userData.to,
      chain: userData.chain
    },
    userId: userData.userId,
    costCode: CustomWorld.getStoreData('pixCode')
  };
};

export const fiatWithdrawApiCryptoV2 = (userData: any) => {
  console.log(CustomWorld.getStoreData('code'));

  if (userData.asset === 'ARS' || userData.asset === 'USD' || userData.asset === 'BRL') {
    return {
      sessionId: CustomWorld.getSessionId(userData.sessionId),
      userAnyId: userData.userAnyId,
      network: userData.network,
      asset: userData.asset,
      amount: userData.amount,
      destination: {
        network: userData.network,
        address: userData.address
      }
    };
  } else if (userData.asset === 'CRC') {
    return {
      sessionId: CustomWorld.getSessionId(userData.sessionId),
      userAnyId: userData.userAnyId,
      network: userData.network,
      asset: userData.asset,
      amount: userData.amount,
      destination: {
        network: userData.network,
        address: userData.address,
        bankCode: userData.bankCode,
        accountType: userData.accountType
      }
    };
  }

  if (userData.type === 'crypto') {
    // if (userData.country === "ARG" || userData.country === "BRL") {
    return {
      sessionId: CustomWorld.getSessionId(userData.sessionId),
      userAnyId: userData.userAnyId,
      // network: userData.network,
      asset: userData.asset,
      amount: userData.amount,
      destination: {
        network: userData.network,
        address: userData.address
      },
      withdrawLockCode: CustomWorld.getStoreData('code')
    };
  } else if (userData.type === 'crypto' && CustomWorld.getStoreData('code') !== undefined) {
    return {
      sessionId: CustomWorld.getSessionId(userData.sessionId),
      userAnyId: userData.userAnyId,
      // network: userData.network,
      asset: userData.asset,
      amount: userData.amount,
      destination: {
        network: userData.network,
        address: userData.address
      },
      withdrawLockCode: CustomWorld.getStoreData('code')
    };
  }

  return {
    sessionId: CustomWorld.getSessionId(userData.sessionId),
    userAnyId: userData.userAnyId,
    network: userData.network,
    asset: userData.asset,
    amount: userData.amount,
    destination: {
      network: userData.network,
      address: userData.address,
      bankCode: userData.bankCode,
      accountType: userData.accountType
    }
  };
};

export const pepInfoCrypto = (userData: any) => {
  return {
    pepData: {
      charge: userData.charge,
      authority: userData.authority,
      character: userData.character
    }
  };
};

// Onboarding Add Bank Account
export const bankingOnboardingApiCrypto = (userData: any) => {
  return {
    userAnyId: CustomWorld.getStoreData('userId') || userData.userAnyId,
    currency: userData.currency,
    cbu: userData.address,
    description: userData.description,
    bank: {
      code: userData.bankCode
    },
    accountType: userData.accountType
  };
};

export const criptoWithdrawApiCryptoV2 = (userData: any) => {};

export const withdrawLockApiCryptoV2 = (userData: any) => {
  return {
    userAnyId: userData.userAnyId,
    asset: userData.asset,
    destination: {
      address: userData.address,
      network: userData.network
    }
  };
};

export const refundPollingWithDeposit = async function (data: any, userData: any) {
  const maxAttemps: number = 15;
  let attempsCounter: number = 0;

  const endpointLock: String = '/v2/payment-locks';
  let payloadLock: object = {
    userAnyId: userData.userAnyId,
    paymentDestination: userData.paymentDestination,
    against: userData.against,
    amount: userData.amount
  };

  const endpointPayment: String = '/v2/synthetics/qr-payment';
  let payloadPayment: object = {};

  let endpointGetSynthetic: String = '';

  while (attempsCounter < maxAttemps) {
    // Lock-Price Creation
    userData.response = await request(data.urlBase).post(endpointLock).set('md-api-key', data.apiKey).set('User-Agent', 'PostmanRuntime/7.44.1').send(payloadLock);
    console.log('API payload:', payloadLock);
    console.log('API response:', userData.response.body);

    let pixCode = userData.response.body.code;
    payloadPayment = {
      sessionId: CustomWorld.getSessionId(userData.sessionId),
      userAnyId: userData.userAnyId,
      pixCode: pixCode
    };

    await delay(3000);

    // Synthetic creation
    userData.response = await request(data.urlBase).post(endpointPayment).set('md-api-key', data.apiKey).set('User-Agent', 'PostmanRuntime/7.44.1').send(payloadPayment);
    console.log('API payload:', payloadPayment);
    console.log('API response:', userData.response.body);

    await delay(3000);

    let syntheticId = userData.response.body.id;
    endpointGetSynthetic = `/v1/synthetics/${syntheticId}`;

    // Deposits
    if (userData.against === 'USDT') {
      let endpointDeposit = '/v1/transaction/deposit';
      let depositCryptoPayload = criptoDepositApiCrypto(userData.response.body);

      // Crypto deposit
      userData.response = await request(data.urlBase)
        .post(endpointDeposit)
        .set('md-api-key', userData.apiKeyDeposit)
        .set('x-api-secret', data.apiSecret)
        .set('User-Agent', 'PostmanRuntime/7.44.1')
        .send(depositCryptoPayload);
      console.log('API payload:', depositCryptoPayload);
      console.log('API response:', userData.response.body);
    } else {
      let endpointDeposit = '/v1/fiat/deposit';
      let depositFiatPayload = fiatDepositApiCrypto(userData.response.body);

      // Fiat deposit
      userData.response = await request(data.urlBase)
        .post(endpointDeposit)
        .set('md-api-key', 'C10XB2Z-AG243CS-G42KB2M-4085WTF')
        .set('x-api-secret', data.apiSecret)
        .set('User-Agent', 'PostmanRuntime/7.44.1')
        .send(depositFiatPayload);
      console.log('API payload:', depositFiatPayload);
      console.log('API response:', userData.response.body);
    }

    await delay(30000);

    // Get synthetic
    userData.response = await request(data.urlBase).get(endpointGetSynthetic).set('md-api-key', data.apiKey).set('User-Agent', 'PostmanRuntime/7.44.1');
    console.log('API response GET:', userData.response.body);

    if (userData.response.body.status === 'CANCELLED') {
      CustomWorld.setStoreData('paymentAgainstAmount', userData.response.body.details.paymentAgainstAmount);
      return userData.response;
    }

    attempsCounter++;
  }
};

export const refundsPolling = async function (data: any, userData: any) {
  const maxAttemps: number = 15;
  let attempsCounter: number = 0;

  const endpointLock: String = '/v2/payment-locks';
  let payloadLock: object = {
    userAnyId: userData.userAnyId,
    paymentDestination: userData.paymentDestination,
    against: userData.against,
    amount: userData.amount
  };

  const endpointPayment: String = '/v2/synthetics/qr-payment';
  let payloadPayment: object = {};

  let endpointGetSynthetic: String = ``;

  while (attempsCounter < maxAttemps) {
    userData.response = await request(data.urlBase).post(endpointLock).set('md-api-key', data.apiKey).set('User-Agent', 'PostmanRuntime/7.44.1').send(payloadLock);

    let pixCode = userData.response.body.code;
    payloadPayment = {
      sessionId: CustomWorld.getSessionId(userData.sessionId),
      userAnyId: userData.userAnyId,
      pixCode: pixCode
    };

    await delay(3000);

    userData.response = await request(data.urlBase).post(endpointPayment).set('md-api-key', data.apiKey).set('User-Agent', 'PostmanRuntime/7.44.1').send(payloadPayment);

    let syntheticId = userData.response.body.id;
    endpointGetSynthetic = `/v1/synthetics/${syntheticId}`;

    await delay(30000);

    userData.response = await request(data.urlBase).get(endpointGetSynthetic).set('md-api-key', data.apiKey).set('User-Agent', 'PostmanRuntime/7.44.1');
    console.log('API response GET:', userData.response.body);

    if (userData.response.body.status === 'CANCELLED') return userData.response;

    attempsCounter++;
  }
};

//-----API CRIPTO-----//
//-----*********-----//
//-----API CAMBIO-----//

export const twoFAAuthApiCambio = (userData: any) => {
  return {
    token: CustomWorld.getStoreData('token2FA')
  };
};

export const authApiCambio = async () => {
  console.log('ENTRA A FX');

  const urlBase = 'https://api-qa.tiendadolar.com.ar/v3';
  const endpointLogin = '/admin/auth/login';
  const secret = 'WRIYQ37BUTETGE3NWYLF4KGEPKIRSKX6';

  const payloadLogin = {
    email: 'andy@tiendadolar.com',
    password: '!12345678'
  };

  let response = await request(urlBase).post(endpointLogin).set('User-Agent', 'PostmanRuntime/7.44.1').send(payloadLogin);
  console.log(response);
  const redirectUrl = response.redirectUrl;

  const token2FA = speakeasy.totp({
    secret: secret,
    encoding: 'base32'
  });

  const payloadAuth = {
    token: token2FA
  };
  console.log(redirectUrl);

  response = await request(urlBase).post(redirectUrl).set('User-Agent', 'PostmanRuntime/7.44.1').send(payloadAuth);

  CustomWorld.setStoreData('adminToken', response.body.accessToken);

  console.log(CustomWorld.getStoreData('adminToken'));
};

// Onboarding inicial
export const inicialOnboardingApiCambio = (userData: any) => {
  return {
    email: userData.email,
    legalId: userData.legalId,
    personalData: {
      sex: userData.sex,
      work: userData.work,
      birthDate: userData.birthDate,
      maritalStatus: userData.maritalStatus,
      isPep: userData.isPep === 'true',
      isFep: userData.isFep === 'true',
      isFatca: userData.isFatca === 'true',
      isUif: userData.isUif === 'true',
      phoneNumber: userData.phoneNumber,
      nationality: userData.nationality
    },
    banking: {
      accounts: [
        {
          cbu: userData.ARScbu,
          currency: userData.ARScurrency,
          description: userData.ARSdescription
        },
        {
          cbu: userData.USDcbu,
          currency: userData.USDcurrency,
          description: userData.USDdescription
        }
      ]
    }
  };
};

//  Onboarding Validate Docs
export const validateOnboardingApiCambio = (userData: any) => {
  return {
    userAnyId: CustomWorld.getStoreData('userId'),
    side: userData.side,
    fileName: userData.fileName
  };
};

// Onboarding Add Bank Account
export const bankingOnboardingApiCambio = (userData: any) => {
  return {
    userAnyId: CustomWorld.getStoreData('userId'),
    address: userData.address,
    currency: userData.currency,
    description: userData.description
  };
};

// Deposito fiat
export const fiatDepositApiCambio = (userData: any) => {
  return {
    companyId: userData.companyId,
    networkId: userData.networkId,
    userId: userData.userId,
    source: userData.source,
    legalId: userData.legalId,
    amount: CustomWorld.getStoreData('thresholdAmount'),
    coin: CustomWorld.getStoreData('coin')
  };
};
