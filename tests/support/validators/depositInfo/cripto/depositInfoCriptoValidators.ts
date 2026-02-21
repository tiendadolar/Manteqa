import { expect } from 'chai';
import { CustomWorld } from '../../../world';
import { DepositInfoCriptoData, DepositInfoCriptoResponse, isDepositInfoCriptoResponse } from '../../../interfaces/DepositInfo/Cripto/depositInfoCripto.interface';
import logger from '../../../utils/logger';

const addresses: Record<string, RegExp> = {
  ETHEREUM: /^0x[a-fA-F0-9]{40}$/,
  BINANCE: /^0x[a-fA-F0-9]{40}$/,
  POLYGON: /^0x[a-fA-F0-9]{40}$/,
  OPTIMISM: /^0x[a-fA-F0-9]{40}$/,
  WORLDCHAIN: /^0x[a-fA-F0-9]{40}$/,
  ARBITRUM: /^0x[a-fA-F0-9]{40}$/,
  BASE: /^0x[a-fA-F0-9]{40}$/,
  TERRA: /^terra1[a-z0-9]{38}$/,
  TERRA2: /^terra1[a-z0-9]{38}$/,
  TRON: /^T[A-Za-z0-9]{33}$/
};

export class DepositInfoCriptoValidator {
  static validateResponseInfoCriptoResponse(response: any, coin: string): DepositInfoCriptoResponse {
    expect(response).to.exist;
    expect(response).to.be.an('object');

    if (!isDepositInfoCriptoResponse) {
      throw new Error('🚨 Response does not match DepositInfoCriptoResponse interface');
    }

    this.validateNetworkFields(response, coin);

    Object.entries(response).forEach(([network, data]) => {
      this.validateDepositInfoCriptoFields((data as DepositInfoCriptoData).address, network);
    });

    console.log('✅ Deposit Info Cripto response validation passed');

    return response as DepositInfoCriptoResponse;
  }

  private static validateNetworkFields(response: any, coin: string): void {
    let chains: string[] = [];

    switch (coin) {
      case 'WLD':
        chains = ['ETHEREUM', 'OPTIMISM', 'WORLDCHAIN'];
        break;

      case 'USDT':
        chains = ['ETHEREUM', 'BINANCE', 'POLYGON', 'OPTIMISM', 'ARBITRUM', 'TRON'];
        break;

      case 'USDC':
        chains = ['ETHEREUM', 'BINANCE', 'POLYGON', 'OPTIMISM', 'BASE', 'ARBITRUM'];
        break;

      default:
        break;
    }

    for (const network of chains) {
      expect(response).to.have.property(network);
      expect(response[network].network).to.be.equal(network);
    }
  }

  private static validateDepositInfoCriptoFields(address: string, network: string): void {
    expect(address).to.match(addresses[network]);
  }
}

export const validateResponse = (response: any, coin: string): DepositInfoCriptoResponse => {
  return DepositInfoCriptoValidator.validateResponseInfoCriptoResponse(response, coin);
};
