const request = require("supertest");
import { CustomWorld } from "../support/world";

export const delay = (ms: number): Promise<void> => {
  console.log("EJECUTANDO DELAY");
  return new Promise((resolve) => setTimeout(resolve, ms));
};

//-----API CRIPTO-----//
// Deposito cripto
export const inicialOnboardingApiCrypto = (userData: any) => {
  return {
    email: userData.email,
    legalId: userData.legalId,
    exchange: userData.exchange,
    personalData: {
      sex: userData.sex,
      work: userData.work,
      birthDate: userData.birthDate,
      maritalStatus: userData.maritalStatus,
      isPep: userData.isPep === "true",
      isFep: userData.isFep === "true",
      isFatca: userData.isFatca === "true",
      // isUif: userData.isUif === "true",
      // phoneNumber: userData.phoneNumber, // Esta roto por el momento
      nationality: userData.nationality,
    },
    banking: {
      accounts: [
        {
          cbu: userData.ARScbu,
          currency: userData.ARScurrency,
          description: userData.ARSdescription,
        },
        {
          cbu: userData.USDcbu,
          currency: userData.USDcurrency,
          description: userData.USDdescription,
        },
      ],
    },
  };
};

export const inicialOnboardingApiCryptoV2 = (userData: any) => {
  console.log(userData.nationality);

  if (userData.nationality === "Argentina") {
    return {
      email: userData.email,
      legalId: userData.legalId,
      exchange: userData.exchange,
      personalData: {
        name: userData.name,
        surname: userData.surname,
        sex: userData.sex,
        work: userData.work,
        birthDate: userData.birthDate,
        maritalStatus: userData.maritalStatus,
        isPep: userData.isPep === "true",
        isFep: userData.isFep === "true",
        isFatca: userData.isFatca === "true",
        phoneNumber: userData.phoneNumber, // Esta roto por el momento
        nationality: userData.nationality,
        address: {
          street: userData.street,
        },
      },
      banking: {
        accounts: [
          {
            cbu: userData.ARScbu,
            currency: userData.ARScurrency,
            description: userData.ARSdescription,
          },
          {
            cbu: userData.USDcbu,
            currency: userData.USDcurrency,
            description: userData.USDdescription,
          },
        ],
      },
    };
  } else {
    return {
      email: userData.email,
      legalId: userData.legalId,
      exchange: userData.exchange,
      personalData: {
        name: userData.name,
        surname: userData.surname,
        sex: userData.sex,
        work: userData.work,
        birthDate: userData.birthDate,
        maritalStatus: userData.maritalStatus,
        isPep: userData.isPep === "true",
        isFep: userData.isFep === "true",
        isFatca: userData.isFatca === "true",
        phoneNumber: userData.phoneNumber, // Esta roto por el momento
        nationality: userData.nationality,
        address: {
          street: userData.street,
        },
      },
      banking: {
        accounts: [
          {
            cbu: userData.ARScbu,
            currency: userData.ARScurrency,
            description: userData.ARSdescription,
            bank: {
              code: userData.bankCode,
            },
            accountType: userData.accountType,
          },
        ],
      },
    };
  }
};

export const criptoDepositApiCrypto = (userData: any) => {
  if (CustomWorld.getStoreData("thresholdAmount") === undefined) {
    return {
      tx: {
        hash: CustomWorld.getNetworkId(),
        from: userData.from || "0x9bD31d82B6212dd60a9328CCe7277161e5975fB5",
        to:
          CustomWorld.getStoreData("depositAddress") ||
          userData.to ||
          userData.details.depositAddress,
        value: {
          wei:
            userData.wei ||
            userData.stages["1"].thresholdAmount * 1000000000000000000,
          human:
            CustomWorld.getStoreData("thresholdAmount") ||
            userData.human ||
            userData.stages["1"].thresholdAmount,
        },
        ticker: userData.ticker || userData.details.paymentAgainstAsset,
        chain: userData.chain || 0,
      },
    };
  } else {
    return {
      tx: {
        hash: CustomWorld.getNetworkId(),
        from: userData.from || "0x9bD31d82B6212dd60a9328CCe7277161e5975fB5",
        to:
          CustomWorld.getStoreData("depositAddress") ||
          userData.to ||
          userData.details.depositAddress,
        value: {
          wei:
            (
              CustomWorld.getStoreData("thresholdAmount") * 1000000000000000000
            ).toString() ||
            userData.wei ||
            userData.stages["1"].thresholdAmount * 1000000000000000000,
          human:
            CustomWorld.getStoreData("thresholdAmount") ||
            userData.human ||
            userData.stages["1"].thresholdAmount,
        },
        ticker: userData.ticker || userData.details.paymentAgainstAsset,
        chain: userData.chain || 0,
      },
    };
  }
};

