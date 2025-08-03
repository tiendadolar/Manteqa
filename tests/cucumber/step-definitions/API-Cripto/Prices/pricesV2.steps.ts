const { Given, When, Then, Before } = require('@cucumber/cucumber');
const { expect } = require('chai');
const request = require('supertest');
import { getTickerInfo } from '../../../../support/utils/ticker.utils';
import { getParPrices } from '../../../../support/utils/utils';
import { CustomWorld, UserData } from '../../../../support/world';

Then('Obtain correct price network', async function (this: CustomWorld) {
  const response: any = this.response;
  const body: any = response.body;
  const ticker: string = body.ticker;
  const parseCrypto: string = getTickerInfo(ticker).parseCrypto;
  const parseFiat: string = getTickerInfo(ticker).parseFiat;

  if (parseFiat !== 'bob') {
    const result = await getParPrices(parseCrypto);

    const mantecaBuyPrice = body.buy;
    const mantecaSellPrice = body.sell;
    // price geckoCoin
    const network = Object.keys(result)[0];
    const price = result[network][parseFiat];
    // price geckoCoin
    const variationBuyAceptance = price * 1.115;
    const variationSellAceptance = price * 0.885;

    if (mantecaBuyPrice > variationBuyAceptance || mantecaSellPrice < variationSellAceptance) {
      console.log('The price is not within the acceptable range');
      console.log(`Buy Price: ${mantecaBuyPrice}, Sell Price: ${mantecaSellPrice}, Network Price: ${network}`);
      expect.fail(`Buy Price: ${mantecaBuyPrice}, Sell Price: ${mantecaSellPrice}, Network Price: ${network}`);
    }

    //   const body = this.response?.body;

    // Nivel raíz
    expect(body).to.have.property('ticker').that.is.a('string').and.not.empty;
    expect(body).to.have.property('buy').that.is.a('string').and.not.empty;
    expect(body).to.have.property('sell').that.is.a('string').and.not.empty;
    expect(body).to.have.property('timestamp').that.is.a('string').and.not.empty;
    expect(body).to.have.property('effectiveBuy').that.is.a('string').and.not.empty;
    expect(body).to.have.property('effectiveSell').that.is.a('string').and.not.empty;

    // Variación
    expect(body).to.have.property('variation').that.is.an('object');

    // Variación buy
    expect(body.variation).to.have.property('buy').that.is.an('object');
    expect(body.variation.buy).to.have.property('realtime').that.is.a('string').and.not.empty;
    expect(body.variation.buy).to.have.property('daily').that.is.a('string').and.not.empty;

    // Variación sell
    expect(body.variation).to.have.property('sell').that.is.an('object');
    expect(body.variation.sell).to.have.property('realtime').that.is.a('string').and.not.empty;
    expect(body.variation.sell).to.have.property('daily').that.is.a('string').and.not.empty;
  } else {
    // Nivel raíz
    expect(body).to.have.property('ticker').that.is.a('string').and.not.empty;
    expect(body).to.have.property('buy').that.is.a('string').and.not.empty;
    expect(body).to.have.property('sell').that.is.a('string').and.not.empty;
    expect(body).to.have.property('timestamp').that.is.a('string').and.not.empty;
    expect(body).to.have.property('effectiveBuy').that.is.a('string').and.not.empty;
    expect(body).to.have.property('effectiveSell').that.is.a('string').and.not.empty;

    // Variación
    expect(body).to.have.property('variation').that.is.an('object');

    // Variación buy
    expect(body.variation).to.have.property('buy').that.is.an('object');
    expect(body.variation.buy).to.have.property('realtime').that.is.a('string').and.not.empty;
    expect(body.variation.buy).to.have.property('daily').that.is.a('string').and.not.empty;

    // Variación sell
    expect(body.variation).to.have.property('sell').that.is.an('object');
    expect(body.variation.sell).to.have.property('realtime').that.is.a('string').and.not.empty;
    expect(body.variation.sell).to.have.property('daily').that.is.a('string').and.not.empty;
  }
});
