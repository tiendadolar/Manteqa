const { Given, When, Then, Before } = require('@cucumber/cucumber');
const { expect } = require('chai');
const request = require('supertest');
import logger from '../../../../support/utils/logger';
import { checkActivities } from '../../../../support/validators/activitiesValidators';
import { CustomWorld, UserData } from '../../../../support/world';

Then('Validate entries for activity {string}', { timeout: 125000 }, async function (this: CustomWorld, activity: string) {
  const response = this.response.body;
  const data = response.data;

  checkActivities(data, activity);
});
