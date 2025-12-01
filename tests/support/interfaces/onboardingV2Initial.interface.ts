export interface OnboardingV2InitialResponse {
  user: User;
  person: Person;
  causedConflict: boolean;
}

export interface Person {
  id: string;
  legalId: string;
  email: string;
  exchangeCountry: string;
  personalData: PersonalData;
  renaperData: RenaperData;
  flags: Flags;
  blockedNumberIds: BlockedNumberIDS;
  companyIds: string[];
  numberIds: string[];
  creationTime: Date;
  updatedAt: Date;
}

export interface BlockedNumberIDS {}

export interface Flags {
  isPEP: boolean;
  isFEP: boolean;
  isDead: boolean;
  isTerrorist: boolean;
  isFACTA: boolean;
  isJuridical: boolean;
}

export interface PersonalData {
  economicLevel: string;
  phoneNumber: string;
  cleanName: string;
  maritalStatus: string;
  name: string;
  surname: string;
  work: string;
  birthDate: Date;
  address: Address;
  sex: string;
  nationality: string;
}

export interface Address {
  postalCode?: string;
  province?: string;
  locality?: string;
  street: string;
  numeration?: string;
  floor?: string;
  apartment?: string;
}

export interface RenaperData {
  isDead: boolean;
  dniModel: string;
  dniNumber: string;
  name: string;
  surname: string;
}

export interface User {
  id: string;
  companyId: string;
  externalId: string;
  numberId: string;
  legalId: string;
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
  depositAddresses: BlockedNumberIDS;
  knownAddresses: any[];
}

export interface Banking {
  accounts: any[];
}

// export interface Onboarding {
//   EMAIL_VALIDATION: BankAccountDefinition;
//   IDENTITY_DECLARATION: BankAccountDefinition;
//   BASIC_PERSONAL_DATA_DEFINITION: BankAccountDefinition;
//   TYC_ACCEPTANCE: BankAccountDefinition;
//   POLITICAL_CONSTRAINTS_VALIDATION: BankAccountDefinition;
//   SECURITY_VALIDATION: BankAccountDefinition;
//   BANK_ACCOUNT_DEFINITION: BankAccountDefinition;
//   FEP_DOCUMENTATION_VALIDATION: BankAccountDefinition;
//   PEP_DOCUMENTATION_VALIDATION: BankAccountDefinition;
//   IDENTITY_VALIDATION: BankAccountDefinition;
//   SELFIE_VALIDATION: BankAccountDefinition;
// }

export interface Onboarding {
  [key: string]: BankAccountDefinition;
}

export interface BankAccountDefinition {
  required: boolean;
  status: Status;
}

export enum Status {
  Completed = 'COMPLETED',
  Pending = 'PENDING'
}

// Type Guard

export const isOnboardingV2Initial = (obj: any): obj is OnboardingV2InitialResponse => {
  return obj && typeof obj.user === 'object' && isUser(obj.user) && typeof obj.person === 'object' && isPerson(obj.person) && typeof obj.causedConflict === 'boolean';
};

export const isPerson = (obj: any): obj is Person => {
  return (
    obj &&
    typeof obj.id === 'string' &&
    typeof obj.legalId === 'string' &&
    typeof obj.email === 'string' &&
    typeof obj.exchangeCountry === 'string' &&
    typeof obj.personalData === 'object' &&
    isPersonalData(obj.personalData) &&
    typeof obj.renaperData === 'object' &&
    isRenaperData(obj.renaperData) &&
    typeof obj.flags === 'object' &&
    isFlags(obj.flags) &&
    typeof obj.blockedNumberIds === 'object' &&
    isBlockedNumberIds(obj.blockedNumberIds) &&
    Array.isArray(obj.companyIds) &&
    obj.companyIds.every((id: any) => typeof id === 'string') &&
    Array.isArray(obj.numberIds) &&
    obj.numberIds.every((id: any) => typeof id === 'string') &&
    (typeof obj.creationTime === 'string' || obj.creationTime instanceof Date) &&
    (typeof obj.updatedAt === 'string' || obj.updatedAt instanceof Date)
  );
};

export const isBlockedNumberIds = (obj: any): obj is BlockedNumberIDS => {
  return obj && typeof obj === 'object'; // Objeto vacío o con propiedades
};

