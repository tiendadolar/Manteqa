export interface LockPriceResponse {
  code: string;
  userId: string;
  userNumberId: string;
  userExternalId?: string;
  side: Side;
  asset: string;
  against: string;
  price: string;
  expireSeconds: number;
  allowMultipleUses: boolean;
  expireAt: string | Date;
  creationTime: string | Date;
}

export type Side = 'BUY' | 'SELL';

export enum SideEnum {
  BUY = 'BUY',
  SELL = 'SELL'
}

export const isLockPriceResponse = (obj: any): obj is LockPriceResponse => {
  return (
    obj &&
    typeof obj.code === 'string' &&
    typeof obj.userId === 'string' &&
    typeof obj.userNumberId === 'string' &&
    (obj.userExternalId === undefined || typeof obj.userExternalId === 'string') &&
    typeof obj.side === 'string' &&
    isSide(obj.side) &&
    typeof obj.asset === 'string' &&
    typeof obj.against === 'string' &&
    typeof obj.price === 'string' &&
    typeof obj.expireSeconds === 'number' &&
    typeof obj.allowMultipleUses === 'boolean' &&
    (typeof obj.expireAt === 'string' || obj.expireAt instanceof Date) &&
    (typeof obj.creationTime === 'string' || obj.creationTime instanceof Date)
  );
};

export const isSide = (side: any): side is Side => {
  return side === 'BUY' || side === 'SELL';
};
