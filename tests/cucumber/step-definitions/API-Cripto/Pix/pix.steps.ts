const { Given, When, Then, Before } = require("@cucumber/cucumber");
const { expect } = require("chai");
const request = require("supertest");
import { CustomWorld, UserData } from "../../../../support/world";
import {
  bankingOnboardingApiCambio,
  criptoDepositApiCrypto,
  fiatDepositApiCambio,
  fiatDepositApiCrypto,
  inicialOnboardingApiCambio,
  validateOnboardingApiCambio,
  fiatWithdrawApiCrypto,
  inicialOnboardingApiCrypto,
  inicialOnboardingApiCryptoV2,
  bankingOnboardingApiCrypto,
} from "../../../../support/utils";

Before({ tags: "@Pix" }, function () {
  console.log("Ejecutando steps para pix");
});

Given(
  "Contar con la api-key {string}",
  function (this: CustomWorld, APIkey: string) {
    // this.apiKey = "BM2YZT6-MR5M5YY-QYZ5CY4-E8E9HYB";
    this.apiKey = APIkey;
  }
);

Given(
  "Contar con la api-secret {string}",
  function (this: CustomWorld, APIsecret: string) {
    this.apiSecret = APIsecret;
  }
);

Given(
  "Contar con el token {string}",
  function (this: CustomWorld, token: string) {
    this.token = CustomWorld.getStoreData("accessToken") || token;
  }
);

Given(
  "Contar con la urlBase {string}",
  function (this: CustomWorld, urlBase: string) {
    this.urlBase = urlBase;
  }
);

When(
  "Asignar el valor {string} a la variable {string}",
  function (this: CustomWorld, value: string, variable: string) {
    if (!this.userData) {
      this.userData = {} as UserData;
    }

    // Si se pide sessionId en el step, se autoincrementa
    if (variable === "sessionId") {
      this.userData[variable] = CustomWorld.getSessionId(value);
      return;
    }

    if (variable === "hash") {
      this.userData[variable] = CustomWorld.getHashCrypto();
      // console.log(this.userData[variable]);
      return;
    }

    if (variable === "networkId") {
      this.userData[variable] = CustomWorld.getNetworkId();
      return;
    }

    // Se utiliza pixCode tambien para lockCode
    if (value === "pixCode") {
      // console.log(CustomWorld.getStoreData("pixCode"));
      this.userData[variable] = CustomWorld.getStoreData("pixCode") || "";
    } else {
      this.userData[variable] = value;
    }
  }
);

When(
  "Asignar el valor {int} a la variable {string}",
  function (this: CustomWorld, value: number, variable: string) {
    if (!this.userData) {
      this.userData = {} as UserData;
    }
    this.userData[variable] = value;
  }
);

When(
  "Asignar el valor a la variable",
  function (this: CustomWorld, dataTable: any) {
    if (!this.userData) {
      this.userData = {} as UserData;
    }

    // Si no existe userData se leen los examples
    dataTable.rawTable.forEach(([key, value]: [string, string]) => {
      this.userData[key] = value;
    });
  }
);