// Deposito fiat
export const fiatDepositApiCrypto = (userData: any) => {
  return {
    userId: CustomWorld.getStoreData("userNumberId") || userData.userNumberId,
    amount:
      CustomWorld.getStoreData("thresholdAmount") ||
      userData.amount ||
      userData.stages["1"].thresholdAmount,
    coin:
      CustomWorld.getStoreData("coin") ||
      userData.coin ||
      userData.details.paymentAgainstAsset,
  };
};

export const fiatWithdrawApiCrypto = (userData: any) => {
  return {
    tx: {
      coin: userData.coin,
      amount: (userData.amount * 1000000000000000000).toString(),
      to: userData.to,
      chain: userData.chain,
    },
    userId: userData.userId,
    costCode: CustomWorld.getStoreData("pixCode"),
  };
};

export const pepInfoCrypto = (userData: any) => {
  return {
    pepData: {
      charge: userData.charge,
      authority: userData.authority,
      character: userData.character,
    },
  };
};

// Onboarding Add Bank Account
export const bankingOnboardingApiCrypto = (userData: any) => {
  return {
    userAnyId: CustomWorld.getStoreData("userId") || userData.userAnyId,
    currency: userData.currency,
    cbu: userData.address,
    description: userData.description,
    bank: {
      code: userData.bankCode,
    },
    accountType: userData.accountType,
  };
};

//-----API CRIPTO-----//
//-----*********-----//
//-----API CAMBIO-----//

// Onboarding inicial
export const inicialOnboardingApiCambio = (userData: any) => {
  return {
    email: userData.email,
    legalId: userData.legalId,
    personalData: {
      sex: userData.sex,
      work: userData.work,
      birthDate: userData.birthDate,
      maritalStatus: userData.maritalStatus,
      isPep: userData.isPep === "true",
      isFep: userData.isFep === "true",
      isFatca: userData.isFatca === "true",
      isUif: userData.isUif === "true",
      phoneNumber: userData.phoneNumber,
      nationality: userData.nationality,
    },
    banking: {
      accounts: [
        {
          cbu: userData.ARScbu,
          currency: userData.ARScurrency,
          description: userData.ARSdescription,
        },
        {
          cbu: userData.USDcbu,
          currency: userData.USDcurrency,
          description: userData.USDdescription,
        },
      ],
    },
  };
};

//  Onboarding Validate Docs
export const validateOnboardingApiCambio = (userData: any) => {
  return {
    userAnyId: CustomWorld.getStoreData("userId"),
    side: userData.side,
    fileName: userData.fileName,
  };
};

// Onboarding Add Bank Account
export const bankingOnboardingApiCambio = (userData: any) => {
  return {
    userAnyId: CustomWorld.getStoreData("userId"),
    address: userData.address,
    currency: userData.currency,
    description: userData.description,
  };
};

// Deposito fiat
export const fiatDepositApiCambio = (userData: any) => {
  return {
    companyId: userData.companyId,
    networkId: userData.networkId,
    userId: userData.userId,
    source: userData.source,
    legalId: userData.legalId,
    amount: CustomWorld.getStoreData("thresholdAmount"),
    coin: CustomWorld.getStoreData("coin"),
  };
};

