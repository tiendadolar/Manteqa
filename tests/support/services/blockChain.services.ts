import { toWei } from '@md/math';
import { ethers } from 'ethers';

export class BlockchainService {
  private provider: ethers.JsonRpcProvider;
  private wallet: ethers.Wallet;

  constructor(networkRpc: string) {
    const rpcUrl = process.env[networkRpc];
    const privateKey = process.env.PRIVATE_KEY_META;

    this.provider = new ethers.JsonRpcProvider(rpcUrl);
    this.wallet = new ethers.Wallet(privateKey!, this.provider);
  }

  async withdraw(to: string, amount: string): Promise<ethers.TransactionReceipt> {
    const tx = await this.wallet.sendTransaction({
      to,
      value: toWei(amount)
    });

    const receipt = await tx.wait();

    return receipt as ethers.TransactionReceipt;
  }
}
