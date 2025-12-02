const { Given, When, Then, Before } = require('@cucumber/cucumber');
const { expect } = require('chai');
const request = require('supertest');
import { OrderResponse } from '../../../../support/interfaces/orders.interface';
import { validateResponse } from '../../../../support/validators/ordersValidator';
import { CustomWorld, UserData } from '../../../../support/world';

Then('Validate order response attributes', { timeout: 50 * 1000 }, async function (this: CustomWorld) {
  const res = this.response;

  expect(this.response).to.exist;
  expect(this.response.body).to.exist;

  const validateOrder: OrderResponse = validateResponse(res.body);
});
