const request = require('supertest');
const { expect } = require('chai');
import logger from '../utils/logger';
import { getWithdrawStage } from '../utils/utils';
import { CustomWorld } from '../world';
import { apiRequest, validateRes } from './requestHelper';
const payments = require('../data/syntheticPaymentData.json');

export const validateSyntheticRefundStage = (body: any, partial?: boolean) => {
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
  } else if (partial) {
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

    //Al validar con Cris borrar o ver que onda
    // const orderReversalStage = Object.values(body.stages).find((stage: any) => stage.stageType === 'ORDER_REVERSAL');

    // expect(orderReversalStage).to.have.property('stageType').that.is.a('string');
    // expect(orderReversalStage).to.have.property('orderId').that.is.a('string');
  } else {
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

    const orderReversalStage = Object.values(body.stages).find((stage: any) => stage.stageType === 'ORDER_REVERSAL');

    expect(orderReversalStage).to.have.property('stageType').that.is.a('string');
    expect(orderReversalStage).to.have.property('orderId').that.is.a('string');
  }
};

export const validateTotalRefund = (body: any) => {
  const refundTotalStage = Object.values(body.stages).find((stage: any) => stage.stageType === 'REFUND');
  let amount: string = CustomWorld.getStoreData('amount') === 'dynamic' ? body.details.paymentAssetAmount : CustomWorld.getStoreData('amount');

  if (body.paymentAgainst === 'USDT') {
    expect(refundTotalStage).to.have.property('stageType').that.is.a('string').to.be.equal('REFUND');
    expect(refundTotalStage).to.have.property('partial').that.is.a('boolean').to.be.equal(false);
    expect(refundTotalStage).to.have.property('assetToRefund').that.is.a('string').to.be.equal(body.paymentAgainst);
    expect(refundTotalStage).to.have.property('amountToRefund').that.is.a('string').to.be.equal(body.paymentAgainstAmount);
    expect(refundTotalStage).to.have.property('asset').that.is.a('string').to.be.equal(CustomWorld.getStoreData('refundAsset'));
    expect(refundTotalStage).to.have.property('amount').that.is.a('string').to.be.equal(amount);
    expect(refundTotalStage).to.have.property('internalRefund').that.is.a('boolean').to.be.equal(false);
    expect(refundTotalStage).to.have.property('refundReason').that.is.a('string');
  }

  if (body.paymentAgainst === 'ARS') {
    expect(refundTotalStage).to.have.property('stageType').that.is.a('string').to.be.equal('REFUND');
    expect(refundTotalStage).to.have.property('partial').that.is.a('boolean').to.be.equal(false);
    expect(refundTotalStage).to.have.property('assetToRefund').that.is.a('string').to.be.equal(CustomWorld.getStoreData('refundAsset'));
    expect(refundTotalStage).to.have.property('amountToRefund').that.is.a('string').to.be.equal(amount);
    expect(refundTotalStage).to.have.property('asset').that.is.a('string').to.be.equal(CustomWorld.getStoreData('refundAsset'));
    expect(refundTotalStage).to.have.property('amount').that.is.a('string').to.be.equal(amount);
    expect(refundTotalStage).to.have.property('internalRefund').that.is.a('boolean').to.be.equal(false);
    expect(refundTotalStage).to.have.property('refundReason').that.is.a('string');
  }
};

export const validatePartialRefund = (body: any) => {
  const refundTotalStage: any = Object.values(body.stages).find((stage: any) => stage.stageType === 'REFUND');
  let amount: string = CustomWorld.getStoreData('amount') === 'dynamic' ? body.details.paymentAssetAmount : CustomWorld.getStoreData('amount');
  CustomWorld.setStoreData('amountToRefund', refundTotalStage.amountToRefund);

  if (body.paymentAgainst === 'USDT') {
    expect(refundTotalStage).to.have.property('stageType').that.is.a('string').to.be.equal('REFUND');
    expect(refundTotalStage).to.have.property('partial').that.is.a('boolean').to.be.equal(true);
    expect(refundTotalStage).to.have.property('assetToRefund').that.is.a('string').to.be.equal(body.paymentAgainst);
    expect(refundTotalStage).to.have.property('amountToRefund').that.is.a('string').to.be.equal(body.paymentAgainstAmount);
    expect(refundTotalStage).to.have.property('asset').that.is.a('string').to.be.equal(CustomWorld.getStoreData('refundAsset'));
    expect(refundTotalStage).to.have.property('amount').that.is.a('string').to.be.equal(amount);
    expect(refundTotalStage).to.have.property('internalRefund').that.is.a('boolean').to.be.equal(false);
    expect(refundTotalStage).to.have.property('refundReason').that.is.a('string').to.be.equal(CustomWorld.getStoreData('refundReason'));
  }

  if (body.paymentAgainst === 'ARS') {
    expect(refundTotalStage).to.have.property('stageType').that.is.a('string').to.be.equal('REFUND');
    expect(refundTotalStage).to.have.property('partial').that.is.a('boolean').to.be.equal(true);
    expect(refundTotalStage).to.have.property('assetToRefund').that.is.a('string').to.be.equal(CustomWorld.getStoreData('refundAsset'));
    expect(refundTotalStage).to.have.property('amountToRefund').that.is.a('string').to.be.equal(amount);
    expect(refundTotalStage).to.have.property('asset').that.is.a('string').to.be.equal(CustomWorld.getStoreData('refundAsset'));
    expect(refundTotalStage).to.have.property('amount').that.is.a('string').to.be.equal(amount);
    expect(refundTotalStage).to.have.property('internalRefund').that.is.a('boolean').to.be.equal(false);
    expect(refundTotalStage).to.have.property('refundReason').that.is.a('string').to.be.equal(CustomWorld.getStoreData('refundReason'));
  }
};

