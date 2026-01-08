const request = require('supertest');
const { expect } = require('chai');
import logger from '../utils/logger';
import { CustomWorld } from '../world';
import { apiRequest, validateRes } from './requestHelper';
const payments = require('../data/syntheticPaymentData.json');

export const validateSyntheticRefundStage = (body: any) => {
  if (body.stages['1'].stageType === 'WITHDRAW') {
    const refundStage = Object.values(body.stages).find((stage: any) => stage.stageType === 'REFUND');

    expect(refundStage).to.have.property('partial').that.is.a('boolean');
    expect(refundStage).to.have.property('assetToRefund').that.is.a('string');
    expect(refundStage).to.have.property('amountToRefund').that.is.a('string');
    expect(refundStage).to.have.property('asset').that.is.a('string');
    expect(refundStage).to.have.property('amount').that.is.a('string');
    expect(refundStage).to.have.property('internalRefund').that.is.a('boolean');
    expect(refundStage).to.have.property('refundReason').that.is.a('string');
    // expect(refundStage).to.have.property('networkId').that.is.a('string');
    expect(refundStage).to.have.property('refundedAt').that.is.a('string');

    const hasOrderReversal = Object.values(body.stages).some((stage: any) => stage.stageType === 'ORDER_REVERSAL');
    expect(hasOrderReversal).to.be.false;
  } else {
    const refundStage = Object.values(body.stages).find((stage: any) => stage.stageType === 'REFUND');

    expect(refundStage).to.have.property('partial').that.is.a('boolean');
    expect(refundStage).to.have.property('assetToRefund').that.is.a('string');
    expect(refundStage).to.have.property('amountToRefund').that.is.a('string');
    expect(refundStage).to.have.property('asset').that.is.a('string');
    expect(refundStage).to.have.property('amount').that.is.a('string');
    expect(refundStage).to.have.property('internalRefund').that.is.a('boolean');
    expect(refundStage).to.have.property('refundReason').that.is.a('string');
    expect(refundStage).to.have.property('networkId').that.is.a('string');
    expect(refundStage).to.have.property('refundedAt').that.is.a('string');

    const orderReversalStage = Object.values(body.stages).find((stage: any) => stage.stageType === 'ORDER_REVERSAL');

    expect(orderReversalStage).to.have.property('stageType').that.is.a('string');
    expect(orderReversalStage).to.have.property('orderId').that.is.a('string');
  }
};

export const validateSyntheticStatus = (body: any, httpStatus: number, statusCode?: number, statusName?: string) => {
  // Cuando los errores de transfero pix en QA se solucionen, comentar este if
  if (CustomWorld.getStoreData('userExchange') === 'ARGENTINA' && CustomWorld.getStoreData('syntheticType') === 'PIX_PAYMENT') {
    logger.warn(statusName);
    if (body.status !== statusName) CustomWorld.clearStoreData();

    expect(httpStatus).to.equal(statusCode);
    expect(body.status).to.be.oneOf(['ACTIVE', 'COMPLETED']);

    if (body?.stages?.['1'].stageType === 'DEPOSIT') CustomWorld.setStoreData('depositStage', true);
    if (body?.stages?.['1'].stageType !== 'DEPOSIT') CustomWorld.setStoreData('notDepositStage', true);
    if (body.hasOwnProperty('details') && body.details.paymentAgainst !== 'USDT') CustomWorld.setStoreData('againstAmountOperated', body.details.againstAmountOperated);
    return;
  }

  logger.warn(statusName);
  if (body.status !== statusName) CustomWorld.clearStoreData();

  expect(httpStatus).to.equal(statusCode);
  expect(body.status).to.equal(statusName);

  if (body?.stages?.['1'].stageType === 'DEPOSIT') CustomWorld.setStoreData('depositStage', true);
  if (body?.stages?.['1'].stageType !== 'DEPOSIT') CustomWorld.setStoreData('notDepositStage', true);
  if (body.hasOwnProperty('details') && body.details.paymentAgainst !== 'USDT') CustomWorld.setStoreData('againstAmountOperated', body.details.againstAmountOperated);
};

export const getSyntheticStatus = async (urlBase: string, endpoint: string, apiKey: string, statusCode?: number, statusName?: string): Promise<any> => {
  const response = await apiRequest({ urlBase, endpoint, method: 'get', apiKey });
  // const response = await request(urlBase).get(endpoint).set('User-Agent', 'PostmanRuntime/7.44.1').set('md-api-key', apiKEY);
  const body: any = response.body;
  const httpStatus: number = response.status;
  CustomWorld.setStoreData('syntheticType', body.type);

  logger.info(httpStatus);
  logger.info(JSON.stringify(body, null, 2));
  return response;

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

export const lockPaymentHelper = async (urlBase: string, apiKey: string, endpoint: string, type: string, par: string, userAnyId: string): Promise<any> => {
  const payload = {
    userAnyId: userAnyId,
    paymentDestination: payments[type][par].paymentDestination,
    amount: payments[type][par].amount,
    against: payments[type][par].against
  };
  logger.debug(JSON.stringify(payload, null, 2));
  const response = await apiRequest({ urlBase, endpoint, method: 'post', apiKey, body: payload });
  validateRes(response, 201);
  return response;
};

export const syntheticPaymentHelper = async (urlBase: string, apiKey: string, endpoint: string, qrCode: string, userAnyId?: string): Promise<any> => {
  const payload = {
    userAnyId: userAnyId,
    qrCode: qrCode
  };
  logger.debug(JSON.stringify(payload, null, 2));
  const response = await apiRequest({ urlBase, endpoint, method: 'post', apiKey, body: payload });

  validateRes(response, 201);
  CustomWorld.setStoreData('syntheticId', response.body.id);
  // CustomWorld.setStoreData('againstAmountOperated', response.body.)
  CustomWorld.setStoreData('paymentAgainstAmount', response.body.details.paymentAgainstAmount, true);
  CustomWorld.setStoreData('isRefund', true, true);
  return response;
};
