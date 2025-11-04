import { expect } from 'chai';
import logger from '../utils/logger';
import { CustomWorld } from '../world';
import { getHour, timeToSeconds } from '../helpers/providerHelper';

export const checkProvider = (provider: string, exchange: string, synthetic: string): any => {
  const hour = timeToSeconds(getHour());
  const bypassInf = timeToSeconds('01:30:00');
  const bypassSup = timeToSeconds('02:00:00');

  if (exchange === 'ARG') {
    if (synthetic === 'QR') {
      if (hour > bypassInf && hour < bypassSup) {
        if (synthetic === 'QR') expect(provider).to.be.equal('PVS');
      } else {
        if (synthetic === 'QR') expect(provider).to.be.equal('PLUS_QR');
      }
    }

    if (synthetic === 'PIX') {
      if (synthetic === 'PIX') expect(provider).to.be.equal('TRANSFERO_PIX');
    }
  }

  if (exchange === 'BRA') {
    if (synthetic === 'QR') expect(provider).to.be.equal('PLUS_QR');
    if (synthetic === 'PIX') {
      if (hour > bypassInf && hour < bypassSup) {
        expect(provider).to.be.equal('AVENIA');
      } else {
        expect(provider).to.be.equal('TRANSFERO');
      }
    }
  }
};
