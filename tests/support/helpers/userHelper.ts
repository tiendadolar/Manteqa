const request = require('supertest');
const { expect } = require('chai');
import logger from '../utils/logger';
import { CustomWorld } from '../world';
import { apiRequest } from './requestHelper';

export const getUserInfoHelper = async (apiKey: string, key?: string, userAnyId?: string) => {
  const urlBase = `https://sandbox.manteca.dev/crypto/v2`;
  const endpoint = `/users/${userAnyId}`;

  const response = await apiRequest({ urlBase, endpoint, method: 'get', apiKey });

  if (key !== undefined) {
    CustomWorld.setStoreData(key.toString(), response.body[key.toString()]);
    logger.debug(CustomWorld.getStoreData(key.toString()));
    return;
  }

  return response;
};

export const getUserInfoDougHelper = async (token: string, userAnyId?: string, key?: string) => {
  const urlBase = `https://api-qa.tiendacrypto.com/v1`;
  const endpoint = `/admin/user/${userAnyId}/doug`;

  const response = await apiRequest({ urlBase, endpoint, method: 'get', token });

  if (key !== undefined) {
    CustomWorld.setStoreData(key.toString(), response.body[key.toString()]);
    logger.debug(CustomWorld.getStoreData(key.toString()));
    return;
  }

  return response;
};