When(
  "Ejecutar el método Post al endpoint {string}",
  { timeout: 50 * 1000 },
  async function (this: CustomWorld, endpoint: string) {
    let paramEndpoint = endpoint;

    try {
      if (
        CustomWorld.getStoreData("userId") !== undefined &&
        endpoint !== "/v3/api/onboarding-actions/upload-identity-image"
      ) {
        paramEndpoint = paramEndpoint.replace(
          "{userId}",
          CustomWorld.getStoreData("userId") || ""
        );
        // CustomWorld.setStoreData("userId", "");
      }
      // API-Cripto
      if (endpoint === "/onboarding-actions/initial") {
        // Onboarding inicial V1
        this.userData = inicialOnboardingApiCrypto(this.userData);
      } else if (endpoint === "/v2/onboarding-actions/initial") {
        // Onboarding inicial V2
        this.userData = inicialOnboardingApiCryptoV2(this.userData);
      } else if (endpoint === "/v2/onboarding-actions/add-bank-account") {
        this.userData = bankingOnboardingApiCrypto(this.userData);
      } else if (endpoint === "/v1/transaction/deposit") {
        // Deposito cripto
        this.userData = criptoDepositApiCrypto(this.userData);
      } else if (endpoint === "/v1/fiat/deposit") {
        // Deposito fiat
        this.userData = fiatDepositApiCrypto(this.userData);
      } else if (endpoint === "/v1/transaction/withdraw") {
        this.userData = fiatWithdrawApiCrypto(this.userData);
      } else if (
        endpoint === "/v1/synthetics/ramp-on" ||
        endpoint === "/v2/payment-locks" ||
        endpoint === "/v2/synthetics/qr-payment"
      ) {
        this.userData.userAnyId =
          this.userData.userAnyId ?? CustomWorld.getStoreData("userId");
        // API-Cambio
      } else if (endpoint === "/v3/api/onboarding-actions/initial") {
        // Onboarding inicial
        this.userData = inicialOnboardingApiCambio(this.userData);
      } else if (
        endpoint === "/v3/api/onboarding-actions/upload-identity-image" ||
        endpoint === "/v3/api/onboarding-actions/upload-selfie-image" ||
        endpoint === "/v3/api/onboarding-actions/upload-pep-documentation" ||
        endpoint === "/onboarding-actions/upload-identity-image" ||
        endpoint === "/onboarding-actions/upload-selfie-image" ||
        endpoint === "/v2/onboarding-actions/upload-identity-image" ||
        endpoint === "/v2/onboarding-actions/upload-selfie-image"
      ) {
        // Onboarding Docs Validate
        this.userData = validateOnboardingApiCambio(this.userData);
      } else if (endpoint === "/v3/onboarding-actions/add-bank-account") {
        // Onboarding Add Bank Account
        this.userData = bankingOnboardingApiCambio(this.userData);
      } else if (endpoint === "/v3/admin/banking/deposit") {
        // Deposito fiat API-Cambio
        console.log(CustomWorld.getStoreData("thresholdAmount"));

        this.userData = fiatDepositApiCambio(this.userData);
      } else if (endpoint === "v3/admin/auth/verifyLogin/{twoFaCode}") {
        paramEndpoint = paramEndpoint.replace(
          "{twoFaCode}",
          CustomWorld.getStoreData("redirectUrl") || ""
        );
      }

      console.log("API payload:", JSON.stringify(this.userData, null, 2));

      this.response = await request(this.urlBase)
        .post(paramEndpoint)
        .set("md-api-key", this.apiKey)
        .set("x-api-secret", this.apiSecret)
        .set("x-access-token", this.token)
        .send(this.userData);
      console.log("API response:", this.response.body);
      this.userData = {};
    } catch (error: any) {
      //   if (error.response) {
      //     // this.attach(`API Error Response: ${JSON.stringify(error.response.body || error.response.text || {}, null, 2)}`, 'text/plain');
      //     // this.response = error.response;
      //   }
      //   throw error;
    }
  }
);

When(
  "Ejecutar el método Get al endpoint {string}",
  { timeout: 50 * 1000 },

  async function (this: CustomWorld, endpoint: string) {
    const paramEndpoint = endpoint
      .replace("{syntheticId}", CustomWorld.getStoreData("syntheticId") || "")
      .replace("{withdrawAnyId}", CustomWorld.getStoreData("withdrawId") || "");
    try {
      console.log("API endpoint:", paramEndpoint);

      this.response = await request(this.urlBase)
        .get(paramEndpoint)
        .set("md-api-key", this.apiKey);
      console.log("API response:", JSON.stringify(this.response.body, null, 2));
    } catch (error: unknown) {
      const err = error as { response?: any };
      this.response = err.response || {
        status: 500,
        body: { message: "Error desconocido" },
      };
      console.error("Error en GET:", this.response.body);
      throw error;
    }
  }
);

