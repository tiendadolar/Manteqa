const request = require('supertest');
const { expect } = require('chai');
import logger from '../utils/logger';
import { CustomWorld } from '../world';
import { apiRequest } from './requestHelper';

export const getBillIdInfoHelper = async (apiKey: string, key?: string, userAnyId?: string) => {
  const urlBase = `https://sandbox.manteca.dev/crypto/v2`;
  const endpoint = `/info/bill-companies/AR-S-02610/5c9fc993-73a9-4929-ab8b-2b75b9864329/0UAB-CLI/1000000001`;

  const response = await apiRequest({ urlBase, endpoint, method: 'get', apiKey });

  return response;
};
