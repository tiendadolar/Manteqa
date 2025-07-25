const { Given, When, Then, Before } = require("@cucumber/cucumber");
const { expect } = require("chai");
const request = require("supertest");
import { CustomWorld, UserData } from "../../../../support/world";
import {
  refundPollingWithDeposit,
  refundsPolling,
} from "../../../../support/utils";

Then(
  "The attributes of the QR USDT synthetic are validated",
  async function (this: CustomWorld) {
    const response: any = this.response;
    const body: any = response.body;
    const details: any = response.body.details;

    expect(details.paymentAgainstAsset).equal("USDT");
    // expect(body.stages).lengthOf;
  }
);

Then(
  "The attributes of the QR ARS synthetic are validated",
  async function (this: CustomWorld) {
    const response: any = this.response;
    const body: any = response.body;
    const details: any = response.body.details;

    expect(details.paymentAgainstAsset).equal("ARS");
    // expect(body.currentStage).equal(1);
  }
);

Then(
  "Execute the refund synthetic {string}",
  { timeout: 500 * 1000 },
  async function (this: CustomWorld, flag: string) {
    try {
      if (flag === "descubierto")
        this.response = await refundsPolling(this, this.userData);
      if (flag === "no descubierto")
        this.response = await refundPollingWithDeposit(this, this.userData);
    } catch (error: any) {
      // if (error.response) {
      //   this.attach(`API Error Response: ${JSON.stringify(error.response.body || error.response.text || {}, null, 2)}`, 'text/plain');
      //   this.response = error.response;
      // }
      // throw error;
    }
  }
);

Then(
  "Obtain a response {int} y status {string}",
  { timeout: 500 * 1000 },
  async function (this: CustomWorld, statusCode: number, statusName: string) {
    const response = this.response;
    console.log(`Response Status: ${response.status}`);

    expect(response.status).to.equal(statusCode);
    // expect(response.body.status).to.equal(statusName);
    expect(
      response.body.status === statusName ||
        response.body.stages[2].withdrawId !== null
    ).to.be.true;
  }
);
