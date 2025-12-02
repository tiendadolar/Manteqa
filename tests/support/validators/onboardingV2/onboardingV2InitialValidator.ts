import { expect } from 'chai';
import logger from '../../utils/logger';
import { CustomWorld } from '../../world';
import { isAddress, isFlags, isOnboardingV2Initial, isPerson, isPersonalData, isRenaperData, isUser, OnboardingV2InitialResponse } from '../../interfaces/onboardingV2Initial.interface';

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

export class onboardingV2InitialValidator {
  static validateOnboardingV2InitialResponse(response: any): OnboardingV2InitialResponse {
    expect(response).to.exist;
    expect(response).to.be.an('object');

    if (!isOnboardingV2Initial(response)) {
      throw new Error('Response does not match OnboardingV2Initial interface');
    }

    this.validateUserFields(response);
    this.validatePersonFields(response);
    expect(response.causedConflict).to.be.a('boolean');

    return response as OnboardingV2InitialResponse;
  }

  private static validateUserFields(response: OnboardingV2InitialResponse): void {
    if (!isUser(response.user)) {
      throw new Error('Response does not match User-OnboardingV2Initial interface');
    }

    expect(response.user.id)
      .to.be.a('string')
      .and.to.match(/^[0-9a-fA-F]{24}$/);
    expect(response.user.companyId)
      .to.be.a('string')
      .and.to.match(/^[0-9a-fA-F]{24}$/);
    if ('externalId' in response.user) expect(response.user.externalId).to.be.a('string').and.not.empty;
    expect(response.user.numberId).to.be.a('string').and.not.empty;
    expect(response.user.legalId).to.be.a('string').and.not.empty;
    expect(response.user.exchange).to.be.a('string').to.be.equal(CustomWorld.getStoreData('exchange'));
    expect(response.user.email).to.be.a('string').to.be.equal(CustomWorld.getStoreData('email'));
    expect(response.user.type).to.be.a('string').and.not.empty;
    expect(response.user.status).to.be.a('string').to.be.equal('ONBOARDING');
    //banking
    expect(response.user).to.have.property('banking');
    expect(response.user.banking).to.be.an('object');
    expect(response.user.banking).to.have.property('accounts');
    expect(response.user.banking.accounts).to.be.an('array');
    //addresses
    expect(response.user).to.have.property('addresses');
    expect(response.user.addresses).to.be.an('object');
    expect(response.user.addresses).to.have.property('depositAddresses');
    expect(response.user.addresses.depositAddresses).to.be.an('object');
    expect(response.user.addresses).to.have.property('knownAddresses');
    expect(response.user.addresses.knownAddresses).to.be.an('array');
    //onboardingTasks
    expect(response.user).to.have.property('onboarding');
    expect(response.user.onboarding).to.be.an('object');

    steps.forEach((step) => {
      expect(response.user.onboarding).to.have.property(step);
      expect(response.user.onboarding[step]).to.be.an('object');

      if (step === 'IDENTITY_DECLARATION') {
        expect(response.user.onboarding[step]).to.have.property('required');
        expect(response.user.onboarding[step].required).to.be.a('boolean');
        expect(response.user.onboarding[step].required).to.be.equal(true);
        expect(response.user.onboarding[step]).to.have.property('status');
        expect(response.user.onboarding[step].status).to.be.a('string');
        expect(response.user.onboarding[step].status).to.be.equal('COMPLETED');
        return;
      }

      expect(response.user.onboarding[step]).to.have.property('required');
      expect(response.user.onboarding[step].required).to.be.a('boolean');
      expect(response.user.onboarding[step]).to.have.property('status');
      expect(response.user.onboarding[step].status).to.be.a('string');
    });
    expect(response.user.creationTime).to.be.a('string').and.not.empty;
    expect(response.user.updatedAt).to.be.a('string').and.not.empty;
  }

