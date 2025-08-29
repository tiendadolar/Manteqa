const request = require('supertest');
const { expect } = require('chai');
const fs = require('fs');
const path = require('path');
import logger from '../utils/logger';
import { CustomWorld } from '../world';

const getUserId = async (urlBase: string, apiKey: string, legalId: string) => {
  const endpoint: string = `/v2/users?legalId=${legalId}`;
  const response: any = await request(urlBase).get(endpoint).set('User-Agent', 'PostmanRuntime/7.44.1').set('md-api-key', apiKey);
  logger.debug(JSON.stringify(response.body.data[0]?.numberId));
  const numberId: string = response.body.data[0]?.numberId;

  return numberId;
};

const deleteUser = async (userNumberId: string) => {
  const urlBase: string = `https://api-qa.tiendacrypto.com`;
  const endpoint: string = `/v1/admin/user`;
  const token: string = CustomWorld.getStoreData('JWT');
  logger.debug(`Token obtenido: ${token}`);

  const payload = {
    numberId: userNumberId
  };

  const response = await request(urlBase).delete(endpoint).set('x-access-token', token).send(payload);
};

const putAwsUrl = async (awsUrl: string) => {
  const imagePath = path.join(__dirname, '../../../images/pic2.png');
  const imageBuffer = fs.readFileSync(imagePath);

  const response = await request(awsUrl).put('').set('User-Agent', 'PostmanRuntime/7.44.1').set('Content-Type', 'image/png').send(imageBuffer);
};

export const onboardingHelper = async (urlBase: string, apiKEY: string, legalId: string): Promise<any> => {
  const numberId: string = await getUserId(urlBase, apiKEY, legalId);

  if (!numberId) return;

  await deleteUser(numberId);
  logger.info(`Usuario con legalId ${legalId} y numberId ${numberId} eliminado correctamente`);
};

export const uploadImages = async (urlBase: string, endpoint: string, apiKey: string, userAnyId: string, side: string, fileName: string): Promise<any> => {
  // logger.debug('ENTRAAAAA');
  // const userAnyId: string = await getUserId(urlBase, apiKey, legalId);
  // logger.debug(userAnyId);

  const payload = {
    userAnyId: userAnyId,
    side: side,
    fileName: fileName
  };

  const response = await request(urlBase).post(endpoint).set('User-Agent', 'PostmanRuntime/7.44.1').set('md-api-key', apiKey).send(payload);
  logger.debug(JSON.stringify(response.body));
  const awsUrl: string = response.body.url;
  await putAwsUrl(awsUrl);
  logger.info(`Imagen ${fileName} subida correctamente`);
};
