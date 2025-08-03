import { COIN_MAPPINGS } from '../constants/constantsCoins';

export interface TickerInfo {
  parseCrypto: string;
  parseFiat: string;
}

export function getCoinName(symbol: string): string {
  return COIN_MAPPINGS[symbol] || symbol.toLowerCase();
}

export function getTickerInfo(ticker: string): TickerInfo {
  let [crypto, fiat]: [string, string] = ticker.split('_') as [string, string];

  if (fiat === 'PUSD') fiat = 'USD';

  return {
    parseCrypto: getCoinName(crypto),
    parseFiat: fiat.toLowerCase()
  };
}
