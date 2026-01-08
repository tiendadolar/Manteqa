import { expect } from 'chai';
import logger from '../utils/logger';
import { CustomWorld } from '../world';
import { isLockPriceResponse, LockPriceResponse } from '../interfaces/lockPrice.interface';
import { isOrderResponse } from '../interfaces/orders.interface';
import { CRYPTO_ASSETS, FIAT_ASSETS } from '../constants/constants.assets';

export class LockPriceValidator {
  static validateLockPriceResponse(response: any): LockPriceResponse {
    expect(response).to.exist;
    expect(response).to.be.an('object');

    if (!isLockPriceResponse(response)) {
      throw new Error('Response does not match LockPriceResponse interface');
    }

    this.validateLockPriceFields(response);

    return response as LockPriceResponse;
  }
  private static validateLockPriceFields(response: LockPriceResponse): void {
    const price = parseFloat(response.price);

    expect(response.code).to.match(/^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i);
    expect(response.userId)
      .to.be.a('string')
      .and.match(/^[a-f\d]{24}$/i);
    expect(response.userNumberId).to.be.equal(CustomWorld.getStoreData('userAnyId'));
    expect(response.side).to.be.oneOf(['BUY', 'SELL']);
    expect(response.side).to.be.equal(CustomWorld.getStoreData('side'));
    expect(response.asset).to.be.equal(CustomWorld.getStoreData('asset'));
    expect(CRYPTO_ASSETS).to.include(CustomWorld.getStoreData('asset'));
    expect(response.against).to.be.equal(CustomWorld.getStoreData('against'));
    expect(FIAT_ASSETS).to.include(CustomWorld.getStoreData('against'));
    expect(price).to.be.greaterThan(0);
    expect(response.allowMultipleUses.toString()).to.be.equal(CustomWorld.getStoreData('allowMultipleUses'));
    expect(response.expireAt).to.match(/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}-03:00$/);
    expect(response.creationTime).to.match(/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}-03:00$/);
  }
}

export const validateResponse = (response: any): LockPriceResponse => {
  return LockPriceValidator.validateLockPriceResponse(response);
};
