@Withdraw
Feature: Retiros Crypto

    @LockCode
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
            | USDT  | 100007647 | BINANCE  |
            | USDT  | 100007647 | BSC      |
            | USDT  | 100007647 | OPTIMISM |
            | USDT  | 100007647 | ARBITRUM |
            | DAI   | 100007647 | POLYGON  |
            | DAI   | 100007647 | BINANCE  |
            | DAI   | 100007647 | BSC      |
            | DAI   | 100007647 | OPTIMISM |
            | DAI   | 100007647 | ARBITRUM |
            | UST   | 100007647 | BINANCE  |
            | UST   | 100007647 | BSC      |
            | ETH   | 100007647 | POLYGON  |
            | ETH   | 100007647 | BINANCE  |
            | ETH   | 100007647 | BSC      |
            | ETH   | 100007647 | OPTIMISM |
            | ETH   | 100007647 | ARBITRUM |
            | BNB   | 100007647 | BINANCE  |
            | BNB   | 100007647 | BSC      |
            | BNB   | 100007647 | OPTIMISM |
            | BNB   | 100007647 | ARBITRUM |
            | BTC   | 100007647 | BINANCE  |
            | BTC   | 100007647 | BSC      |
            | BTC   | 100007647 | OPTIMISM |
            | BTC   | 100007647 | ARBITRUM |
            | SOL   | 100007647 | BINANCE  |
            | SOL   | 100007647 | BSC      |
            | SOL   | 100007647 | OPTIMISM |
            | SOL   | 100007647 | ARBITRUM |
            | POL   | 100007647 | POLYGON  |
            | POL   | 100007647 | BINANCE  |
            | POL   | 100007647 | BSC      |
            | POL   | 100007647 | OPTIMISM |
            | POL   | 100007647 | ARBITRUM |
            | USDC  | 100007647 | POLYGON  |
            | USDC  | 100007647 | BINANCE  |
            | USDC  | 100007647 | BSC      |
            | USDC  | 100007647 | OPTIMISM |
            | USDC  | 100007647 | ARBITRUM |
            | NUARS | 100007647 | BINANCE  |
            | NUARS | 100007647 | BSC      |
            | SDAI  | 100007647 | OPTIMISM |
            | USDCB | 100007647 | POLYGON  |
            | USDCB | 100007647 | BINANCE  |
            | USDCB | 100007647 | BSC      |
            | USDCB | 100007647 | OPTIMISM |
            | USDCB | 100007647 | ARBITRUM |

    @SmokeWithdraw
    Scenario Outline: Ejecutar retiro crypto de <coin> mediante <chain>
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
            | coin  | userId    | chain      | amount | wallet                                     |
            | WLD   | 100007647 | WORLDCHAIN | 10     | 0x96c5d20b2a975c050e4220be276ace4892f4b41a |
            | USDT  | 100007647 | POLYGON    | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | USDT  | 100007647 | BINANCE    | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | USDT  | 100007647 | BSC        | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | USDT  | 100007647 | OPTIMISM   | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | USDT  | 100007647 | ARBITRUM   | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | DAI   | 100007647 | POLYGON    | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | DAI   | 100007647 | BINANCE    | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | DAI   | 100007647 | BSC        | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            # | DAI   | 100007647 | OPTIMISM | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            # | DAI   | 100007647 | ARBITRUM | 10     | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            # | ETH   | 100007647 | POLYGON    | 1      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | ETH   | 100007647 | BINANCE    | 1      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | ETH   | 100007647 | BSC        | 1      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            # | ETH   | 100007647 | OPTIMISM   | 1      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            # | ETH   | 100007647 | ARBITRUM   | 1      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | BNB   | 100007647 | BINANCE    | 1      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | BNB   | 100007647 | BSC        | 1      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            # | BNB   | 100007647 | OPTIMISM   | 1      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            # | BNB   | 100007647 | ARBITRUM   | 1      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | BTC   | 100007647 | BINANCE    | 1      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | BTC   | 100007647 | BSC        | 1      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            # | BTC   | 100007647 | OPTIMISM   | 1      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            # | BTC   | 100007647 | ARBITRUM   | 1      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            # | SOL   | 100007647 | BINANCE    | 5      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            # | SOL   | 100007647 | BSC      | 5      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            # | SOL   | 100007647 | OPTIMISM | 5      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            # | SOL   | 100007647 | ARBITRUM | 5      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            # | POL   | 100007647 | POLYGON  | 5      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            # | POL   | 100007647 | BINANCE    | 5      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            # | POL   | 100007647 | BSC      | 5      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            # | POL   | 100007647 | OPTIMISM | 5      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            # | POL   | 100007647 | ARBITRUM | 5      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | USDC  | 100007647 | POLYGON    | 5      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            # | USDC  | 100007647 | BINANCE    | 5      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            # | USDC  | 100007647 | BSC        | 5      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            # | USDC  | 100007647 | OPTIMISM   | 5      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            # | USDC  | 100007647 | ARBITRUM   | 5      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            # | NUARS | 100007647 | BINANCE    | 5      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            # | NUARS | 100007647 | BSC        | 5      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            # | SDAI  | 100007647 | OPTIMISM   | 5      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
            | USDCB | 100007647 | POLYGON    | 5      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
    # | USDCB | 100007647 | BINANCE  | 5      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
    # | USDCB | 100007647 | BSC      | 5      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
    # | USDCB | 100007647 | OPTIMISM | 5      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |
    # | USDCB | 100007647 | ARBITRUM | 5      | 0x09219631A56D2A8414B99d227A3Aa07A2b74F0EA |

    @SmokeWithdraw @Crypto @ARG @V1
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
            | WLD  | 100009893 | WORLDCHAIN | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | WLD  | 100009893 | OPTIMISM   | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        Examples:
            | coin | userId    | chain    | amount | wallet                                     |
            | USDT | 100009893 | POLYGON  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | USDT | 100009893 | ETHEREUM | 4      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | USDC | 100009893 | POLYGON  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | USDC | 100009893 | BASE     | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    # | BNB  | 100009893 | BINANCE  | 0.1    | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    # | USDC | 100009893 | OPTIMISM | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    # | BTC  | 100009893 | BINANCE  | 0.01   | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    # | USDT | 100009893 | BINANCE  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    # | USDT | 100009893 | POLYGON  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    # | ETH  | 100009893 | ETHEREUM | 0.01   | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    # | ETH  | 100009893 | BINANCE  | 0.01   | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

    @SmokeWithdraw @Crypto @CHL @V1
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
            | WLD  | 100009892 | WORLDCHAIN | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | WLD  | 100009892 | OPTIMISM   | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        Examples:
            | coin | userId    | chain    | amount | wallet                                     |
            | USDT | 100009892 | POLYGON  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | USDT | 100009892 | ETHEREUM | 4      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | USDC | 100009892 | POLYGON  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | USDC | 100009892 | BASE     | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    # | BNB  | 100009892 | BINANCE    | 0.1    | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    # | USDC | 100009892 | OPTIMISM   | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    # | BTC  | 100009892 | BINANCE    | 0.01   | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    # | USDT | 100009892 | BINANCE    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    # | USDT | 100009892 | POLYGON    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    # | ETH  | 100009892 | ETHEREUM   | 0.01   | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    # | ETH  | 100009892 | BINANCE    | 0.01   | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

    @SmokeWithdraw @Crypto @COL @V1
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
            | WLD  | 100009893 | WORLDCHAIN | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        Examples:
            | coin | userId    | chain      | amount | wallet                                     |
            | WLD  | 100009891 | WORLDCHAIN | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | BNB  | 100009891 | BINANCE    | 0.1    | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | USDC | 100009891 | OPTIMISM   | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | BTC  | 100009891 | BINANCE    | 0.01   | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | USDT | 100009891 | BINANCE    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | USDT | 100009891 | POLYGON    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | ETH  | 100009891 | ETHEREUM   | 0.01   | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | ETH  | 100009891 | BINANCE    | 0.01   | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

    @SmokeWithdraw @Crypto @MXN @V1
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
            | WLD  | 100009893 | WORLDCHAIN | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        Examples:
            | coin | userId    | chain      | amount | wallet                                     |
            | WLD  | 100009889 | WORLDCHAIN | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | BNB  | 100009889 | BINANCE    | 0.1    | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | USDC | 100009889 | OPTIMISM   | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | BTC  | 100009889 | BINANCE    | 0.01   | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | USDT | 100009889 | BINANCE    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | USDT | 100009889 | POLYGON    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | ETH  | 100009889 | ETHEREUM   | 0.01   | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | ETH  | 100009889 | BINANCE    | 0.01   | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

    @SmokeWithdraw @Crypto @PAN @V1
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
            | WLD  | 100009893 | WORLDCHAIN | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        Examples:
            | coin | userId    | chain      | amount | wallet                                     |
            | WLD  | 100009887 | WORLDCHAIN | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | BNB  | 100009887 | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | USDC | 100009887 | OPTIMISM   | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | BTC  | 100009887 | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | USDT | 100009887 | BINANCE    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | USDT | 100009887 | POLYGON    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | ETH  | 100009887 | ETHEREUM   | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | ETH  | 100009887 | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

    @SmokeWithdraw @Crypto @GTQ @V1
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
            | WLD  | 100009893 | WORLDCHAIN | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        Examples:
            | coin | userId    | chain      | amount | wallet                                     |
            | WLD  | 100009886 | WORLDCHAIN | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | BNB  | 100009886 | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | USDC | 100009886 | OPTIMISM   | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | BTC  | 100009886 | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | USDT | 100009886 | BINANCE    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | USDT | 100009886 | POLYGON    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | ETH  | 100009886 | ETHEREUM   | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | ETH  | 100009886 | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

    @SmokeWithdraw @Crypto @PHP @V1
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
            | WLD  | 100009893 | WORLDCHAIN | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        Examples:
            | coin | userId    | chain      | amount | wallet                                     |
            | WLD  | 100009885 | WORLDCHAIN | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | BNB  | 100009885 | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | USDC | 100009885 | OPTIMISM   | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | BTC  | 100009885 | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | USDT | 100009885 | BINANCE    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | USDT | 100009885 | POLYGON    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | ETH  | 100009885 | ETHEREUM   | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | ETH  | 100009885 | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

    @SmokeWithdraw @Crypto @BRA @V1
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
            | WLD  | 100009893 | WORLDCHAIN | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        Examples:
            | coin | userId    | chain      | amount | wallet                                     |
            | WLD  | 100009884 | WORLDCHAIN | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | BNB  | 100009884 | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | USDC | 100009884 | OPTIMISM   | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | BTC  | 100009884 | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | USDT | 100009884 | BINANCE    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | USDT | 100009884 | POLYGON    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | ETH  | 100009884 | ETHEREUM   | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | ETH  | 100009884 | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

    @SmokeWithdraw @Crypto @CRC @V1
    Scenario Outline: Ejecutar retiro crypto de <coin> mediante <chain> para user CRC por V1
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
            | WLD  | 100009893 | WORLDCHAIN | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        Examples:
            | coin | userId    | chain      | amount | wallet                                     |
            | WLD  | 100009883 | WORLDCHAIN | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | BNB  | 100009883 | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | USDC | 100009883 | OPTIMISM   | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | BTC  | 100009883 | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | USDT | 100009883 | BINANCE    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | USDT | 100009883 | POLYGON    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | ETH  | 100009883 | ETHEREUM   | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | ETH  | 100009883 | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

    # ------------- V2 ---------------




    @SmokeWithdraw @Crypto @ARGv2 @V2
    Scenario Outline: Ejecutar retiro <type> de <asset> mediante <network> para user <country> por V2
        Given The API key is available "PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY"
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
            | type   | asset | userAnyId | country | network    | amount | address                                    |
            | crypto | WLD   | 100009873 | ARG     | WORLDCHAIN | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | crypto | WLD   | 100009873 | ARG     | OPTIMISM   | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @Working
        Examples:
            | type   | asset | userAnyId | country | network  | amount | address                                    |
            | crypto | USDT  | 100009873 | ARG     | POLYGON  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | crypto | USDT  | 100009873 | ARG     | ETHEREUM | 4      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | crypto | USDC  | 100009873 | ARG     | POLYGON  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | crypto | USDC  | 100009873 | ARG     | BASE     | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

    # Examples:
    #     | type   | asset | userAnyId | country | network    | amount | address                                    |
    #     | crypto | WLD   | 100009873 | ARG     | WORLDCHAIN | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | BNB   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDC  | 100009873 | ARG     | OPTIMISM   | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | BTC   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDT  | 100009873 | ARG     | BINANCE    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDT  | 100009873 | ARG     | POLYGON    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | ETH   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

    @SmokeWithdraw @Crypto @BRLv2 @V2
    Scenario Outline: Ejecutar retiro <type> de <asset> mediante <network> para user <country> por V2
        Given The API key is available "PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY"
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
            | type   | asset | userAnyId | country | network    | amount | address                                    |
            | crypto | WLD   | 100009873 | ARG     | WORLDCHAIN | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | crypto | WLD   | 100009873 | ARG     | OPTIMISM   | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @Working
        Examples:
            | type   | asset | userAnyId | country | network  | amount | address                                    |
            | crypto | USDC  | 100009873 | ARG     | OPTIMISM | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | crypto | USDT  | 100009873 | ARG     | POLYGON  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | crypto | USDT  | 100009873 | ARG     | ETHEREUM | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | crypto | USDC  | 100009873 | ARG     | POLYGON  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | crypto | USDC  | 100009873 | ARG     | BASE     | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

    # Examples:
    #     | type   | asset | userAnyId | country | network    | amount | address                                    |
    #     | crypto | WLD   | 100009873 | ARG     | WORLDCHAIN | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | BNB   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDC  | 100009873 | ARG     | OPTIMISM   | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | BTC   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDT  | 100009873 | ARG     | BINANCE    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDT  | 100009873 | ARG     | POLYGON    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | ETH   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

    @SmokeWithdraw @Crypto @CPLv2 @V2
    Scenario Outline: Ejecutar retiro <type> de <asset> mediante <network> para user <country> por V2
        Given The API key is available "PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY"
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
            | type   | asset | userAnyId | country | network    | amount | address                                    |
            | crypto | WLD   | 100009873 | ARG     | WORLDCHAIN | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | crypto | WLD   | 100009873 | ARG     | OPTIMISM   | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @Working
        Examples:
            | type   | asset | userAnyId | country | network  | amount | address                                    |
            | crypto | USDC  | 100009873 | ARG     | OPTIMISM | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | crypto | USDT  | 100009873 | ARG     | POLYGON  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | crypto | USDT  | 100009873 | ARG     | ETHEREUM | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | crypto | USDC  | 100009873 | ARG     | POLYGON  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | crypto | USDC  | 100009873 | ARG     | BASE     | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

    # Examples:
    #     | type   | asset | userAnyId | country | network    | amount | address                                    |
    #     | crypto | WLD   | 100009873 | ARG     | WORLDCHAIN | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | BNB   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDC  | 100009873 | ARG     | OPTIMISM   | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | BTC   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDT  | 100009873 | ARG     | BINANCE    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDT  | 100009873 | ARG     | POLYGON    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | ETH   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

    @SmokeWithdraw @Crypto @COPv2 @V2
    Scenario Outline: Ejecutar retiro <type> de <asset> mediante <network> para user <country> por V2
        Given The API key is available "PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY"
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
            | type   | asset | userAnyId | country | network    | amount | address                                    |
            | crypto | WLD   | 100009873 | ARG     | WORLDCHAIN | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | crypto | WLD   | 100009873 | ARG     | OPTIMISM   | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @Working
        Examples:
            | type   | asset | userAnyId | country | network  | amount | address                                    |
            | crypto | USDC  | 100009873 | ARG     | OPTIMISM | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | crypto | USDT  | 100009873 | ARG     | POLYGON  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | crypto | USDT  | 100009873 | ARG     | ETHEREUM | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | crypto | USDC  | 100009873 | ARG     | POLYGON  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | crypto | USDC  | 100009873 | ARG     | BASE     | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

    # Examples:
    #     | type   | asset | userAnyId | country | network    | amount | address                                    |
    #     | crypto | WLD   | 100009873 | ARG     | WORLDCHAIN | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | BNB   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDC  | 100009873 | ARG     | OPTIMISM   | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | BTC   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDT  | 100009873 | ARG     | BINANCE    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDT  | 100009873 | ARG     | POLYGON    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | ETH   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

    @SmokeWithdraw @Crypto @MXNv2 @V2
    Scenario Outline: Ejecutar retiro <type> de <asset> mediante <network> para user <country> por V2
        Given The API key is available "PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY"
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
            | type   | asset | userAnyId | country | network    | amount | address                                    |
            | crypto | WLD   | 100009873 | ARG     | WORLDCHAIN | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | crypto | WLD   | 100009873 | ARG     | OPTIMISM   | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @Working
        Examples:
            | type   | asset | userAnyId | country | network  | amount | address                                    |
            | crypto | USDC  | 100009873 | ARG     | OPTIMISM | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | crypto | USDT  | 100009873 | ARG     | POLYGON  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | crypto | USDT  | 100009873 | ARG     | ETHEREUM | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | crypto | USDC  | 100009873 | ARG     | POLYGON  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | crypto | USDC  | 100009873 | ARG     | BASE     | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

    # Examples:
    #     | type   | asset | userAnyId | country | network    | amount | address                                    |
    #     | crypto | WLD   | 100009873 | ARG     | WORLDCHAIN | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | BNB   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDC  | 100009873 | ARG     | OPTIMISM   | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | BTC   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDT  | 100009873 | ARG     | BINANCE    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDT  | 100009873 | ARG     | POLYGON    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | ETH   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

    @SmokeWithdraw @Crypto @PANv2 @V2
    Scenario Outline: Ejecutar retiro <type> de <asset> mediante <network> para user <country> por V2
        Given The API key is available "PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY"
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
            | type   | asset | userAnyId | country | network    | amount | address                                    |
            | crypto | WLD   | 100009873 | ARG     | WORLDCHAIN | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | crypto | WLD   | 100009873 | ARG     | OPTIMISM   | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @Working
        Examples:
            | type   | asset | userAnyId | country | network  | amount | address                                    |
            | crypto | USDC  | 100009873 | ARG     | OPTIMISM | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | crypto | USDT  | 100009873 | ARG     | POLYGON  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | crypto | USDT  | 100009873 | ARG     | ETHEREUM | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | crypto | USDC  | 100009873 | ARG     | POLYGON  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | crypto | USDC  | 100009873 | ARG     | BASE     | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

    # Examples:
    #     | type   | asset | userAnyId | country | network    | amount | address                                    |
    #     | crypto | WLD   | 100009873 | ARG     | WORLDCHAIN | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | BNB   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDC  | 100009873 | ARG     | OPTIMISM   | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | BTC   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDT  | 100009873 | ARG     | BINANCE    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDT  | 100009873 | ARG     | POLYGON    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | ETH   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

    @SmokeWithdraw @Crypto @GTQv2 @V2
    Scenario Outline: Ejecutar retiro <type> de <asset> mediante <network> para user <country> por V2
        Given The API key is available "PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY"
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
            | type   | asset | userAnyId | country | network    | amount | address                                    |
            | crypto | WLD   | 100009873 | ARG     | WORLDCHAIN | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | crypto | WLD   | 100009873 | ARG     | OPTIMISM   | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @Working
        Examples:
            | type   | asset | userAnyId | country | network  | amount | address                                    |
            | crypto | USDC  | 100009873 | ARG     | OPTIMISM | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | crypto | USDT  | 100009873 | ARG     | POLYGON  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | crypto | USDT  | 100009873 | ARG     | ETHEREUM | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | crypto | USDC  | 100009873 | ARG     | POLYGON  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | crypto | USDC  | 100009873 | ARG     | BASE     | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

    # Examples:
    #     | type   | asset | userAnyId | country | network    | amount | address                                    |
    #     | crypto | WLD   | 100009873 | ARG     | WORLDCHAIN | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | BNB   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDC  | 100009873 | ARG     | OPTIMISM   | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | BTC   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDT  | 100009873 | ARG     | BINANCE    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDT  | 100009873 | ARG     | POLYGON    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | ETH   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

    @SmokeWithdraw @Crypto @PHPv2 @V2
    Scenario Outline: Ejecutar retiro <type> de <asset> mediante <network> para user <country> por V2
        Given The API key is available "PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY"
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
            | type   | asset | userAnyId | country | network    | amount | address                                    |
            | crypto | WLD   | 100009873 | ARG     | WORLDCHAIN | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | crypto | WLD   | 100009873 | ARG     | OPTIMISM   | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @Working
        Examples:
            | type   | asset | userAnyId | country | network  | amount | address                                    |
            | crypto | USDC  | 100009873 | ARG     | OPTIMISM | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | crypto | USDT  | 100009873 | ARG     | POLYGON  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | crypto | USDT  | 100009873 | ARG     | ETHEREUM | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | crypto | USDC  | 100009873 | ARG     | POLYGON  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | crypto | USDC  | 100009873 | ARG     | BASE     | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

    # Examples:
    #     | type   | asset | userAnyId | country | network    | amount | address                                    |
    #     | crypto | WLD   | 100009873 | ARG     | WORLDCHAIN | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | BNB   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDC  | 100009873 | ARG     | OPTIMISM   | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | BTC   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDT  | 100009873 | ARG     | BINANCE    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDT  | 100009873 | ARG     | POLYGON    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | ETH   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

    @SmokeWithdraw @Crypto @CRCv2 @V2
    Scenario Outline: Ejecutar retiro <type> de <asset> mediante <network> para user <country> por V2
        Given The API key is available "PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY"
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
            | type   | asset | userAnyId | country | network    | amount | address                                    |
            | crypto | WLD   | 100009873 | ARG     | WORLDCHAIN | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
        # | crypto | WLD   | 100009873 | ARG     | OPTIMISM   | 3      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

        @Working
        Examples:
            | type   | asset | userAnyId | country | network  | amount | address                                    |
            | crypto | USDC  | 100009873 | ARG     | OPTIMISM | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | crypto | USDT  | 100009873 | ARG     | POLYGON  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | crypto | USDT  | 100009873 | ARG     | ETHEREUM | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | crypto | USDC  | 100009873 | ARG     | POLYGON  | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
            | crypto | USDC  | 100009873 | ARG     | BASE     | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

    # Examples:
    #     | type   | asset | userAnyId | country | network    | amount | address                                    |
    #     | crypto | WLD   | 100009873 | ARG     | WORLDCHAIN | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | BNB   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDC  | 100009873 | ARG     | OPTIMISM   | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | BTC   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDT  | 100009873 | ARG     | BINANCE    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | USDT  | 100009873 | ARG     | POLYGON    | 1      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |
    #     | crypto | ETH   | 100009873 | ARG     | BINANCE    | 0.001  | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |

    @Smoke3
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