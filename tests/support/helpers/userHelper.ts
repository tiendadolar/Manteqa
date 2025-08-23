const request = require('supertest');
import logger from '../utils/logger';
import { CustomWorld } from '../world';

export const getUserInfoHelper = async (apiKEY: string, key: string, userAnyId: string) => {
  const urlBase = `https://sandbox.manteca.dev/crypto/v2`;
  const endpoint = `/users/${userAnyId}`;

  try {
    const response = await request(urlBase).get(endpoint).set('User-Agent', 'PostmanRuntime/7.44.1').set('md-api-key', apiKEY);

    CustomWorld.setStoreData(key.toString(), response.body[key.toString()]);
    logger.debug(CustomWorld.getStoreData(key.toString()));
  } catch (error) {
    console.log(error);
  }
};
