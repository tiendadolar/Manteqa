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

export const fiatDepositHelper = async (urlBase: string, endpoint: string, apiKey: string, apiSecret: string, userId: string, amount: string, coin: string): Promise<any> => {
  const payload = {
    userId: userId,
    amount: amount,
    coin: coin
  };
  const response = await apiRequest({ urlBase, endpoint, method: 'post', apiKey, apiSecret, body: payload });
  // const response = await request(urlBase).post(endpoint).set('User-Agent', 'PostmanRuntime/7.44.1').set('md-api-key', apiKEY).set('md-api-secret', apiSecret).send(payload);
};
