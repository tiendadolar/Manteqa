export interface EndpointHandler {
  canHandle(endpoint: string, userData?: any): boolean;
  handle(userData: any, world?: any): any;
  modifyEndpoint?(endpoint: string, world: any): string;
}