Then(
  "Se obtiene una respuesta {int}",
  function t(this: CustomWorld, statusCode: number) {
    expect(this.response.status).to.equal(statusCode);

    // console.log("Response body:", this.response.body);

    if (this.response.body.code) {
      CustomWorld.setStoreData("pixCode", this.response.body.code);
      // console.log(CustomWorld.getStoreData("pixCode"));
    }

    // POSIBLE ERROR EN OTROS MODULOS
    if (this.response.body.id && this.response.body.status === "STARTING")
      CustomWorld.setStoreData("syntheticId", this.response.body.id);

    if (this.response.body.userId) {
      CustomWorld.setStoreData("userId", this.response.body.userId);
    }

    if (this.response.body.userNumberId) {
      CustomWorld.setStoreData("userNumberId", this.response.body.userNumberId);
    }

    if (this.response.body.numberId) {
      CustomWorld.setStoreData("withdrawId", this.response.body.numberId);
    }

    if (Array.isArray(this.response.body) && this.response.body[0]?.numberId) {
      CustomWorld.setStoreData("withdrawId", this.response.body[0].numberId);
    }

    if (this.response.body.stages && this.response.body.stages.withdrawId) {
      const stage = this.response.body.stages[1];
      CustomWorld.setStoreData("withdrawId", stage.withdrawId);
    }
    if (
      this.response.body.status === "STARTING" &&
      this.response.body.details.depositAddress
    ) {
      CustomWorld.setStoreData(
        "depositAddress",
        this.response.body.details.depositAddress
      );
    }
    if (this.response.body.url) {
      CustomWorld.setStoreData("awsUrl", this.response.body.url);
    }
    if (
      this.response.body.status === "STARTING" &&
      this.response.body.stages &&
      this.response.body.stages["1"] &&
      this.response.body.stages["1"].thresholdAmount
    ) {
      CustomWorld.setStoreData(
        "thresholdAmount",
        this.response.body.stages["1"].thresholdAmount
      );
    }
    if (
      this.response.body.stages &&
      this.response.body.stages["1"] &&
      this.response.body.stages["1"].asset
    ) {
      CustomWorld.setStoreData("coin", this.response.body.stages["1"].asset);
    }
    if (this.response.body.user && this.response.body.user.id) {
      console.log(this.response.body.user.id);
      CustomWorld.setStoreData("userId", this.response.body.user.id);
      console.log(CustomWorld.getStoreData("userId"));
    }
    if (this.response.body.redirectUrl) {
      CustomWorld.setStoreData("redirectUrl", this.response.body.redirectUrl);
    }
    if (this.response.body.accessToken) {
      CustomWorld.setStoreData("accessToken", this.response.body.accessToken);
    }
  }
);

Then("Se crea el LockPix de precio", function (this: CustomWorld) {
  expect(this.response.body).to.be.an("object");

  const body = this.response.body;

  expect(body).to.have.property("code").that.is.a("string");
  expect(body).to.have.property("companyId").that.is.a("string");
  expect(body).to.have.property("userId").that.is.a("string");
  expect(body).to.have.property("userNumberId").that.is.a("string");
  if (body.hasOwnProperty("userExternalId"))
    expect(body.userExternalId).to.be.a("string");
  expect(body).to.have.property("paymentRecipientName").that.is.a("string");
  expect(body).to.have.property("paymentRecipientLegalId").that.is.a("string");
  expect(body).to.have.property("paymentAssetAmount").that.is.a("string");
  expect(body).to.have.property("paymentAsset").that.is.a("string");
  expect(body).to.have.property("paymentPrice").that.is.a("string");
  expect(body).to.have.property("paymentAgainstAmount").that.is.a("string");
  expect(body).to.have.property("expireAt").that.is.a("string");
  expect(body).to.have.property("creationTime").that.is.a("string");
});

Then("Se crea el sintetico de pago", function (this: CustomWorld) {
  expect(this.response.body).to.be.an("object");
  // expect(this.response.body.stages).to.be.an("array").that.is.not.empty;
});
