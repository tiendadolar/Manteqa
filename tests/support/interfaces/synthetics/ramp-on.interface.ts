export interface RampOnResponse {
  id: string;
  numberId: string;
  externalId?: string;
  userId: string;
  userNumberId: string;
  userExternalId?: string;
  sessionId?: string;
  status: 'STARTING';
  type: 'RAMP_OPERATION';
  details: Details;
  currentStage: number;
  stages: Stages;
  creationTime: string | Date;
  updatedAt: string | Date;
}

export interface Details {
  depositAddresses: DepositAddresses;
  depositAddress: string;
  depositAvailableNetworks: string[];
  withdrawCostInAgainst: string;
  withdrawCostInAsset: string;
  effectiveWithdrawAmount: string;
  price: string;
  priceExpireAt: string | Date;
}

export interface DepositAddresses {
  [network: string]: DepositAddress;
}

export interface DepositAddress {
  address: string;
  type: 'DEPOSIT' | 'WITHDRAW';
}

export interface Stages {
  [stageNumber: string]: Stage;
}

export interface Stage {
  stageType: 'DEPOSIT' | 'ORDER' | 'WITHDRAW';
  legalEntity: 'CRYPTO_ARG' | 'CRYPTO_GLOBAL';
  asset?: string;
  thresholdAmount?: string;
  useOverflow?: boolean;
  expireAt?: string | Date;
  side?: 'BUY' | 'SELL';
  type?: 'MARKET' | 'LIMIT';
  against?: string;
  assetAmount?: string;
  price?: string;
  priceCode?: string;
  network?: string;
  amount?: string;
  to?: string;
  destination?: Destination;
}

export interface Destination {
  network: string;
  address: string;
}

// Type Guards
export const isRampOnResponse = (obj: any): obj is RampOnResponse => {
  console.log('isRampOnResponse');
  return (
    obj &&
    typeof obj.id === 'string' &&
    typeof obj.numberId === 'string' &&
    (obj.externalId === undefined || typeof obj.externalId === 'string') &&
    typeof obj.userId === 'string' &&
    typeof obj.userNumberId === 'string' &&
    (obj.userExternalId === undefined || typeof obj.userExternalId === 'string') &&
    (obj.sessionId === undefined || typeof obj.sessionId === 'string') &&
    obj.status === 'STARTING' &&
    obj.type === 'RAMP_OPERATION' &&
    typeof obj.details === 'object' &&
    isDetails(obj.details) &&
    typeof obj.currentStage === 'number' &&
    typeof obj.stages === 'object' &&
    isStages(obj.stages) &&
    (typeof obj.creationTime === 'string' || obj.creationTime instanceof Date) &&
    (typeof obj.updatedAt === 'string' || obj.updatedAt instanceof Date)
  );
};

export const isDetails = (obj: any): obj is Details => {
  console.log('isDetails');
  return (
    obj &&
    typeof obj.depositAddresses === 'object' &&
    isDepositAddresses(obj.depositAddresses) &&
    typeof obj.depositAddress === 'string' &&
    Array.isArray(obj.depositAvailableNetworks) &&
    obj.depositAvailableNetworks.every((n: any) => typeof n === 'string') &&
    typeof obj.withdrawCostInAgainst === 'string' &&
    typeof obj.withdrawCostInAsset === 'string' &&
    typeof obj.effectiveWithdrawAmount === 'string' &&
    typeof obj.price === 'string' &&
    (typeof obj.priceExpireAt === 'string' || obj.priceExpireAt instanceof Date)
  );
};

export const isDepositAddresses = (obj: any): obj is DepositAddresses => {
  console.log('isDepositAddresses');
  if (!obj || typeof obj !== 'object') return false;
  return Object.values(obj).every((value) => isDepositAddress(value));
};

export const isDepositAddress = (obj: any): obj is DepositAddress => {
  console.log('isDepositAddress');
  return (
    obj &&
    typeof obj.address === 'string' &&
    (obj.type === undefined || obj.type === 'DEPOSIT' || obj.type === 'WITHDRAW') &&
    (obj.network === undefined || typeof obj.network === 'string') &&
    (obj.alias === undefined || typeof obj.alias === 'string')
  );
};

export const isStages = (obj: any): obj is Stages => {
  console.log('isStages');
  if (!obj || typeof obj !== 'object') return false;
  return Object.values(obj).every((value) => isStage(value));
};

export const isStage = (obj: any): obj is Stage => {
  console.log('isStage');
  if (!obj) return false;
  if (obj.stageType !== 'DEPOSIT' && obj.stageType !== 'ORDER' && obj.stageType !== 'WITHDRAW') return false;
  if (obj.legalEntity !== 'CRYPTO_ARG' && obj.legalEntity !== 'CRYPTO_GLOBAL') return false;

  if (obj.stageType === 'DEPOSIT') {
    if (obj.asset !== undefined && typeof obj.asset !== 'string') return false;
    if (obj.thresholdAmount !== undefined && typeof obj.thresholdAmount !== 'string') return false;
    if (obj.useOverflow !== undefined && typeof obj.useOverflow !== 'boolean') return false;
    if (obj.expireAt !== undefined && typeof obj.expireAt !== 'string' && !(obj.expireAt instanceof Date)) return false;
  }

  if (obj.stageType === 'ORDER') {
    if (obj.side !== undefined && obj.side !== 'BUY' && obj.side !== 'SELL') return false;
    if (obj.type !== undefined && obj.type !== 'MARKET' && obj.type !== 'LIMIT') return false;
    if (obj.asset !== undefined && typeof obj.asset !== 'string') return false;
    if (obj.against !== undefined && typeof obj.against !== 'string') return false;
    if (obj.assetAmount !== undefined && typeof obj.assetAmount !== 'string') return false;
    if (obj.price !== undefined && typeof obj.price !== 'string') return false;
    if (obj.priceCode !== undefined && typeof obj.priceCode !== 'string') return false;
  }
  if (obj.stageType === 'WITHDRAW') {
    if (obj.network !== undefined && typeof obj.network !== 'string') return false;
    if (obj.asset !== undefined && typeof obj.asset !== 'string') return false;
    if (obj.amount !== undefined && typeof obj.amount !== 'string') return false;
    if (obj.to !== undefined && typeof obj.to !== 'string') return false;
    if (obj.destination !== undefined && (typeof obj.destination !== 'object' || !isDestination(obj.destination))) return false;
  }

  return true;
};

export const isDestination = (obj: any): obj is Destination => {
  return obj && typeof obj.network === 'string' && typeof obj.address === 'string';
};