export const refundPollingWithDeposit = async function (
  data: any,
  userData: any
) {
  const maxAttemps: number = 15;
  let attempsCounter: number = 0;

  const endpointLock: String = "/v2/payment-locks";
  let payloadLock: object = {
    userAnyId: userData.userAnyId,
    paymentDestination: userData.paymentDestination,
    against: userData.against,
    amount: userData.amount,
  };

  const endpointPayment: String = "/v2/synthetics/qr-payment";
  let payloadPayment: object = {};

  let endpointGetSynthetic: String = "";

  while (attempsCounter < maxAttemps) {
    // Lock-Price Creation
    userData.response = await request(data.urlBase)
      .post(endpointLock)
      .set("md-api-key", data.apiKey)
      .send(payloadLock);
    console.log("API payload:", payloadLock);
    console.log("API response:", userData.response.body);

    let pixCode = userData.response.body.code;
    payloadPayment = {
      sessionId: CustomWorld.getSessionId(userData.sessionId),
      userAnyId: userData.userAnyId,
      pixCode: pixCode,
    };

    await delay(3000);

    // Synthetic creation
    userData.response = await request(data.urlBase)
      .post(endpointPayment)
      .set("md-api-key", data.apiKey)
      .send(payloadPayment);
    console.log("API payload:", payloadPayment);
    console.log("API response:", userData.response.body);

    await delay(3000);

    let syntheticId = userData.response.body.id;
    endpointGetSynthetic = `/v1/synthetics/${syntheticId}`;

    // Deposits
    if (userData.against === "USDT") {
      let endpointDeposit = "/v1/transaction/deposit";
      let depositCryptoPayload = criptoDepositApiCrypto(userData.response.body);

      // Crypto deposit
      userData.response = await request(data.urlBase)
        .post(endpointDeposit)
        .set("md-api-key", userData.apiKeyDeposit)
        .set("x-api-secret", data.apiSecret)
        .send(depositCryptoPayload);
      console.log("API payload:", depositCryptoPayload);
      console.log("API response:", userData.response.body);
    } else {
      let endpointDeposit = "/v1/fiat/deposit";
      let depositFiatPayload = fiatDepositApiCrypto(userData.response.body);

      // Fiat deposit
      userData.response = await request(data.urlBase)
        .post(endpointDeposit)
        .set("md-api-key", "C10XB2Z-AG243CS-G42KB2M-4085WTF")
        .set("x-api-secret", data.apiSecret)
        .send(depositFiatPayload);
      console.log("API payload:", depositFiatPayload);
      console.log("API response:", userData.response.body);
    }

    await delay(10000);

    // Get synthetic
    userData.response = await request(data.urlBase)
      .get(endpointGetSynthetic)
      .set("md-api-key", data.apiKey);
    console.log("API response GET:", userData.response.body);

    if (userData.response.body.status === "CANCELLED") return userData.response;

    attempsCounter++;
  }
};

export const refundsPolling = async function (data: any, userData: any) {
  const maxAttemps: number = 15;
  let attempsCounter: number = 0;

  const endpointLock: String = "/v2/payment-locks";
  let payloadLock: object = {
    userAnyId: userData.userAnyId,
    paymentDestination: userData.paymentDestination,
    against: userData.against,
    amount: userData.amount,
  };

  const endpointPayment: String = "/v2/synthetics/qr-payment";
  let payloadPayment: object = {};

  let endpointGetSynthetic: String = ``;

  while (attempsCounter < maxAttemps) {
    userData.response = await request(data.urlBase)
      .post(endpointLock)
      .set("md-api-key", data.apiKey)
      .send(payloadLock);

    let pixCode = userData.response.body.code;
    payloadPayment = {
      sessionId: CustomWorld.getSessionId(userData.sessionId),
      userAnyId: userData.userAnyId,
      pixCode: pixCode,
    };

    await delay(3000);

    userData.response = await request(data.urlBase)
      .post(endpointPayment)
      .set("md-api-key", data.apiKey)
      .send(payloadPayment);

    let syntheticId = userData.response.body.id;
    endpointGetSynthetic = `/v1/synthetics/${syntheticId}`;

    await delay(10000);

    userData.response = await request(data.urlBase)
      .get(endpointGetSynthetic)
      .set("md-api-key", data.apiKey);
    console.log("API response GET:", userData.response.body);

    if (userData.response.body.status === "CANCELLED") return userData.response;

    attempsCounter++;
  }
};
