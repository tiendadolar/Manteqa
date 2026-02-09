export interface WithdrawCriptoV2Response {
  id: string;
  numberId: string;
  network: string;
  networkId: string;
  userId: string;
  userNumberId: string;
  userLegalId: string;
  status: WithdrawCriptoV2Status;
  asset: string;
  amount: string;
  filledAmount: string;
  destination: string;
  externalId?: string;
  sessionId?: string;
  creationTime: string | Date;
  updatedAt: string | Date;
}

export type WithdrawCriptoV2Status = 'PENDING' | 'COMPLETED' | 'CANCELLED';

export type BlockchainNetwork = 'ETHEREUM' | 'BINANCE' | 'POLYGON' | 'ARBITRUM' | 'OPTIMISM' | 'BASE' | 'WORLDCHAIN' | 'TRON' | 'SOLANA' | 'STELLAR';

export enum WithdrawCriptoV2StatusEnum {
  PENDING = 'PENDING',
  COMPLETED = 'COMPLETED',
  CANCELLED = 'CANCELLED'
}

export enum BlockchainNetworkEnum {
  ETHEREUM = 'ETHEREUM',
  BINANCE = 'BINANCE',
  POLYGON = 'POLYGON',
  ARBITRUM = 'ARBITRUM',
  OPTIMISM = 'OPTIMISM',
  BASE = 'BASE',
  WORLDCHAIN = 'WORLDCHAIN',
  TRON = 'TRON',
  SOLANA = 'SOLANA',
  STELLAR = 'STELLAR'
}

export const isWithdrawCriptoV2Response = (obj: any): obj is WithdrawCriptoV2Response => {
  return (
    obj &&
    typeof obj.id === 'string' &&
    typeof obj.numberId === 'string' &&
    typeof obj.network === 'string' &&
    isBlockchainNetwork(obj.network) &&
    typeof obj.networkId === 'string' &&
    typeof obj.userId === 'string' &&
    typeof obj.userNumberId === 'string' &&
    typeof obj.userLegalId === 'string' &&
    typeof obj.status === 'string' &&
    WithdrawCriptoV2Status(obj.status) &&
    typeof obj.asset === 'string' &&
    typeof obj.amount === 'string' &&
    typeof obj.filledAmount === 'string' &&
    typeof obj.destination === 'string' &&
    (obj.externalId === undefined || typeof obj.externalId === 'string') &&
    (obj.sessionId === undefined || typeof obj.sessionId === 'string') &&
    (typeof obj.creationTime === 'string' || obj.creationTime instanceof Date) &&
    (typeof obj.updatedAt === 'string' || obj.updatedAt instanceof Date)
  );
};

export const WithdrawCriptoV2Status = (status: any): status is WithdrawCriptoV2Status => {
  const validStatuses: WithdrawCriptoV2Status[] = ['PENDING', 'COMPLETED', 'CANCELLED'];
  return typeof status === 'string' && validStatuses.includes(status as WithdrawCriptoV2Status);
};

export const isBlockchainNetwork = (network: any): network is BlockchainNetwork => {
  const validNetworks: BlockchainNetwork[] = ['ETHEREUM', 'BINANCE', 'POLYGON', 'ARBITRUM', 'OPTIMISM', 'BASE', 'WORLDCHAIN', 'TRON', 'SOLANA', 'STELLAR'];
  return typeof network === 'string' && validNetworks.includes(network as BlockchainNetwork);
};
