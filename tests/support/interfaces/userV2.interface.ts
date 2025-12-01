export interface GetUserV2Response {
  id: string;
  externalId?: string;
  numberId: string;
  exchange: string;
  email: string;
  type: string;
  status: string;
  banking: Banking;
  addresses: Addresses;
  onboarding: Onboarding;
  creationTime: Date;
  updatedAt: Date;
}

export interface Addresses {
  depositAddresses: DepositAddresses;
  knownAddresses: any[];
}

export interface DepositAddresses {
  [key: string]: string | undefined;
}

export interface Banking {
  accounts: Account[];
}

export interface Account {
  cbu?: string;
  currency?: string;
  description?: string;
}

export interface Onboarding {
  [key: string]: BankAccountDefinition;
}

export interface BankAccountDefinition {
  required: boolean;
  status: Status;
}

export enum Status {
  Completed = 'COMPLETED',
  Pending = 'PENDING',
  InProgress = 'IN_PROGRESS'
}

//Type Guards

export const isGetUserV2Response = (obj: any): obj is GetUserV2Response => {
  return (
    obj &&
    typeof obj.id === 'string' &&
    (obj.externalId === undefined || typeof obj.externalId === 'string') &&
    typeof obj.numberId === 'string' &&
    typeof obj.numberId === 'string' &&
    typeof obj.exchange === 'string' &&
    typeof obj.email === 'string' &&
    typeof obj.type === 'string' &&
    typeof obj.status === 'string' &&
    typeof obj.banking === 'object' &&
    isBanking(obj.banking) &&
    typeof obj.addresses === 'object' &&
    isAddresses(obj.addresses) &&
    typeof obj.onboarding === 'object' &&
    isOnboarding(obj.onboarding) &&
    (typeof obj.creationTime === 'string' || obj.creationTime instanceof Date) &&
    (typeof obj.updatedAt === 'string' || obj.updatedAt instanceof Date)
  );
};

export const isAddresses = (obj: any): obj is Addresses => {
  return obj && typeof obj.depositAddresses === 'object' && isDepositAddresses(obj.depositAddresses) && Array.isArray(obj.knownAddresses);
};

export const isDepositAddresses = (obj: any): obj is DepositAddresses => {
  if (!obj || typeof obj !== 'object') return false;

  return Object.values(obj).every((value) => value === undefined || typeof value === 'string');
};

export const isBanking = (obj: any): obj is Banking => {
  return obj && Array.isArray(obj.accounts) && obj.accounts.every((account: any) => account && typeof account === 'object');
};

export const isAccount = (obj: any): obj is Account => {
  return obj && typeof obj === 'object';
};

export const isOnboarding = (obj: any): obj is Onboarding => {
  if (!obj || typeof obj !== 'object') return false;

  // Validar que todas las propiedades son BankAccountDefinition
  return Object.values(obj).every((step: any) => isBankAccountDefinition(step));
};

export const isBankAccountDefinition = (obj: any): obj is BankAccountDefinition => {
  return obj && typeof obj.required === 'boolean' && typeof obj.status === 'string' && (obj.status === Status.Completed || obj.status === Status.Pending || obj.status === Status.InProgress);
};
