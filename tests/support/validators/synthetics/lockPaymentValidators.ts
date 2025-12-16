import { expect } from 'chai';
import logger from '../../utils/logger';
import { CustomWorld } from '../../world';
import { isLockPaymentResponse, LockPaymentResponse } from '../../interfaces/LockPayment.interface';

export class LockPaymentValidator {
  static validateLockPayment(response: any): LockPaymentResponse {
    expect(response).to.exist;
    expect(response).to.be.an('object');

    if (!isLockPaymentResponse(response)) {
      throw new Error('Response does not match LockPaymentResponse interface');
    }

    this.validateLockPaymentFields(response);
    if (response.sender !== undefined) this.validateSenderFields(response);

    return response as LockPaymentResponse;
  }
  private static validateLockPaymentFields(lockPayment: LockPaymentResponse): void {
    expect(lockPayment.userNumberId).to.be.equal(CustomWorld.getStoreData('userAnyId'));
    expect(parseFloat(lockPayment.paymentAssetAmount) / parseFloat(lockPayment.paymentAgainstAmount)).to.be.closeTo(parseFloat(lockPayment.paymentPrice), 0.02);
    expect(lockPayment.paymentAgainst).to.be.equal(CustomWorld.getStoreData('against') || 'USDT');
  }

  private static validateSenderFields(lockPayment: LockPaymentResponse): void {
    expect(lockPayment.sender?.exchange).to.be.equal(CustomWorld.getStoreData('exchange'));
    expect(lockPayment.sender?.legalId).to.be.equal(CustomWorld.getStoreData('legalId'));
    expect(lockPayment.sender?.name).to.be.equal(CustomWorld.getStoreData('name'));
    expect(lockPayment.sender?.surname).to.be.equal(CustomWorld.getStoreData('surname'));
  }
}

export const validateResponse = (response: any): LockPaymentResponse => {
  return LockPaymentValidator.validateLockPayment(response);
};