  private static validatePersonFields(response: OnboardingV2InitialResponse): void {
    if (!isPerson(response.person)) {
      throw new Error('Response does not match Person-OnboardingV2Initial interface');
    }
    expect(response.person.id)
      .to.be.a('string')
      .and.to.match(/^[0-9a-fA-F]{24}$/);
    expect(response.person.legalId).to.be.a('string').and.not.empty;
    expect(response.person.email).to.be.a('string').to.be.equal(CustomWorld.getStoreData('email'));
    expect(response.person.exchangeCountry).to.be.a('string').and.not.empty;
    this.validatePersonalDataFields(response);
    this.validateRenaperDataFields(response);
    this.validateFlagsFields(response);
    expect(response.person.blockedNumberIds).to.be.an('object');
    expect(response.person.companyIds).to.be.an('array').that.is.not.empty;
    response.person.companyIds.forEach((id) => {
      expect(id)
        .to.be.a('string')
        .and.match(/^[a-fA-F0-9]{24}$/);
    });
    expect(response.person.numberIds).to.be.an('array').that.is.not.empty;
    response.person.numberIds.forEach((id) => {
      expect(id).to.be.a('string').to.be.equal(response.user.numberId);
    });
    expect(response.person.creationTime).to.be.a('string').and.not.empty;
    expect(response.person.updatedAt).to.be.a('string').and.not.empty;
  }

  private static validatePersonalDataFields(response: OnboardingV2InitialResponse): void {
    if (!isPersonalData(response.person.personalData)) {
      throw new Error('Response does not match personalData-OnboardingV2Initial interface');
    }

    expect(response.person.personalData.economicLevel).to.be.a('string').and.not.empty;
    expect(response.person.personalData.phoneNumber).to.be.a('string').and.not.empty;
    expect(response.person.personalData.cleanName).to.be.a('string').and.not.empty;
    expect(response.person.personalData.maritalStatus).to.be.a('string').and.not.empty;
    expect(response.person.personalData.name).to.be.a('string').and.not.empty;
    expect(response.person.personalData.surname).to.be.a('string').and.not.empty;
    expect(response.person.personalData.work).to.be.a('string').and.not.empty;
    expect(response.person.personalData.birthDate).to.be.a('string').and.not.empty;
    this.validateAddressFields(response);
    expect(response.person.personalData.sex).to.be.a('string').and.not.empty;
    expect(response.person.personalData.nationality).to.be.a('string').and.not.empty;
  }

  private static validateAddressFields(response: OnboardingV2InitialResponse): void {
    if (!isAddress(response.person.personalData.address)) {
      throw new Error('Response does not match personalDataAddress-OnboardingV2Initial interface');
    }

    expect(response.person.personalData.address.postalCode).to.be.a('string');
    expect(response.person.personalData.address.province).to.be.a('string').and.not.empty;
    expect(response.person.personalData.address.locality).to.be.a('string').and.not.empty;
    expect(response.person.personalData.address.street).to.be.a('string').and.not.empty;
    expect(response.person.personalData.address.numeration).to.be.a('string').and.not.empty;
    expect(response.person.personalData.address.floor).to.be.a('string');
    expect(response.person.personalData.address.apartment).to.be.a('string');
  }

  private static validateRenaperDataFields(response: OnboardingV2InitialResponse): void {
    if (!isRenaperData(response.person.renaperData)) {
      throw new Error('Response does not match PersonRenaperData-OnboardingV2Initial interface');
    }
    expect(response.person.renaperData.isDead).to.be.a('boolean');
    expect(response.person.renaperData.dniModel).to.be.a('string').and.not.empty;
    expect(response.person.renaperData.dniNumber).to.be.a('string').and.not.empty;
    expect(response.person.renaperData.name).to.be.a('string').and.not.empty;
    expect(response.person.renaperData.surname).to.be.a('string').and.not.empty;
  }

  private static validateFlagsFields(response: OnboardingV2InitialResponse): void {
    if (!isFlags(response.person.flags)) {
      throw new Error('Response does not match PersonFlags-OnboardingV2Initial interface');
    }

    expect(response.person.flags.isPEP).to.be.a('boolean');
    expect(response.person.flags.isFEP).to.be.a('boolean');
    expect(response.person.flags.isDead).to.be.a('boolean');
    expect(response.person.flags.isTerrorist).to.be.a('boolean');
    expect(response.person.flags.isFACTA).to.be.a('boolean');
    expect(response.person.flags.isJuridical).to.be.a('boolean');
  }
}

export const validateResponse = (response: any): OnboardingV2InitialResponse => {
  return onboardingV2InitialValidator.validateOnboardingV2InitialResponse(response);
};
