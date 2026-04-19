const request = require('supertest');
const { expect } = require('chai');
import logger from '../utils/logger';

export function normalizeCoin(coin: string): string {
  return coin.split('_')[0];
}
