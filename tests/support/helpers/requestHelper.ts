const request = require('supertest');
const { expect } = require('chai');
import logger from '../utils/logger';

const errorRequest = (response: any) => {
  logger.error(response.status);
  logger.error(JSON.stringify(response.body));
  throw new Error();
};

export const apiRequest = async ({
  urlBase,
  endpoint,
  method = 'get',
  apiKey,
  body = {},
  headers = {}
}: {
  urlBase: string;
  endpoint: string;
  method?: 'get' | 'post' | 'put' | 'delete' | 'patch';
  apiKey?: string;
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

  if (finalHeaders) {
    req = req.set(finalHeaders);
  }

  if (['post', 'put', 'patch'].includes(method) && body) {
    req = req.send(body);
  }

  return req;
};

export const validateRes = (response: any, expectedStatus: number) => {
  try {
    expect(response.status).to.equal(expectedStatus);
  } catch (error) {
    errorRequest(response);
  }
};
