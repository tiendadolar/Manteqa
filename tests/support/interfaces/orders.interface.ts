export interface OrderResponse {
  id: string;
  numberId: string;
  externalId?: string;
  sessionId?: string;
  userId: string;
  userNumberId: string;
  userExternalId?: string;
  exchange: string;
  status: string;
  type: string;
  side: string;
  asset: string;
  against: string;
  assetAmount: string;
  filledAmount: string;
  price: string;
  effectivePrice: string;
  feeInfo: FeeInfo;
  finalClaimInfo: FinalCInfo;
  finalCreditInfo: FinalCInfo;
  creationTime: string;
  updatedAt: string;
}

export interface FeeInfo {
  platformFee: string;
  companyProfit: string;
  totalFee: string;
}

export interface FinalCInfo {
  asset: string;
  total: string;
  base: string;
  totalFees: string;
  platformFee: string;
  companyProfit: string;
}

export const isOrderResponse = (obj: any): obj is OrderResponse => {
  return (
    obj &&
    typeof obj.id === 'string' &&
    typeof obj.numberId === 'string' &&
    typeof obj.externalId === 'string' &&
    typeof obj.sessionId === 'string' &&
    typeof obj.userId === 'string' &&
    typeof obj.userNumberId === 'string' &&
    typeof obj.userExternalId === 'string' &&
    typeof obj.exchange === 'string' &&
    typeof obj.status === 'string' &&
    typeof obj.type === 'string' &&
    typeof obj.side === 'string' &&
    typeof obj.asset === 'string' &&
    typeof obj.against === 'string' &&
    typeof obj.assetAmount === 'string' &&
    typeof obj.filledAmount === 'string' &&
    typeof obj.price === 'string' &&
    typeof obj.effectivePrice === 'string' &&
    typeof obj.feeInfo === 'object' &&
    typeof obj.finalClaimInfo === 'object' &&
    typeof obj.finalCreditInfo === 'object' &&
    (typeof obj.creationTime === 'string' || obj.creationTime instanceof Date) &&
    (typeof obj.updatedAt === 'string' || obj.updatedAt instanceof Date)
  );
};

export const isFeeInfo = (obj: any): obj is FeeInfo => {
  return obj && typeof obj.platformFee === 'string' && typeof obj.companyProfit === 'string' && typeof obj.totalFee === 'string';
};

export const isFinalCInfo = (obj: any): obj is FinalCInfo => {
  return (
    obj &&
    typeof obj.asset === 'string' &&
    typeof obj.total === 'string' &&
    typeof obj.base === 'string' &&
    typeof obj.totalFees === 'string' &&
    typeof obj.platformFee === 'string' &&
    typeof obj.companyProfit === 'string'
  );
};
