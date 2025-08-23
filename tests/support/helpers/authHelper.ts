const request = require('supertest');
const speakeasy = require('speakeasy');
const credentials = require('../data/authCredentials.json');
import logger from '../utils/logger';
import { CustomWorld } from '../world';

const generateTwoFAHelper = (secret: string) => {
  const token = speakeasy.totp({
    secret: secret,
    encoding: 'base32'
  });
  return token;
};

export const getUserCredentials = (key: string) => {
  const userENV = credentials[key];
  if (!userENV) {
    throw new Error(`No credentials found for key: ${key}`);
  }
  return userENV;
};

export const TwoFAHelper = async (urlBase: string, endpoint: string, secret: string): Promise<any> => {
  const loginEndpoint: string = endpoint;
  const TwoFApayload: Object = {
    token: generateTwoFAHelper(secret)
  };
  try {
    const response = await request(urlBase).post(loginEndpoint).set('User-Agent', 'PostmanRuntime/7.44.1').send(TwoFApayload);
    return response.body.accessToken;
  } catch (error) {}
};

export const authHelper = async (urlBase: string, endpoint: string, email: string, password: string, secret: string): Promise<any> => {
  const loginEndpoint: string = endpoint;
  const loginPayload: Object = {
    email: email,
    password: password
  };
  try {
    const response = await request(urlBase).post(loginEndpoint).set('User-Agent', 'PostmanRuntime/7.44.1').send(loginPayload);
    const token = await TwoFAHelper(urlBase, response.body.redirectUrl, secret);
    CustomWorld.setStoreData('JWT', token);
  } catch (error) {}
};
