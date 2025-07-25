@Orders
Feature: Ordenes

    Scenario Outline: Ejecutar ordenes de <trade> de <coin> contra <against>
        Given The API key is available "95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<coin>" to the variable "coin"
        And Assign the value "<operation>" to the variable "operation"
        And Assign the value "<userId>" to the variable "userId"
        And Execute the POST method on the endpoint "/v1/order/lock"
        Then Obtain a response 200
        And The price lock is created

        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userId>" to the variable "userId"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<coin>" to the variable "coin"
        And Assign the value "<operation>" to the variable "operation"
        And Assign the value "pixCode" to the variable "code"
        And Execute the POST method on the endpoint "/v1/order"
        Then Obtain a response 200
        And The purchase order is created

        When Wait for the processing of the "orden" por 1 seconds
        And Execute the GET method on the endpoint "/v1/order/{orderNumberId}"
        Then Obtain a response 200 y status COMPLETED

        @Buy
        Examples:
            | sessionId   | trade  | coin     | operation | userId    | amount | against |
            | order-qaa-n | compra | WLD_ARS  | BUY       | 100010451 | 5      | ARS     |
            | order-qaa-n | compra | USDT_ARS | BUY       | 100010451 | 5      | ARS     |
            | order-qaa-n | compra | DAI_ARS  | BUY       | 100010451 | 5      | ARS     |
            | order-qaa-n | compra | USDC_ARS | BUY       | 100010451 | 5      | ARS     |
            | order-qaa-n | compra | ETH_ARS  | BUY       | 100010451 | 0.01   | ARS     |
            | order-qaa-n | compra | BNB_ARS  | BUY       | 100010451 | 0.01   | ARS     |
            | order-qaa-n | compra | BTC_ARS  | BUY       | 100010451 | 0.01   | ARS     |
            | order-qaa-n | compra | POL_ARS  | BUY       | 100010451 | 5      | ARS     |

        @Sell
        Examples:
            | sessionId   | trade | coin     | operation | userId    | amount | against |
            | order-qaa-n | venta | WLD_ARS  | SELL      | 100010451 | 5      | ARS     |
            | order-qaa-n | venta | USDT_ARS | SELL      | 100010451 | 5      | ARS     |
            | order-qaa-n | venta | DAI_ARS  | SELL      | 100010451 | 5      | ARS     |
            | order-qaa-n | venta | USDC_ARS | SELL      | 100010451 | 5      | ARS     |
            | order-qaa-n | venta | ETH_ARS  | SELL      | 100010451 | 0.01   | ARS     |
            | order-qaa-n | venta | BNB_ARS  | SELL      | 100010451 | 0.01   | ARS     |
            | order-qaa-n | venta | BTC_ARS  | SELL      | 100010451 | 0.01   | ARS     |
            | order-qaa-n | venta | POL_ARS  | SELL      | 100010451 | 5      | ARS     |









