const request = require('supertest');
const { expect } = require('chai');
import { withdrawLockApiCryptoV2 } from '../../../utils/utils';
import { CustomWorld } from '../../../world';
import { apiRequest } from '../../requestHelper';

export const getLockWithdrawCostV2Helper = async (apiKey: string, userData: any) => {
  const urlBase = `https://sandbox.manteca.dev/crypto/v2`;
  const endpoint = `/withdraw-locks`;
  const body = {
    userAnyId: CustomWorld.getStoreData('userAnyId'),
    asset: CustomWorld.getStoreData('asset'),
    destination: {
      address: CustomWorld.getStoreData('address'),
      network: CustomWorld.getStoreData('network')
    }
  };

  const response = await apiRequest({ urlBase, endpoint, method: 'post', apiKey, body });

  return response;
};
