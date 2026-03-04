import { expect } from 'chai';
import { isWithdrawCriptoV2Response, WithdrawCriptoV2Response } from '../../../interfaces/withdrawals/V2/withdrawCripto.interface';
import { CustomWorld } from '../../../world';

export class WithdrawCriptoValidator {
  static validateWithdrawCriptoResponse(response: any): WithdrawCriptoV2Response {
    expect(response).to.exist;
    expect(response).to.be.an('object');

    if (!isWithdrawCriptoV2Response(response)) {
      throw new Error('Response does not match WithdrawCriptoV2Response interface');
    }

    this.validateWithdrawCriptoV2Fields(response);
    console.log('✅ Withdrawal V2 response validation passed');

    return response as WithdrawCriptoV2Response;
  }

  private static validateWithdrawCriptoV2Fields(response: WithdrawCriptoV2Response): void {
    console.log('cost: ', CustomWorld.getStoreData('cost'));
    console.log('amount: ', CustomWorld.getStoreData('amount'));

    const neto = parseFloat(CustomWorld.getStoreData('amount')) - parseFloat(CustomWorld.getStoreData('cost'));
    console.log('neto: ', neto);

    expect(response.id)
      .to.be.a('string')
      .and.match(/^[a-fA-F0-9]{24}$/);
    expect(response.network).to.be.equal(CustomWorld.getStoreData('network'));
    expect(response.userId)
      .to.be.a('string')
      .and.match(/^[a-fA-F0-9]{24}$/);
    expect(response.userNumberId).to.be.equal(CustomWorld.getStoreData('userAnyId'));
    expect(response.userLegalId).to.be.equal(CustomWorld.getStoreData('userLegalId'));
    expect(response.asset).to.be.equal(CustomWorld.getStoreData('asset'));
    expect(parseFloat(response.amount)).to.be.closeTo(neto, 0.000001);
    expect(parseFloat(response.filledAmount)).to.be.closeTo(neto, 0.000001);
    expect(response.destination).to.be.equal(CustomWorld.getStoreData('address'));
    if (response.externalId !== undefined) {
      expect(response.externalId).to.be.equal(CustomWorld.getStoreData('externalId'));
    }
    if (response.sessionId !== undefined) {
      expect(response.sessionId).to.be.equal(CustomWorld.getStoreData('sessionId'));
    }
    expect(response.creationTime).to.match(/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}-03:00$/);
    expect(response.updatedAt).to.match(/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}-03:00$/);
  }
}

export const validateResponse = (response: any): WithdrawCriptoV2Response => {
  return WithdrawCriptoValidator.validateWithdrawCriptoResponse(response);
};
