import { expect } from 'chai';
import logger from '../../utils/logger';
import { CustomWorld } from '../../world';
import { GetUserV2Response, isAddresses, isBanking, isGetUserV2Response, isOnboarding } from '../../interfaces/userV2.interface';

const chains = ['ETHEREUM', 'BINANCE', 'TERRA', 'TERRA2', 'POLYGON', 'OPTIMISM', 'WORLDCHAIN', 'BASE', 'ARBITRUM', 'TRON'];
const steps = [
  'EMAIL_VALIDATION',
  'IDENTITY_DECLARATION',
  'BASIC_PERSONAL_DATA_DEFINITION',
  'TYC_ACCEPTANCE',
  'POLITICAL_CONSTRAINTS_VALIDATION',
  'SECURITY_VALIDATION',
  'BANK_ACCOUNT_DEFINITION',
  'FEP_DOCUMENTATION_VALIDATION',
  'PEP_DOCUMENTATION_VALIDATION',
  'IDENTITY_VALIDATION',
  'SELFIE_VALIDATION'
];

export class GetUserValidator {
  static validateGetUserResponse(response: any, world?: any): GetUserV2Response {
    expect(response).to.exist;
    expect(response).to.be.an('object');

    if (!isGetUserV2Response(response)) {
      throw new Error('Response does not match GetUserV2Response interface');
    }
    this.validateGetUserFields(response, world);
    return response as GetUserV2Response;
  }

  private static validateGetUserFields(response: GetUserV2Response, world?: any): void {
    expect(response.id)
      .to.be.a('string')
      .and.to.match(/^[0-9a-fA-F]{24}$/);
    if (response.externalId !== undefined) expect(response.externalId).to.be.equal(CustomWorld.getStoreData('externalId'));
    expect(response.numberId).to.be.a('string').to.be.equal(world.response.body.user.numberId);
    expect(response.exchange).to.be.a('string').to.be.equal(CustomWorld.getStoreData('exchange'));
    expect(response.type).to.be.a('string').to.be.equal(world.response.body.user.type);
    expect(response.status).to.be.a('string').to.be.equal('ACTIVE');
    this.validateBankingFields(response);
    this.validateAddressesFields(response);
    this.validateOnboardingFields(response);
    expect(response.creationTime).to.be.a('string').and.not.empty;
    expect(response.updatedAt).to.be.a('string').and.not.empty;
  }

  private static validateBankingFields(response: GetUserV2Response): void {
    if (!isBanking(response.banking)) {
      throw new Error('Response does not match Banking-GetUserV2Response interface');
    }

    expect(response.banking.accounts).to.be.an('array');
  }

  private static validateAddressesFields(response: GetUserV2Response): void {
    if (!isAddresses(response.addresses)) {
      throw new Error('Response does not match Addresses-GetUserV2Response interface');
    }

    expect(response.addresses).to.be.an('object');

    chains.forEach((chain) => {
      expect(response.addresses.depositAddresses).to.have.property(chain);

      if (chain === 'TERRA' || chain === 'TERRA2') {
        expect(response.addresses.depositAddresses[chain])
          .to.be.a('string')
          .and.to.match(/^terra1[a-z0-9]{38}$/);
        return;
      }

      if (chain === 'TRON') {
        expect(response.addresses.depositAddresses[chain])
          .to.be.a('string')
          .and.to.match(/^T[A-Za-z0-9]{33}$/);
        return;
      }

      expect(response.addresses.depositAddresses[chain])
        .to.be.a('string')
        .and.to.match(/^0x[a-fA-F0-9]{40}$/);
    });

    expect(response.addresses.knownAddresses).to.be.an('array');
  }

  private static validateOnboardingFields(response: GetUserV2Response): void {
    if (!isOnboarding(response.onboarding)) {
      throw new Error('Response does not match Onboarding-GetUserV2Response interface');
    }

    expect(response.onboarding).to.be.an('object');

    steps.forEach((step) => {
      const field = response.onboarding[step];

      expect(response.onboarding).to.have.property(step);
      expect(field).to.be.an('object');

      if (field.required === true) {
        expect(field.status).to.be.equal('COMPLETED');
      }
    });
  }
}

export const validateResponse = (response: any, world?: any): GetUserV2Response => {
  return GetUserValidator.validateGetUserResponse(response, world);
};
