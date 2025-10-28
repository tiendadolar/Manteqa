import { execSync } from 'child_process';
import fs from 'fs';
import { apiRequest } from '../../support/helpers/requestHelper';
import path from 'path';

const lockPath = path.resolve(__dirname, '../payloads/lock.json');

const urlBase = 'https://sandbox.manteca.dev/crypto';
const endpoint = '/v2/payment-locks';
const apiKey = 'F4EZSEW-AMC4Z24-G5CNFS4-880BSHJ';

async function getLock() {
  const payload = {
    userAnyId: '100009359',
    paymentDestination: 'qr3',
    against: 'USDT'
  };

  const res = await apiRequest({ urlBase, endpoint, method: 'post', apiKey, body: payload });

  const lockCode = res.body.code;
  fs.writeFileSync(lockPath, JSON.stringify({ lockCode }, null, 2));
  console.log('✅ LockCode obtenido:', lockCode);
}

async function runLoadTest() {
  execSync('npx artillery run tests/artillery/qr-fallback.yml', { stdio: 'inherit' });
}

(async () => {
  await getLock();
  await runLoadTest();
})();
