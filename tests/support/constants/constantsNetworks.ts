export const NETWORKS_MAPPINGS: Record<string, number> = {
  ETHEREUM: 0,
  POLYGON: 4,
  OPTIMISM: 5,
  WORLDCHAIN: 6,
  BASE: 7,
  ARBITRUM: 8,
  SOLANA: 12,
  STELLAR: 11
} as const;

// export type SupportedNetworks = keyof typeof NETWORKS_MAPPINGS;
