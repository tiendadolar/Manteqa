export const COIN_MAPPINGS: Record<string, string> = {
  USDT: 'tether',
  USDC: 'usd-coin',
  WLD: 'worldcoin-wld',
  ETH: 'ethereum',
  BTC: 'bitcoin',
  USDCB: 'usd-coin-wormhole-bnb',
  BNB: 'binancecoin',
  DAI: 'dai',
  TRX: 'tron'
} as const;

export type SupportedCoins = keyof typeof COIN_MAPPINGS;
