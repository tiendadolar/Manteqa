const request = require('supertest');
const { expect } = require('chai');
import logger from '../utils/logger';
import { CustomWorld } from '../world';
import { apiRequest } from './requestHelper';

const validateSyntheticStatus = (body: any, httpStatus: number, statusCode: number, statusName: string) => {
  if (body.status !== statusName) CustomWorld.clearStoreData();

  expect(httpStatus).to.equal(statusCode);
  expect(body.status).to.equal(statusName);

  if (body?.stages?.['1'].stageType === 'DEPOSIT') CustomWorld.setStoreData('depositStage', true);
  if (body?.stages?.['1'].stageType !== 'DEPOSIT') CustomWorld.setStoreData('notDepositStage', true);
  if (body.hasOwnProperty('details') && body.details.paymentAgainst !== 'USDT') CustomWorld.setStoreData('againstAmountOperated', body.details.againstAmountOperated);
};

export const getSyntheticStatus = async (urlBase: string, endpoint: string, apiKey: string, statusCode: number, statusName: string): Promise<any> => {
  const response = await apiRequest({ urlBase, endpoint, method: 'get', apiKey });
  logger.debug(JSON.stringify(response.body, null, 2));
  // const response = await request(urlBase).get(endpoint).set('User-Agent', 'PostmanRuntime/7.44.1').set('md-api-key', apiKEY);
  const body: any = response.body;
  const httpStatus: number = response.status;

  logger.info(httpStatus);
  logger.info(JSON.stringify(body, null, 2));

  validateSyntheticStatus(body, httpStatus, statusCode, statusName);
};

export const adminRefundHelper = async (urlBase: string, endpoint: string, token: string, refundReason: string, amount: string): Promise<any> => {
  const payload = {
    refundReason,
    amount
  };
  const response = await apiRequest({ urlBase, endpoint, method: 'post', token, body: payload });
  return response;
};
