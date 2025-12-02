const { Given, When, Then, Before } = require('@cucumber/cucumber');
const { expect } = require('chai');
const request = require('supertest');
import { validateRes } from '../../../../support/helpers/requestHelper';
import { ErrorResponse } from '../../../../support/interfaces/error.interface';
import logger from '../../../../support/utils/logger';
import { delay } from '../../../../support/utils/utils';
import { validateErrorResponse } from '../../../../support/validators/error.validators';
import { CustomWorld, UserData } from '../../../../support/world';

Then('Validate response attributes with internalStatus: {string} and message: {string}', { timeout: 50 * 1000 }, async function (this: CustomWorld, internalStatus: string, message: string) {
  const res = this.response;

  expect(this.response).to.exist;
  expect(this.response.body).to.exist;
  await delay(5000);

  const validateResponse: ErrorResponse = validateErrorResponse(res.body, internalStatus, message);
});

Then(
  'Validate response attributes with internalStatus: {string} and message: {string} and error: {string}',
  { timeout: 50 * 1000 },
  async function (this: CustomWorld, internalStatus: string, message: string, errors: string) {
    const res = this.response;

    expect(this.response).to.exist;
    expect(this.response.body).to.exist;
    await delay(5000);

    const validateResponse: ErrorResponse = validateErrorResponse(res.body, internalStatus, message, errors);
  }
);
