import { expect } from 'chai';
import logger from '../utils/logger';
import { CustomWorld } from '../world';
import { isLockWithdrawCostResponse, LockWithdrawCostData, LockWithdrawCostResponse } from '../interfaces/lockWithdrawCost.interface';

export class LockWithdrawCostValidator {
  static validateLockWithdrawCostResponse(response: any): LockWithdrawCostResponse {
    expect(response).to.exist;
    expect(response).to.be.an('object');

    if (!isLockWithdrawCostResponse(response)) {
      throw new Error('Response does not match LockWithdrawCostResponse interface');
    }

    Object.entries(response).forEach(([network, data]) => {
      this.validateNetworkField(network, data);
      this.validateLockWithdrawCostFields(data);
    });

    return response as LockWithdrawCostResponse;
  }

  private static validateNetworkField(network: string, data: any): void {
    expect(network).to.be.a('string').and.not.empty;
    expect(network).to.equal(CustomWorld.getStoreData('network'));
    expect(data.network).to.equal(CustomWorld.getStoreData('network'));
    expect(data.network).to.equal(network);
  }

  private static validateLockWithdrawCostFields(data: LockWithdrawCostData): void {
    expect(data.companyId)
      .to.be.a('string')
      .and.match(/^[0-9a-fA-F]{24}$/);
    expect(data.userId)
      .to.be.a('string')
      .and.match(/^[0-9a-fA-F]{24}$/);
    expect(data.userNumberId).to.be.equal(CustomWorld.getStoreData('userAnyId'));
    expect(data.asset).to.be.equal(CustomWorld.getStoreData('asset'));
    expect(data.network).to.be.equal(CustomWorld.getStoreData('network'));
    expect(data.address).to.be.equal(CustomWorld.getStoreData('address'));
    expect(data.expireAt).to.match(/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}-03:00$/);
    expect(data.creationTime).to.match(/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}-03:00$/);
    expect(data.code).to.match(/^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i);
  }
}

export const validateResponse = (response: any): LockWithdrawCostResponse => {
  return LockWithdrawCostValidator.validateLockWithdrawCostResponse(response);
};
