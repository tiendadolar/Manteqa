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
        'Lvj/GV5XemlrG0IHrXEpovCVRh2O+P1CnLNwaJ6ov4BhMfP6AzUHiH4NKipATwuOgy0xbZm7OJbjCG1tjkDOgpB/4920qIRffg6eHb6evseZ5xGZHYxOdrmEE9Ka0by31TC9GKYrLnI3WwfzPojB0WlTKV7nznWGtBg6qXL7Ndei6IQEx8lENKjdGqI6NZhG3M9g0td3cyhzlES4ONx0QhSSv9+JUK+7qtFD3Ny+PERasxCFlx3c4R48iWl7IgEWB1zglMXgI7jZOSmfjw5FjdA7INFiKUi249vZvPhR4pobc6FTO+MslgOjiO/mTmjdXky/yI2FeZcHOs3oRyg6HA==|6497E3319343ED0DA8514FFE';
    if (userData.paymentDestination === 'qr3BOBmanualamount')
      userData.paymentDestination =
        'Lvj/GV5XemlrG0IHrXEpovCVRh2O+P1CnLNwaJ6ov4BhMfP6AzUHiH4NKipATwuOgy0xbZm7OJbjCG1tjkDOgpB/4920qIRffg6eHb6evseZ5xGZHYxOdrmEE9Ka0by31TC9GKYrLnI3WwfzPojB0WlTKV7nznWGtBg6qXL7Ndei6IQEx8lENKjdGqI6NZhG3M9g0td3cyhzlES4ONx0QhSSv9+JUK+7qtFD3Ny+PERasxCFlx3c4R48iWl7IgEWB1zglMXgI7jZOSmfjw5FjdA7INFiKUi249vZvPhR4pobc6FTO+MslgOjiO/mTmjdXky/yI2FeZcHOs3oRyg6HA==|6497E3319343ED0DA8514FFE';

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
