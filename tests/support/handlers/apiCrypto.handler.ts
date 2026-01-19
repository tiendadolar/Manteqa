import { EndpointHandler } from '../factory/endpointHandler.interface';
import logger from '../utils/logger';
import {
  bankingOnboardingApiCrypto,
  billingPaymentSynthetic,
  criptoDepositApiCrypto,
  fiatDepositApiCrypto,
  fiatWithdrawApiCrypto,
  fiatWithdrawApiCryptoV2,
  inicialOnboardingApiCrypto,
  inicialOnboardingApiCryptoV2,
  manualRefund,
  rampOffExchange,
  rampOnExchange,
  remittances,
  senderPaymentSynthetic,
  withdrawLockApiCryptoV2
} from '../utils/utils';
import { CustomWorld } from '../world';

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
    if (userData.exchange) userData = senderPaymentSynthetic(userData, userData.gender, userData.street);

    userData.userAnyId = userData.userAnyId ?? world.getStoreData('userId');
    if (userData.qrCode === 'qr3BOBmanualamount')
      userData.qrCode =
        'p6Ll/7nOT/HlyF2DDH8s5yJ9KhRrnajNgjcsb3JTyHRP2EC8miqJ6McKc4P3DdHH51OmqQqtuBHLrN4nHYDvNLeMd2STHOLBeDvM+Au7irTMLIkLq5ujxtLzZY4vV0ElefFl1daxcp5MsOk+5mLHcI7JhA15UoW6ngZN/t1I7Uew1n1OVGKksBu0AAb3OkZbICsOZcfAK+mYUQD/G2ZDxgv9+0gqThme9N9TZYQe/mEwWUYu+7nTi8pBkZNPKE8e6zcIMyJQh9ZeMzMkYL/MbZ6BUReZymywd94uCOFPzyiqC/j/mxvhD/kKxOje1pHf21JD5SBj/T/7G0NJuE9x/w==|5B8FF436_is_open';
    if (userData.paymentDestination === 'qr3BOBmanualamount')
      userData.paymentDestination =
        'p6Ll/7nOT/HlyF2DDH8s5yJ9KhRrnajNgjcsb3JTyHRP2EC8miqJ6McKc4P3DdHH51OmqQqtuBHLrN4nHYDvNLeMd2STHOLBeDvM+Au7irTMLIkLq5ujxtLzZY4vV0ElefFl1daxcp5MsOk+5mLHcI7JhA15UoW6ngZN/t1I7Uew1n1OVGKksBu0AAb3OkZbICsOZcfAK+mYUQD/G2ZDxgv9+0gqThme9N9TZYQe/mEwWUYu+7nTi8pBkZNPKE8e6zcIMyJQh9ZeMzMkYL/MbZ6BUReZymywd94uCOFPzyiqC/j/mxvhD/kKxOje1pHf21JD5SBj/T/7G0NJuE9x/w==|5B8FF436_is_open';

    return userData;
  }
}

export class BillingPaymentHandler implements EndpointHandler {
  canHandle(endpoint: string, userData: any): boolean {
    return ['/v2/bill-locks'].includes(endpoint);
  }

  handle(userData: any, world?: any) {
    return billingPaymentSynthetic(userData);
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

export class manualRefundHandler implements EndpointHandler {
  canHandle(endpoint: string, userData: any): boolean {
    return endpoint === '/v1/admin/synthetics/{syntheticId}/refund';
  }

  modifyEndpoint(endpoint: string, world: any): string {
    return endpoint.replace('{syntheticId}', CustomWorld.getStoreData('syntheticId'));
  }

  handle(userData: any, world?: any) {
    return manualRefund(userData, world);
  }
}
