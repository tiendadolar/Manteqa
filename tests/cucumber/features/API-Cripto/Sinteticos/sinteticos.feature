@Sintetico
Feature: Sintéticos

    # ----- Company No Descubierto -----
    @Syn @RampOn
    Scenario: Creación de sintético Ramp-On
        Given The API key is available "GHJXE4N-J4C432Z-KCNNAN3-PYC7X1N"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "100008209" to the variable "userAnyId"
        And Assign the value "automation-test-n" to the variable "sessionId"
        And Assign the value "USDT" to the variable "asset"
        And Assign the value "ARS" to the variable "against"
        And Assign the value "7" to the variable "assetAmount"
        And Assign the value "0x21534455766A80d11724eCbD3017425c77a014d3" to the variable "withdrawAddress"
        And Assign the value "POLYGON" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v1/synthetics/ramp-on"
        Then Obtain a response 201
        And Se validan atributos para sintético operado en no descubierto

    @Syn @RampOn @DepoBOB
    Scenario: Generar deposito Fiat
        Given The API key is available "C10XB2Z-AG243CS-G42KB2M-4085WTF"
        And The API secret is available "1RpvdT7Vc7ukKeGKdU"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "100009354" to the variable "userId"
        And Assign the value "13150" to the variable "amount"
        And Assign the value "ARS" to the variable "coin"
        # And Assign the value "10000000000000000000" to the variable "bank" opcional (LOCALPAYMENT por ejemplo)
        And Execute the POST method on the endpoint "/v1/fiat/deposit"
        Then Obtain a response 201

    @Syn @partialRampOn
    Scenario: Creación de sintético Partial-Ramp-On
        Given The API key is available "GHJXE4N-J4C432Z-KCNNAN3-PYC7X1N"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "100007676" to the variable "userAnyId"
        And Assign the value "automation-test-n" to the variable "sessionId"
        And Assign the value "USDT" to the variable "asset"
        And Assign the value "ARS" to the variable "against"
        And Assign the value "7" to the variable "assetAmount"
        And Assign the value "0x96E8C5474f4D1fa9f4097b9B9de3f14E65Cb98Ed" to the variable "withdrawAddress"
        And Assign the value "POLYGON" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v1/synthetics/partial-ramp-on"
        Then Obtain a response 201

    @Syn @partialRampOn
    Scenario: Generar deposito Fiat
        Given The API key is available "C10XB2Z-AG243CS-G42KB2M-4085WTF"
        And The API secret is available "BuFJx56wuzdQArJktt"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "100007676" to the variable "userId"
        And Assign the value "amount" to the variable "amount"
        And Assign the value "coin" to the variable "coin"
        # And Assign the value "10000000000000000000" to the variable "bank" opcional (LOCALPAYMENT por ejemplo)
        And Execute the POST method on the endpoint "/v1/fiat/deposit"
        Then Obtain a response 201

    @Syn @RampOff
    Scenario: Creación de sintético Ramp-Off
        Given The API key is available "GHJXE4N-J4C432Z-KCNNAN3-PYC7X1N"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "100008189" to the variable "userAnyId"
        And Assign the value "automation-test-n" to the variable "sessionId"
        And Assign the value "USDT" to the variable "asset"
        And Assign the value "ARS" to the variable "against"
        And Assign the value "13500" to the variable "againstAmount"
        And Assign the value "0140420703690150418728" to the variable "withdrawAddress"
        And Assign the value "POLYGON" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v1/synthetics/ramp-off"
        Then Obtain a response 201

    @Syn @RampOff
    Scenario: Generar deposito Crypto
        # Apikey de TC
        Given The API key is available "C10XB2Z-AG243CS-G42KB2M-4085WTF"
        # apiSecret de la company del user
        And The API secret is available "BuFJx56wuzdQArJktt"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "0of00s808a0s0a0d0000129tfd00000f00f0c0cz00fi00efb0000t00000i1g0f" to the variable "hash"
        And Assign the value "0x9bD31d82B6212dd60a9328CCe7277161e5975fB5" to the variable "from"
        And Assign the value "0x21534455766A80d11724eCbD3017425c77a014d2" to the variable "to"
        And Assign the value "10000000000000000000" to the variable "wei"
        And Assign the value "10" to the variable "human"
        And Assign the value "USDT" to the variable "ticker"
        And Assign the value 0 to the variable "chain"
        And Execute the POST method on the endpoint "/v1/transaction/deposit"
        Then Obtain a response 201

    @Syn @partialRampOff
    Scenario: Creación de sintético Partial-Ramp-Off
        Given The API key is available "GHJXE4N-J4C432Z-KCNNAN3-PYC7X1N"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "100007676" to the variable "userAnyId"
        And Assign the value "automation-test-n" to the variable "sessionId"
        And Assign the value "USDT" to the variable "asset"
        And Assign the value "ARS" to the variable "against"
        And Assign the value "13500" to the variable "againstAmount"
        And Assign the value "0140420703690150418728" to the variable "withdrawAddress"
        And Assign the value "POLYGON" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v1/synthetics/partial-ramp-off"
        Then Obtain a response 201

    @Syn @partialRampOff
    Scenario: Generar deposito Crypto
        Given The API key is available "C10XB2Z-AG243CS-G42KB2M-4085WTF"
        And The API secret is available "BuFJx56wuzdQArJktt"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "0of00s808a0s0a0d0000129tfd00000f00f0c0cz00fi00efb0000t00000i1g0f" to the variable "hash"
        And Assign the value "0x9bD31d82B6212dd60a9328CCe7277161e5975fB5" to the variable "from"
        And Assign the value "0x96E8C5474f4D1fa9f4097b9B9de3f14E65Cb98Ed" to the variable "to"
        And Assign the value "10000000000000000000" to the variable "wei"
        And Assign the value "10" to the variable "human"
        And Assign the value "USDT" to the variable "ticker"
        And Assign the value 0 to the variable "chain"
        And Execute the POST method on the endpoint "/v1/transaction/deposit"
        Then Obtain a response 201
    # ----- Company No Descubierto -----
    # ----- ---------------------- -----
    # ----- Company Descubierto -----
    @SynDesc @RampOnDesc
    Scenario: Creación de sintético Ramp-On
        Given The API key is available "JYM3AK8-XXGME8N-JZDQCP7-Q16T2NX"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "100007698" to the variable "userAnyId"
        And Assign the value "automation-test-n" to the variable "sessionId"
        And Assign the value "USDT" to the variable "asset"
        And Assign the value "ARS" to the variable "against"
        And Assign the value "7" to the variable "assetAmount"
        And Assign the value "0x12e47c3B39896B7871700A9d409B51231AC078B8" to the variable "withdrawAddress"
        And Assign the value "POLYGON" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v1/synthetics/ramp-on"
        Then Obtain a response 201

    @SynDesc @partialRampOnDesc
    Scenario: Creación de sintético Partial-Ramp-On
        Given The API key is available "JYM3AK8-XXGME8N-JZDQCP7-Q16T2NX"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "100007698" to the variable "userAnyId"
        And Assign the value "automation-test-n" to the variable "sessionId"
        And Assign the value "USDT" to the variable "asset"
        And Assign the value "ARS" to the variable "against"
        And Assign the value "7" to the variable "assetAmount"
        And Assign the value "0x12e47c3B39896B7871700A9d409B51231AC078B8" to the variable "withdrawAddress"
        And Assign the value "POLYGON" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v1/synthetics/partial-ramp-on"
        Then Obtain a response 201

    @SynDesc @RampOffDesc
    Scenario: Creación de sintético Ramp-Off
        Given The API key is available "JYM3AK8-XXGME8N-JZDQCP7-Q16T2NX"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "100007698" to the variable "userAnyId"
        And Assign the value "automation-test-n" to the variable "sessionId"
        And Assign the value "USDT" to the variable "asset"
        And Assign the value "ARS" to the variable "against"
        And Assign the value "13500" to the variable "againstAmount"
        And Assign the value "0140420703690150418728" to the variable "withdrawAddress"
        And Assign the value "POLYGON" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v1/synthetics/ramp-off"
        Then Obtain a response 201

    @SynDesc @partialRampOffDesc
    Scenario: Creación de sintético Ramp-Off
        Given The API key is available "JYM3AK8-XXGME8N-JZDQCP7-Q16T2NX"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "100007698" to the variable "userAnyId"
        And Assign the value "automation-test-n" to the variable "sessionId"
        And Assign the value "USDT" to the variable "asset"
        And Assign the value "ARS" to the variable "against"
        And Assign the value "13500" to the variable "againstAmount"
        And Assign the value "0000003100000341514293" to the variable "withdrawAddress"
        And Assign the value "POLYGON" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v1/synthetics/partial-ramp-off"
        Then Obtain a response 201
    # ----- Company Descubierto -----


    # ----- REGRESSION NO TOCAR -----
    # ----- Company No Descubierto -----

    @Regression @RampOn
    Scenario: Creación de sintético Ramp-On con asset
        Given The API key is available "P0H3ZHM-N2EM338-PRP6BA7-S3NTRJD"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "100008214" to the variable "userAnyId"
        And Assign the value "automation-test-n" to the variable "sessionId"
        And Assign the value "USDT" to the variable "asset"
        And Assign the value "ARS" to the variable "against"
        And Assign the value "10" to the variable "assetAmount"
        And Assign the value "0x21534455766A80d11724eCbD3017425c77a014d3" to the variable "withdrawAddress"
        And Assign the value "POLYGON" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v1/synthetics/ramp-on"
        Then Obtain a response 201
        And Se validan atributos para sintético ramp-on operado en no descubierto

    @Regression @RampOn
    Scenario: Generar deposito Fiat
        Given The API key is available "C10XB2Z-AG243CS-G42KB2M-4085WTF"
        And The API secret is available "rcrgtDnGxjY2AYC5qs"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "100008214" to the variable "userId"
        And Assign the value "amount" to the variable "amount"
        And Assign the value "coin" to the variable "coin"
        # And Assign the value "10000000000000000000" to the variable "bank" opcional (LOCALPAYMENT por ejemplo)
        And Execute the POST method on the endpoint "/v1/fiat/deposit"
        Then Obtain a response 201

    @Regression @RampOn
    Scenario: Validar ejecución del sintético Ramp-On
        Given The API key is available "P0H3ZHM-N2EM338-PRP6BA7-S3NTRJD"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Wait for the processing of the "orden" por 40 seconds
        And Execute the GET method on the endpoint "/v2/synthetics/{syntheticId}"
        Then Obtain a response 200 y status COMPLETED

    @Regression @RampOn
    Scenario: Creación de sintético Ramp-On con against
        Given The API key is available "P0H3ZHM-N2EM338-PRP6BA7-S3NTRJD"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "100008214" to the variable "userAnyId"
        And Assign the value "automation-test-n" to the variable "sessionId"
        And Assign the value "USDT" to the variable "asset"
        And Assign the value "ARS" to the variable "against"
        And Assign the value "15000" to the variable "againstAmount"
        And Assign the value "0x21534455766A80d11724eCbD3017425c77a014d3" to the variable "withdrawAddress"
        And Assign the value "POLYGON" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v1/synthetics/ramp-on"
        Then Obtain a response 201
        And Se validan atributos para sintético ramp-on operado en no descubierto

    @Regression @RampOn
    Scenario: Generar deposito Fiat
        Given The API key is available "C10XB2Z-AG243CS-G42KB2M-4085WTF"
        And The API secret is available "rcrgtDnGxjY2AYC5qs"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "100008214" to the variable "userId"
        And Assign the value "amount" to the variable "amount"
        And Assign the value "coin" to the variable "coin"
        # And Assign the value "10000000000000000000" to the variable "bank" opcional (LOCALPAYMENT por ejemplo)
        And Execute the POST method on the endpoint "/v1/fiat/deposit"
        Then Obtain a response 201

    @Regression @RampOn
    Scenario: Validar ejecución del sintético Ramp-On
        Given The API key is available "P0H3ZHM-N2EM338-PRP6BA7-S3NTRJD"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Wait for the processing of the "orden" por 40 seconds
        And Execute the GET method on the endpoint "/v2/synthetics/{syntheticId}"
        Then Obtain a response 200 y status COMPLETED

    @Regression @RampOn
    Scenario: Creación de sintético Ramp-On con asset valor limite mínimo
        Given The API key is available "P0H3ZHM-N2EM338-PRP6BA7-S3NTRJD"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "100008214" to the variable "userAnyId"
        And Assign the value "automation-test-n" to the variable "sessionId"
        And Assign the value "USDT" to the variable "asset"
        And Assign the value "ARS" to the variable "against"
        And Assign the value "0.1" to the variable "assetAmount"
        And Assign the value "0x21534455766A80d11724eCbD3017425c77a014d3" to the variable "withdrawAddress"
        And Assign the value "POLYGON" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v1/synthetics/ramp-on"
        Then Obtain a response 201
        And Se validan atributos para sintético ramp-on operado en no descubierto

    @Regression @RampOn
    Scenario: Generar deposito Fiat
        Given The API key is available "C10XB2Z-AG243CS-G42KB2M-4085WTF"
        And The API secret is available "rcrgtDnGxjY2AYC5qs"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "100008214" to the variable "userId"
        And Assign the value "amount" to the variable "amount"
        And Assign the value "coin" to the variable "coin"
        # And Assign the value "10000000000000000000" to the variable "bank" opcional (LOCALPAYMENT por ejemplo)
        And Execute the POST method on the endpoint "/v1/fiat/deposit"
        Then Obtain a response 201

    @Regression @RampOn
    Scenario: Validar ejecución del sintético Ramp-On
        Given The API key is available "P0H3ZHM-N2EM338-PRP6BA7-S3NTRJD"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Wait for the processing of the "orden" por 40 seconds
        And Execute the GET method on the endpoint "/v2/synthetics/{syntheticId}"
        Then Obtain a response 200 y status COMPLETED

    @Regression @RampOn
    Scenario: Creación de sintético Ramp-On con against valor limite mínimo
        Given The API key is available "P0H3ZHM-N2EM338-PRP6BA7-S3NTRJD"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "100008214" to the variable "userAnyId"
        And Assign the value "automation-test-n" to the variable "sessionId"
        And Assign the value "USDT" to the variable "asset"
        And Assign the value "ARS" to the variable "against"
        And Assign the value "130" to the variable "againstAmount"
        And Assign the value "0x21534455766A80d11724eCbD3017425c77a014d3" to the variable "withdrawAddress"
        And Assign the value "POLYGON" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v1/synthetics/ramp-on"
        Then Obtain a response 201
        And Se validan atributos para sintético ramp-on operado en no descubierto

    @Regression @RampOn
    Scenario: Generar deposito Fiat
        Given The API key is available "C10XB2Z-AG243CS-G42KB2M-4085WTF"
        And The API secret is available "rcrgtDnGxjY2AYC5qs"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "100008214" to the variable "userId"
        And Assign the value "amount" to the variable "amount"
        And Assign the value "coin" to the variable "coin"
        # And Assign the value "10000000000000000000" to the variable "bank" opcional (LOCALPAYMENT por ejemplo)
        And Execute the POST method on the endpoint "/v1/fiat/deposit"
        Then Obtain a response 201

    @Regression @RampOn
    Scenario: Validar ejecución del sintético Ramp-On
        Given The API key is available "P0H3ZHM-N2EM338-PRP6BA7-S3NTRJD"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Wait for the processing of the "orden" por 40 seconds
        And Execute the GET method on the endpoint "/v2/synthetics/{syntheticId}"
        Then Obtain a response 200 y status COMPLETED

    @Regression @E2EFlow
    Scenario Outline: Flujo E2E Ramp-On con Depósito
        # Parte 1: Creación de sintético
        Given The API key is available "P0H3ZHM-N2EM338-PRP6BA7-S3NTRJD"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Assign the value "<withdrawAddress>" to the variable "withdrawAddress"
        And Assign the value "<withdrawNetwork>" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v1/synthetics/ramp-on"
        Then Obtain a response 201
        # And Se validan atributos para sintético ramp-on operado en no descubierto

        # Parte 2: Generar depósito
        Given The API key is available "C10XB2Z-AG243CS-G42KB2M-4085WTF"
        And The API secret is available "rcrgtDnGxjY2AYC5qs"
        When Assign the value "100008214" to the variable "userId"
        And Assign the value "amount" to the variable "amount"
        And Assign the value "coin" to the variable "coin"
        And Execute the POST method on the endpoint "/v1/fiat/deposit"
        Then Obtain a response 201

        # Parte 2: Validar ejeccución del sintético
        Given The API key is available "P0H3ZHM-N2EM338-PRP6BA7-S3NTRJD"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Wait for the processing of the "orden" por 40 seconds
        And Execute the GET method on the endpoint "/v2/synthetics/{syntheticId}"
        Then Obtain a response 200 y status COMPLETED

        Examples:
            | userAnyId | sessionId         | asset | against | assetAmount | withdrawAddress                            | withdrawNetwork |
            | 100008214 | regression-test-n | USDT  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | ETHEREUM        |
            | 100008214 | regression-test-n | DAI   | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | ETHEREUM        |
            | 100008214 | regression-test-n | BUSD  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | ETHEREUM        |
            | 100008214 | regression-test-n | USDC  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | ETHEREUM        |
            | 100008214 | regression-test-n | USDCB | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | ETHEREUM        |
            | 100008214 | regression-test-n | UST   | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | ETHEREUM        |
            | 100008214 | regression-test-n | ETH   | ARS     | 1           | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | ETHEREUM        |
            | 100008214 | regression-test-n | BNB   | ARS     | 1           | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | ETHEREUM        |
            | 100008214 | regression-test-n | AUST  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | ETHEREUM        |
            | 100008214 | regression-test-n | BTC   | ARS     | 1           | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | ETHEREUM        |
            | 100008214 | regression-test-n | LUNA  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | ETHEREUM        |
            | 100008214 | regression-test-n | LUNA2 | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | ETHEREUM        |
            | 100008214 | regression-test-n | SOL   | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | ETHEREUM        |
            | 100008214 | regression-test-n | MATIC | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | ETHEREUM        |
            | 100008214 | regression-test-n | NUARS | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | ETHEREUM        |
            | 100008214 | regression-test-n | WLD   | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | WORLDCHAIN      |
            | 100008214 | regression-test-n | USDL  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | ETHEREUM        |
            | 100008214 | regression-test-n | SDAI  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | ETHEREUM        |
            | 100008214 | regression-test-n | AXS   | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | ETHEREUM        |
            | 100008214 | regression-test-n | MANA  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | ETHEREUM        |
            | 100008214 | regression-test-n | USDT  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | POLYGON         |
            | 100008214 | regression-test-n | DAI   | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | POLYGON         |
            | 100008214 | regression-test-n | BUSD  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | POLYGON         |
            | 100008214 | regression-test-n | USDC  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | POLYGON         |
            | 100008214 | regression-test-n | USDCB | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | POLYGON         |
            | 100008214 | regression-test-n | UST   | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | POLYGON         |
            | 100008214 | regression-test-n | ETH   | ARS     | 1           | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | POLYGON         |
            | 100008214 | regression-test-n | BNB   | ARS     | 1           | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | POLYGON         |
            | 100008214 | regression-test-n | AUST  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | POLYGON         |
            | 100008214 | regression-test-n | BTC   | ARS     | 1           | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | POLYGON         |
            | 100008214 | regression-test-n | LUNA  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | POLYGON         |
            | 100008214 | regression-test-n | LUNA2 | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | POLYGON         |
            | 100008214 | regression-test-n | SOL   | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | POLYGON         |
            | 100008214 | regression-test-n | MATIC | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | POLYGON         |
            | 100008214 | regression-test-n | NUARS | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | POLYGON         |
            | 100008214 | regression-test-n | USDL  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | POLYGON         |
            | 100008214 | regression-test-n | SDAI  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | POLYGON         |
            | 100008214 | regression-test-n | AXS   | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | POLYGON         |
            | 100008214 | regression-test-n | MANA  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | POLYGON         |
            | 100008214 | regression-test-n | USDT  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | BINANCE         |
            | 100008214 | regression-test-n | DAI   | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | BINANCE         |
            | 100008214 | regression-test-n | BUSD  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | BINANCE         |
            | 100008214 | regression-test-n | USDC  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | BINANCE         |
            | 100008214 | regression-test-n | USDCB | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | BINANCE         |
            | 100008214 | regression-test-n | UST   | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | BINANCE         |
            | 100008214 | regression-test-n | ETH   | ARS     | 1           | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | BINANCE         |
            | 100008214 | regression-test-n | BNB   | ARS     | 1           | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | BINANCE         |
            | 100008214 | regression-test-n | AUST  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | BINANCE         |
            | 100008214 | regression-test-n | BTC   | ARS     | 1           | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | BINANCE         |
            | 100008214 | regression-test-n | LUNA  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | BINANCE         |
            | 100008214 | regression-test-n | LUNA2 | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | BINANCE         |
            | 100008214 | regression-test-n | SOL   | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | BINANCE         |
            | 100008214 | regression-test-n | MATIC | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | BINANCE         |
            | 100008214 | regression-test-n | NUARS | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | BINANCE         |
            | 100008214 | regression-test-n | USDL  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | BINANCE         |
            | 100008214 | regression-test-n | SDAI  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | BINANCE         |
            | 100008214 | regression-test-n | AXS   | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | BINANCE         |
            | 100008214 | regression-test-n | MANA  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | BINANCE         |
            | 100008214 | regression-test-n | USDT  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | BINANCE         |
            | 100008214 | regression-test-n | USDT  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | OPTIMISM        |
            | 100008214 | regression-test-n | DAI   | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | OPTIMISM        |
            | 100008214 | regression-test-n | BUSD  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | OPTIMISM        |
            | 100008214 | regression-test-n | USDC  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | OPTIMISM        |
            | 100008214 | regression-test-n | USDCB | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | OPTIMISM        |
            | 100008214 | regression-test-n | UST   | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | OPTIMISM        |
            | 100008214 | regression-test-n | ETH   | ARS     | 1           | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | OPTIMISM        |
            | 100008214 | regression-test-n | BNB   | ARS     | 1           | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | OPTIMISM        |
            | 100008214 | regression-test-n | AUST  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | OPTIMISM        |
            | 100008214 | regression-test-n | BTC   | ARS     | 1           | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | OPTIMISM        |
            | 100008214 | regression-test-n | LUNA  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | OPTIMISM        |
            | 100008214 | regression-test-n | LUNA2 | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | OPTIMISM        |
            | 100008214 | regression-test-n | SOL   | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | OPTIMISM        |
            | 100008214 | regression-test-n | MATIC | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | OPTIMISM        |
            | 100008214 | regression-test-n | NUARS | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | OPTIMISM        |
            | 100008214 | regression-test-n | USDL  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | OPTIMISM        |
            | 100008214 | regression-test-n | SDAI  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | OPTIMISM        |
            | 100008214 | regression-test-n | AXS   | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | OPTIMISM        |
            | 100008214 | regression-test-n | MANA  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | OPTIMISM        |

    #! ************** E2E **************
    # ----- Descubierto -----
    # ----- LooselyManagedAssets -----
    @Smoke @E2EFlow @RampOnDesc
    Scenario Outline: Flujo E2E Ramp-On descubierto loosely managed generando deuda a la company "<asset>" contra "<against>"

        # Parte 1: Creación de sintético
        Given The API key is available "RR3XN5E-R8MMCGX-PPVNJT6-GSK7BF2"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"

        And Obtain a company debt "<against>" balance

        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Assign the value "<withdrawAddress>" to the variable "withdrawAddress"
        And Assign the value "<withdrawNetwork>" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v2/synthetics/ramp-on"
        Then Obtain a response 201

        # Parte 2: Validar ejeccución del sintético
        When Wait for the processing of the "orden" por 60 seconds
        And Execute the GET method on the endpoint "/v2/synthetics/{syntheticId}"
        Then Obtain a response 200 y status "COMPLETED"

        And Obtain a company debt "<against>" balance

        Examples:
            | userAnyId | sessionId                | asset | against | assetAmount | withdrawAddress                            | withdrawNetwork |
            | 100009780 | smoke-rampOn-DESC-test-n | WLD   | ARS     | 3           | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | WORLDCHAIN      |
            | 100009780 | smoke-rampOn-DESC-test-n | USDT  | ARS     | 5           | 0xd673e64ea7b8689920c957414d01c488B5a4fab5 | ETHEREUM        |
            | 100009780 | smoke-rampOn-DESC-test-n | DAI   | ARS     | 5           | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | ETHEREUM        |

    @Smoke @E2EFlow @RampOnDesc
    Scenario Outline: Flujo E2E Ramp-On descubierto loosely managed con deposito "<asset>" contra "<against>"
        # Parte 1: Creación de sintético
        Given The API key is available "RR3XN5E-R8MMCGX-PPVNJT6-GSK7BF2"
        And The API secret is available "tNYgnM4sZR2ypkEDnU"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"

        And Obtain a company debt "<against>" balance

        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Assign the value "<disallowDebt>" to the variable "disallowDebt"
        And Assign the value "<withdrawAddress>" to the variable "withdrawAddress"
        And Assign the value "<withdrawNetwork>" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v2/synthetics/ramp-on"
        Then Obtain a response 201

        # Parte 2: Generar depósito
        Given Execute fiat deposit

        # Parte 2: Validar ejeccución del sintético
        When Wait for the processing of the "orden" por 60 seconds
        And Execute the GET method on the endpoint "/v2/synthetics/{syntheticId}"
        Then Obtain a response 200 y status "COMPLETED"

        And Obtain a company debt "<against>" balance

        Examples:
            | userAnyId | sessionId                | asset | against | assetAmount | disallowDebt | withdrawAddress                            | withdrawNetwork |
            | 100009780 | smoke-rampOn-DESC-test-n | WLD   | ARS     | 3           | true         | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | WORLDCHAIN      |

    @Smoke @E2EFlow @RampOnDesc
    Scenario Outline: Flujo E2E Ramp-On descubierto loosely managed operando desde userBalance "<asset>" contra "<against>"
        # Parte 1: Creación de sintético
        Given The API key is available "RR3XN5E-R8MMCGX-PPVNJT6-GSK7BF2"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"

        And Obtain "<against>" balance for "<userAnyId>" user

        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Assign the value "<withdrawAddress>" to the variable "withdrawAddress"
        And Assign the value "<withdrawNetwork>" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v2/synthetics/ramp-on"
        Then Obtain a response 201

        # Parte 2: Validar ejeccución del sintético
        When Wait for the processing of the "orden" por 60 seconds
        And Execute the GET method on the endpoint "/v2/synthetics/{syntheticId}"
        Then Obtain a response 200 y status "COMPLETED"

        And Obtain "<against>" balance for "<userAnyId>" user

        Examples:
            | userAnyId | sessionId                | asset | against | assetAmount | disallowDebt | withdrawAddress                            | withdrawNetwork |
            | 100009788 | smoke-rampOn-DESC-test-n | WLD   | ARS     | 3           | true         | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | WORLDCHAIN      |

    @Smoke @E2EFlow @RampOnDesc @TRON
    Scenario Outline: Flujo E2E Ramp-On descubierto loosely managed generando deuda a la company "<asset>" contra "<against>"

        # Parte 1: Creación de sintético
        Given The API key is available "RR3XN5E-R8MMCGX-PPVNJT6-GSK7BF2"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"

        And Obtain a company debt "<against>" balance

        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Assign the value "<withdrawAddress>" to the variable "withdrawAddress"
        And Assign the value "<withdrawNetwork>" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v2/synthetics/ramp-on"
        Then Obtain a response 201

        # Parte 2: Validar ejeccución del sintético
        When Wait for the processing of the "orden" por 120 seconds
        And Execute the GET method on the endpoint "/v2/synthetics/{syntheticId}"
        Then Obtain a response 200 y status "COMPLETED"

        And Obtain a company debt "<against>" balance

        Examples:
            | userAnyId | sessionId                | asset | against | assetAmount | withdrawAddress                    | withdrawNetwork |
            | 100009780 | smoke-rampOn-DESC-test-n | TRX   | ARS     | 3           | TRaHQ7KfnkQHCM8zFyX7HrNmMkr54A9oyM | TRON            |
            | 100009780 | smoke-rampOn-DESC-test-n | USDT  | ARS     | 3           | TRaHQ7KfnkQHCM8zFyX7HrNmMkr54A9oyM | TRON            |

    # Se ejecuta solo el stage de orden
    @Smoke @E2EFlow @PartialRampOnDesc
    Scenario Outline: Flujo E2E Partial-Ramp-On descubierto loosely managed generando deuda a la company "<asset>" contra "<against>"
        # Parte 1: Creación de sintético
        Given The API key is available "RR3XN5E-R8MMCGX-PPVNJT6-GSK7BF2"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"

        And Obtain a company debt "<against>" balance

        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Assign the value "<withdrawAddress>" to the variable "withdrawAddress"
        And Assign the value "<withdrawNetwork>" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v1/synthetics/partial-ramp-on"
        Then Obtain a response 201

        # Parte 2: Validar ejeccución del sintético
        When Wait for the processing of the "orden" por 40 seconds
        And Execute the GET method on the endpoint "/v2/synthetics/{syntheticId}"
        Then Obtain a response 200 y status "COMPLETED"

        And Obtain a company debt "<against>" balance

        Examples:
            | userAnyId | sessionId                       | asset | against | assetAmount | withdrawAddress                            | withdrawNetwork |
            | 100009781 | smoke-partialRampOn-DESC-test-n | WLD   | ARS     | 3           | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | WORLDCHAIN      |
            | 100009781 | smoke-partialRampOn-DESC-test-n | USDT  | ARS     | 5           | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | ETHEREUM        |
            | 100009781 | smoke-partialRampOn-DESC-test-n | DAI   | ARS     | 5           | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | ETHEREUM        |

    # ----- PartiallyManagedAssets -----
    @Smoke @E2EFlow @RampOnDesc
    Scenario Outline: Flujo E2E Ramp-On descubierto partially managed generando deuda a la company "<asset>" contra "<against>"

        # Parte 1: Creación de sintético
        Given The API key is available "XW0SRXM-TEGM71S-KS8B5MA-ZF1Z79F"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"

        And Obtain a company debt "<against>" balance

        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Assign the value "<withdrawAddress>" to the variable "withdrawAddress"
        And Assign the value "<withdrawNetwork>" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v2/synthetics/ramp-on"
        Then Obtain a response 201

        # Parte 2: Validar ejeccución del sintético
        When Wait for the processing of the "orden" por 60 seconds
        And Execute the GET method on the endpoint "/v2/synthetics/{syntheticId}"
        Then Obtain a response 200 y status "COMPLETED"

        And Obtain a company debt "<against>" balance

        Examples:
            | userAnyId | sessionId                | asset | against | assetAmount | withdrawAddress                            | withdrawNetwork |
            | 100011129 | smoke-rampOn-DESC-test-n | USDT  | ARS     | 5           | 0xd673e64ea7b8689920c957414d01c488B5a4fab5 | ETHEREUM        |


    @Smoke @E2EFlow @RampOnDesc @t
    Scenario Outline: Flujo E2E Ramp-On descubierto partially managed deposit stage "<asset>" contra "<against>"

        # Parte 1: Creación de sintético
        Given The API key is available "XW0SRXM-TEGM71S-KS8B5MA-ZF1Z79F"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"

        And Obtain "<against>" balance for "<userAnyId>" user

        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Assign the value "<disallowDebt>" to the variable "disallowDebt"
        And Assign the value "<withdrawAddress>" to the variable "withdrawAddress"
        And Assign the value "<withdrawNetwork>" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v2/synthetics/ramp-on"
        Then Obtain a response 201

        # Parte 2: Validar ejeccución del sintético
        When Wait for the processing of the "orden" por 60 seconds
        And Execute the GET method on the endpoint "/v2/synthetics/{syntheticId}"
        Then Obtain a response 200 y status "COMPLETED"

        And Obtain "<against>" balance for "<userAnyId>" user

        Examples:
            | userAnyId | sessionId                | asset | against | assetAmount | disallowDebt | withdrawAddress                            | withdrawNetwork |
            | 100011129 | smoke-rampOn-DESC-test-n | WLD   | ARS     | 3           | true         | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | WORLDCHAIN      |

    # ----- No Descubierto -----

    @Smoke @E2EFlow @RampOn
    Scenario Outline: Flujo E2E Ramp-On no descubierto "<asset>" constra "<against>"
        # Parte 1: Creación de sintético
        Given The API key is available "<apiKEY>"
        And The API secret is available "6RcTZScYUFb2bq9qWq"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"

        And Obtain "<against>" balance for "<userAnyId>" user

        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Assign the value "<withdrawAddress>" to the variable "withdrawAddress"
        And Assign the value "<withdrawNetwork>" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v1/synthetics/ramp-on"
        Then Obtain a response 201
        # And Se validan atributos para sintético ramp-on operado en no descubierto

        # Parte 2: Generar depósito
        Given Execute fiat deposit

        # Parte 2: Validar ejeccución del sintético
        When Wait for the processing of the "orden" por 45 seconds
        And Execute the GET method on the endpoint "/v2/synthetics/{syntheticId}"
        Then Obtain a response 200 y status "COMPLETED"

        And Obtain "<against>" balance for "<userAnyId>" user

        Examples:
            | apiKEY                          | userAnyId | sessionId    | asset | against | assetAmount | withdrawAddress                            | withdrawNetwork |
            | P0H3ZHM-N2EM338-PRP6BA7-S3NTRJD | 100008214 | smoke-test-n | WLD   | ARS     | 3           | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | WORLDCHAIN      |
            | P0H3ZHM-N2EM338-PRP6BA7-S3NTRJD | 100008214 | smoke-test-n | USDT  | ARS     | 10          | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | ETHEREUM        |
            | P0H3ZHM-N2EM338-PRP6BA7-S3NTRJD | 100008214 | smoke-test-n | DAI   | ARS     | 10          | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | ETHEREUM        |

    @Smoke @E2EFlow @RampOn @Tron
    Scenario Outline: Flujo E2E Ramp-On no descubierto "<asset>" contra "<against>"
        # Parte 1: Creación de sintético
        Given The API key is available "<apiKEY>"
        And The API secret is available "6RcTZScYUFb2bq9qWq"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"

        And Obtain "<against>" balance for "<userAnyId>" user

        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Assign the value "<withdrawAddress>" to the variable "withdrawAddress"
        And Assign the value "<withdrawNetwork>" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v1/synthetics/ramp-on"
        Then Obtain a response 201
        # And Se validan atributos para sintético ramp-on operado en no descubierto

        # Parte 2: Generar depósito
        Given Execute fiat deposit

        # Parte 2: Validar ejeccución del sintético
        When Wait for the processing of the "orden" por 120 seconds
        And Execute the GET method on the endpoint "/v2/synthetics/{syntheticId}"
        Then Obtain a response 200 y status "COMPLETED"

        And Obtain "<against>" balance for "<userAnyId>" user

        Examples:
            | apiKEY                          | userAnyId | sessionId    | asset | against | assetAmount | withdrawAddress                    | withdrawNetwork |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | 100011193 | smoke-test-n | TRX   | ARS     | 5           | TRaHQ7KfnkQHCM8zFyX7HrNmMkr54A9oyM | TRON            |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | 100011193 | smoke-test-n | USDT  | ARS     | 5           | TRaHQ7KfnkQHCM8zFyX7HrNmMkr54A9oyM | TRON            |

    @Smoke @E2EFlow @RampOn @testr
    Scenario Outline: Flujo E2E Ramp-On no descubierto operando desde el user balance "<asset>" contra "<against>"
        # Parte 1: Creación de sintético
        Given The API key is available "<apiKEY>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"

        And Obtain "<against>" balance for "<userAnyId>" user

        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Assign the value "<skipDeposit>" to the variable "skipDeposit"
        And Assign the value "<withdrawAddress>" to the variable "withdrawAddress"
        And Assign the value "<withdrawNetwork>" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v1/synthetics/ramp-on"
        Then Obtain a response 201

        # Parte 2: Validar ejeccución del sintético
        When Wait for the processing of the "orden" por 45 seconds
        And Execute the GET method on the endpoint "/v2/synthetics/{syntheticId}"
        Then Obtain a response 200 y status "COMPLETED"

        And Obtain "<against>" balance for "<userAnyId>" user

        Examples:
            | apiKEY                          | userAnyId | sessionId    | asset | against | assetAmount | skipDeposit | withdrawAddress                            | withdrawNetwork |
            | P0H3ZHM-N2EM338-PRP6BA7-S3NTRJD | 100008214 | smoke-test-n | WLD   | ARS     | 3           | true        | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | WORLDCHAIN      |

    @Smoke @E2EFlow @RampOff
    Scenario Outline: Flujo E2E Ramp-Off no descubierto "<asset>" constra "<against>"
        # Parte 1: Creación de sintético
        Given The API key is available "P0H3ZHM-N2EM338-PRP6BA7-S3NTRJD"
        And The API secret is available "6RcTZScYUFb2bq9qWq"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"

        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Assign the value "<withdrawAddress>" to the variable "withdrawAddress"
        And Assign the value "<withdrawNetwork>" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v1/synthetics/ramp-off"
        Then Obtain a response 201
        # And Se validan atributos para sintético ramp-on operado en no descubierto

        # Parte 2: Generar depósito
        Given Execute crypto deposit

        # Parte 2: Validar ejeccución del sintético
        When Wait for the processing of the "orden" por 20 seconds
        And Execute the GET method on the endpoint "/v2/synthetics/{syntheticId}"
        Then Obtain a response 200 y status "COMPLETED"

        Examples:
            | userAnyId | sessionId    | asset | against | assetAmount | withdrawAddress        | withdrawNetwork | to                                         | ticker | chain |
            | 100009688 | smoke-test-n | WLD   | ARS     | 3           | 4530000800015017168564 | WORLDCHAIN      | 0xFFb66dD89211C43Dd76cF7fbE287172bDF35A187 | WLD    | 6     |
            | 100009688 | smoke-test-n | USDT  | ARS     | 3           | 4530000800015017168564 | ETHEREUM        | 0xFFb66dD89211C43Dd76cF7fbE287172bDF35A187 | USDT   | 0     |
            | 100009688 | smoke-test-n | DAI   | ARS     | 5           | 4530000800015017168564 | ETHEREUM        | 0xFFb66dD89211C43Dd76cF7fbE287172bDF35A187 | DAI    | 0     |

    @Smoke @E2EFlow @RampOff @Tron
    Scenario Outline: Flujo E2E Ramp-Off no descubierto "<asset>" constra "<against>"
        # Parte 1: Creación de sintético
        Given The API key is available "B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV"
        And The API secret is available "mZJ5r9KCdRjnWCdPJg"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"

        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Assign the value "<withdrawAddress>" to the variable "withdrawAddress"
        And Assign the value "<withdrawNetwork>" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v1/synthetics/ramp-off"
        Then Obtain a response 201
        # And Se validan atributos para sintético ramp-on operado en no descubierto

        # Parte 2: Generar depósito
        Given Execute crypto deposit

        # Parte 2: Validar ejeccución del sintético
        When Wait for the processing of the "orden" por 45 seconds
        And Execute the GET method on the endpoint "/v2/synthetics/{syntheticId}"
        Then Obtain a response 200 y status "COMPLETED"

        Examples:
            | userAnyId | sessionId    | asset | against | assetAmount | withdrawAddress        | withdrawNetwork | to                                 | ticker | chain |
            | 100011193 | smoke-test-n | TRX   | ARS     | 3           | 4530000800015017168564 | TRON            | TBm3cipnHc7HifuBJdh8JM3nwG3LQJ9UQv | TRX    | 9     |
            | 100011193 | smoke-test-n | USDT  | ARS     | 3           | 4530000800015017168564 | TRON            | TBm3cipnHc7HifuBJdh8JM3nwG3LQJ9UQv | USDT   | 9     |

    @Smoke @E2EFlow @PartialRampOn @testb
    Scenario Outline: Flujo E2E Partial-Ramp-On no descubierto
        # Parte 1: Creación de sintético
        Given The API key is available "P0H3ZHM-N2EM338-PRP6BA7-S3NTRJD"
        And The API secret is available "6RcTZScYUFb2bq9qWq"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"

        And Obtain "<against>" balance for "<userAnyId>" user

        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Assign the value "<withdrawAddress>" to the variable "withdrawAddress"
        And Assign the value "<withdrawNetwork>" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v1/synthetics/partial-ramp-on"
        Then Obtain a response 201
        # And Se validan atributos para sintético ramp-on operado en no descubierto

        # Parte 2: Generar depósito
        Given Execute fiat deposit

        # Parte 2: Validar ejeccución del sintético
        When Wait for the processing of the "orden" por 10 seconds
        And Execute the GET method on the endpoint "/v2/synthetics/{syntheticId}"
        Then Obtain a response 200 y status "COMPLETED"

        And Obtain "<against>" balance for "<userAnyId>" user

        Examples:
            | userAnyId | sessionId                  | asset | against | assetAmount | withdrawAddress                            | withdrawNetwork |
            | 100009719 | smoke-partialRampOn-test-n | WLD   | ARS     | 3           | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | WORLDCHAIN      |
            | 100009719 | smoke-partialRampOn-test-n | USDT  | ARS     | 2           | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | ETHEREUM        |
            | 100009719 | smoke-partialRampOn-test-n | DAI   | ARS     | 4           | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | ETHEREUM        |

    @Smoke @E2EFlow @PartialRampOff
    Scenario Outline: Flujo E2E Partial-Ramp-Off no descubierto
        # Parte 1: Creación de sintético
        Given The API key is available "P0H3ZHM-N2EM338-PRP6BA7-S3NTRJD"
        And The API secret is available "6RcTZScYUFb2bq9qWq"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"

        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Assign the value "<withdrawAddress>" to the variable "withdrawAddress"
        And Assign the value "<withdrawNetwork>" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v1/synthetics/partial-ramp-off"
        Then Obtain a response 201
        # And Se validan atributos para sintético ramp-on operado en no descubierto

        # Parte 2: Generar depósito
        Given Execute crypto deposit

        # Parte 2: Validar ejeccución del sintético
        When Wait for the processing of the "orden" por 40 seconds
        And Execute the GET method on the endpoint "/v2/synthetics/{syntheticId}"
        Then Obtain a response 200 y status "COMPLETED"

        Examples:
            | userAnyId | sessionId                   | asset | against | assetAmount | withdrawAddress        | withdrawNetwork | to                                         | ticker | chain |
            | 100009774 | smoke-partialRampOff-test-n | WLD   | ARS     | 10          | 4530000800015017168564 | WORLDCHAIN      | 0x367b5Aa470049B722ce815b8f9EB66064D0415d4 | WLD    | 6     |
            | 100009774 | smoke-partialRampOff-test-n | USDT  | ARS     | 10          | 4530000800015017168564 | ETHEREUM        | 0x367b5Aa470049B722ce815b8f9EB66064D0415d4 | USDT   | 0     |
            | 100009774 | smoke-partialRampOff-test-n | DAI   | ARS     | 10          | 4530000800015017168564 | ETHEREUM        | 0x367b5Aa470049B722ce815b8f9EB66064D0415d4 | DAI    | 0     |
