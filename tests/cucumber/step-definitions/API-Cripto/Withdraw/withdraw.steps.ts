const { Given, When, Then, Before } = require("@cucumber/cucumber");
const { expect } = require("chai");
const request = require("supertest");
import { CustomWorld, UserData } from "../../../../support/world";

Then(
  "Se validan atributos para lock de retiro crypto",
  async function (this: CustomWorld) {
    const response = this.response?.body;
    const result = response.result;
    const chain = response.chain;
    const ticker = response.ticker;
    const code = response.code;
    const expires = response.expires;

    expect(response).to.have.property("result").that.is.an("object");
    expect(result).to.have.property("gasUsed").that.is.a("string").and.not
      .empty;
    expect(result).to.have.property("feeInUSD").that.is.a("string").and.not
      .empty;
    expect(result).to.have.property("feeInNative").that.is.a("string").and.not
      .empty;
    expect(result).to.have.property("priceOfNative").that.is.a("string").and.not
      .empty;
    expect(result).to.have.property("wait").that.is.a("string").and.not.empty;
    expect(result).to.have.property("feeInRequestedCoin").that.is.a("string")
      .and.not.empty;

    //   expect(chain).that.is.a("number").and.not.empty;

    expect(ticker).that.is.a("string").and.not.empty;

    expect(code).that.is.a("string").and.not.empty;

    expect(expires).that.is.a("string").and.not.empty;
  }
);

Then(
  "Se obtiene una respuesta {int} y status EXECUTED",
  function (this: CustomWorld, statusCode: number) {
    const response: any = this.response;
    const body: any = response.body;

    expect(this.response.status).to.equal(statusCode);
    expect(body.status).to.equal("EXECUTED");
  }
);

Then(
  "Se obtiene una respuesta {int} y status EXECUTED para retiro fiat",
  function (this: CustomWorld, statusCode: number) {
    const response: any = this.response;
    const body: any = response.body;

    expect(this.response.status).to.equal(statusCode);
    expect(body.status).to.be.oneOf(["EXECUTED", "PENDING"]);
  }
);