export const validateSyntheticStatus = (body: any, httpStatus: number, statusCode?: number, statusName?: string) => {
  // Cuando los errores de transfero pix en QA se solucionen, comentar este if
  if (CustomWorld.getStoreData('userExchange') === 'ARGENTINA' && CustomWorld.getStoreData('syntheticType') === 'PIX_PAYMENT') {
    const withdrawStage = getWithdrawStage(body.stages);
    const withdrawId = withdrawStage.withdrawId;

    logger.warn(statusName);
    logger.warn(withdrawId);
    if (body.status !== statusName) CustomWorld.clearStoreData();

    expect(httpStatus).to.equal(statusCode);
    expect(body.status).to.be.oneOf(['ACTIVE', 'COMPLETED']);
    expect(withdrawId).to.be.a('string').and.not.empty;

    if (body?.stages?.['1'].stageType === 'DEPOSIT') CustomWorld.setStoreData('depositStage', true);
    if (body?.stages?.['1'].stageType !== 'DEPOSIT') CustomWorld.setStoreData('notDepositStage', true);
    if (body.hasOwnProperty('details') && body.details.paymentAgainst !== 'USDT') CustomWorld.setStoreData('againstAmountOperated', body.details.againstAmountOperated);
    return;
  }

  if (CustomWorld.getStoreData('syntheticType') === 'PERU_QR_PAYMENT') {
    const withdrawStage = getWithdrawStage(body.stages);
    const withdrawId = withdrawStage.withdrawId;

    logger.warn(statusName);
    logger.warn(withdrawId);
    if (body.status !== statusName) CustomWorld.clearStoreData();

    expect(httpStatus).to.equal(statusCode);
    expect(body.status).to.be.oneOf(['ACTIVE', 'COMPLETED']);
    expect(withdrawId).to.be.a('string').and.not.empty;

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

export const validateRefundSyntheticStatus = (response: any, status: string): void => {
  const syntheticStatus: string = response.body.status;
  expect(syntheticStatus).to.be.equal(status);
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
  let payload = {};

  if (par === 'USDT_BRL_SENDER') {
    payload = {
      userAnyId: userAnyId,
      paymentDestination: payments[type][par].paymentDestination,
      amount: payments[type][par].amount,
      against: payments[type][par].against,
      sender: {
        exchange: payments[type][par].sender.exchange,
        legalId: payments[type][par].sender.legalId,
        name: payments[type][par].sender.name,
        surname: payments[type][par].sender.surname
      }
    };
  } else {
    payload = {
      userAnyId: userAnyId,
      paymentDestination: payments[type][par].paymentDestination,
      amount: payments[type][par].amount,
      against: payments[type][par].against
    };
  }

  logger.debug(JSON.stringify(payload, null, 2));
  const response = await apiRequest({ urlBase, endpoint, method: 'post', apiKey, body: payload });
  validateRes(response, 201);
  return response;
};

export const syntheticPaymentHelper = async (urlBase: string, apiKey: string, endpoint: string, qrCode: string, userAnyId?: string, skipDeposit?: boolean, against?: string): Promise<any> => {
  let payload: object = {};

  if (userAnyId === '100062353' || against === 'ARS') {
    payload = {
      userAnyId: userAnyId,
      skipDeposit: skipDeposit,
      disallowDebt: true,
      qrCode: qrCode
    };
  } else {
    payload = {
      userAnyId: userAnyId,
      skipDeposit: skipDeposit,
      qrCode: qrCode
    };
  }

  logger.debug(JSON.stringify(payload, null, 2));
  const response = await apiRequest({ urlBase, endpoint, method: 'post', apiKey, body: payload });

  validateRes(response, 201);
  CustomWorld.setStoreData('syntheticId', response.body.id);
  // CustomWorld.setStoreData('againstAmountOperated', response.body.)
  CustomWorld.setStoreData('paymentAgainstAmount', response.body.details.paymentAgainstAmount, true);
  CustomWorld.setStoreData('isRefund', true, true);
  return response;
};
