export interface DepositInfoFiatResponse {
  address: string;
  network: string;
  accountType?: string;
  accountName?: string;
  legalId?: string;
  alias?: string;
  bankCode?: string;
  bankName?: string;
}

export const isDepositInfoFiatResponse = (obj: any): obj is DepositInfoFiatResponse => {
  const keys = obj && typeof obj === 'object' ? Object.keys(obj) : [];
  return keys.length === 1 && isDepositInfoFiatData(obj[keys[0]]);
};

export const isDepositInfoFiatData = (obj: any): obj is DepositInfoFiatResponse => {
  return (
    obj &&
    typeof obj.address === 'string' &&
    obj.address.length > 0 &&
    typeof obj.network === 'string' &&
    obj.network.length > 0 &&
    (obj.accountType === undefined || typeof obj.accountType === 'string') &&
    (obj.accountName === undefined || typeof obj.accountName === 'string') &&
    (obj.alias === undefined || typeof obj.alias === 'string') &&
    (obj.legalId === undefined || typeof obj.legalId === 'string') &&
    (obj.bankCode === undefined || typeof obj.bankCode === 'string') &&
    (obj.bankName === undefined || typeof obj.bankName === 'string')
  );
};
