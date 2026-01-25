const fs = require('fs');
const path = require('path');
const { setWorldConstructor, World } = require('@cucumber/cucumber');
const { v4: uuidv4 } = require('uuid');

export interface UserData {
  userAnyId?: string;
  against?: string;
  [key: string]: any;
}

export class CustomWorld extends World {
  apiKey: string = '';
  apiSecret: string = '';
  token: string = '';
  urlBase: string = '';
  userData: UserData = {} as UserData;
  response: any = null;

  private static storeData: {
    session: { [key: string]: any };
    persistent: { [key: string]: any };
  } = { session: {}, persistent: {} };

  private static sessionCounterFile = path.join(__dirname, '.sessionCounter');
  private static hashCryptoFile = path.join(__dirname, '.hashCrypto');
  private static externalIdFile = path.join(__dirname, '.externalId');
  private static sessionCounter: number = 0;
  private static hashCrypto: number = 0;
  private static extIdCounter: number = 0;
  private static networkId: string = uuidv4();

  static {
    try {
      if (fs.existsSync(this.sessionCounterFile)) {
        this.sessionCounter = parseInt(fs.readFileSync(this.sessionCounterFile, 'utf-8') || 0);
      }
    } catch (error) {
      console.error('Error loading session counter:', error);
    }
  }

  static {
    try {
      if (fs.existsSync(this.hashCryptoFile)) {
        this.hashCrypto = parseInt(fs.readFileSync(this.hashCryptoFile, 'utf-8') || 0);
      }
    } catch (error) {
      console.error('Error loading hashCrypto counter:', error);
    }
  }

  static {
    try {
      if (fs.existsSync(this.externalIdFile)) {
        this.extIdCounter = parseInt(fs.readFileSync(this.externalIdFile, 'utf-8') || 0);
      }
    } catch (error) {
      console.error('Error loading externalId counter:', error);
    }
  }

  static getSessionId(value: string): string {
    this.sessionCounter++;
    fs.writeFileSync(this.sessionCounterFile, this.sessionCounter.toString());
    return `${value}-${this.sessionCounter}`;
  }

  static getHashCrypto(): string {
    this.hashCrypto++;
    fs.writeFileSync(this.hashCryptoFile, this.hashCrypto.toString());
    return `automation-test-${this.hashCrypto}`;
  }

  static getExternalId(value: string): string {
    if (value === 'integrations') return value;
    this.extIdCounter++;
    fs.writeFileSync(this.externalIdFile, this.extIdCounter.toString());
    return `${value}-${this.extIdCounter}`;
  }

  static getNetworkId(): string {
    this.networkId = uuidv4();
    return this.networkId;
  }

  static setStoreData(key: string, value: any, persistent = false): void {
    if (persistent) {
      CustomWorld.storeData.persistent[key] = value;
    } else {
      CustomWorld.storeData.session[key] = value;
    }
  }

  static getStoreData(key: string): any {
    return CustomWorld.storeData.session[key] ?? CustomWorld.storeData.persistent[key];
  }

  static clearStoreData(clearPersistent = false): void {
    CustomWorld.storeData.session = {};
    if (clearPersistent) {
      CustomWorld.storeData.persistent = {};
    }
  }

  // static getUserData(key: string): any {
  //   return CustomWorld.getUserData(key);
  // }

  setUserData(key: keyof UserData | string, value: any): void {
    if (!this.userData) {
      this.userData = {} as UserData;
    }
    this.userData[key] = value;
  }

  getUserData<T = any>(key: keyof UserData | string): T {
    return this.userData?.[key];
  }
}

setWorldConstructor(CustomWorld);
