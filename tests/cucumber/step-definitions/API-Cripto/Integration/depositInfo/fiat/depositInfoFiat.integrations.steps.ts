const { expect } = require('chai');
const request = require('supertest');
const { Given, When, Then, Before } = require('@cucumber/cucumber');
import { getUserInfoDougHelper } from '../../../../../../support/helpers/userHelper';
import { DepositInfoFiatResponse } from '../../../../../../support/interfaces/DepositInfo/Fiat/depositInfoFiat.interface';
import { validateResponse } from '../../../../../../support/validators/depositInfo/fiat/depositInfoFiatValidators';
import { CustomWorld } from '../../../../../../support/world';

Then('Validate deposit info fiat response attributes', { timeout: 50 * 1000 }, async function (this: CustomWorld) {
  //   const userAnyId: string = CustomWorld.getStoreData('userAnyId');
  const res: any = this.response;
  const exchange = CustomWorld.getStoreData('coin');

  const validateDepositInfoFiat: DepositInfoFiatResponse = validateResponse(res.body, exchange);
});
