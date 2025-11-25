import { expect } from 'chai';
import logger from '../utils/logger';
import { CustomWorld } from '../world';
import { ErrorResponse, isErrorResponse } from '../interfaces/error.interface';

export class ErrorResponseValidator {
  static validateErrorResponse(response: any, internalStatus: string, message: string, errors?: string): ErrorResponse {
    expect(response).to.exist;
    expect(response).to.be.an('object');

    if (!isErrorResponse(response)) {
      throw new Error('Response does not match ErrorResponse interface');
    }

    this.validateErrorFields(response);
    this.validateErrorinfo(response, internalStatus, message, errors);

    return response as ErrorResponse;
  }

  private static validateErrorFields(response: ErrorResponse): void {
    expect(response.internalStatus).to.be.a('string').and.not.empty;
    expect(response.message).to.be.a('string').and.not.empty;
    if (response.errors) expect(response.errors).to.be.an('array').and.not.empty;
  }

  private static validateErrorinfo(response: ErrorResponse, internalStatus: string, message: string, errors?: string): void {
    expect(response.internalStatus).to.be.equal(internalStatus);
    expect(response.message).to.be.equal(message);
    if (response.errors) expect(response.errors[0]).to.be.equal(errors);
  }
}

export const validateErrorResponse = (response: any, internalStatus: string, message: string, errors?: string): ErrorResponse => {
  return ErrorResponseValidator.validateErrorResponse(response, internalStatus, message, errors);
};
