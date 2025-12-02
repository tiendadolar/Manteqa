const { Given, When, Then, Before } = require('@cucumber/cucumber');
const { expect } = require('chai');
const request = require('supertest');
import { onboardingHelper } from '../../../../support/helpers/onboardingHelper';
import { OnboardingV2InitialResponse } from '../../../../support/interfaces/onboardingV2Initial.interface';
import logger from '../../../../support/utils/logger';
import { validateResponse } from '../../../../support/validators/onboardingV2/onboardingV2InitialValidator';
import { CustomWorld } from '../../../../support/world';

Then('Validate initial onboarding response attributes', { timeout: 50 * 1000 }, async function (this: CustomWorld) {
  const res = this.response;

  const validateInitialOnbV2: OnboardingV2InitialResponse = validateResponse(res.body);
  logger.debug(res.body.user.legalId);
  await onboardingHelper(this.urlBase, this.apiKey, res.body.user.legalId);
});
