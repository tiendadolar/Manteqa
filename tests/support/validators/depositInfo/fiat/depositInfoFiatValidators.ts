import { expect } from 'chai';
import { CustomWorld } from '../../../world';
import { DepositInfoFiatResponse, isDepositInfoFiatResponse } from '../../../interfaces/DepositInfo/Fiat/depositInfoFiat.interface';

export class DepositInfoFiatValidator {
  static validateDepositInfoFiatResponse(response: any, exchange: string): DepositInfoFiatResponse {
    expect(response).to.exist;
    expect(response).to.be.an('object');

    if (!isDepositInfoFiatResponse) {
      throw new Error('🚨 Response does not match DepositInfoFiatResponse interface');
    }
    const network = Object.keys(response)[0];
    const data = response[network];

    this.validateNetworkField(network, exchange);
    this.validateDepositInfoFiatFields(data, exchange);

    console.log('✅ Deposit Info Fiat response validation passed');

    return response as DepositInfoFiatResponse;
  }

  private static validateNetworkField(response: any, exchange: string): void {
    switch (exchange) {
      case 'ARS':
        expect(response).to.be.equal('BANK_TRANSFER');
        break;
      case 'CLP':
        expect(response).to.be.equal('BANK_TRANSFER');
        break;
      case 'BRL':
        expect(response).to.be.equal('PIX');
        break;
      case 'BOB':
        expect(response).to.be.equal('BOLIVIA_QR');
        break;
      case 'GTQ':
        expect(response).to.be.equal('GUATEMALA_QR');
        break;
      case 'MXN':
        expect(response).to.be.equal('SPEI');
        break;
      case 'USD':
        expect(response).to.be.equal('BANK_TRANSFER');
        break;
      case 'COP':
        expect(response).to.be.equal('BREB');
        break;

      default:
        break;
    }
  }

  private static validateDepositInfoFiatFields(response: any, exchange: string): void {
    switch (exchange) {
      case 'ARS':
        expect(response.address).to.be.equal('43100013438000000451101');
        expect(response.network).to.be.equal('BANK_TRANSFER');
        expect(response.alias).to.be.equal('TIENDACRYPTO.ARS');
        break;
      case 'CLP':
        expect(response.address).to.be.equal('928623463');
        expect(response.accountType).to.be.equal('CHECKING');
        expect(response.network).to.be.equal('BANK_TRANSFER');
        expect(response.accountName).to.be.equal('Local payments SPA');
        expect(response.legalId).to.be.equal('77.175.361-2');
        expect(response.bankCode).to.be.equal('324');
        expect(response.bankName).to.be.equal('BANCO SECURITY');
        break;
      case 'BRL':
        expect(response.address).to.be.equal('pix-key-test');
        expect(response.network).to.be.equal('PIX');
        break;
      case 'BOB':
        expect(response.address).to.be.equal('dynamic');
        expect(response.network).to.be.equal('BOLIVIA_QR');
        break;
      case 'GTQ':
        expect(response.address).to.be.equal('dynamic');
        expect(response.network).to.be.equal('GUATEMALA_QR');
        break;
      case 'MXN':
        expect(response.address).to.be.equal('646010319801971224');
        expect(response.network).to.be.equal('SPEI');
        expect(response.bankCode).to.be.equal('012');
        expect(response.bankName).to.be.equal('BBVA BANCOMER');
        break;
      case 'USD':
        expect(response.address).to.be.equal('4310003742700100000033');
        expect(response.network).to.be.equal('BANK_TRANSFER');
        expect(response.alias).to.be.equal('SIXA.USD');
        break;
      case 'COP':
        expect(response.address).to.be.equal('dynamic');
        expect(response.network).to.be.equal('BREB');
        break;

      default:
        break;
    }
  }
}

export const validateResponse = (response: any, exchange: string): DepositInfoFiatResponse => {
  return DepositInfoFiatValidator.validateDepositInfoFiatResponse(response, exchange);
};
