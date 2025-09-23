import { AddBankAccountCambioHandler, AuthTF2Handler, FiatDepositAdminCambioHandler, OnboardingInitialHandler, OnboardingValidateDocHandler, ParamReplaceHandler } from '../handlers/apiCambio.handler';
import {
  AddBankAccountV2Handler,
  CbuCRCHandler,
  DepositCryptoHandler,
  DepositFiatHandler,
  OnboardingInitialV1Handler,
  OnboardingInitialV2Handler,
  SyntheticOffHandler,
  SyntheticPaymentHandler,
  WithdrawFiatV1Handler,
  WithdrawFiatV2Handler,
  WithdrawLockV2Handler
} from '../handlers/apiCrypto.handler';
import { EndpointHandler } from './endpointHandler.interface';

export class EndpointHandlerFactory {
  private handlerInstances: EndpointHandler[];

  constructor() {
    this.handlerInstances = [
      new OnboardingInitialV1Handler(),
      new OnboardingInitialV2Handler(),
      new AddBankAccountV2Handler(),
      new DepositCryptoHandler(),
      new DepositFiatHandler(),
      new WithdrawFiatV1Handler(),
      new CbuCRCHandler(),
      new WithdrawFiatV2Handler(),
      new WithdrawLockV2Handler(),
      new SyntheticPaymentHandler(),
      new SyntheticOffHandler(),
      new OnboardingInitialHandler(),
      new OnboardingValidateDocHandler(),
      new AddBankAccountCambioHandler(),
      new FiatDepositAdminCambioHandler(),
      new AuthTF2Handler(),
      new ParamReplaceHandler()
    ];
  }

  getHandlers(endpoint: string, userData: any): EndpointHandler[] {
    return this.handlerInstances.filter((handler) => handler.canHandle(endpoint, userData));
  }
}
