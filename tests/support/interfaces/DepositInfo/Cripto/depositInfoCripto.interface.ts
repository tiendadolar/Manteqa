export interface DepositInfoCriptoResponse {
  [network: string]: DepositInfoCriptoData;
}

export interface DepositInfoCriptoData {
  address: string;
  network: string;
}

export const isDepositInfoCriptoResponse = (obj: any): obj is DepositInfoCriptoResponse => {
  return obj && typeof obj === 'object' && Object.keys(obj).length > 0 && Object.values(obj).every((value) => isDepositInfoCriptoData(value));
};

export const isDepositInfoCriptoData = (obj: any): obj is DepositInfoCriptoData => {
  return obj && typeof obj.address === 'string' && obj.address.length > 0 && typeof obj.network === 'string' && obj.network.length > 0;
};