export const isFlags = (obj: any): obj is Flags => {
  return (
    obj &&
    typeof obj.isPEP === 'boolean' &&
    typeof obj.isFEP === 'boolean' &&
    typeof obj.isDead === 'boolean' &&
    typeof obj.isTerrorist === 'boolean' &&
    typeof obj.isFACTA === 'boolean' &&
    typeof obj.isJuridical === 'boolean'
  );
};

export const isPersonalData = (obj: any): obj is PersonalData => {
  return (
    obj &&
    typeof obj.economicLevel === 'string' &&
    typeof obj.phoneNumber === 'string' &&
    typeof obj.cleanName === 'string' &&
    typeof obj.maritalStatus === 'string' &&
    typeof obj.name === 'string' &&
    typeof obj.surname === 'string' &&
    typeof obj.work === 'string' &&
    (typeof obj.birthDate === 'string' || obj.birthDate instanceof Date) &&
    typeof obj.address === 'object' &&
    isAddress(obj.address) &&
    typeof obj.sex === 'string' &&
    typeof obj.nationality === 'string'
  );
};

export const isAddress = (obj: any): obj is Address => {
  return (
    obj &&
    typeof obj.postalCode === 'string' &&
    typeof obj.province === 'string' &&
    typeof obj.locality === 'string' &&
    typeof obj.street === 'string' &&
    typeof obj.numeration === 'string' &&
    typeof obj.floor === 'string' &&
    typeof obj.apartment === 'string'
  );
};

export const isRenaperData = (obj: any): obj is RenaperData => {
  return obj && typeof obj.isDead === 'boolean' && typeof obj.dniModel === 'string' && typeof obj.dniNumber === 'string' && typeof obj.name === 'string' && typeof obj.surname === 'string';
};

export const isUser = (obj: any): obj is User => {
  return (
    obj &&
    typeof obj.id === 'string' &&
    typeof obj.companyId === 'string' &&
    typeof obj.externalId === 'string' &&
    typeof obj.numberId === 'string' &&
    typeof obj.legalId === 'string' &&
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
  return obj && typeof obj.depositAddresses === 'object' && isBlockedNumberIds(obj.depositAddresses) && Array.isArray(obj.knownAddresses);
};

export const isBanking = (obj: any): obj is Banking => {
  return obj && Array.isArray(obj.accounts);
};

export const isOnboarding = (obj: any): obj is Onboarding => {
  return (
    obj &&
    typeof obj.EMAIL_VALIDATION === 'object' &&
    isBankAccountDefinition(obj.EMAIL_VALIDATION) &&
    typeof obj.IDENTITY_DECLARATION === 'object' &&
    isBankAccountDefinition(obj.IDENTITY_DECLARATION) &&
    typeof obj.BASIC_PERSONAL_DATA_DEFINITION === 'object' &&
    isBankAccountDefinition(obj.BASIC_PERSONAL_DATA_DEFINITION) &&
    typeof obj.TYC_ACCEPTANCE === 'object' &&
    isBankAccountDefinition(obj.TYC_ACCEPTANCE) &&
    typeof obj.POLITICAL_CONSTRAINTS_VALIDATION === 'object' &&
    isBankAccountDefinition(obj.POLITICAL_CONSTRAINTS_VALIDATION) &&
    typeof obj.SECURITY_VALIDATION === 'object' &&
    isBankAccountDefinition(obj.SECURITY_VALIDATION) &&
    typeof obj.BANK_ACCOUNT_DEFINITION === 'object' &&
    isBankAccountDefinition(obj.BANK_ACCOUNT_DEFINITION) &&
    typeof obj.FEP_DOCUMENTATION_VALIDATION === 'object' &&
    isBankAccountDefinition(obj.FEP_DOCUMENTATION_VALIDATION) &&
    typeof obj.PEP_DOCUMENTATION_VALIDATION === 'object' &&
    isBankAccountDefinition(obj.PEP_DOCUMENTATION_VALIDATION) &&
    typeof obj.IDENTITY_VALIDATION === 'object' &&
    isBankAccountDefinition(obj.IDENTITY_VALIDATION) &&
    typeof obj.SELFIE_VALIDATION === 'object' &&
    isBankAccountDefinition(obj.SELFIE_VALIDATION)
  );
};

export const isBankAccountDefinition = (obj: any): obj is BankAccountDefinition => {
  return obj && typeof obj.required === 'boolean' && typeof obj.status === 'string' && (obj.status === Status.Completed || obj.status === Status.Pending);
};
