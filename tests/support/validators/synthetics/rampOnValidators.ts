import { expect } from 'chai';
import { isRampOnResponse, RampOnResponse, Stage } from '../../interfaces/synthetics/ramp-on.interface';
import { CustomWorld } from '../../world';
import { validateAddress } from '../../utils/chainsFormat.utils';

export class RampOnResponseValidator {
  static validateRampOnResponse(response: any, overdraw: boolean, exchange: string): RampOnResponse {
    expect(response).to.exist;
    expect(response).to.be.an('object');

    if (!isRampOnResponse(response)) {
      throw new Error('Response does not match RampOnResponse interface');
    }

    this.validateRampOnFields(response);
    this.validateDetailsFields(response);
    this.validateStagesFields(response, response.stages, response.currentStage, overdraw, exchange);
    this.validateDateFields(response);

    return response as RampOnResponse;
  }

  private static validateRampOnFields(rampOn: RampOnResponse): void {
    expect(rampOn.id)
      .to.be.a('string')
      .and.match(/^[0-9a-fA-F]{24}$/);
    expect(rampOn.numberId).to.be.a('string').and.not.empty;
    expect(rampOn.userId)
      .to.be.a('string')
      .and.match(/^[0-9a-fA-F]{24}$/);
    expect(rampOn.userNumberId).to.be.a('string').and.not.empty;
    expect(rampOn.status).to.equal('STARTING');
    expect(rampOn.type).to.equal('RAMP_OPERATION');
    expect(rampOn.currentStage).to.be.a('number').and.greaterThan(0);
  }

  private static validateDetailsFields(rampOn: RampOnResponse): void {
    const withdrawCostInAgainst = parseFloat(rampOn.details.withdrawCostInAgainst);
    const withdrawCostInAsset = parseFloat(rampOn.details.withdrawCostInAsset);
    const effectiveWithdrawAmount = parseFloat(rampOn.details.effectiveWithdrawAmount);
    const price = parseFloat(rampOn.details.price);
    const priceExpireAt = new Date(rampOn.details.priceExpireAt);
    const bankTransfer = rampOn.details.depositAddresses.BANK_TRANSFER;

    expect(rampOn.details.depositAddresses).to.exist;
    expect(rampOn.details.depositAddresses).to.be.an('object');
    expect(bankTransfer).to.exist;
    expect(bankTransfer.address).to.be.a('string').and.not.empty;
    // expect(bankTransfer.type).to.equal('DEPOSIT');

    expect(rampOn.details.depositAvailableNetworks).to.be.an('array').and.not.empty;
    expect(withdrawCostInAgainst).to.be.a('number').and.least(0);
    expect(withdrawCostInAsset).to.be.a('number').and.greaterThan(0);
    expect(effectiveWithdrawAmount).to.be.a('number').and.greaterThan(0);
    expect(price).to.be.a('number').and.greaterThan(0);

    expect(priceExpireAt).to.be.a('date');
    expect(priceExpireAt.getTime()).to.be.greaterThan(Date.now());
  }

  private static validateStagesFields(rampOn: RampOnResponse, stages: any, currentStage: number, overdraw: boolean, exchange: string): void {
    //Validate that current stage be included in synthetic stages.
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

      this.validateStageFields(stageData, parseInt(stageNumber), rampOn);
    });
  }

  private static validateStageFields(stage: Stage, stageNumber: number, rampOn: RampOnResponse): void {
    switch (stage.stageType) {
      case 'DEPOSIT':
        const depositExpireAt = new Date(stage.expireAt ?? '0');
        expect(stage.asset).to.be.a('string').to.be.equal(CustomWorld.getStoreData('against'));
        expect(stage.thresholdAmount).to.be.equal((parseFloat(rampOn.details.price) * parseFloat(CustomWorld.getStoreData('assetAmount'))).toFixed(2));
        expect(stage.useOverflow).to.be.a('boolean');
        expect(depositExpireAt).to.be.a('date');
        expect(depositExpireAt.getTime()).to.be.greaterThan(Date.now());
        break;

      case 'ORDER':
        const assetAmount = stage.assetAmount ?? '0';
        expect(stage.side).to.be.oneOf(['BUY']);
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
        expect(stage.network).to.be.equal(CustomWorld.getStoreData('withdrawNetwork'));
        expect(stage.asset).to.be.equal(CustomWorld.getStoreData('asset'));
        expect(parseFloat(amount)).to.be.equal(parseFloat(CustomWorld.getStoreData('assetAmount')));
        expect(stage.to).to.be.equal(CustomWorld.getStoreData('withdrawAddress'));
        expect(stage.destination).to.exist;
        expect(stage.destination?.network).to.equal(stage.network);
        expect(stage.destination?.address).to.equal(stage.to);

        validateAddress(stage.to ?? '0', stage.network ?? '0');
        break;
    }
  }

  private static validateDateFields(rampOn: RampOnResponse): void {
    const creationTime = new Date(rampOn.creationTime);
    const updatedAt = new Date(rampOn.updatedAt);

    expect(creationTime).to.be.a('date');
    expect(updatedAt).to.be.a('date');
    expect(creationTime.getTime()).to.be.lessThanOrEqual(updatedAt.getTime());
  }
}

export const validateResponse = (response: any, overdraw: boolean, exchange: string): RampOnResponse => {
  return RampOnResponseValidator.validateRampOnResponse(response, overdraw, exchange);
};
