import { EndpointHandler } from '../factory/endpointHandler.interface';
import { bankingOnboardingApiCambio, fiatDepositApiCambio, inicialOnboardingApiCambio, validateOnboardingApiCambio } from '../utils/utils';
import { CustomWorld } from '../world';

export class OnboardingInitialHandler implements EndpointHandler {
  canHandle(endpoint: string, userData?: any): boolean {
    return endpoint === '/v3/api/onboarding-actions/initial';
  }

  handle(userData: any, world?: any) {
    return inicialOnboardingApiCambio(userData);
  }
}

export class OnboardingValidateDocHandler implements EndpointHandler {
  canHandle(endpoint: string, userData?: any): boolean {
    const docEndpoints = [
      '/v3/api/onboarding-actions/upload-identity-image',
      '/v3/api/onboarding-actions/upload-selfie-image',
      '/v3/api/onboarding-actions/upload-pep-documentation',
      '/onboarding-actions/upload-identity-image',
      '/onboarding-actions/upload-selfie-image',
      '/v2/onboarding-actions/upload-identity-image',
      '/v2/onboarding-actions/upload-selfie-image'
    ];
    return docEndpoints.includes(endpoint);
  }

  handle(userData: any, world?: any) {
    return validateOnboardingApiCambio(userData);
  }
}

export class AddBankAccountCambioHandler implements EndpointHandler {
  canHandle(endpoint: string, userData?: any): boolean {
    return endpoint === '/v3/onboarding-actions/add-bank-account';
  }

  handle(userData: any, world?: any) {
    return bankingOnboardingApiCambio(userData);
  }
}

export class FiatDepositAdminCambioHandler implements EndpointHandler {
  canHandle(endpoint: string, userData?: any): boolean {
    return endpoint === '/v3/admin/banking/deposit';
  }

  handle(userData: any, world?: any) {
    return fiatDepositApiCambio(userData);
  }
}

export class AuthTF2Handler implements EndpointHandler {
  canHandle(endpoint: string, userData?: any): boolean {
    return endpoint === '/v3/{twoFaCode}';
  }

  modifyEndpoint(endpoint: string, world: any): string {
    return endpoint.replace('{twoFaCode}', world.getStoreData('redirectUrl') || '');
  }

  handle(userData: any, world?: any) {
    return fiatDepositApiCambio(userData);
  }
}

export class ParamReplaceHandler implements EndpointHandler {
  canHandle(endpoint: string, userData?: any): boolean {
    return CustomWorld.getStoreData('userId') !== undefined && endpoint !== '/v3/api/onboarding-actions/upload-identity-image';
  }

  modifyEndpoint(endpoint: string, world: any): string {
    return endpoint.replace('{userId}', CustomWorld.getStoreData('userId') || '');
  }

  handle(userData: any, world?: any) {
    return userData;
  }
}
