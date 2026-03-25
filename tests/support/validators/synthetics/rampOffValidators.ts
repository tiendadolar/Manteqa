import { expect } from 'chai';
import { CustomWorld } from '../../world';
import { isRampOffResponse, RampOffResponse, Stage } from '../../interfaces/synthetics/ramp-off-interface';
import { validateAddress } from '../../utils/chainsFormat.utils';

export class RampOffResponseValidator {
  static validateRampOffResponse(response: any, overdraw: boolean, exchange: string): RampOffResponse {
    expect(response).to.exist;
    expect(response).to.be.an('object');

    if (!isRampOffResponse(response)) {
      throw new Error('Response does not match RampOffResponse interface');
    }

    this.validateRampOffFields(response);
    this.validateDetailsFields(response);
    this.validateStagesFields(response, response.stages, response.currentStage, overdraw, exchange);
    this.validateDateFields(response);

    return response as RampOffResponse;
  }

  private static validateRampOffFields(rampOff: RampOffResponse): void {
    expect(rampOff.id)
      .to.be.a('string')
      .and.match(/^[0-9a-fA-F]{24}$/);
    expect(rampOff.numberId).to.be.a('string').and.not.empty;
    expect(rampOff.userId)
      .to.be.a('string')
      .and.match(/^[0-9a-fA-F]{24}$/);
    expect(rampOff.userNumberId).to.be.a('string').and.not.empty;
    expect(rampOff.status).to.equal('STARTING');
    expect(rampOff.type).to.equal('RAMP_OPERATION');
    expect(rampOff.currentStage).to.be.a('number').and.greaterThan(0);
  }

  private static validateDetailsFields(rampOff: RampOffResponse): void {
    const withdrawCostInAgainst = parseFloat(rampOff.details.withdrawCostInAgainst);
    const withdrawCostInAsset = parseFloat(rampOff.details.withdrawCostInAsset);
    const effectiveWithdrawAmount = parseFloat(rampOff.details.effectiveWithdrawAmount);
    const price = parseFloat(rampOff.details.price);
    const priceExpireAt = new Date(rampOff.details.priceExpireAt);

    expect(rampOff.details.depositAddresses).to.exist;

    Object.entries(rampOff.details.depositAddresses).forEach(([network, data]) => {
      expect(data.address).to.be.a('string').and.not.empty;
      expect(data.network).to.equal(network);
      validateAddress(data.address, network);
    });
    expect(rampOff.details.depositAddress).to.be.a('string').and.not.empty;
    expect(rampOff.details.depositAvailableNetworks).to.be.an('array').and.not.empty;
    rampOff.details.depositAvailableNetworks.forEach((network: string) => {
      expect(rampOff.details.depositAddresses[network]).to.exist;
    });

    expect(withdrawCostInAgainst).to.be.a('number').and.gte(0);
    expect(withdrawCostInAsset).to.be.a('number').and.gte(0);
    expect(effectiveWithdrawAmount).to.be.a('number').and.greaterThan(0);
    expect(price).to.be.a('number').and.greaterThan(0);
    expect(priceExpireAt).to.be.a('date');
    expect(priceExpireAt.getTime()).to.be.greaterThan(Date.now());
  }

  private static validateStagesFields(rampOff: RampOffResponse, stages: any, currentStage: number, overdraw: boolean, exchange: string): void {
    const stageKeys = Object.keys(stages).map(Number);
    expect(stageKeys).to.include(currentStage);

    Object.entries(stages).forEach(([stageNumber, stage]) => {
      const stageData = stage as Stage;

      if (!overdraw && exchange === 'ARG') {
        expect(stageData.stageType).to.be.oneOf(['DEPOSIT', 'ORDER', 'WITHDRAW']);
        expect(stageData.legalEntity).to.be.oneOf(['CRYPTO_ARG']);
      }

      if (!overdraw && exchange !== 'ARG') {
        expect(stageData.stageType).to.be.oneOf(['DEPOSIT', 'ORDER', 'WITHDRAW']);
        expect(stageData.legalEntity).to.be.oneOf(['CRYPTO_GLOBAL']);
      }

      if (overdraw && exchange === 'ARG') {
        expect(stageData.stageType).to.be.oneOf(['ORDER', 'WITHDRAW']);
        expect(stageData.legalEntity).to.be.oneOf(['CRYPTO_ARG']);
      }

      if (overdraw && exchange !== 'ARG') {
        expect(stageData.stageType).to.be.oneOf(['ORDER', 'WITHDRAW']);
        expect(stageData.legalEntity).to.be.oneOf(['CRYPTO_GLOBAL']);
      }

      this.validateStageFields(stageData, parseInt(stageNumber), rampOff);
    });
  }

  private static validateStageFields(stage: Stage, stageNumber: number, rampOff: RampOffResponse): void {
    switch (stage.stageType) {
      case 'DEPOSIT':
        const depositExpireAt = new Date(stage.expireAt ?? '0');
        const thresholdAmount = stage.thresholdAmount ?? '0';
        expect(stage.asset).to.be.a('string').to.be.equal(CustomWorld.getStoreData('asset'));
        expect(parseFloat(thresholdAmount)).to.be.equal(parseFloat(CustomWorld.getStoreData('assetAmount')));
        expect(stage.useOverflow).to.be.a('boolean');
        expect(depositExpireAt).to.be.a('date');
        expect(depositExpireAt.getTime()).to.be.greaterThan(Date.now());
        break;

      case 'ORDER':
        const assetAmount = stage.assetAmount ?? '0';
        expect(stage.side).to.be.oneOf(['SELL']);
        expect(stage.type).to.be.oneOf(['MARKET', 'LIMIT']);
        expect(stage.asset).to.be.equal(CustomWorld.getStoreData('asset'));
        expect(stage.against).to.be.equal(CustomWorld.getStoreData('against'));
        expect(parseFloat(assetAmount)).to.be.equal(parseFloat(CustomWorld.getStoreData('assetAmount')));
        expect(stage.price).to.be.a('string');
        expect(stage.priceCode)
          .to.be.a('string')
          .and.matches(/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i, 'No es un UUID v4 válido');
        break;

      case 'WITHDRAW':
        const amount = stage.amount ?? '0';
        expect(stage.asset).to.be.equal(CustomWorld.getStoreData('against'));
        expect(parseFloat(amount).toFixed(2)).to.be.equal((parseFloat(CustomWorld.getStoreData('assetAmount')) * parseFloat(rampOff.details.price)).toFixed(2));
        expect(stage.to).to.be.equal(CustomWorld.getStoreData('withdrawAddress'));
        expect(stage.destination).to.exist;
        // expect(stage.destination?.network).to.equal(stage.network);
        expect(stage.destination?.address).to.equal(stage.to);
        break;
    }
  }

  private static validateDateFields(rampOff: RampOffResponse): void {
    const creationTime = new Date(rampOff.creationTime);
    const updatedAt = new Date(rampOff.updatedAt);

    expect(creationTime).to.be.a('date');
    expect(updatedAt).to.be.a('date');
    expect(creationTime.getTime()).to.be.lessThanOrEqual(updatedAt.getTime());
  }
}

export const validateResponse = (response: any, overdraw: boolean, exchange: string): RampOffResponse => {
  return RampOffResponseValidator.validateRampOffResponse(response, overdraw, exchange);
};
