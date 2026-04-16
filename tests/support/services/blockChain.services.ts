import { toWei } from '@md/math';
import { ethers } from 'ethers';

const RPC_MAP: Record<string, string> = {
  WORLDCHAIN: 'RPC_WORLDCHAIN',
  ETHEREUM: 'RPC_ETHEREUM',
  POLYGON: 'RCP_POLYGON',
  BINANCE: 'RPC_BINANCE',
  BASE: 'RPC_BASE',
  ARBITRUM: 'RPC_ARBITRUM',
  OP: 'RPC_OP'
};

const TOKEN_MAP: Record<string, Record<string, string>> = {
  BASE: {
    USDC: '0x8431eBc62F7B08af1bBf80eE7c85364ffc24ae24'
  },
  ETHEREUM: {
    USDT: '0x1d56e7adc2494b448742cf320ea305cd87295fcc'
  },
  BINANCE: {
    USDT: '0x3eC7DA586A34589157e0B3AFA5F9eFADa51f36ec'
  },
  OP: {
    WLD: '0x6c582801a9BDb0025C5f5C33C417BBBE1E42B2Bb',
    USDCB: '0x177AAE8822048B9dD840C9816CD0e9654924c261',
    USDC: '0x5fd84259d66Cd46123540766Be93DFE6D43130D7'
  },
  ARBITRUM: {
    USDC: '0x8431eBc62F7B08af1bBf80eE7c85364ffc24ae24'
  },
  POLYGON: {
    USDT: '0x8431eBc62F7B08af1bBf80eE7c85364ffc24ae24'
  },
  WORLDCHAIN: {
    WLD: '0xb7406C08dCefA9B502428eAe7284f88EE44c4333'
  }
};

const ERC20_ABI = ['function transfer(address to, uint256 amount) returns (bool)', 'function balanceOf(address account) view returns (uint256)', 'function decimals() view returns (uint8)'];

export class BlockchainService {
  private provider: ethers.JsonRpcProvider;
  private wallet: ethers.Wallet;
  private network: string;

  constructor(network: string) {
    const networkRpc = RPC_MAP[network.toUpperCase()];
    const rpcUrl = process.env[networkRpc];
    const privateKey = process.env.PRIVATE_KEY_META;

    if (!rpcUrl) throw new Error(`RPC URL not found for env var: "${networkRpc}"`);
    if (!privateKey) throw new Error('PRIVATE_KEY_META is not defined in .env');

    this.provider = new ethers.JsonRpcProvider(rpcUrl);
    this.wallet = new ethers.Wallet(privateKey!, this.provider);
    this.network = network.toUpperCase();
  }

  async withdraw(to: string, amount: string): Promise<ethers.TransactionReceipt> {
    const tx = await this.wallet.sendTransaction({
      to,
      value: toWei(amount)
    });

    const receipt = await tx.wait();

    return receipt as ethers.TransactionReceipt;
  }

  async withdrawToken(to: string, amount: string, token: string): Promise<ethers.TransactionReceipt> {
    const coin = token.toUpperCase();
    const tokenAddress = TOKEN_MAP[this.network]?.[coin];

    if (!tokenAddress) throw new Error(`Token "${token}" is not supported on network "${this.network}"`);

    const contract = new ethers.Contract(tokenAddress, ERC20_ABI, this.wallet);

    // Obtener decimales del token (USDC=6, ETH/DAI=18)
    const decimals: number = await contract.decimals();
    const parsedAmount = ethers.parseUnits(amount, decimals);

    const tx = await contract.transfer(to, parsedAmount);
    const receipt = await tx.wait();
    if (!receipt) throw new Error(`Token transaction failed — no receipt returned`);

    return receipt;
  }

  async getBalance(address: string): Promise<string> {
    const balance = await this.provider.getBalance(address);
    return ethers.formatEther(balance);
  }

  getAddress(): string {
    return this.wallet.address;
  }
}
