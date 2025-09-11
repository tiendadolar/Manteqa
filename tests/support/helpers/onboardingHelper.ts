const request = require('supertest');
const { expect } = require('chai');
const fs = require('fs');
const path = require('path');
const exchangeData = require('../data/accountData.json');
import logger from '../utils/logger';
import { CustomWorld } from '../world';
import { apiRequest, validateRes } from './requestHelper';

const getUserId = async (urlBase: string, apiKey: string, legalId: string) => {
  const endpoint: string = `/v2/users?legalId=${legalId}`;
  const response = await apiRequest({ urlBase, endpoint, method: 'get', apiKey });
  const numberId: string = response.body.data[0]?.numberId;

  validateRes(response, 200);
  return numberId;
};

const deleteUser = async (userNumberId: string) => {
  const urlBase: string = `https://api-qa.tiendacrypto.com`;
  const endpoint: string = `/v1/admin/user`;
  const token: string = CustomWorld.getStoreData('JWT');

  const payload = {
    numberId: userNumberId
  };

  const response = await apiRequest({ urlBase, endpoint, method: 'delete', token, body: payload });
  validateRes(response, 204);
};

const putAwsUrl = async (awsUrl: string) => {
  const imagePath = path.join(__dirname, '../../../images/pic2.png');
  const imageBuffer = fs.readFileSync(imagePath);
  const urlBase = awsUrl;

  // const response = await request(awsUrl).put('').set('User-Agent', 'PostmanRuntime/7.44.1').set('Content-Type', 'image/png').send(imageBuffer);
  const response = await apiRequest({ urlBase, method: 'put', endpoint: '', headers: { 'Content-Type': 'image/png' }, body: imageBuffer });
};

export const onboardingHelper = async (urlBase: string, apiKEY: string, legalId: string): Promise<any> => {
  const numberId: string = await getUserId(urlBase, apiKEY, legalId);

  if (!numberId) return;

  await deleteUser(numberId);
  logger.info(`Usuario con legalId ${legalId} y numberId ${numberId} eliminado correctamente`);
};

export const uploadImagesHelper = async (urlBase: string, endpoint: string, apiKey: string, userAnyId: string, side: string, fileName: string): Promise<any> => {
  const payload = {
    userAnyId: userAnyId,
    side: side,
    fileName: fileName
  };
  const response = await apiRequest({ urlBase, endpoint, method: 'post', apiKey, body: payload });
  validateRes(response, 200);
  const awsUrl: string = response.body.url;
  await putAwsUrl(awsUrl);
  logger.info(`Image uploading completed`);
};

export const addBankAccountHelper = async (urlBase: string, endpoint: string, apiKey: string, userAnyId: string, exchange: string): Promise<any> => {
  const argPayload = {
    userAnyId: userAnyId,
    currency: exchangeData[exchange].currency,
    cbu: exchangeData[exchange].cbu,
    description: `Cuenta ${exchange} automatizada`
  };

  const noArgPayload = {
    userAnyId: userAnyId,
    currency: exchangeData[exchange].currency,
    cbu: exchangeData[exchange].cbu,
    description: exchangeData[exchange].description,
    bank: {
      code: exchangeData[exchange].code
    },
    accountType: exchangeData[exchange].accountType
  };

  const payload = exchange === 'ARGENTINA' || exchange === 'BRAZIL' ? argPayload : noArgPayload;

  const response = await apiRequest({ urlBase, endpoint, method: 'post', apiKey, body: payload });
  logger.info(`Bank account added for exchange: ${exchange}`);
  return response;
};
