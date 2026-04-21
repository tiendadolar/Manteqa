const request = require('supertest');
const { expect } = require('chai');
import logger from '../utils/logger';
import { CustomWorld } from '../world';
import { apiRequest } from './requestHelper';

type CountryConfig = {
  companyCode: string;
  methodId: string;
  methodType: string;
  referenceId: string;
};

const countryConfigBillMap: Record<string, CountryConfig> = {
  ARGENTINA: {
    companyCode: 'AR-S-02610',
    methodId: '5c9fc993-73a9-4929-ab8b-2b75b9864329',
    methodType: '0UAB-CLI',
    referenceId: '1000000001'
  },
  COLOMBIA: {
    companyCode: 'CO-S-00138',
    methodId: 'b3f20f8d-0a3c-45c9-a4f3-6c255f8621e9',
    methodType: '0UVT-CLI',
    referenceId: '1000000001'
  },
  PERU: {
    companyCode: 'PE-S-00056',
    methodId: '1ece4a4f-de98-46d8-8619-1bd7452fbb03',
    methodType: '0VFO-CLI',
    referenceId: '1000000004'
  },
  MEXICO: {
    companyCode: 'MX-S-90934',
    methodId: '0cb32273-3a6e-4e5d-85ab-381b45a46561',
    methodType: 'CRXT-CLI',
    referenceId: '1000000001'
  },
  CHILE: {
    companyCode: 'CL-S-00214',
    methodId: 'b6253017-5053-4c8f-ae16-b0ff7c8c1a3a',
    methodType: 'BLHW-CLI',
    referenceId: '1000000001'
  }
};

const countryConfigTopUpMap: Record<string, CountryConfig> = {
  ARGENTINA: {
    companyCode: 'AR-R-00009',
    methodId: 'a5555957-72a9-42a3-9de9-8f71807b2499',
    methodType: 'Recharges',
    referenceId: '1111110000'
  },
  COLOMBIA: {
    companyCode: 'CO-R-0010',
    methodId: '4fe48ed4-41ec-4c7c-91e1-88dc729b6e24',
    methodType: 'phoneNumber',
    referenceId: '3146830766'
  },
  PERU: {
    companyCode: 'PE-R-00002',
    methodId: 'b3577e66-3169-4901-8c05-fc1d6ed05e83',
    methodType: 'Recharges',
    referenceId: '1111110006'
  },
  MEXICO: {
    companyCode: 'MX-R-90005',
    methodId: '073acea1-69bc-4cde-bb4c-f679c5612789',
    methodType: 'Recharges',
    referenceId: '1111110000'
  },
  CHILE: {
    companyCode: 'CL-R-00002',
    methodId: 'd56505ee-be8a-4a3b-ad18-837a221d29c5',
    methodType: 'Recharges',
    referenceId: '1111110000'
  }
};

export const getBillIdInfoHelper = async (apiKey: string, country?: string, key?: string, userAnyId?: string) => {
  const countryMap: string = (country || '').toUpperCase();
  const urlBase = `https://sandbox.manteca.dev/crypto/v2`;

  const config = countryConfigBillMap[countryMap];
  if (!config) throw new Error(`Country '${country}' not supported`);

  const { companyCode, methodId, methodType, referenceId } = config;
  const endpoint = `/info/bill-companies/${companyCode}/${methodId}/${methodType}/${referenceId}`;

  const response = await apiRequest({ urlBase, endpoint, method: 'get', apiKey });

  return response;
};

export const getTopUpIdInfoHelper = async (apiKey: string, country?: string, key?: string, userAnyId?: string) => {
  const countryMap: string = (country || '').toUpperCase();
  const urlBase = `https://sandbox.manteca.dev/crypto/v2`;

  const config = countryConfigTopUpMap[countryMap];
  if (!config) throw new Error(`Country '${country}' not supported`);

  const { companyCode, methodId, methodType, referenceId } = config;
  const endpoint = `/info/bill-companies/${companyCode}/${methodId}/${methodType}/${referenceId}`;

  const response = await apiRequest({ urlBase, endpoint, method: 'get', apiKey });

  return response;
};
