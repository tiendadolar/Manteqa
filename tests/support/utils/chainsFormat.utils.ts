import { expect } from 'chai';

export const ADDRESS_VALIDATORS: Record<string, RegExp> = {
  ETHEREUM: /^0x[a-fA-F0-9]{40}$/,
  BINANCE: /^0x[a-fA-F0-9]{40}$/,
  POLYGON: /^0x[a-fA-F0-9]{40}$/,
  OPTIMISM: /^0x[a-fA-F0-9]{40}$/,
  WORLDCHAIN: /^0x[a-fA-F0-9]{40}$/,
  ARBITRUM: /^0x[a-fA-F0-9]{40}$/,
  BASE: /^0x[a-fA-F0-9]{40}$/,
  TRON: /^T[A-Za-z0-9]{33}$/,
  STELLAR: /^[GMA][A-Z2-7]{55,68}$/,
  SOLANA: /^[1-9A-HJ-NP-Za-km-z]{32,44}$/
};

export const validateAddress = (address: string, network: string): void => {
  if (ADDRESS_VALIDATORS[network]) {
    expect(address).to.match(ADDRESS_VALIDATORS[network], `Invalid ${network} address format: ${address}`);
  } else {
    expect(address).to.be.a('string').and.not.empty;
  }
};
