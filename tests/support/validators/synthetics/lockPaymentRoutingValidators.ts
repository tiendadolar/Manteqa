import { expect } from 'chai';
import logger from '../../utils/logger';
import { CustomWorld } from '../../world';
import { isLockPaymentResponse, LockPaymentResponse } from '../../interfaces/LockPayment.interface';

export class LockPaymentRoutingValidator {
  static validateLockPayment(response: any, principalAccount?: any): LockPaymentResponse {
    expect(response).to.exist;
    expect(response).to.be.an('object');

    if (!isLockPaymentResponse(response)) {
      throw new Error('Response does not match LockPaymentResponse interface');
    }

    this.validateLockPaymentFields(response);
    if (response.sender !== undefined) this.validateSenderFields(response, principalAccount);

    return response as LockPaymentResponse;
  }
  private static validateLockPaymentFields(lockPayment: LockPaymentResponse): void {
    expect(lockPayment.userNumberId).to.be.equal(CustomWorld.getStoreData('principalAccount'));
    expect(parseFloat(lockPayment.paymentAssetAmount) / parseFloat(lockPayment.paymentAgainstAmount)).to.be.closeTo(parseFloat(lockPayment.paymentPrice), 0.02);
    expect(lockPayment.paymentAgainst).to.be.equal(CustomWorld.getStoreData('against') || 'USDT');
  }

  private static validateSenderFields(lockPayment: LockPaymentResponse, principalAccount?: any): void {
    expect(lockPayment.sender?.exchange).to.be.equal(principalAccount.compliance.personalData.nationality.toUpperCase());
    expect(lockPayment.sender?.legalId).to.be.equal(principalAccount.compliance.personalData.cuit);
    expect(lockPayment.sender?.name).to.be.equal(principalAccount.compliance.personalData.name);
    expect(lockPayment.sender?.surname).to.be.equal(principalAccount.compliance.personalData.surname);
  }
}

export const validateResponseRouting = (response: any, principalAccount?: any): LockPaymentResponse => {
  return LockPaymentRoutingValidator.validateLockPayment(response, principalAccount);
};
