export interface LockPaymentResponse {
  code: string;
  type: PaymentType;
  companyId: string;
  userId: string;
  userNumberId: string;
  userExternalId?: string;
  sender?: Sender;
  paymentRecipientName: string;
  paymentRecipientLegalId: string;
  paymentAssetAmount: string;
  paymentAsset: string;
  paymentPrice: string;
  paymentAgainstAmount: string;
  paymentAgainst: string;
  expireAt: string | Date;
  creationTime: string | Date;
}

export type PaymentType = 'PERU_QR' | 'QR3' | 'PIX';

export interface Sender {
  exchange: string;
  legalId: string;
  name: string;
  surname: string;
}

export const isLockPaymentResponse = (obj: any): obj is LockPaymentResponse => {
  return (
    obj &&
    typeof obj.code === 'string' &&
    typeof obj.type === 'string' &&
    isPaymentType(obj.type) &&
    typeof obj.companyId === 'string' &&
    typeof obj.userId === 'string' &&
    typeof obj.userNumberId === 'string' &&
    (obj.userExternalId === undefined || typeof obj.userExternalId === 'string') &&
    (obj.sender === undefined || (typeof obj.sender === 'object' && isSender(obj.sender))) &&
    typeof obj.paymentRecipientName === 'string' &&
    typeof obj.paymentRecipientLegalId === 'string' &&
    typeof obj.paymentAssetAmount === 'string' &&
    typeof obj.paymentAsset === 'string' &&
    typeof obj.paymentPrice === 'string' &&
    typeof obj.paymentAgainstAmount === 'string' &&
    typeof obj.paymentAgainst === 'string' &&
    (typeof obj.expireAt === 'string' || obj.expireAt instanceof Date) &&
    (typeof obj.creationTime === 'string' || obj.creationTime instanceof Date)
  );
};

export const isPaymentType = (type: any): type is PaymentType => {
  return typeof type === 'string' && PAYMENT_TYPES.includes(type as any);
};

export const isSender = (obj: any): obj is Sender => {
  return obj && typeof obj.exchange === 'string' && typeof obj.legalId === 'string' && typeof obj.name === 'string' && typeof obj.surname === 'string';
};

export const PAYMENT_TYPES = ['PERU_QR', 'PIX', 'QR3'] as const;
