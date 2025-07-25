const { Given, When, Then, Before } = require('@cucumber/cucumber');
const { expect } = require('chai');
const request = require('supertest');
import { CustomWorld } from '../../../../support/world';

Before({ tags: '@Pix' }, function () {
  console.log('Ejecutando steps para Orders');
});

Then('The orders of the company are obtained', function (this: CustomWorld) {
  const response = this.response.body;

  expect(response).to.have.property('totalCount');
  expect(response).to.have.property('pageCount');
  expect(response).to.have.property('pageSize');
  expect(response).to.have.property('page');
  expect(response).to.have.property('lastPage');
  expect(response).to.have.property('data').that.is.an('array');

  response.data.forEach((order: any) => {
    expect(order).to.have.property('coin').that.is.a('string');
    expect(order).to.have.property('operation').that.is.a('string');
    expect(order).to.have.property('status').that.is.a('string');
    expect(order).to.have.property('amount').that.is.a('string');
    expect(order).to.have.property('creationTime').that.is.a('string');

    expect(order).to.have.property('user');
    expect(order.user).to.have.property('id').that.is.a('string');
    expect(order.user).to.have.property('cuit').that.is.a('string');
    expect(order.user).to.have.property('name').that.is.a('string');
  });
});

Then('The price lock is created', function (this: CustomWorld) {
  const response = this.response.body;

  expect(response).to.have.property('code').that.is.a('string');
  expect(response).to.have.property('price').that.is.a('string');
  expect(response).to.have.property('expires').that.is.a('string');
});

Then('The purchase order is created', function (this: CustomWorld) {
  const response = this.response.body;

  expect(response).to.have.property('coin').that.is.a('string');
  expect(response).to.have.property('operation').that.is.a('string');
  expect(response).to.have.property('coinValue').that.is.a('string');
  expect(response).to.have.property('amount').that.is.a('string');
  expect(response).to.have.property('status').that.is.a('string');
  expect(response).to.have.property('coinValueLC').that.is.a('string');
  expect(response).to.have.property('coinValueArs').that.is.a('string');
  expect(response).to.have.property('creationTime').that.is.a('string');
  expect(response).to.have.property('fee').that.is.a('number');
  expect(response).to.have.property('sessionId').that.is.a('string');
  expect(response).to.have.property('numberId').that.is.a('string');
});

Then('The withdraw is processed', function (this: CustomWorld) {
  let failedOrder = false;
  const response = this.response.body;

  expect(response).to.be.an('array').that.is.not.empty;

  response.forEach((order: any) => {
    if (order.status === 'PENDING') {
      failedOrder = true;
      console.warn(`Orden con numberId ${order.numberId} tiene status FAILED`);
    }

    expect(order).to.have.property('amount').that.is.a('string');
    expect(order).to.have.property('numberId').that.is.a('string');
    expect(order).to.have.property('coin').that.is.a('string');
    expect(order).to.have.property('destAccount').that.is.a('object');
    expect(order).to.have.property('creationTime').that.is.a('string');
    expect(order).to.have.property('user').that.is.a('object');
    expect(order).to.have.property('bank').that.is.a('string');
    expect(order).to.have.property('publicAccessHash').that.is.a('string');
    expect(order).to.have.property('autoHandledCount').that.is.a('number');
  });
});
