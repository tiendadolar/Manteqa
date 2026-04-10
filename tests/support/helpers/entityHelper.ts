const request = require('supertest');
const { expect } = require('chai');
import logger from '../utils/logger';
import { CustomWorld } from '../world';
import { apiRequest } from './requestHelper';

export const validateEntity = (against: string, legalEntity: string): void => {
  switch (against) {
    case 'ARS':
      expect(legalEntity).to.be.equal('WALLET_ARG');
      break;
    case 'USD':
      expect(legalEntity).to.be.equal('CRYPTO_ARG');
    default:
      break;
  }
};

export const validateEntitySyntheticOrder = (against: string, legalEntity: string): void => {
  switch (against) {
    case 'ARS':
      expect(legalEntity).to.be.equal('WALLET_ARG');
      break;
    case 'USD':
      expect(legalEntity).to.be.equal('CRYPTO_ARG');
    default:
      break;
  }
};

export const validateEntitySyntheticWithdraw = (against: string, legalEntity: string): void => {
  switch (against) {
    case 'ARS':
      expect(legalEntity).to.be.equal('WALLET_ARG');
      break;
    case 'USD':
      expect(legalEntity).to.be.equal('CRYPTO_ARG');
    default:
      break;
  }
};
