const { expect } = require('chai');
const request = require('supertest');
const { Given, When, Then, Before } = require('@cucumber/cucumber');
import { getUserInfoDougHelper } from '../../../../../../support/helpers/userHelper';
import { getLockWithdrawCostV2Helper } from '../../../../../../support/helpers/withdrawals/V2/withdrawCriptoV2.helper';
import { WithdrawCriptoV2Response } from '../../../../../../support/interfaces/Withdrawals/V2/withdrawCripto.interface';
import { validateResponse } from '../../../../../../support/validators/withdrawals/V2/withdrawCriptoValidators';
import { CustomWorld } from '../../../../../../support/world';

Then('Validate withdraw cripto V2 response attributes', { timeout: 50 * 1000 }, async function (this: CustomWorld) {
  const token: string = CustomWorld.getStoreData('JWT');
  const userAnyId: string = CustomWorld.getStoreData('userAnyId');
  const res: any = this.response;
  const cuit: any = await getUserInfoDougHelper(token, userAnyId);
  CustomWorld.setStoreData('userLegalId', cuit.body.cuit);
  const cost: any = await getLockWithdrawCostV2Helper(this.apiKey, this.userData);
  CustomWorld.setStoreData('cost', (Object.values(cost.body)[0] as any).cost);

  const validateWithdrawCriptoV2: WithdrawCriptoV2Response = validateResponse(res.body);
});
