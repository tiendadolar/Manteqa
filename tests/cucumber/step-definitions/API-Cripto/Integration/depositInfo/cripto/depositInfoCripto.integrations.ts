const { expect } = require('chai');
const request = require('supertest');
const { Given, When, Then, Before } = require('@cucumber/cucumber');
import { DepositInfoCriptoResponse } from '../../../../../../support/interfaces/DepositInfo/Cripto/depositInfoCripto.interface';
import { validateResponse } from '../../../../../../support/validators/depositInfo/cripto/depositInfoCriptoValidators';
import { CustomWorld } from '../../../../../../support/world';

Then('Validate deposit info cripto response attributes', { timeout: 50 * 1000 }, async function (this: CustomWorld) {
  //   const userAnyId: string = CustomWorld.getStoreData('userAnyId');
  const res: any = this.response;
  const coin = CustomWorld.getStoreData('coin');

  const validateDepositInfoFiat: DepositInfoCriptoResponse = validateResponse(res.body, coin);
});
