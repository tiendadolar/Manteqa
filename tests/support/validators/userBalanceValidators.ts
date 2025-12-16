import { expect } from 'chai';
import logger from '../utils/logger';
import { CustomWorld } from '../world';

// Use true on setStoreData to create a persistent storage data (not cleaned by call clearStoreData())
export const thereIsBalanceCurrencyValidator = (balance: any, currency: string, inicial?: string, final?: string): any => {
  const finalBalance = CustomWorld.getStoreData(`${final}`);

  // if we don't have final balance stored, set inicial balance
  if (finalBalance === undefined) {
    if (!(currency in balance)) {
      CustomWorld.setStoreData(`${inicial}`, '0', true);
      logger.info(`Inicial balance for ${currency}: ${CustomWorld.getStoreData(`${inicial}`)}`);
      return;
    } else {
      CustomWorld.setStoreData(`${inicial}`, String(balance[currency]), true);
      logger.info(`Inicial balance for ${currency}: ${CustomWorld.getStoreData(`${inicial}`)}`);
      return;
    }
  } else {
    return;
  }
};

export const thereIsFinalBalanceCurrencyValidator = (balance: any, currency: string, inicial?: string, final?: string): any => {
  const inicialBalance = CustomWorld.getStoreData(`${inicial}`);

  // if we have inicial balance stored, set final balance
  if (inicialBalance !== undefined) {
    // We set final balance
    CustomWorld.setStoreData(`${final}`, String(balance[currency]), true);

    logger.info(`Final balance for ${currency}: ${CustomWorld.getStoreData(`${final}`)}`);
    return;
  } else {
    return;
  }
};

export const compareBalanceTypeValidator = (charge?: string, inicial?: string, final?: string): any => {
  // Obtain data from World and assign to variable
  if (charge === 'balance') {
    const inicialBalance = CustomWorld.getStoreData(`${inicial}`);
    const finalBalance = CustomWorld.getStoreData(`${final}`);
    return { inicialBalance, finalBalance };
  }
  const inicialBalance = CustomWorld.getStoreData(`${inicial}`);
  const finalBalance = CustomWorld.getStoreData(`${final}`);
  return { inicialBalance, finalBalance };
};

export const compareBalanceFlowValidator = (inicialAmount: string, finalAmount: string): void => {
  const response: any = CustomWorld.getStoreData('responseBDD');
  const isRefund: boolean = CustomWorld.getStoreData('isRefund');
  const isCompanyDebt: boolean = CustomWorld.getStoreData('isCompanyDebt');
  let coin: string = '';
  let assetAmountOperated: string = '';

  // If is a refund synthetic and take debt company
  if (isRefund && isCompanyDebt) {
    const finalDebt = parseFloat(inicialAmount) + parseFloat(CustomWorld.getStoreData('paymentAgainstAmount'));

    expect(finalDebt).to.be.closeTo(parseFloat(finalAmount), 0.02);

    logger.info(`In this case we operated onto company balance, so the final should be increased`);
    logger.info(`Balance after refund is correct: Inicial Balance ${inicialAmount}, Final Balance ${finalDebt}`);
    return;
  }

  // If is just a refund, take balance funds
  if (isRefund) {
    expect(parseFloat(inicialAmount)).to.be.closeTo(parseFloat(finalAmount), 0.02);

    logger.info(`In this case we operated onto user balance, so both of them should be equal`);
    logger.info(`Balance after refund is correct: Inicial Balance ${inicialAmount}, Final Balance ${finalAmount}`);
    return;
  }

  if (response !== undefined && isCompanyDebt) {
    coin = response.stages['1'].asset;
    logger.warn(coin);
    if (coin === 'USDT' || coin === 'USDC') {
      assetAmountOperated = response.stages['1'].assetAmount;
      logger.warn(assetAmountOperated);

      const finalDebt = parseFloat(inicialAmount) + parseFloat(assetAmountOperated);
      expect(finalDebt).to.be.closeTo(parseFloat(finalAmount), 0.02);

      logger.info(`In this case we operated onto company balance, so the final should be increased`);
      logger.info(`Balance after refund is correct: Inicial Balance ${inicialAmount}, Final Balance ${finalDebt}`);
      return;
    }

    if (coin === 'ARS') {
    }
  }
};
