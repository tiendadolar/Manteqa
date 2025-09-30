import { EndpointHandler } from '../factory/endpointHandler.interface';
import logger from '../utils/logger';
import {
  bankingOnboardingApiCrypto,
  criptoDepositApiCrypto,
  fiatDepositApiCrypto,
  fiatWithdrawApiCrypto,
  fiatWithdrawApiCryptoV2,
  inicialOnboardingApiCrypto,
  inicialOnboardingApiCryptoV2,
  rampOffExchange,
  rampOnExchange,
  remittances,
  senderPaymentSynthetic,
  withdrawLockApiCryptoV2
} from '../utils/utils';

export class OnboardingInitialV1Handler implements EndpointHandler {
  canHandle(endpoint: string): boolean {
    return endpoint === '/onboarding-actions/initial';
  }

  handle(userData: any) {
    return inicialOnboardingApiCrypto(userData);
  }
}

export class OnboardingInitialV2Handler implements EndpointHandler {
  canHandle(endpoint: string): boolean {
    return endpoint === '/v2/onboarding-actions/initial';
  }

  handle(userData: any) {
    return inicialOnboardingApiCryptoV2(userData);
  }
}

export class AddBankAccountV2Handler implements EndpointHandler {
  canHandle(endpoint: string): boolean {
    return endpoint === '/v2/onboarding-actions/add-bank-account';
  }

  handle(userData: any) {
    return bankingOnboardingApiCrypto(userData);
  }
}

export class DepositCryptoHandler implements EndpointHandler {
  canHandle(endpoint: string): boolean {
    return endpoint === '/v1/transaction/deposit';
  }

  handle(userData: any, world?: any) {
    return criptoDepositApiCrypto(userData);
  }
}

export class DepositFiatHandler implements EndpointHandler {
  canHandle(endpoint: string): boolean {
    return endpoint === '/v1/fiat/deposit';
  }

  handle(userData: any, world?: any) {
    return fiatDepositApiCrypto(userData);
  }
}

export class WithdrawFiatV1Handler implements EndpointHandler {
  canHandle(endpoint: string): boolean {
    return endpoint === '/v1/transaction/withdraw';
  }

  handle(userData: any, world?: any) {
    return fiatWithdrawApiCrypto(userData);
  }
}

export class CbuCRCHandler implements EndpointHandler {
  canHandle(endpoint: string, userData: any): boolean {
    return endpoint === '/v1/fiat/withdraw' && userData.coin === 'CRC';
  }

  handle(userData: any, world?: any) {
    userData.cbu = '';
    return userData;
  }
}

export class WithdrawFiatV2Handler implements EndpointHandler {
  canHandle(endpoint: string): boolean {
    return endpoint === '/v2/withdraws';
  }

  handle(userData: any, world?: any) {
    if (userData.senderExchange && userData.recipientExchange) return remittances(userData);
    return fiatWithdrawApiCryptoV2(userData);
  }
}

export class WithdrawLockV2Handler implements EndpointHandler {
  canHandle(endpoint: string): boolean {
    return endpoint === '/v2/withdraw-locks';
  }

  handle(userData: any, world?: any) {
    return withdrawLockApiCryptoV2(userData);
  }
}

export class SyntheticOnHandler implements EndpointHandler {
  canHandle(endpoint: string): boolean {
    return ['/v1/synthetics/ramp-on'].includes(endpoint);
  }

  handle(userData: any, world?: any) {
    if (userData.against != 'ARS') userData = rampOnExchange(userData);

    userData.userAnyId = userData.userAnyId ?? world.getStoreData('userId');
    return userData;
  }
}

export class SyntheticPaymentHandler implements EndpointHandler {
  canHandle(endpoint: string): boolean {
    return ['/v2/payment-locks', '/v2/synthetics/qr-payment'].includes(endpoint);
  }

  handle(userData: any, world?: any) {
    if (userData.exchange) userData = senderPaymentSynthetic(userData);

    userData.userAnyId = userData.userAnyId ?? world.getStoreData('userId');
    return userData;
  }
}

export class SyntheticOffHandler implements EndpointHandler {
  canHandle(endpoint: string, userData: any): boolean {
    return endpoint === '/v1/synthetics/ramp-off' && userData.against !== 'ARS';
  }

  handle(userData: any, world?: any) {
    return rampOffExchange(userData);
  }
}
