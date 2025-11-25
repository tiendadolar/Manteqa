import { expect } from 'chai';
import logger from '../utils/logger';
import { CustomWorld } from '../world';
import { FeeInfo, FinalCInfo, isFeeInfo, isFinalCInfo, isOrderResponse, OrderResponse } from '../interfaces/orders.interface';

export class OrderResponseValidator {
  static validateOrderResponse(response: any): OrderResponse {
    expect(response).to.exist;
    expect(response).to.be.an('object');

    if (!isOrderResponse(response)) {
      throw new Error('Response does not match OrderResponse interface');
    }

    this.validateOrderFields(response);
    this.validateFeeInfo(response.feeInfo);
    this.validateFinalCInfo(response.finalClaimInfo, 'finalClaimInfo');
    this.validateFinalCInfo(response.finalCreditInfo, 'finalCreditInfo');

    return response as OrderResponse;
  }

  private static validateOrderFields(order: OrderResponse): void {
    expect(order.id).to.be.a('string').and.not.empty;
    expect(order.numberId).to.be.a('string').and.not.empty;
    expect(order.externalId).to.be.a('string').and.not.empty;
    expect(order.sessionId).to.be.a('string').and.not.empty;
    expect(order.userId).to.be.a('string').and.not.empty;
    expect(order.userNumberId).to.be.a('string').and.not.empty;
    expect(order.userExternalId).to.be.a('string').and.not.empty;
    expect(order.exchange).to.be.oneOf(['ARGENTINA', 'BRAZIL', 'MEXICO']);
    expect(order.status).to.be.oneOf(['PENDING', 'COMPLETED', 'FAILED']);
    expect(order.type).to.be.oneOf(['DIRECT']);
    expect(order.side).to.be.oneOf(['BUY', 'SELL']);
    expect(order.asset).to.be.a('string').and.not.empty;
    expect(order.against).to.be.a('string').and.not.empty;
    expect(order.assetAmount).to.match(/^\d+(\.\d+)?$/);
    expect(order.filledAmount).to.match(/^\d+(\.\d+)?$/);
    expect(order.price).to.match(/^\d+(\.\d+)?$/);
    expect(order.effectivePrice).to.match(/^\d+(\.\d+)?$/);
  }

  private static validateFeeInfo(feeInfo: FeeInfo): void {
    if (!isFeeInfo(feeInfo)) {
      throw new Error('feeInfo does not match FeeInfo interface');
    }

    expect(feeInfo.platformFee).to.match(/^\d+(\.\d+)?$/);
    expect(feeInfo.companyProfit).to.match(/^\d+(\.\d+)?$/);
    expect(feeInfo.totalFee).to.match(/^\d+(\.\d+)?$/);
  }

  private static validateFinalCInfo(finalInfo: FinalCInfo, context: string): void {
    if (!isFinalCInfo(finalInfo)) {
      throw new Error(`${context} does not match FinalCInfo interface`);
    }

    expect(finalInfo.asset).to.match(/^[A-Z0-9]{1,10}$/);
    expect(finalInfo.total).to.match(/^\d+(\.\d+)?$/);
    expect(finalInfo.base).to.match(/^\d+(\.\d+)?$/);
    expect(finalInfo.totalFees).to.match(/^\d+(\.\d+)?$/);
    expect(finalInfo.platformFee).to.match(/^\d+(\.\d+)?$/);
    expect(finalInfo.companyProfit).to.match(/^\d+(\.\d+)?$/);
  }
}

export const validateResponse = (response: any): OrderResponse => {
  return OrderResponseValidator.validateOrderResponse(response);
};
