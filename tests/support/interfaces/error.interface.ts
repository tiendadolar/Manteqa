export interface ErrorResponse {
  internalStatus: string;
  message: string;
  errors?: string[];
}

export const isErrorResponse = (obj: any): obj is ErrorResponse => {
  return obj && typeof obj.internalStatus === 'string' && typeof obj.message === 'string' && (obj.errors === undefined || Array.isArray(obj.errors));
};
