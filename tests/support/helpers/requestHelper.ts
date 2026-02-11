const request = require('supertest');
const { expect } = require('chai');
import logger from '../utils/logger';
import { CustomWorld } from '../world';

const errorRequest = (response: any, expectedStatus: number) => {
  logger.error(response.status);
  logger.error(JSON.stringify(response.body));
  throw new Error(`Expected ${expectedStatus} but got ${response.status}: ${JSON.stringify(response.body)}`);
};

export const apiRequest = async ({
  urlBase,
  endpoint,
  method = 'get',
  apiKey,
  token,
  apiSecret,
  body = {},
  headers = {}
}: {
  urlBase: string;
  endpoint?: string;
  method: 'get' | 'post' | 'put' | 'delete' | 'patch';
  apiKey?: string;
  token?: string;
  apiSecret?: string;
  body?: any;
  headers?: Record<string, string>;
}) => {
  const finalHeaders: Record<string, string> = {
    'User-Agent': 'PostmanRuntime/7.45.0',
    ...headers
  };

  let req = request(urlBase)[method](endpoint);

  if (apiKey) {
    req = req.set('x-api-key', apiKey);
  }

  if (token) {
    req = req.set('x-access-token', token);
  }

  if (apiSecret) {
    req = req.set('md-api-secret', apiSecret);
  }

  if (finalHeaders) {
    req = req.set(finalHeaders);
  }

  if (['post', 'put', 'patch', 'delete'].includes(method) && body) {
    req = req.send(body);
  }

  return req;
};

export const validateRes = (response: any, expectedStatus: number) => {
  try {
    expect(response.status).to.equal(expectedStatus);
    CustomWorld.setStoreData('responseHelper', response.body);
  } catch (error) {
    errorRequest(response, expectedStatus);
  }
};
