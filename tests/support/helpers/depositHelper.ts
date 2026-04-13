const request = require('supertest');
const { expect } = require('chai');
import logger from '../utils/logger';
import { CustomWorld } from '../world';
import { apiRequest } from './requestHelper';

export const cryptoDepositHelper = async (
  urlBase: string,
  endpoint: string,
  apiKey: string,
  apiSecret: string,
  from: string,
  to: string,
  wei: string,
  human: string,
  ticker: string,
  chain: any
): Promise<any> => {
  const payload = {
    tx: {
      hash: CustomWorld.getNetworkId(),
      from: from,
      to: to,
      value: {
        wei: wei,
        human: human
      },
      ticker: ticker,
      chain: chain
    }
  };
  logger.info(`Crypto deposit payload: ${JSON.stringify(payload)}`);
  const response = await apiRequest({ urlBase, endpoint, method: 'post', apiKey, apiSecret, body: payload });
  // const response = await request(urlBase).post(endpoint).set('User-Agent', 'PostmanRuntime/7.44.1').set('md-api-key', apiKEY).set('md-api-secret', apiSecret).send(payload);
};

export const cryptoDepositHelper2 = async (urlBase: string, endpoint: string, token: string, from: string, to: string, amount: string, ticker: string, chain: any): Promise<any> => {
  const payload = {
    hash: CustomWorld.getNetworkId(),
    from: from,
    to: to,
    amount: amount,
    ticker: ticker,
    chain: chain
  };
  logger.info(`Crypto deposit payload: ${JSON.stringify(payload)}`);
  const response = await request(urlBase).post(endpoint).set('User-Agent', 'PostmanRuntime/7.44.1').set('x-access-token', token).send(payload);
  logger.info(`Crypto deposit response: ${JSON.stringify(response.body)}`);
};

export const fiatDepositHelper = async (urlBase: string, endpoint: string, apiKey: string, apiSecret: string, userId: string, amount: string, coin: string, entity?: string): Promise<any> => {
  const payload = {
    userId: userId,
    amount: amount,
    coin: coin,
    legalEntity: entity
  };
  const response = await apiRequest({ urlBase, endpoint, method: 'post', apiKey, apiSecret, body: payload });
  console.log(JSON.stringify(response.body, null, 2));
};

export const getHotWallet = (network: string | undefined, entity: string): string => {
  if (!network || network === undefined) {
    if (entity === 'CRYPTO_GLOBAL') return '0x0BB116fED4F402DBE82dF6AA66E50105c1d310d9';
    if (entity === 'CRYPTO_ARG') return '0xd99589F1b1695996533bB4dB43B97DD6331dBcc2';
    if (entity === 'WALLET_ARG') return '0x500BD656601F3454121FF72ef52AEB27bA8CC88C';
  }

  switch (network) {
    case 'SOLANA':
      if (entity === 'CRYPTO_GLOBAL') return 'A5FrHAimj28EmysnRXoPb1go3Z1tfCuYqdvV8NrWeioe';
      if (entity === 'CRYPTO_ARG') return 'tiKHPRHbxnUSmeggWWd17zuQ1z4HV2427x4xcmuVD8p';
      break;

    case 'STELLAR':
      if (entity === 'CRYPTO_GLOBAL') return 'GCVQ3XR5GZK76BA4EAWM5Z7DEBCXVA5NYPJSEB6UOKMCHHA4QYQQURYK';
      if (entity === 'CRYPTO_ARG') return 'GDDF5T734QWTTLFSBDZVO2J6ERT2LO2LNRKNLYRPIXMA3KUSKW755LTU';
      break;

    case 'TRON':
      if (entity === 'CRYPTO_GLOBAL') return '0x0BB116fED4F402DBE82dF6AA66E50105c1d310d9';
      if (entity === 'CRYPTO_ARG') return 'TVogmpw7MbNCD9i91fsDYENVkh7HFUfcoB';
      break;

    default:
      if (entity === 'CRYPTO_GLOBAL') return '0x0BB116fED4F402DBE82dF6AA66E50105c1d310d9';
      if (entity === 'CRYPTO_ARG') return '0xd99589F1b1695996533bB4dB43B97DD6331dBcc2';
  }

  return '';
};
