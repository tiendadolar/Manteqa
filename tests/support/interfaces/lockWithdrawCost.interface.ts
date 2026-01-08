export interface LockWithdrawCostResponse {
  [network: string]: LockWithdrawCostData;
}

export interface LockWithdrawCostData {
  companyId: string;
  userId: string;
  userNumberId: string;
  userExternalId?: string;
  asset: string;
  network: string;
  address: string;
  cost: string;
  expireSeconds: string;
  expireAt: string | Date;
  creationTime: string | Date;
  code: string;
}

export type BlockchainNetwork = 'ETHEREUM' | 'BINANCE' | 'POLYGON' | 'ARBITRUM' | 'OPTIMISM' | 'BASE' | 'WORLDCHAIN' | 'TERRA' | 'TERRA2' | 'TRON';

export enum BlockchainNetworkEnum {
  ETHEREUM = 'ETHEREUM',
  BINANCE = 'BINANCE',
  POLYGON = 'POLYGON',
  ARBITRUM = 'ARBITRUM',
  OPTIMISM = 'OPTIMISM',
  BASE = 'BASE',
  WORLDCHAIN = 'WORLDCHAIN',
  TERRA = 'TERRA',
  TERRA2 = 'TERRA2',
  TRON = 'TRON'
}

export const isLockWithdrawCostResponse = (obj: any): obj is LockWithdrawCostResponse => {
  if (!obj || typeof obj !== 'object') return false;

  // Validar que todas las propiedades del objeto son DepositAddressData
  return Object.values(obj).every((data: any) => typeof data === 'object' && isLockWithdrawCostData(data));
};

export const isLockWithdrawCostData = (obj: any): obj is LockWithdrawCostData => {
  return (
    obj &&
    typeof obj.companyId === 'string' &&
    typeof obj.userId === 'string' &&
    typeof obj.userNumberId === 'string' &&
    (obj.userExternalId === undefined || typeof obj.userExternalId === 'string') &&
    typeof obj.asset === 'string' &&
    typeof obj.network === 'string' &&
    isBlockchainNetwork(obj.network) &&
    typeof obj.address === 'string' &&
    typeof obj.cost === 'string' &&
    typeof obj.expireSeconds === 'string' &&
    (typeof obj.expireAt === 'string' || obj.expireAt instanceof Date) &&
    (typeof obj.creationTime === 'string' || obj.creationTime instanceof Date) &&
    typeof obj.code === 'string'
  );
};

export const isBlockchainNetwork = (network: any): network is BlockchainNetwork => {
  const validNetworks: BlockchainNetwork[] = ['ETHEREUM', 'BINANCE', 'POLYGON', 'ARBITRUM', 'OPTIMISM', 'BASE', 'WORLDCHAIN', 'TERRA', 'TERRA2', 'TRON'];
  return typeof network === 'string' && validNetworks.includes(network as BlockchainNetwork);
};
