const { Given, When, Then, Before } = require("@cucumber/cucumber");
const { expect } = require("chai");
const request = require("supertest");
const fs = require("fs");
const path = require("path");
import { pepInfoCrypto } from "../../../../support/utils/utils";
import { CustomWorld, UserData } from "../../../../support/world";

Before({ tags: "@Onboarding" }, function () {
  console.log("Ejecutando steps para onboarding");
});

Then(
  "Execute the PUT method on the endpoint",
  { timeout: 50 * 1000 },
  async function (this: CustomWorld) {
    const imagePath = path.join(__dirname, "../../../../../images/pic2.png");
    const imageBuffer = fs.readFileSync(imagePath);
    let url = "";

    if (CustomWorld.getStoreData("awsUrl") !== undefined) {
      url = CustomWorld.getStoreData("awsUrl") || "";
    }

    try {
      this.response = await request(url)
        .put("")
        .set("Content-Type", "image/png")
        // .send(this.userData)
        .send(imageBuffer);
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
  "Execute the PUT method on the endpoint {string}",
  async function (this: CustomWorld, endpoint: string) {
    let paramEndpoint = endpoint;

    if (
      CustomWorld.getStoreData("userId") !== undefined &&
      endpoint === "/v1/documentation/{userId}/pep"
    ) {
      paramEndpoint = paramEndpoint.replace(
        "{userId}",
        CustomWorld.getStoreData("userId") || ""
      );
      // this.userData = {};
      this.userData = pepInfoCrypto(this.userData);
    }

    try {
      console.log(paramEndpoint);

      console.log("User Data:", this.userData);
      this.response = await request(this.urlBase)
        .put(paramEndpoint)
        .set("md-api-key", this.apiKey)
        // .set("x-api-secret", this.apiSecret)
        // .set("x-access-token", this.token)
        .send(this.userData);
      console.log("API response:", this.response.body);
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

// Then(
//   "Obtain a response {int} y el userId",
//   function t(this: CustomWorld, statusCode: number) {
//     expect(this.response.status).to.equal(statusCode);

//     if (this.response.body.userId) {
//       CustomWorld.setStoreData("userId", this.response.body.userId);
//       console.log(CustomWorld.getStoreData("userId"));
//     }
//   }
// );

Then("The user is created", function (this: CustomWorld) {
  const response: any = this.response;
  const body: any = response.body;
  const expectedCurrencies = [
    "ARS",
    "USD",
    "CLP",
    "COP",
    "BRL",
    "GTQ",
    "CRC",
    "PUSD",
    "MXN",
    "PHP",
  ];
  const actualCurrencies = Object.keys(body.bankAccounts);

  expect(this.response.body).to.be.an("object");

  expect(body.numberId).to.be.a("string").and.not.empty;

  expect(body.email).to.be.a("string").and.not.empty;
  expect(body.email).to.match(/^[^\s@]+@[^\s@]+\.[^\s@]+$/);

  expect(body.cuit).to.be.a("string").and.not.empty;
  expect(body.cuit).to.have.lengthOf(11);
  expect(body.cuit).to.match(/^\d{11}$/);

  expect(body.country).to.be.a("string").and.not.empty;

  expect(body.phoneNumber).to.be.a("string").and.not.empty;
  expect(body.phoneNumber).to.match(/^\d+$/);

  expect(body.civilState).to.be.a("string").and.not.empty;
  expect(body.civilState).to.be.oneOf([
    "soltero",
    "casado",
    "divorciado",
    "viudo",
  ]);

  expect(body.name).to.be.a("string").and.not.empty;

  expect(body.creationTime).to.be.a("string").and.not.empty;
  expect(body.creationTime).to.match(
    /^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}Z$/
  );

  expect(body.bankAccounts).to.be.an("object").and.not.empty;

  expect(actualCurrencies).to.have.members(expectedCurrencies);

  expect(body.balance).to.be.an("object").and.not.empty;

  expect(body.balance && body.lockedBalance).to.have.property("fiat");
  expect(body.balance && body.lockedBalance).to.have.property("crypto");
  expect(Object.keys(body.balance)).to.have.members(["fiat", "crypto"]);
  expect(Object.keys(body.balance)).to.have.lengthOf(2);
  expect(Object.keys(body.lockedBalance)).to.have.members(["fiat", "crypto"]);
  expect(Object.keys(body.lockedBalance)).to.have.lengthOf(2);

  expect(body.balance.fiat).to.be.an("object");
  expect(body.balance.crypto).to.be.an("object");

  // expect(body.addresses).to.be.an("object").and.not.empty;

  // expect(body.addresses).to.have.property("evm");
  // expect(body.addresses).to.have.property("terra");
  // expect(Object.keys(body.addresses)).to.have.members(["evm", "terra"]);
  // expect(Object.keys(body.addresses)).to.have.lengthOf(2);

  // expect(body.addresses.evm).to.be.a("string");
  // expect(body.addresses.terra).to.be.a("string");

  // if (body.addresses.evm && body.addresses.evm !== "") {
  //   expect(body.addresses.evm).to.match(/^0x[a-fA-F0-9]{40}$/);
  // }

  // if (body.addresses.terra && body.addresses.terra !== "") {
  //   expect(body.addresses.terra).to.match(/^terra[a-z0-9]{39}$/);
  // }
});

Then("The bank account is added", function (this: CustomWorld) {
  expect(this.response.body).to.be.an("object");
});

Then(
  "The error is received {string}",
  async function (this: CustomWorld, value: string) {
    this.userData["mensaje"] = value;
    const response: any = this.response;
    const body: any = response.body;

    expect(response.status).to.equal(400);

    expect(body.internalStatus).to.be.equal("BAD_REQUEST").and.not.empty;
    expect(body.message).to.be.a("string").and.not.empty;
    expect(body.errors).to.be.an("array").and.not.empty;
    expect(body.errors[0]).to.be.a("string").and.not.empty;
    console.log(this.userData["mensaje"]);
  }
);
