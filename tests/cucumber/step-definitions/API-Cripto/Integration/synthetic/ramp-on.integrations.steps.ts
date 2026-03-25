import { RampOnResponse } from '../../../../../support/interfaces/synthetics/ramp-on.interface';
import { validateResponse } from '../../../../../support/validators/synthetics/rampOnValidators';
import { CustomWorld } from '../../../../../support/world';

const { Given, When, Then, Before } = require('@cucumber/cucumber');
const { expect } = require('chai');
const request = require('supertest');

Then('Validate ramp on {string} for {string} user response attributes', { timeout: 50 * 1000 }, async function (this: CustomWorld, overdraw: string, exchange: string) {
  const res = this.response;
  const isOverdraw: boolean = overdraw === 'overdraw' ? true : false;

  expect(this.response).to.exist;
  expect(this.response.body).to.exist;

  const validateOrder: RampOnResponse = validateResponse(res.body, isOverdraw, exchange);
});
