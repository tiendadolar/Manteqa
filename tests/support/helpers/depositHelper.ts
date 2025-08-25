const request = require('supertest');
const { expect } = require('chai');
import logger from '../utils/logger';
import { CustomWorld } from '../world';

export const cryptoDepositHelper = async (
  urlBase: string,
  endpoint: string,
  apiKEY: string,
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
  logger.info(`Crupto deposit payload: ${JSON.stringify(payload)}`);
  const response = await request(urlBase).post(endpoint).set('User-Agent', 'PostmanRuntime/7.44.1').set('md-api-key', apiKEY).set('md-api-secret', apiSecret).send(payload);
  logger.info(`Crypto deposit response: ${JSON.stringify(response.body)}`);
};

export const fiatDepositHelper = async (urlBase: string, endpoint: string, apiKEY: string, apiSecret: string, userId: string, amount: string, coin: string): Promise<any> => {
  const payload = {
    userId: userId,
    amount: amount,
    coin: coin
  };
  const response = await request(urlBase).post(endpoint).set('User-Agent', 'PostmanRuntime/7.44.1').set('md-api-key', apiKEY).set('md-api-secret', apiSecret).send(payload);
};
