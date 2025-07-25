const { Given, When, Then, Before } = require("@cucumber/cucumber");
const { expect } = require("chai");
const request = require("supertest");
import { CustomWorld, UserData } from "../../../../support/world";

Then("The lock-price is created", function (this: CustomWorld) {
  const response = this.response; // Asegúrate que guardaste la respuesta en this.response
  expect(response).to.not.be.undefined;

  const { code, side, asset, price, effectivePrice, expireSeconds } =
    response.body;

  const priceFloat = parseFloat(price);
  const effectivePriceFloat = parseFloat(effectivePrice);

  if (side === "BUY" && asset === "USD")
    expect(effectivePriceFloat).to.be.at.least(priceFloat);

  if (side === "SELL" && asset === "USD")
    expect(priceFloat).to.be.at.least(effectivePriceFloat);

  expect(
    typeof response.code === "string" && response.code.trim().length > 0
  ).toBe(true);
  expect(expireSeconds).to.be.equal(10);
});
