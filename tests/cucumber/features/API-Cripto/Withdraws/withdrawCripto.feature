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


    @Smoke @V1 @Automated
    Scenario Outline: Ejecutar retiro crypto de <coin> mediante <chain> por V1 endpoints
        Given The API key is available "BM2YZT6-MR5M5YY-QYZ5CY4-E8E9HYB"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<coin>" to the variable "coin"
        And Assign the value "<userId>" to the variable "userId"
        And Assign the value "<chain>" to the variable "chain"
        And Execute the POST method on the endpoint "/v1/transaction/withdraw/lock"
        Then Obtain a response 200

        Given The API key is available "BM2YZT6-MR5M5YY-QYZ5CY4-E8E9HYB"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<coin>" to the variable "coin"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<wallet>" to the variable "to"
        And Assign the value "<chain>" to the variable "chain"
        And Assign the value "<userId>" to the variable "userId"
        And Assign the value "code" to the variable "costCode"
        And Execute the POST method on the endpoint "/v1/transaction/withdraw"
        Then Obtain a response 200

        # Parte 2: Validar ejeccución del sintético
        Given The API key is available "BM2YZT6-MR5M5YY-QYZ5CY4-E8E9HYB"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Wait for the processing of the "orden" por 40 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED

        Examples:
            | coin | userId    | chain      | amount | wallet                                     |
            | WLD  | 100007647 | WORLDCHAIN | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | USDT | 100007647 | POLYGON    | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | USDT | 100007647 | BSC        | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | USDT | 100007647 | ARBITRUM   | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | USDT | 100007647 | ETHEREUM   | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | DAI  | 100007647 | BSC        | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | ETH  | 100007647 | BSC        | 0.001  | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | ETH  | 100007647 | ETHEREUM   | 0.001  | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | BNB  | 100007647 | BSC        | 0.001  | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | BTC  | 100007647 | BSC        | 0.001  | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | POL  | 100007647 | POLYGON    | 0.5    | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | USDC | 100007647 | POLYGON    | 5      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | USDC | 100007647 | BSC        | 5      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | USDC | 100007647 | OPTIMISM   | 5      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | USDC | 100007647 | ARBITRUM   | 5      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |

    @Regression @Crypto @ARG @V1 @Automated
    Scenario Outline: Ejecutar retiro crypto de <coin> mediante <chain> para user ARG por V1
        Given The API key is available "Y2HQYTM-BHQ4377-Q9XS7RX-17PPS04"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<coin>" to the variable "coin"
        And Assign the value "<userId>" to the variable "userId"
        And Assign the value "<chain>" to the variable "chain"
        And Execute the POST method on the endpoint "/v1/transaction/withdraw/lock"
        Then Obtain a response 200

        Given The API key is available "Y2HQYTM-BHQ4377-Q9XS7RX-17PPS04"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<coin>" to the variable "coin"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<wallet>" to the variable "to"
        And Assign the value "<chain>" to the variable "chain"
        And Assign the value "<userId>" to the variable "userId"
        And Assign the value "code" to the variable "costCode"
        And Execute the POST method on the endpoint "/v1/transaction/withdraw"
        Then Obtain a response 200

        # Parte 2: Validar ejeccución del sintético
        Given The API key is available "Y2HQYTM-BHQ4377-Q9XS7RX-17PPS04"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Wait for the processing of the "orden" por 40 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED

        @WLD
        Examples:
            | coin | userId    | chain      | amount | wallet                                     |
            | WLD  | 100009893 | WORLDCHAIN | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | WLD  | 100009893 | OPTIMISM   | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @Working
        Examples:
            | coin | userId    | chain    | amount | wallet                                     |
            | USDT | 100009893 | POLYGON  | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | USDT | 100009893 | BINANCE  | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | USDT | 100009893 | ETHEREUM | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | USDC | 100009893 | OPTIMISM | 5      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |


    @Regression @Crypto @CHL @V1 @Automated
    Scenario Outline: Ejecutar retiro crypto de <coin> mediante <chain> para user CHL por V1
        Given The API key is available "Y2HQYTM-BHQ4377-Q9XS7RX-17PPS04"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<coin>" to the variable "coin"
        And Assign the value "<userId>" to the variable "userId"
        And Assign the value "<chain>" to the variable "chain"
        And Execute the POST method on the endpoint "/v1/transaction/withdraw/lock"
        Then Obtain a response 200

        Given The API key is available "Y2HQYTM-BHQ4377-Q9XS7RX-17PPS04"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<coin>" to the variable "coin"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<wallet>" to the variable "to"
        And Assign the value "<chain>" to the variable "chain"
        And Assign the value "<userId>" to the variable "userId"
        And Assign the value "code" to the variable "costCode"
        And Execute the POST method on the endpoint "/v1/transaction/withdraw"
        Then Obtain a response 200

        # Parte 2: Validar ejeccución del sintético
        Given The API key is available "Y2HQYTM-BHQ4377-Q9XS7RX-17PPS04"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Wait for the processing of the "orden" por 40 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED

        @WLD
        Examples:
            | coin | userId    | chain      | amount | wallet                                     |
            | WLD  | 100009892 | WORLDCHAIN | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | WLD  | 100009892 | OPTIMISM   | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @NoFundsAvailableInHotWallet
        Examples:
            | coin | userId    | chain    | amount | wallet                                     |
            | USDT | 100009892 | POLYGON  | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | USDT | 100009892 | BINANCE  | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | USDT | 100009892 | ETHEREUM | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | USDC | 100009892 | OPTIMISM | 5      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |

    @Regression @Crypto @COL @V1 @Automated
    Scenario Outline: Ejecutar retiro crypto de <coin> mediante <chain> para user COL por V1
        Given The API key is available "Y2HQYTM-BHQ4377-Q9XS7RX-17PPS04"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<coin>" to the variable "coin"
        And Assign the value "<userId>" to the variable "userId"
        And Assign the value "<chain>" to the variable "chain"
        And Execute the POST method on the endpoint "/v1/transaction/withdraw/lock"
        Then Obtain a response 200

        Given The API key is available "Y2HQYTM-BHQ4377-Q9XS7RX-17PPS04"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<coin>" to the variable "coin"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<wallet>" to the variable "to"
        And Assign the value "<chain>" to the variable "chain"
        And Assign the value "<userId>" to the variable "userId"
        And Assign the value "code" to the variable "costCode"
        And Execute the POST method on the endpoint "/v1/transaction/withdraw"
        Then Obtain a response 200

        # Parte 2: Validar ejeccución del sintético
        Given The API key is available "Y2HQYTM-BHQ4377-Q9XS7RX-17PPS04"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Wait for the processing of the "orden" por 40 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED

        @WLD
        Examples:
            | coin | userId    | chain      | amount | wallet                                     |
            | WLD  | 100009891 | WORLDCHAIN | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @NoFundsAvailableInHotWallet
        Examples:
            | coin | userId    | chain    | amount | wallet                                     |
            | USDT | 100009891 | POLYGON  | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | USDT | 100009891 | BINANCE  | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | USDT | 100009891 | ETHEREUM | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | USDC | 100009891 | OPTIMISM | 5      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |

    @Regression @Crypto @MXN @V1 @Automated
    Scenario Outline: Ejecutar retiro crypto de <coin> mediante <chain> para user MXN por V1
        Given The API key is available "Y2HQYTM-BHQ4377-Q9XS7RX-17PPS04"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<coin>" to the variable "coin"
        And Assign the value "<userId>" to the variable "userId"
        And Assign the value "<chain>" to the variable "chain"
        And Execute the POST method on the endpoint "/v1/transaction/withdraw/lock"
        Then Obtain a response 200

        Given The API key is available "Y2HQYTM-BHQ4377-Q9XS7RX-17PPS04"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<coin>" to the variable "coin"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<wallet>" to the variable "to"
        And Assign the value "<chain>" to the variable "chain"
        And Assign the value "<userId>" to the variable "userId"
        And Assign the value "code" to the variable "costCode"
        And Execute the POST method on the endpoint "/v1/transaction/withdraw"
        Then Obtain a response 200

        # Parte 2: Validar ejeccución del sintético
        Given The API key is available "Y2HQYTM-BHQ4377-Q9XS7RX-17PPS04"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Wait for the processing of the "orden" por 60 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED

        @WLD
        Examples:
            | coin | userId    | chain      | amount | wallet                                     |
            | WLD  | 100009889 | WORLDCHAIN | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @NoFundsAvailableInHotWallet
        Examples:
            | coin | userId    | chain    | amount | wallet                                     |
            | USDT | 100009889 | POLYGON  | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | USDT | 100009889 | BINANCE  | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | USDT | 100009889 | ETHEREUM | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | USDC | 100009889 | OPTIMISM | 5      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |

    @Regression @Crypto @PAN @V1 @Automated
    Scenario Outline: Ejecutar retiro crypto de <coin> mediante <chain> para user PAN por V1
        Given The API key is available "Y2HQYTM-BHQ4377-Q9XS7RX-17PPS04"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<coin>" to the variable "coin"
        And Assign the value "<userId>" to the variable "userId"
        And Assign the value "<chain>" to the variable "chain"
        And Execute the POST method on the endpoint "/v1/transaction/withdraw/lock"
        Then Obtain a response 200

        Given The API key is available "Y2HQYTM-BHQ4377-Q9XS7RX-17PPS04"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<coin>" to the variable "coin"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<wallet>" to the variable "to"
        And Assign the value "<chain>" to the variable "chain"
        And Assign the value "<userId>" to the variable "userId"
        And Assign the value "code" to the variable "costCode"
        And Execute the POST method on the endpoint "/v1/transaction/withdraw"
        Then Obtain a response 200

        # Parte 2: Validar ejeccución del sintético
        Given The API key is available "Y2HQYTM-BHQ4377-Q9XS7RX-17PPS04"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Wait for the processing of the "orden" por 60 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED

        @WLD
        Examples:
            | coin | userId    | chain      | amount | wallet                                     |
            | WLD  | 100009887 | WORLDCHAIN | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @NoFundsAvailableInHotWallet
        Examples:
            | coin | userId    | chain    | amount | wallet                                     |
            | USDT | 100009887 | POLYGON  | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | USDT | 100009887 | BINANCE  | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | USDT | 100009887 | ETHEREUM | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | USDC | 100009887 | OPTIMISM | 5      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |

    @Regression @Crypto @GTQ @V1 @Automated
    Scenario Outline: Ejecutar retiro crypto de <coin> mediante <chain> para user GTQ por V1
        Given The API key is available "Y2HQYTM-BHQ4377-Q9XS7RX-17PPS04"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<coin>" to the variable "coin"
        And Assign the value "<userId>" to the variable "userId"
        And Assign the value "<chain>" to the variable "chain"
        And Execute the POST method on the endpoint "/v1/transaction/withdraw/lock"
        Then Obtain a response 200

        Given The API key is available "Y2HQYTM-BHQ4377-Q9XS7RX-17PPS04"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<coin>" to the variable "coin"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<wallet>" to the variable "to"
        And Assign the value "<chain>" to the variable "chain"
        And Assign the value "<userId>" to the variable "userId"
        And Assign the value "code" to the variable "costCode"
        And Execute the POST method on the endpoint "/v1/transaction/withdraw"
        Then Obtain a response 200

        # Parte 2: Validar ejeccución del sintético
        Given The API key is available "Y2HQYTM-BHQ4377-Q9XS7RX-17PPS04"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Wait for the processing of the "orden" por 60 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED

        @WLD
        Examples:
            | coin | userId    | chain      | amount | wallet                                     |
            | WLD  | 100009886 | WORLDCHAIN | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @NoFundsAvailableInHotWallet
        Examples:
            | coin | userId    | chain    | amount | wallet                                     |
            | USDT | 100009886 | POLYGON  | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | USDT | 100009886 | BINANCE  | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | USDT | 100009886 | ETHEREUM | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | USDC | 100009886 | OPTIMISM | 5      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |

    @Regression @Crypto @PHP @V1 @Automated
    Scenario Outline: Ejecutar retiro crypto de <coin> mediante <chain> para user PHP por V1
        Given The API key is available "Y2HQYTM-BHQ4377-Q9XS7RX-17PPS04"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<coin>" to the variable "coin"
        And Assign the value "<userId>" to the variable "userId"
        And Assign the value "<chain>" to the variable "chain"
        And Execute the POST method on the endpoint "/v1/transaction/withdraw/lock"
        Then Obtain a response 200

        Given The API key is available "Y2HQYTM-BHQ4377-Q9XS7RX-17PPS04"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<coin>" to the variable "coin"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<wallet>" to the variable "to"
        And Assign the value "<chain>" to the variable "chain"
        And Assign the value "<userId>" to the variable "userId"
        And Assign the value "code" to the variable "costCode"
        And Execute the POST method on the endpoint "/v1/transaction/withdraw"
        Then Obtain a response 200

        # Parte 2: Validar ejeccución del sintético
        Given The API key is available "Y2HQYTM-BHQ4377-Q9XS7RX-17PPS04"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Wait for the processing of the "orden" por 60 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED

        @WLD
        Examples:
            | coin | userId    | chain      | amount | wallet                                     |
            | WLD  | 100009885 | WORLDCHAIN | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @NoFundsAvailableInHotWallet
        Examples:
            | coin | userId    | chain    | amount | wallet                                     |
            | USDT | 100009885 | POLYGON  | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | USDT | 100009885 | BINANCE  | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | USDT | 100009885 | ETHEREUM | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | USDC | 100009885 | OPTIMISM | 5      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |

    @Regression @Crypto @BRA @V1 @Automated
    Scenario Outline: Ejecutar retiro crypto de <coin> mediante <chain> para user BRA por V1
        Given The API key is available "Y2HQYTM-BHQ4377-Q9XS7RX-17PPS04"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<coin>" to the variable "coin"
        And Assign the value "<userId>" to the variable "userId"
        And Assign the value "<chain>" to the variable "chain"
        And Execute the POST method on the endpoint "/v1/transaction/withdraw/lock"
        Then Obtain a response 200

        Given The API key is available "Y2HQYTM-BHQ4377-Q9XS7RX-17PPS04"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<coin>" to the variable "coin"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<wallet>" to the variable "to"
        And Assign the value "<chain>" to the variable "chain"
        And Assign the value "<userId>" to the variable "userId"
        And Assign the value "code" to the variable "costCode"
        And Execute the POST method on the endpoint "/v1/transaction/withdraw"
        Then Obtain a response 200

        # Parte 2: Validar ejeccución del sintético
        Given The API key is available "Y2HQYTM-BHQ4377-Q9XS7RX-17PPS04"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Wait for the processing of the "orden" por 60 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED

        @WLD
        Examples:
            | coin | userId    | chain      | amount | wallet                                     |
            | WLD  | 100009884 | WORLDCHAIN | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @NoFundsAvailableInHotWallet
        Examples:
            | coin | userId    | chain    | amount | wallet                                     |
            | USDT | 100009884 | POLYGON  | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | USDT | 100009884 | BINANCE  | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | USDT | 100009884 | ETHEREUM | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | USDC | 100009884 | OPTIMISM | 5      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |

    # ------------- V2 ---------------

    @Smoke @Crypto @ARGv2 @V2 @Automated
    Scenario Outline: Ejecutar retiro <type> de <asset> mediante <network> para user <country> por V2
        Given The API key is available "<apiKEY>"
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

        # Parte 2: Validar ejeccución del sintético
        Given The API key is available "PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Wait for the processing of the "orden" por 60 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED

        @WLD
        Examples:
            | apiKEY                          | type   | asset | userAnyId | country | network    | amount | address                                    |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | WLD   | 100009873 | ARG     | WORLDCHAIN | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | WLD   | 100009873 | ARG     | OPTIMISM   | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @Working
        Examples:
            | apiKEY                          | type   | asset | userAnyId | country | network  | amount | address                                    |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | USDT  | 100009873 | ARG     | POLYGON  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | USDT  | 100009873 | ARG     | ETHEREUM | 7      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | USDT  | 100009873 | ARG     | BINANCE  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | USDC  | 100009873 | ARG     | OPTIMISM | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @TRON
        Examples:
            | apiKEY                          | type   | asset | userAnyId | country | network | amount | address                            |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | crypto | USDT  | 100011214 | ARG     | TRON    | 3      | TBm3cipnHc7HifuBJdh8JM3nwG3LQJ9UQv |

        @Test
        Examples:
            | apiKEY                          | type   | asset | userAnyId | country | network | amount | address                                    |
            #     | crypto | WLD   | 100009873 | ARG     | WORLDCHAIN | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            #     | crypto | BNB   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            #     | crypto | USDC  | 100009873 | ARG     | OPTIMISM   | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            #     | crypto | BTC   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | USDT  | 100009873 | ARG     | BINANCE | 12     | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDT  | 100009873 | ARG     | POLYGON    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | ETH   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

    @Smoke @Crypto @BRLv2 @V2 @Automated
    Scenario Outline: Ejecutar retiro <type> de <asset> mediante <network> para user <country> por V2
        Given The API key is available "<apiKEY>"
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

        # Parte 2: Validar ejeccución del sintético
        Given The API key is available "PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Wait for the processing of the "orden" por 60 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED

        @WLD
        Examples:
            | apiKEY                          | type   | asset | userAnyId | country | network    | amount | address                                    |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | crypto | WLD   | 100011214 | ARG     | WORLDCHAIN | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | crypto | WLD   | 100011214 | ARG     | OPTIMISM   | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @Working
        Examples:
            | apiKEY                          | type   | asset | userAnyId | country | network  | amount | address                                    |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | crypto | USDT  | 100011214 | ARG     | POLYGON  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | crypto | USDT  | 100011214 | ARG     | ETHEREUM | 4      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | crypto | USDT  | 100011214 | ARG     | BINANCE  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | crypto | USDC  | 100011214 | ARG     | OPTIMISM | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @TRON
        Examples:
            | apiKEY                          | type   | asset | userAnyId | country | network | amount | address                            |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | crypto | USDT  | 100011214 | BRA     | POLYGON | 3      | TK87U6EA5Fyq1zLZc9Q6NEeasHtTTRMaLu |

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
        Given The API key is available "<apiKEY>"
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

        # Parte 2: Validar ejeccución del sintético
        Given The API key is available "PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Wait for the processing of the "orden" por 60 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED

        @WLD
        Examples:
            | apiKEY                          | type   | asset | userAnyId | country | network    | amount | address                                    |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | WLD   | 100009875 | ARG     | WORLDCHAIN | 3      | 0x48ed4fdbc27c52658912e7daad711defd7777908 |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | WLD   | 100009875 | ARG     | OPTIMISM   | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @Working
        Examples:
            | apiKEY                          | type   | asset | userAnyId | country | network  | amount | address                                    |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | USDT  | 100009875 | ARG     | POLYGON  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | USDT  | 100009875 | ARG     | ETHEREUM | 4      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | USDT  | 100009875 | ARG     | BINANCE  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | USDC  | 100009875 | ARG     | OPTIMISM | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

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
        Given The API key is available "<apiKEY>"
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

        # Parte 2: Validar ejeccución del sintético
        Given The API key is available "PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Wait for the processing of the "orden" por 60 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED

        @WLD
        Examples:
            | apiKEY                          | type   | asset | userAnyId | country | network    | amount | address                                    |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | WLD   | 100009876 | ARG     | WORLDCHAIN | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | WLD   | 100009876 | ARG     | OPTIMISM   | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @Working
        Examples:
            | apiKEY                          | type   | asset | userAnyId | country | network  | amount | address                                    |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | USDT  | 100009876 | ARG     | POLYGON  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | USDT  | 100009876 | ARG     | ETHEREUM | 4      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | USDT  | 100009876 | ARG     | BINANCE  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | USDC  | 100009876 | ARG     | OPTIMISM | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
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
        Given The API key is available "<apiKEY>"
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

        # Parte 2: Validar ejeccución del sintético
        Given The API key is available "PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Wait for the processing of the "orden" por 60 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED

        @WLD
        Examples:
            | apiKEY                          | type   | asset | userAnyId | country | network    | amount | address                                    |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | WLD   | 100009877 | ARG     | WORLDCHAIN | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | WLD   | 100009877 | ARG     | OPTIMISM   | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @Working
        Examples:
            | apiKEY                          | type   | asset | userAnyId | country | network  | amount | address                                    |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | USDT  | 100009877 | ARG     | POLYGON  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | USDT  | 100009877 | ARG     | ETHEREUM | 4      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | USDT  | 100009877 | ARG     | BINANCE  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | USDC  | 100009877 | ARG     | OPTIMISM | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

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
        Given The API key is available "<apiKEY>"
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

        # Parte 2: Validar ejeccución del sintético
        Given The API key is available "PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Wait for the processing of the "orden" por 60 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED

        @WLD
        Examples:
            | apiKEY                          | type   | asset | userAnyId | country | network    | amount | address                                    |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | WLD   | 100009878 | ARG     | WORLDCHAIN | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | WLD   | 100009878 | ARG     | OPTIMISM   | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @Working
        Examples:
            | apiKEY                          | type   | asset | userAnyId | country | network  | amount | address                                    |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | USDT  | 100009878 | ARG     | POLYGON  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | USDT  | 100009878 | ARG     | ETHEREUM | 4      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | USDT  | 100009878 | ARG     | BINANCE  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | USDC  | 100009878 | ARG     | OPTIMISM | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

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
        Given The API key is available "<apiKEY>"
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

        # Parte 2: Validar ejeccución del sintético
        Given The API key is available "PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Wait for the processing of the "orden" por 60 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED

        @WLD
        Examples:
            | apiKEY                          | type   | asset | userAnyId | country | network    | amount | address                                    |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | WLD   | 100009879 | ARG     | WORLDCHAIN | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | WLD   | 100009879 | ARG     | OPTIMISM   | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @Working
        Examples:
            | apiKEY                          | type   | asset | userAnyId | country | network  | amount | address                                    |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | USDT  | 100009879 | ARG     | POLYGON  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | USDT  | 100009879 | ARG     | ETHEREUM | 4      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | USDT  | 100009879 | ARG     | BINANCE  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | USDC  | 100009879 | ARG     | OPTIMISM | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

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
        Given The API key is available "<apiKEY>"
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

        # Parte 2: Validar ejeccución del sintético
        Given The API key is available "PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Wait for the processing of the "orden" por 60 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED

        @WLD
        Examples:
            | apiKEY                          | type   | asset | userAnyId | country | network    | amount | address                                    |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | WLD   | 100009880 | ARG     | WORLDCHAIN | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | WLD   | 100009880 | ARG     | OPTIMISM   | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @Working
        Examples:
            | apiKEY                          | type   | asset | userAnyId | country | network  | amount | address                                    |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | USDC  | 100009880 | ARG     | OPTIMISM | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | USDT  | 100009880 | ARG     | POLYGON  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | USDT  | 100009880 | ARG     | ETHEREUM | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | USDC  | 100009880 | ARG     | POLYGON  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | USDC  | 100009880 | ARG     | BASE     | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

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
        Given The API key is available "<apiKEY>"
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

        # Parte 2: Validar ejeccución del sintético
        Given The API key is available "PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Wait for the processing of the "orden" por 60 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED

        @WLD
        Examples:
            | apiKEY                          | type   | asset | userAnyId | country | network    | amount | address                                    |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | WLD   | 100009881 | ARG     | WORLDCHAIN | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @Working
        Examples:
            | apiKEY                          | type   | asset | userAnyId | country | network  | amount | address                                    |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | USDC  | 100009881 | ARG     | OPTIMISM | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | USDT  | 100009881 | ARG     | POLYGON  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | USDT  | 100009881 | ARG     | ETHEREUM | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | USDC  | 100009881 | ARG     | POLYGON  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | crypto | USDC  | 100009881 | ARG     | BASE     | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

    # Examples:
    #     | type   | asset | userAnyId | country | network    | amount | address                                    |
    #     | crypto | WLD   | 100009873 | ARG     | WORLDCHAIN | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | BNB   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDC  | 100009873 | ARG     | OPTIMISM   | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | BTC   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDT  | 100009873 | ARG     | BINANCE    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDT  | 100009873 | ARG     | POLYGON    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | ETH   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

    @Smoke @Lock
    Scenario Outline: Ejecutar retiro <type> de <asset> mediante <network> para user <country> haciendo lock price por V2
        Given The API key is available "PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY"
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
        And Assign the value "<type>" to the variable "type"
        And Assign the value "<country>" to the variable "country"
        And Execute the POST method on the endpoint "/v2/withdraws"
        Then Obtain a response 201

        When Wait for the processing of the "orden" por 60 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED

        @WLD
        Examples:
            | type   | asset | userAnyId | country | network    | amount | address                                    |
            | crypto | WLD   | 100009873 | ARG     | WORLDCHAIN | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

    @auth @Automated
    Scenario Outline: Validar que los retiros para un user exchange <exchange> se realicen por la Hot Wallet <wallet>
        Given The API key is available "<apiKEY>"
        And login user admin "<credential>"
        And Get user "exchange" info for "<userId>" id
        And The urlBase is available "https://api-qa.tiendacrypto.com/v1"
        When Assign the value "<userId>" to the variable "userId"
        And Assign the value <chain> to the variable "chain"
        And Assign the value "<coin>" to the variable "coin"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<address>" to the variable "address"
        And Execute the POST method on the endpoint "/admin/withdraw/crypto"
        Then Obtain a response 200 for admin withdraw

        @NOTRON
        Examples:
            | apiKEY                          | credential                | userId    | chain | coin | amount | address                                    |
            # | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | andresperalta@manteca.dev | 100011192 | 4     | USDC | 3      | 0xf3CD48DAA6Eac2fb1495fa6832c5A88245Bf3a72 |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | andresperalta@manteca.dev | 100011192 | 1     | USDT | 3      | 0xf3CD48DAA6Eac2fb1495fa6832c5A88245Bf3a72 |
        # | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | andresperalta@manteca.dev | 100009873 | 1     | USDT | 3      | 0x6fBf278Bf9cd0cF2897A66fB1FFc8C1320Ec70C1 |



        @TRON
        Examples:
            | apiKEY                          | credential                | userId    | chain | coin | amount | address                            |
            # | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | andresperalta@manteca.dev | 100011236 | 9     | TRX  | 3      | TBm3cipnHc7HifuBJdh8JM3nwG3LQJ9UQv         |
            | 0DBQKAS-Q4R456C-HCYXX4W-AYBYC6P | andresperalta@manteca.dev | 100011236 | 9     | USDT | 3      | TBm3cipnHc7HifuBJdh8JM3nwG3LQJ9UQv |
            | 0DBQKAS-Q4R456C-HCYXX4W-AYBYC6P | andresperalta@manteca.dev | 100011236 | 9     | TRX  | 3      | TBm3cipnHc7HifuBJdh8JM3nwG3LQJ9UQv |

