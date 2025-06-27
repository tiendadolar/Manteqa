@Withdraw
Feature: Retiros Crypto

    @LockCode
    Scenario Outline: Crear lock de retiro crypto
        Given Contar con la api-key "BM2YZT6-MR5M5YY-QYZ5CY4-E8E9HYB"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "<coin>" a la variable "coin"
        And Asignar el valor "<userId>" a la variable "userId"
        And Asignar el valor "<chain>" a la variable "chain"
        And Ejecutar el método Post al endpoint "/v1/transaction/withdraw/lock"
        Then Se obtiene una respuesta 200
        And Se validan atributos para lock de retiro crypto

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
        Given Contar con la api-key "BM2YZT6-MR5M5YY-QYZ5CY4-E8E9HYB"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "<coin>" a la variable "coin"
        And Asignar el valor "<userId>" a la variable "userId"
        And Asignar el valor "<chain>" a la variable "chain"
        And Ejecutar el método Post al endpoint "/v1/transaction/withdraw/lock"
        Then Se obtiene una respuesta 200

        Given Contar con la api-key "BM2YZT6-MR5M5YY-QYZ5CY4-E8E9HYB"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "<coin>" a la variable "coin"
        And Asignar el valor "<amount>" a la variable "amount"
        And Asignar el valor "<wallet>" a la variable "to"
        And Asignar el valor "<chain>" a la variable "chain"
        And Asignar el valor "<userId>" a la variable "userId"
        And Asignar el valor "code" a la variable "costCode"
        And Ejecutar el método Post al endpoint "/v1/transaction/withdraw"
        Then Se obtiene una respuesta 200

        # Parte 2: Validar ejeccución del sintético
        Given Contar con la api-key "BM2YZT6-MR5M5YY-QYZ5CY4-E8E9HYB"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Esperar procesamiento de la "orden" por 40 segundos
        And Ejecutar el método Get al endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Se obtiene una respuesta 200 y status EXECUTED

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