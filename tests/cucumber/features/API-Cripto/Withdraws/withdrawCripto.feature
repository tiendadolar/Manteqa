@Withdraw
Feature: Retiros Crypto

    @Regression @LockCode @Automated
    Scenario Outline: Crear lock de retiro crypto
        Given The API key is available "BM2YZT6-MR5M5YY-QYZ5CY4-E8E9HYB"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<coin>" to the variable "coin"
        And Assign the value "<userId>" to the variable "userId"
        And Assign the value "<chain>" to the variable "chain"
        And Execute the POST method on the endpoint "/v1/transaction/withdraw/lock"
        Then Obtain a response 200
        And Attributes for the crypto withdrawal lock are validated

        Examples:
            | coin  | userId    | chain    |
            | USDT  | 100007647 | POLYGON  |
            | USDC  | 100007647 | POLYGON  |
            | POL   | 100007647 | POLYGON  |
            | DAI   | 100007647 | BSC      |
            | BNB   | 100007647 | BSC      |
            | ETH   | 100007647 | BSC      |
            | BTC   | 100007647 | BSC      |
            | SOL   | 100007647 | BSC      |
            | USDT  | 100007647 | BSC      |
            | USDC  | 100007647 | BSC      |
            | USDC  | 100007647 | OPTIMISM |
            | USDCB | 100007647 | OPTIMISM |
            | WLD   | 100007647 | OPTIMISM |
            | USDC  | 100007647 | ARBITRUM |
            | USDT  | 100007647 | ARBITRUM |


    @Smoke @Crypto @V1 @Automated
    Scenario Outline: Ejecutar retiro crypto de <coin> mediante <chain> por V1 endpoints
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<coin>" to the variable "coin"
        And Assign the value "<userId>" to the variable "userId"
        And Assign the value "<chain>" to the variable "chain"
        And Execute the POST method on the endpoint "/v1/transaction/withdraw/lock"
        Then Obtain a response 200

        When Assign the value "<coin>" to the variable "coin"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<wallet>" to the variable "to"
        And Assign the value "<chain>" to the variable "chain"
        And Assign the value "<userId>" to the variable "userId"
        And Assign the value "code" to the variable "costCode"
        And Execute the POST method on the endpoint "/v1/transaction/withdraw"
        Then Obtain a response 200

        # Parte 2: Validar ejeccución del sintético
        When Wait for the processing of the "orden" por 40 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED

        # Polygon has nonce number faileds so it can generate failed withdraws
        Examples:
            | companyId                | coin | userId    | chain      | amount | wallet                                     |
            | 67e56fea17c2cfbcc92efaab | WLD  | 100007647 | WORLDCHAIN | 3      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | 67e56fea17c2cfbcc92efaab | USDT | 100007647 | POLYGON    | 3      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            # |67e56fea17c2cfbcc92efaab| USDT | 100007647 | BSC        | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA | No working Binance Provider QA
            # |67e56fea17c2cfbcc92efaab| USDT | 100007647 | ARBITRUM   | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA | No working Binance Provider QA
            | 67e56fea17c2cfbcc92efaab | USDT | 100007647 | ETHEREUM   | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            #|67e56fea17c2cfbcc92efaab | DAI  | 100007647 | BSC        | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA | No working Binance Provider QA
            #| 67e56fea17c2cfbcc92efaab| ETH  | 100007647 | BSC        | 0.001  | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA | No working Binance Provider QA
            #|67e56fea17c2cfbcc92efaab | ETH  | 100007647 | ETHEREUM   | 0.001  | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            #|67e56fea17c2cfbcc92efaab | BNB  | 100007647 | BSC        | 0.001  | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA | No working Binance Provider QA
            #|67e56fea17c2cfbcc92efaab | BTC  | 100007647 | BSC        | 0.001  | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA | No working Binance Provider QA
            | 67e56fea17c2cfbcc92efaab | POL  | 100007647 | POLYGON    | 2      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            #| 67e56fea17c2cfbcc92efaab| USDC | 100007647 | POLYGON    | 5      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA | No Funds in hot wallet Argentina
            # |67e56fea17c2cfbcc92efaab| USDC | 100007647 | BSC        | 5      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA | No working Binance Provider QA
            | 67e56fea17c2cfbcc92efaab | USDC | 100007647 | OPTIMISM   | 2      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
    # |67e56fea17c2cfbcc92efaab| USDC | 100007647 | ARBITRUM   | 5      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA | No working Binance Provider QA

    @Smoke @Crypto @V1 @Bind @Automated
    Scenario Outline: Ejecutar retiro BIND crypto de <coin> mediante <chain> por V1 endpoints
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<coin>" to the variable "coin"
        And Assign the value "<userId>" to the variable "userId"
        And Assign the value "<chain>" to the variable "chain"
        And Execute the POST method on the endpoint "/v1/transaction/withdraw/lock"
        Then Obtain a response 200

        When Assign the value "<coin>" to the variable "coin"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<wallet>" to the variable "to"
        And Assign the value "<chain>" to the variable "chain"
        And Assign the value "<userId>" to the variable "userId"
        And Assign the value "code" to the variable "costCode"
        And Execute the POST method on the endpoint "/v1/transaction/withdraw"
        Then Obtain a response 200

        When Wait for the processing of the "orden" por 40 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED

        Examples:
            | companyId                | coin | userId    | chain    | amount | wallet                                     |
            | 69addea7aa541dac7566fd9a | USDC | 100062359 | INTERNAL | 5      | 0x6BDfB5d3cc79f65e102d52F98d0724be446977B1 |
            | 69addea7aa541dac7566fd9a | USDT | 100062359 | INTERNAL | 5      | 0x6BDfB5d3cc79f65e102d52F98d0724be446977B1 |
            | 69addea7aa541dac7566fd9a | USDC | 100060231 | INTERNAL | 5      | 0x6856355786A7183Ff12A0a6d9a097a670a039fE7 |
            | 69addea7aa541dac7566fd9a | USDT | 100060231 | INTERNAL | 5      | 0x6856355786A7183Ff12A0a6d9a097a670a039fE7 |

    @Regression @Crypto @ARG @V1 @Automated
    Scenario Outline: Ejecutar retiro crypto de <coin> mediante <chain> para user ARG por V1
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<coin>" to the variable "coin"
        And Assign the value "<userId>" to the variable "userId"
        And Assign the value "<chain>" to the variable "chain"
        And Execute the POST method on the endpoint "/v1/transaction/withdraw/lock"
        Then Obtain a response 200

        When Assign the value "<coin>" to the variable "coin"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<wallet>" to the variable "to"
        And Assign the value "<chain>" to the variable "chain"
        And Assign the value "<userId>" to the variable "userId"
        And Assign the value "code" to the variable "costCode"
        And Execute the POST method on the endpoint "/v1/transaction/withdraw"
        Then Obtain a response 200

        # Parte 2: Validar ejeccución del sintético
        When Wait for the processing of the "orden" por 40 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED

        @WLD
        Examples:
            | companyId                | coin | userId    | chain      | amount | wallet                                     |
            | 6864a82d08430ed74bf6296f | WLD  | 100009893 | WORLDCHAIN | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
        #| | WLD  | 100009893 | OPTIMISM   | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | No funds in hot wallet Argentina

        @Working
        Examples:
            | companyId                | coin | userId    | chain    | amount | wallet                                     |
            | 6864a82d08430ed74bf6296f | USDT | 100009893 | POLYGON  | 3      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            #| 6864a82d08430ed74bf6296f| USDT | 100009893 | BINANCE  | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA | No working Binance Provider QA
            | 6864a82d08430ed74bf6296f | USDT | 100009893 | ETHEREUM | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | 6864a82d08430ed74bf6296f | USDC | 100009893 | OPTIMISM | 2      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |


    @Regression @Crypto @CHL @V1 @Automated
    Scenario Outline: Ejecutar retiro crypto de <coin> mediante <chain> para user CHL por V1
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<coin>" to the variable "coin"
        And Assign the value "<userId>" to the variable "userId"
        And Assign the value "<chain>" to the variable "chain"
        And Execute the POST method on the endpoint "/v1/transaction/withdraw/lock"
        Then Obtain a response 200

        When Assign the value "<coin>" to the variable "coin"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<wallet>" to the variable "to"
        And Assign the value "<chain>" to the variable "chain"
        And Assign the value "<userId>" to the variable "userId"
        And Assign the value "code" to the variable "costCode"
        And Execute the POST method on the endpoint "/v1/transaction/withdraw"
        Then Obtain a response 200

        # Parte 2: Validar ejeccución del sintético
        When Wait for the processing of the "orden" por 40 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED

        @WLD
        Examples:
            | companyId                | coin | userId    | chain      | amount | wallet                                     |
            | 6864a82d08430ed74bf6296f | WLD  | 100009892 | WORLDCHAIN | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | 6864a82d08430ed74bf6296f | WLD  | 100009892 | OPTIMISM   | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @NoFundsAvailableInHotWallet
        Examples:
            | companyId                | coin | userId    | chain    | amount | wallet                                     |
            | 6864a82d08430ed74bf6296f | USDT | 100009892 | POLYGON  | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | 6864a82d08430ed74bf6296f | USDT | 100009892 | BINANCE  | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | 6864a82d08430ed74bf6296f | USDT | 100009892 | ETHEREUM | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | 6864a82d08430ed74bf6296f | USDC | 100009892 | OPTIMISM | 5      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |

    @Regression @Crypto @COL @V1 @Automated
    Scenario Outline: Ejecutar retiro crypto de <coin> mediante <chain> para user COL por V1
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<coin>" to the variable "coin"
        And Assign the value "<userId>" to the variable "userId"
        And Assign the value "<chain>" to the variable "chain"
        And Execute the POST method on the endpoint "/v1/transaction/withdraw/lock"
        Then Obtain a response 200

        When Assign the value "<coin>" to the variable "coin"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<wallet>" to the variable "to"
        And Assign the value "<chain>" to the variable "chain"
        And Assign the value "<userId>" to the variable "userId"
        And Assign the value "code" to the variable "costCode"
        And Execute the POST method on the endpoint "/v1/transaction/withdraw"
        Then Obtain a response 200

        # Parte 2: Validar ejeccución del sintético
        When Wait for the processing of the "orden" por 40 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED

        @WLD
        Examples:
            | companyId                | coin | userId    | chain      | amount | wallet                                     |
            | 6864a82d08430ed74bf6296f | WLD  | 100009891 | WORLDCHAIN | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @NoFundsAvailableInHotWallet
        Examples:
            | companyId                | coin | userId    | chain    | amount | wallet                                     |
            | 6864a82d08430ed74bf6296f | USDT | 100009891 | POLYGON  | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | 6864a82d08430ed74bf6296f | USDT | 100009891 | BINANCE  | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | 6864a82d08430ed74bf6296f | USDT | 100009891 | ETHEREUM | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | 6864a82d08430ed74bf6296f | USDC | 100009891 | OPTIMISM | 5      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |

    @Regression @Crypto @MXN @V1 @Automated
    Scenario Outline: Ejecutar retiro crypto de <coin> mediante <chain> para user MXN por V1
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<coin>" to the variable "coin"
        And Assign the value "<userId>" to the variable "userId"
        And Assign the value "<chain>" to the variable "chain"
        And Execute the POST method on the endpoint "/v1/transaction/withdraw/lock"
        Then Obtain a response 200

        When Assign the value "<coin>" to the variable "coin"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<wallet>" to the variable "to"
        And Assign the value "<chain>" to the variable "chain"
        And Assign the value "<userId>" to the variable "userId"
        And Assign the value "code" to the variable "costCode"
        And Execute the POST method on the endpoint "/v1/transaction/withdraw"
        Then Obtain a response 200

        # Parte 2: Validar ejeccución del sintético
        When Wait for the processing of the "orden" por 60 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED

        @WLD
        Examples:
            | companyId                | coin | userId    | chain      | amount | wallet                                     |
            | 6864a82d08430ed74bf6296f | WLD  | 100009889 | WORLDCHAIN | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @NoFundsAvailableInHotWallet
        Examples:
            | companyId                | coin | userId    | chain    | amount | wallet                                     |
            | 6864a82d08430ed74bf6296f | USDT | 100009889 | POLYGON  | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | 6864a82d08430ed74bf6296f | USDT | 100009889 | BINANCE  | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | 6864a82d08430ed74bf6296f | USDT | 100009889 | ETHEREUM | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | 6864a82d08430ed74bf6296f | USDC | 100009889 | OPTIMISM | 5      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |

    @Regression @Crypto @PAN @V1 @Automated
    Scenario Outline: Ejecutar retiro crypto de <coin> mediante <chain> para user PAN por V1
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<coin>" to the variable "coin"
        And Assign the value "<userId>" to the variable "userId"
        And Assign the value "<chain>" to the variable "chain"
        And Execute the POST method on the endpoint "/v1/transaction/withdraw/lock"
        Then Obtain a response 200

        When Assign the value "<coin>" to the variable "coin"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<wallet>" to the variable "to"
        And Assign the value "<chain>" to the variable "chain"
        And Assign the value "<userId>" to the variable "userId"
        And Assign the value "code" to the variable "costCode"
        And Execute the POST method on the endpoint "/v1/transaction/withdraw"
        Then Obtain a response 200

        # Parte 2: Validar ejeccución del sintético
        When Wait for the processing of the "orden" por 60 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED

        @WLD
        Examples:
            | companyId | coin | userId    | chain      | amount | wallet                                     |
            |           | WLD  | 100009887 | WORLDCHAIN | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @NoFundsAvailableInHotWallet
        Examples:
            | companyId                | coin | userId    | chain    | amount | wallet                                     |
            | 6864a82d08430ed74bf6296f | USDT | 100009887 | POLYGON  | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | 6864a82d08430ed74bf6296f | USDT | 100009887 | BINANCE  | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | 6864a82d08430ed74bf6296f | USDT | 100009887 | ETHEREUM | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | 6864a82d08430ed74bf6296f | USDC | 100009887 | OPTIMISM | 5      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |

    @Regression @Crypto @GTQ @V1 @Automated
    Scenario Outline: Ejecutar retiro crypto de <coin> mediante <chain> para user GTQ por V1
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<coin>" to the variable "coin"
        And Assign the value "<userId>" to the variable "userId"
        And Assign the value "<chain>" to the variable "chain"
        And Execute the POST method on the endpoint "/v1/transaction/withdraw/lock"
        Then Obtain a response 200

        When Assign the value "<coin>" to the variable "coin"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<wallet>" to the variable "to"
        And Assign the value "<chain>" to the variable "chain"
        And Assign the value "<userId>" to the variable "userId"
        And Assign the value "code" to the variable "costCode"
        And Execute the POST method on the endpoint "/v1/transaction/withdraw"
        Then Obtain a response 200

        # Parte 2: Validar ejeccución del sintético
        When Wait for the processing of the "orden" por 60 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED

        @WLD
        Examples:
            | companyId                | coin | userId    | chain      | amount | wallet                                     |
            | 6864a82d08430ed74bf6296f | WLD  | 100009886 | WORLDCHAIN | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @NoFundsAvailableInHotWallet
        Examples:
            | companyId                | coin | userId    | chain    | amount | wallet                                     |
            | 6864a82d08430ed74bf6296f | USDT | 100009886 | POLYGON  | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | 6864a82d08430ed74bf6296f | USDT | 100009886 | BINANCE  | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | 6864a82d08430ed74bf6296f | USDT | 100009886 | ETHEREUM | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | 6864a82d08430ed74bf6296f | USDC | 100009886 | OPTIMISM | 5      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |

    @Regression @Crypto @PHP @V1 @Automated
    Scenario Outline: Ejecutar retiro crypto de <coin> mediante <chain> para user PHP por V1
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<coin>" to the variable "coin"
        And Assign the value "<userId>" to the variable "userId"
        And Assign the value "<chain>" to the variable "chain"
        And Execute the POST method on the endpoint "/v1/transaction/withdraw/lock"
        Then Obtain a response 200

        When Assign the value "<coin>" to the variable "coin"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<wallet>" to the variable "to"
        And Assign the value "<chain>" to the variable "chain"
        And Assign the value "<userId>" to the variable "userId"
        And Assign the value "code" to the variable "costCode"
        And Execute the POST method on the endpoint "/v1/transaction/withdraw"
        Then Obtain a response 200

        # Parte 2: Validar ejeccución del sintético
        When Wait for the processing of the "orden" por 60 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED

        @WLD
        Examples:
            | companyId                | coin | userId    | chain      | amount | wallet                                     |
            | 6864a82d08430ed74bf6296f | WLD  | 100009885 | WORLDCHAIN | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @NoFundsAvailableInHotWallet
        Examples:
            | companyId                | coin | userId    | chain    | amount | wallet                                     |
            | 6864a82d08430ed74bf6296f | USDT | 100009885 | POLYGON  | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | 6864a82d08430ed74bf6296f | USDT | 100009885 | BINANCE  | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | 6864a82d08430ed74bf6296f | USDT | 100009885 | ETHEREUM | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | 6864a82d08430ed74bf6296f | USDC | 100009885 | OPTIMISM | 5      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |

    @Regression @Crypto @BRA @V1 @Automated
    Scenario Outline: Ejecutar retiro crypto de <coin> mediante <chain> para user BRA por V1
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<coin>" to the variable "coin"
        And Assign the value "<userId>" to the variable "userId"
        And Assign the value "<chain>" to the variable "chain"
        And Execute the POST method on the endpoint "/v1/transaction/withdraw/lock"
        Then Obtain a response 200

        When Assign the value "<coin>" to the variable "coin"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<wallet>" to the variable "to"
        And Assign the value "<chain>" to the variable "chain"
        And Assign the value "<userId>" to the variable "userId"
        And Assign the value "code" to the variable "costCode"
        And Execute the POST method on the endpoint "/v1/transaction/withdraw"
        Then Obtain a response 200

        # Parte 2: Validar ejeccución del sintético
        When Wait for the processing of the "orden" por 60 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED

        @WLD
        Examples:
            | companyId                | coin | userId    | chain      | amount | wallet                                     |
            | 6864a82d08430ed74bf6296f | WLD  | 100009884 | WORLDCHAIN | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @NoFundsAvailableInHotWallet
        Examples:
            | companyId                | coin | userId    | chain    | amount | wallet                                     |
            | 6864a82d08430ed74bf6296f | USDT | 100009884 | POLYGON  | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | 6864a82d08430ed74bf6296f | USDT | 100009884 | BINANCE  | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | 6864a82d08430ed74bf6296f | USDT | 100009884 | ETHEREUM | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | 6864a82d08430ed74bf6296f | USDC | 100009884 | OPTIMISM | 5      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |

    @Regression @Crypto @PYG @V1 @Automated
    Scenario Outline: Ejecutar retiro crypto de <coin> mediante <chain> para user BRA por V1
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<coin>" to the variable "coin"
        And Assign the value "<userId>" to the variable "userId"
        And Assign the value "<chain>" to the variable "chain"
        And Execute the POST method on the endpoint "/v1/transaction/withdraw/lock"
        Then Obtain a response 200

        When Assign the value "<coin>" to the variable "coin"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<wallet>" to the variable "to"
        And Assign the value "<chain>" to the variable "chain"
        And Assign the value "<userId>" to the variable "userId"
        And Assign the value "code" to the variable "costCode"
        And Execute the POST method on the endpoint "/v1/transaction/withdraw"
        Then Obtain a response 200

        # Parte 2: Validar ejeccución del sintético
        When Wait for the processing of the "orden" por 60 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED

        @WLD
        Examples:
            | companyId                | coin | userId    | chain      | amount | wallet                                     |
            | 6864a82d08430ed74bf6296f | WLD  | 100067281 | WORLDCHAIN | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @NoFundsAvailableInHotWallet
        Examples:
            | companyId                | coin | userId    | chain    | amount | wallet                                     |
            | 6864a82d08430ed74bf6296f | USDT | 100067281 | POLYGON  | 5      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            # | 6864a82d08430ed74bf6296f | USDT | 100067281 | BINANCE  | 5      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | 6864a82d08430ed74bf6296f | USDT | 100067281 | ETHEREUM | 4      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
    # | 6864a82d08430ed74bf6296f | USDC | 100067281 | OPTIMISM | 5      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |


    # ------------- V2 ---------------

    @Smoke @Crypto @V2 @Bind @Automated
    Scenario Outline: Ejecutar retiro <type> de <asset> mediante <network> para user <country> por V2
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<network>" to the variable "network"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<network>" to the variable "network"
        And Assign the value "<address>" to the variable "address"
        And Assign the value "<type>" to the variable "type"
        And Assign the value "<country>" to the variable "country"
        And Execute the POST method on the endpoint "/v2/withdraws"
        Then Obtain a response 201

        When Wait for the processing of the "orden" por 60 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED

        @WLD
        Examples:
            | companyId                | type   | asset | userAnyId | country | network  | amount | address                                    |
            | 69addea7aa541dac7566fd9a | crypto | USDT  | 100062359 | ARG     | INTERNAL | 5      | 0x6BDfB5d3cc79f65e102d52F98d0724be446977B1 |
            | 69addea7aa541dac7566fd9a | crypto | USDC  | 100062359 | ARG     | INTERNAL | 5      | 0x6BDfB5d3cc79f65e102d52F98d0724be446977B1 |
            | 69addea7aa541dac7566fd9a | crypto | USDT  | 100060231 | ARG     | INTERNAL | 5      | 0x6856355786A7183Ff12A0a6d9a097a670a039fE7 |
            | 69addea7aa541dac7566fd9a | crypto | USDC  | 100060231 | ARG     | INTERNAL | 5      | 0x6856355786A7183Ff12A0a6d9a097a670a039fE7 |


    @Smoke @Crypto @ARGv2 @V2 @Automated
    Scenario Outline: Ejecutar retiro <type> de <asset> mediante <network> para user <country> por V2
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<network>" to the variable "network"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<network>" to the variable "network"
        And Assign the value "<address>" to the variable "address"
        And Execute the POST method on the endpoint "/v2/withdraws"
        Then Obtain a response 201
        # Parte 2: Validar ejeccución del sintético
        When Wait for the processing of the "orden" por 60 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED

        @WLD
        Examples:
            | companyId                | type   | asset | userAnyId | country | network    | amount | address                                    |
            | 6864976a08430ed74bf61d0c | crypto | WLD   | 100009873 | ARG     | WORLDCHAIN | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | 6864976a08430ed74bf61d0c | crypto | WLD   | 100009873 | ARG     | OPTIMISM   | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @Working
        Examples:
            | companyId                | type   | asset | userAnyId | country | network  | amount | address                                    |
            | 6864976a08430ed74bf61d0c | crypto | USDT  | 100009873 | ARG     | POLYGON  | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | 6864976a08430ed74bf61d0c | crypto | USDT  | 100009873 | ARG     | ETHEREUM | 4      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            # | 6864976a08430ed74bf61d0c | crypto | USDT  | 100009873 | ARG     | BINANCE  | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | 6864976a08430ed74bf61d0c | crypto | USDC  | 100009873 | ARG     | OPTIMISM | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @TRON
        Examples:
            | companyId                | type   | asset | userAnyId | country | network | amount | address                            |
            | 683cce15397feba125068c9b | crypto | USDT  | 100011214 | ARG     | TRON    | 3      | TBm3cipnHc7HifuBJdh8JM3nwG3LQJ9UQv |


    @Smoke @Crypto @BRLv2 @V2 @Automated
    Scenario Outline: Ejecutar retiro <type> de <asset> mediante <network> para user <country> por V2
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<network>" to the variable "network"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<network>" to the variable "network"
        And Assign the value "<address>" to the variable "address"
        And Execute the POST method on the endpoint "/v2/withdraws"
        Then Obtain a response 201
        # Parte 2: Validar ejeccución del sintético
        When Wait for the processing of the "orden" por 60 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED

        @WLD
        Examples:
            | companyId                | type   | asset | userAnyId | country | network    | amount | address                                    |
            | 683cce15397feba125068c9b | crypto | WLD   | 100011214 | BRA     | WORLDCHAIN | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | 683cce15397feba125068c9b | crypto | WLD   | 100011214 | BRA     | OPTIMISM   | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @Working
        Examples:
            | companyId                | type   | asset | userAnyId | country | network  | amount | address                                    |
            | 683cce15397feba125068c9b | crypto | USDT  | 100011214 | BRA     | POLYGON  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | 683cce15397feba125068c9b | crypto | USDT  | 100011214 | BRA     | ETHEREUM | 4      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            # | 683cce15397feba125068c9b | crypto | USDT  | 100011214 | BRA     | BINANCE  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | 683cce15397feba125068c9b | crypto | USDC  | 100011214 | BRA     | OPTIMISM | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @TRON
        Examples:
            | companyId                | type   | asset | userAnyId | country | network | amount | address                            |
            | 683cce15397feba125068c9b | crypto | USDT  | 100011214 | BRA     | TRON    | 3      | TK87U6EA5Fyq1zLZc9Q6NEeasHtTTRMaLu |

    # Examples:
    #     | type   | asset | userAnyId | country | network    | amount | address                                    |
    #     | crypto | WLD   | 100009873 | ARG     | WORLDCHAIN | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | BNB   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDC  | 100009873 | ARG     | OPTIMISM   | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | BTC   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDT  | 100009873 | ARG     | BINANCE    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDT  | 100009873 | ARG     | POLYGON    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | ETH   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

    @Smoke @Crypto @CPLv2 @V2 @Automated
    Scenario Outline: Ejecutar retiro <type> de <asset> mediante <network> para user <country> por V2
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<network>" to the variable "network"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<network>" to the variable "network"
        And Assign the value "<address>" to the variable "address"
        And Execute the POST method on the endpoint "/v2/withdraws"
        Then Obtain a response 201
        # Parte 2: Validar ejeccución del sintético
        When Wait for the processing of the "orden" por 60 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED

        @WLD
        Examples:
            | companyId                | type   | asset | userAnyId | country | network    | amount | address                                    |
            | 6864976a08430ed74bf61d0c | crypto | WLD   | 100009875 | CPL     | WORLDCHAIN | 3      | 0x48ed4fdbc27c52658912e7daad711defd7777908 |
            | 6864976a08430ed74bf61d0c | crypto | WLD   | 100009875 | CPL     | OPTIMISM   | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @Working
        Examples:
            | companyId                | type   | asset | userAnyId | country | network  | amount | address                                    |
            | 6864976a08430ed74bf61d0c | crypto | USDT  | 100009875 | CPL     | POLYGON  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | 6864976a08430ed74bf61d0c | crypto | USDT  | 100009875 | CPL     | ETHEREUM | 4      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            # | 6864976a08430ed74bf61d0c | crypto | USDT  | 100009875 | CPL     | BINANCE  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | 6864976a08430ed74bf61d0c | crypto | USDC  | 100009875 | CPL     | OPTIMISM | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

    # Examples:
    #     | type   | asset | userAnyId | country | network    | amount | address                                    |
    #     | crypto | WLD   | 100009873 | ARG     | WORLDCHAIN | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | BNB   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDC  | 100009873 | ARG     | OPTIMISM   | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | BTC   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDT  | 100009873 | ARG     | BINANCE    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDT  | 100009873 | ARG     | POLYGON    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | ETH   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

    @Smoke @Crypto @COPv2 @V2 @Automated
    Scenario Outline: Ejecutar retiro <type> de <asset> mediante <network> para user <country> por V2
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<network>" to the variable "network"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<network>" to the variable "network"
        And Assign the value "<address>" to the variable "address"
        And Execute the POST method on the endpoint "/v2/withdraws"
        Then Obtain a response 201
        # Parte 2: Validar ejeccución del sintético
        When Wait for the processing of the "orden" por 60 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED

        @WLD
        Examples:
            | companyId                | type   | asset | userAnyId | country | network    | amount | address                                    |
            | 6864976a08430ed74bf61d0c | crypto | WLD   | 100009876 | COP     | WORLDCHAIN | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | 6864976a08430ed74bf61d0c | crypto | WLD   | 100009876 | COP     | OPTIMISM   | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @Working
        Examples:
            | companyId                | type   | asset | userAnyId | country | network  | amount | address                                    |
            | 6864976a08430ed74bf61d0c | crypto | USDT  | 100009876 | COP     | POLYGON  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | 6864976a08430ed74bf61d0c | crypto | USDT  | 100009876 | COP     | ETHEREUM | 4      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            # | 6864976a08430ed74bf61d0c | crypto | USDT  | 100009876 |COP     | BINANCE  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | 6864976a08430ed74bf61d0c | crypto | USDC  | 100009876 | COP     | OPTIMISM | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    # Examples:
    #     | type   | asset | userAnyId | country | network    | amount | address                                    |
    #     | crypto | WLD   | 100009873 | ARG     | WORLDCHAIN | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | BNB   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDC  | 100009873 | ARG     | OPTIMISM   | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | BTC   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDT  | 100009873 | ARG     | BINANCE    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDT  | 100009873 | ARG     | POLYGON    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | ETH   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

    @Smoke @Crypto @MXNv2 @V2 @Automated
    Scenario Outline: Ejecutar retiro <type> de <asset> mediante <network> para user <country> por V2
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<network>" to the variable "network"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<network>" to the variable "network"
        And Assign the value "<address>" to the variable "address"
        And Execute the POST method on the endpoint "/v2/withdraws"
        Then Obtain a response 201
        # Parte 2: Validar ejeccución del sintético
        When Wait for the processing of the "orden" por 60 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED

        @WLD
        Examples:
            | companyId                | type   | asset | userAnyId | country | network    | amount | address                                    |
            | 6864976a08430ed74bf61d0c | crypto | WLD   | 100009877 | MXN     | WORLDCHAIN | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | 6864976a08430ed74bf61d0c | crypto | WLD   | 100009877 | MXN     | OPTIMISM   | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @Working
        Examples:
            | companyId                | type   | asset | userAnyId | country | network  | amount | address                                    |
            | 6864976a08430ed74bf61d0c | crypto | USDT  | 100009877 | MXN     | POLYGON  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | 6864976a08430ed74bf61d0c | crypto | USDT  | 100009877 | MXN     | ETHEREUM | 4      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            # | 6864976a08430ed74bf61d0c | crypto | USDT  | 100009877 | MXN     | BINANCE  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | 6864976a08430ed74bf61d0c | crypto | USDC  | 100009877 | MXN     | OPTIMISM | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

    # Examples:
    #     | type   | asset | userAnyId | country | network    | amount | address                                    |
    #     | crypto | WLD   | 100009873 | ARG     | WORLDCHAIN | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | BNB   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDC  | 100009873 | ARG     | OPTIMISM   | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | BTC   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDT  | 100009873 | ARG     | BINANCE    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDT  | 100009873 | ARG     | POLYGON    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | ETH   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

    @Smoke @Crypto @PANv2 @V2 @Automated
    Scenario Outline: Ejecutar retiro <type> de <asset> mediante <network> para user <country> por V2
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<network>" to the variable "network"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<network>" to the variable "network"
        And Assign the value "<address>" to the variable "address"
        And Execute the POST method on the endpoint "/v2/withdraws"
        Then Obtain a response 201
        # Parte 2: Validar ejeccución del sintético
        When Wait for the processing of the "orden" por 60 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED

        @WLD
        Examples:
            | companyId                | type   | asset | userAnyId | country | network    | amount | address                                    |
            | 6864976a08430ed74bf61d0c | crypto | WLD   | 100009878 | PAN     | WORLDCHAIN | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | 6864976a08430ed74bf61d0c | crypto | WLD   | 100009878 | PAN     | OPTIMISM   | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @Working
        Examples:
            | companyId                | type   | asset | userAnyId | country | network  | amount | address                                    |
            | 6864976a08430ed74bf61d0c | crypto | USDT  | 100009878 | PAN     | POLYGON  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | 6864976a08430ed74bf61d0c | crypto | USDT  | 100009878 | PAN     | ETHEREUM | 4      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    # | 6864976a08430ed74bf61d0c | crypto | USDT  | 100009878 | PAN     | BINANCE  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    # | 6864976a08430ed74bf61d0c | crypto | USDC  | 100009878 | PAN     | OPTIMISM | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

    # Examples:
    #     | type   | asset | userAnyId | country | network    | amount | address                                    |
    #     | crypto | WLD   | 100009873 | ARG     | WORLDCHAIN | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | BNB   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDC  | 100009873 | ARG     | OPTIMISM   | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | BTC   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDT  | 100009873 | ARG     | BINANCE    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDT  | 100009873 | ARG     | POLYGON    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | ETH   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

    @Smoke @Crypto @GTQv2 @V2 @Automated
    Scenario Outline: Ejecutar retiro <type> de <asset> mediante <network> para user <country> por V2
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<network>" to the variable "network"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<network>" to the variable "network"
        And Assign the value "<address>" to the variable "address"
        And Execute the POST method on the endpoint "/v2/withdraws"
        Then Obtain a response 201
        # Parte 2: Validar ejeccución del sintético
        When Wait for the processing of the "orden" por 60 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED

        @WLD
        Examples:
            | companyId                | type   | asset | userAnyId | country | network    | amount | address                                    |
            | 6864976a08430ed74bf61d0c | crypto | WLD   | 100009879 | GTQ     | WORLDCHAIN | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | 6864976a08430ed74bf61d0c | crypto | WLD   | 100009879 | GTQ     | OPTIMISM   | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @Working
        Examples:
            | companyId                | type   | asset | userAnyId | country | network  | amount | address                                    |
            | 6864976a08430ed74bf61d0c | crypto | USDT  | 100009879 | GTQ     | POLYGON  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | 6864976a08430ed74bf61d0c | crypto | USDT  | 100009879 | GTQ     | ETHEREUM | 4      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    # | 6864976a08430ed74bf61d0c | crypto | USDT  | 100009879 | ARG     | BINANCE  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    # | 6864976a08430ed74bf61d0c | crypto | USDC  | 100009879 | ARG     | OPTIMISM | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

    # Examples:
    #     | type   | asset | userAnyId | country | network    | amount | address                                    |
    #     | crypto | WLD   | 100009873 | ARG     | WORLDCHAIN | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | BNB   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDC  | 100009873 | ARG     | OPTIMISM   | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | BTC   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDT  | 100009873 | ARG     | BINANCE    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDT  | 100009873 | ARG     | POLYGON    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | ETH   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

    @Smoke @Crypto @PHPv2 @V2 @Automated
    Scenario Outline: Ejecutar retiro <type> de <asset> mediante <network> para user <country> por V2
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<network>" to the variable "network"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<network>" to the variable "network"
        And Assign the value "<address>" to the variable "address"
        And Execute the POST method on the endpoint "/v2/withdraws"
        Then Obtain a response 201
        # Parte 2: Validar ejeccución del sintético
        When Wait for the processing of the "orden" por 60 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED

        @WLD
        Examples:
            | companyId                | type   | asset | userAnyId | country | network    | amount | address                                    |
            | 6864976a08430ed74bf61d0c | crypto | WLD   | 100009880 | PHP     | WORLDCHAIN | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | 6864976a08430ed74bf61d0c | crypto | WLD   | 100009880 | PHP     | OPTIMISM   | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @Working
        Examples:
            | companyId                | type   | asset | userAnyId | country | network  | amount | address                                    |
            # | 6864976a08430ed74bf61d0c | crypto | USDC  | 100009880 | PHP     | OPTIMISM | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            # | 6864976a08430ed74bf61d0c | crypto | USDT  | 100009880 | PHP     | POLYGON  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | 6864976a08430ed74bf61d0c | crypto | USDT  | 100009880 | PHP     | ETHEREUM | 4      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            # | 6864976a08430ed74bf61d0c | crypto | USDC  | 100009880 | PHP     | POLYGON  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | 6864976a08430ed74bf61d0c | crypto | USDC  | 100009880 | PHP     | BASE     | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

    # Examples:
    #     | type   | asset | userAnyId | country | network    | amount | address                                    |
    #     | crypto | WLD   | 100009873 | ARG     | WORLDCHAIN | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | BNB   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDC  | 100009873 | ARG     | OPTIMISM   | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | BTC   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDT  | 100009873 | ARG     | BINANCE    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDT  | 100009873 | ARG     | POLYGON    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | ETH   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

    @Smoke @Crypto @CRCv2 @V2 @Automated
    Scenario Outline: Ejecutar retiro <type> de <asset> mediante <network> para user <country> por V2
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<network>" to the variable "network"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<network>" to the variable "network"
        And Assign the value "<address>" to the variable "address"
        And Execute the POST method on the endpoint "/v2/withdraws"
        Then Obtain a response 201
        # Parte 2: Validar ejeccución del sintético
        When Wait for the processing of the "orden" por 60 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED

        @WLD
        Examples:
            | companyId                | type   | asset | userAnyId | country | network    | amount | address                                    |
            | 6864976a08430ed74bf61d0c | crypto | WLD   | 100009881 | CRC     | WORLDCHAIN | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @Working
        Examples:
            | companyId                | type   | asset | userAnyId | country | network  | amount | address                                    |
            # | 6864976a08430ed74bf61d0c | crypto | USDC  | 100009881 |CRC     | OPTIMISM | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            # | 6864976a08430ed74bf61d0c | crypto | USDT  | 100009881 |CRC     | POLYGON  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | 6864976a08430ed74bf61d0c | crypto | USDT  | 100009881 | CRC     | ETHEREUM | 4      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            # | 6864976a08430ed74bf61d0c | crypto | USDC  | 100009881 | CRC    | POLYGON  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | 6864976a08430ed74bf61d0c | crypto | USDC  | 100009881 | CRC     | BASE     | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

    # Examples:
    #     | type   | asset | userAnyId | country | network    | amount | address                                    |
    #     | crypto | WLD   | 100009873 | ARG     | WORLDCHAIN | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | BNB   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDC  | 100009873 | ARG     | OPTIMISM   | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | BTC   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDT  | 100009873 | ARG     | BINANCE    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDT  | 100009873 | ARG     | POLYGON    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | ETH   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

    @Smoke @Crypto @PYGv2 @V2 @Automated
    Scenario Outline: Ejecutar retiro <type> de <asset> mediante <network> para user <country> por V2
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<network>" to the variable "network"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<network>" to the variable "network"
        And Assign the value "<address>" to the variable "address"
        And Execute the POST method on the endpoint "/v2/withdraws"
        Then Obtain a response 201
        # Parte 2: Validar ejeccución del sintético
        When Wait for the processing of the "orden" por 60 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED

        @WLD
        Examples:
            | companyId                | type   | asset | userAnyId | country | network    | amount | address                                    |
            | 6864976a08430ed74bf61d0c | crypto | WLD   | 100067267 | PYG     | WORLDCHAIN | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @Working
        Examples:
            | companyId                | type   | asset | userAnyId | country | network  | amount | address                                    |
            # | 6864976a08430ed74bf61d0c | crypto | USDC  | 100067267 |PYG     | OPTIMISM | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            # | 6864976a08430ed74bf61d0c | crypto | USDT  | 100067267 |PYG     | POLYGON  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | 6864976a08430ed74bf61d0c | crypto | USDT  | 100067267 | PYG     | ETHEREUM | 4      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            # | 6864976a08430ed74bf61d0c | crypto | USDC  | 100067267 | PYG    | POLYGON  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | 6864976a08430ed74bf61d0c | crypto | USDC  | 100067267 | PYG     | BASE     | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |


    @Smoke @Crypto @V2Endpoint @Automated
    Scenario Outline: Ejecutar retiro <type> de <asset> mediante <network> para user <country> haciendo lock price por V2
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<address>" to the variable "address"
        And Assign the value "<network>" to the variable "network"
        And Execute the POST method on the endpoint "/v2/withdraw-locks"
        Then Obtain a response 201

        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<network>" to the variable "network"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<network>" to the variable "network"
        And Assign the value "<address>" to the variable "address"
        And Execute the POST method on the endpoint "/v2/withdraws"
        Then Obtain a response 201

        When Wait for the processing of the "orden" por 60 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED

        @WLD
        Examples:
            | companyId                | type   | asset | userAnyId | country | network    | amount | address                                    |
            | 6864976a08430ed74bf61d0c | crypto | WLD   | 100009873 | ARG     | WORLDCHAIN | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | 6864976a08430ed74bf61d0c | crypto | USDT  | 100009873 | ARG     | POLYGON    | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | 6864976a08430ed74bf61d0c | crypto | USDT  | 100009873 | ARG     | ETHEREUM   | 7      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            # | 6864976a08430ed74bf61d0c | crypto | POL   | 100009873 | ARG     | POLYGON    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | 6864976a08430ed74bf61d0c | crypto | USDC  | 100009873 | ARG     | OPTIMISM   | 2      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

    @Smoke @HotWallet @Automated
    Scenario Outline: Validar que los retiros para un user exchange <exchange> se realicen por la Hot Wallet <wallet>
        Given Get credentials for company "<companyId>"
        And login user admin "<credential>"
        And Get user "exchange" info for "<userId>" id
        And The urlBase is available "https://api-qa.tiendacrypto.com"
        When Assign the value "<userId>" to the variable "userId"
        And Assign the value <chain> to the variable "chain"
        And Assign the value "<coin>" to the variable "coin"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<address>" to the variable "address"
        And Execute the POST method on the endpoint "/v1/admin/withdraw/crypto"
        Then Obtain a response 200 for admin withdraw

        @NOTRON
        Examples:
            | companyId                | credential                | userId    | chain | coin | amount | address                                    |
            # | 683cce15397feba125068c9b | andresperalta@manteca.dev | 100011192 | 4     | USDC | 3      | 0xf3CD48DAA6Eac2fb1495fa6832c5A88245Bf3a72 |
            | 683cce15397feba125068c9b | andresperalta@manteca.dev | 100011192 | 0     | USDT | 5      | 0xf3CD48DAA6Eac2fb1495fa6832c5A88245Bf3a72 |
            | 6864976a08430ed74bf61d0c | andresperalta@manteca.dev | 100009873 | 1     | USDT | 3      | 0x6fBf278Bf9cd0cF2897A66fB1FFc8C1320Ec70C1 |



        @TRONtest
        Examples:
            | companyId                | credential                | userId    | chain | coin | amount | address                            |
            # | 683cce15397feba125068c9b | andresperalta@manteca.dev | 100011236 | 9     | TRX  | 3      | TBm3cipnHc7HifuBJdh8JM3nwG3LQJ9UQv         |
            # | 68a50570fbdff4f9d45884b0 | andresperalta@manteca.dev | 100011236 | 9     | USDT | 3      | TBm3cipnHc7HifuBJdh8JM3nwG3LQJ9UQv |
            | 68a50570fbdff4f9d45884b0 | andresperalta@manteca.dev | 100011236 | 9     | TRX  | 3      | TBm3cipnHc7HifuBJdh8JM3nwG3LQJ9UQv |
