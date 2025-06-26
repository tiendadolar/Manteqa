@Sintetico
Feature: Sintéticos

    # ----- Company No Descubierto -----
    @Syn @RampOn
    Scenario: Creación de sintético Ramp-On
        Given Contar con la api-key "GHJXE4N-J4C432Z-KCNNAN3-PYC7X1N"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "100008209" a la variable "userAnyId"
        And Asignar el valor "automation-test-n" a la variable "sessionId"
        And Asignar el valor "USDT" a la variable "asset"
        And Asignar el valor "ARS" a la variable "against"
        And Asignar el valor "7" a la variable "assetAmount"
        And Asignar el valor "0x21534455766A80d11724eCbD3017425c77a014d3" a la variable "withdrawAddress"
        And Asignar el valor "POLYGON" a la variable "withdrawNetwork"
        And Ejecutar el método Post al endpoint "/v1/synthetics/ramp-on"
        Then Se obtiene una respuesta 201
        And Se validan atributos para sintético operado en no descubierto

    @Syn @RampOn @Depo
    Scenario: Generar deposito Fiat
        Given Contar con la api-key "C10XB2Z-AG243CS-G42KB2M-4085WTF"
        And Contar con la api-secret "BuFJx56wuzdQArJktt"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "100008213" a la variable "userId"
        And Asignar el valor "13000" a la variable "amount"
        And Asignar el valor "ARS" a la variable "coin"
        # And Asignar el valor "10000000000000000000" a la variable "bank" opcional (LOCALPAYMENT por ejemplo)
        And Ejecutar el método Post al endpoint "/v1/fiat/deposit"
        Then Se obtiene una respuesta 201

    @Syn @partialRampOn
    Scenario: Creación de sintético Partial-Ramp-On
        Given Contar con la api-key "GHJXE4N-J4C432Z-KCNNAN3-PYC7X1N"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "100007676" a la variable "userAnyId"
        And Asignar el valor "automation-test-n" a la variable "sessionId"
        And Asignar el valor "USDT" a la variable "asset"
        And Asignar el valor "ARS" a la variable "against"
        And Asignar el valor "7" a la variable "assetAmount"
        And Asignar el valor "0x96E8C5474f4D1fa9f4097b9B9de3f14E65Cb98Ed" a la variable "withdrawAddress"
        And Asignar el valor "POLYGON" a la variable "withdrawNetwork"
        And Ejecutar el método Post al endpoint "/v1/synthetics/partial-ramp-on"
        Then Se obtiene una respuesta 201

    @Syn @partialRampOn
    Scenario: Generar deposito Fiat
        Given Contar con la api-key "C10XB2Z-AG243CS-G42KB2M-4085WTF"
        And Contar con la api-secret "BuFJx56wuzdQArJktt"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "100007676" a la variable "userId"
        And Asignar el valor "amount" a la variable "amount"
        And Asignar el valor "coin" a la variable "coin"
        # And Asignar el valor "10000000000000000000" a la variable "bank" opcional (LOCALPAYMENT por ejemplo)
        And Ejecutar el método Post al endpoint "/v1/fiat/deposit"
        Then Se obtiene una respuesta 201

    @Syn @RampOff
    Scenario: Creación de sintético Ramp-Off
        Given Contar con la api-key "GHJXE4N-J4C432Z-KCNNAN3-PYC7X1N"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "100008189" a la variable "userAnyId"
        And Asignar el valor "automation-test-n" a la variable "sessionId"
        And Asignar el valor "USDT" a la variable "asset"
        And Asignar el valor "ARS" a la variable "against"
        And Asignar el valor "13500" a la variable "againstAmount"
        And Asignar el valor "0140420703690150418728" a la variable "withdrawAddress"
        And Asignar el valor "POLYGON" a la variable "withdrawNetwork"
        And Ejecutar el método Post al endpoint "/v1/synthetics/ramp-off"
        Then Se obtiene una respuesta 201

    @Syn @RampOff
    Scenario: Generar deposito Crypto
        # Apikey de TC
        Given Contar con la api-key "C10XB2Z-AG243CS-G42KB2M-4085WTF"
        # apiSecret de la company del user
        And Contar con la api-secret "BuFJx56wuzdQArJktt"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "0of00s808a0s0a0d0000129tfd00000f00f0c0cz00fi00efb0000t00000i1g0f" a la variable "hash"
        And Asignar el valor "0x9bD31d82B6212dd60a9328CCe7277161e5975fB5" a la variable "from"
        And Asignar el valor "0x21534455766A80d11724eCbD3017425c77a014d2" a la variable "to"
        And Asignar el valor "10000000000000000000" a la variable "wei"
        And Asignar el valor "10" a la variable "human"
        And Asignar el valor "USDT" a la variable "ticker"
        And Asignar el valor 0 a la variable "chain"
        And Ejecutar el método Post al endpoint "/v1/transaction/deposit"
        Then Se obtiene una respuesta 201

    @Syn @partialRampOff
    Scenario: Creación de sintético Partial-Ramp-Off
        Given Contar con la api-key "GHJXE4N-J4C432Z-KCNNAN3-PYC7X1N"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "100007676" a la variable "userAnyId"
        And Asignar el valor "automation-test-n" a la variable "sessionId"
        And Asignar el valor "USDT" a la variable "asset"
        And Asignar el valor "ARS" a la variable "against"
        And Asignar el valor "13500" a la variable "againstAmount"
        And Asignar el valor "0140420703690150418728" a la variable "withdrawAddress"
        And Asignar el valor "POLYGON" a la variable "withdrawNetwork"
        And Ejecutar el método Post al endpoint "/v1/synthetics/partial-ramp-off"
        Then Se obtiene una respuesta 201

    @Syn @partialRampOff
    Scenario: Generar deposito Crypto
        Given Contar con la api-key "C10XB2Z-AG243CS-G42KB2M-4085WTF"
        And Contar con la api-secret "BuFJx56wuzdQArJktt"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "0of00s808a0s0a0d0000129tfd00000f00f0c0cz00fi00efb0000t00000i1g0f" a la variable "hash"
        And Asignar el valor "0x9bD31d82B6212dd60a9328CCe7277161e5975fB5" a la variable "from"
        And Asignar el valor "0x96E8C5474f4D1fa9f4097b9B9de3f14E65Cb98Ed" a la variable "to"
        And Asignar el valor "10000000000000000000" a la variable "wei"
        And Asignar el valor "10" a la variable "human"
        And Asignar el valor "USDT" a la variable "ticker"
        And Asignar el valor 0 a la variable "chain"
        And Ejecutar el método Post al endpoint "/v1/transaction/deposit"
        Then Se obtiene una respuesta 201
    # ----- Company No Descubierto -----
    # ----- ---------------------- -----
    # ----- Company Descubierto -----
    @SynDesc @RampOnDesc
    Scenario: Creación de sintético Ramp-On
        Given Contar con la api-key "JYM3AK8-XXGME8N-JZDQCP7-Q16T2NX"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "100007698" a la variable "userAnyId"
        And Asignar el valor "automation-test-n" a la variable "sessionId"
        And Asignar el valor "USDT" a la variable "asset"
        And Asignar el valor "ARS" a la variable "against"
        And Asignar el valor "7" a la variable "assetAmount"
        And Asignar el valor "0x12e47c3B39896B7871700A9d409B51231AC078B8" a la variable "withdrawAddress"
        And Asignar el valor "POLYGON" a la variable "withdrawNetwork"
        And Ejecutar el método Post al endpoint "/v1/synthetics/ramp-on"
        Then Se obtiene una respuesta 201

    @SynDesc @partialRampOnDesc
    Scenario: Creación de sintético Partial-Ramp-On
        Given Contar con la api-key "JYM3AK8-XXGME8N-JZDQCP7-Q16T2NX"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "100007698" a la variable "userAnyId"
        And Asignar el valor "automation-test-n" a la variable "sessionId"
        And Asignar el valor "USDT" a la variable "asset"
        And Asignar el valor "ARS" a la variable "against"
        And Asignar el valor "7" a la variable "assetAmount"
        And Asignar el valor "0x12e47c3B39896B7871700A9d409B51231AC078B8" a la variable "withdrawAddress"
        And Asignar el valor "POLYGON" a la variable "withdrawNetwork"
        And Ejecutar el método Post al endpoint "/v1/synthetics/partial-ramp-on"
        Then Se obtiene una respuesta 201

    @SynDesc @RampOffDesc
    Scenario: Creación de sintético Ramp-Off
        Given Contar con la api-key "JYM3AK8-XXGME8N-JZDQCP7-Q16T2NX"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "100007698" a la variable "userAnyId"
        And Asignar el valor "automation-test-n" a la variable "sessionId"
        And Asignar el valor "USDT" a la variable "asset"
        And Asignar el valor "ARS" a la variable "against"
        And Asignar el valor "13500" a la variable "againstAmount"
        And Asignar el valor "0140420703690150418728" a la variable "withdrawAddress"
        And Asignar el valor "POLYGON" a la variable "withdrawNetwork"
        And Ejecutar el método Post al endpoint "/v1/synthetics/ramp-off"
        Then Se obtiene una respuesta 201

    @SynDesc @partialRampOffDesc
    Scenario: Creación de sintético Ramp-Off
        Given Contar con la api-key "JYM3AK8-XXGME8N-JZDQCP7-Q16T2NX"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "100007698" a la variable "userAnyId"
        And Asignar el valor "automation-test-n" a la variable "sessionId"
        And Asignar el valor "USDT" a la variable "asset"
        And Asignar el valor "ARS" a la variable "against"
        And Asignar el valor "13500" a la variable "againstAmount"
        And Asignar el valor "0000003100000341514293" a la variable "withdrawAddress"
        And Asignar el valor "POLYGON" a la variable "withdrawNetwork"
        And Ejecutar el método Post al endpoint "/v1/synthetics/partial-ramp-off"
        Then Se obtiene una respuesta 201
    # ----- Company Descubierto -----


    # ----- REGRESSION NO TOCAR -----
    # ----- Company No Descubierto -----

    @Regression @Smoke @RampOn
    Scenario: Creación de sintético Ramp-On con asset
        Given Contar con la api-key "P0H3ZHM-N2EM338-PRP6BA7-S3NTRJD"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "100008214" a la variable "userAnyId"
        And Asignar el valor "automation-test-n" a la variable "sessionId"
        And Asignar el valor "USDT" a la variable "asset"
        And Asignar el valor "ARS" a la variable "against"
        And Asignar el valor "10" a la variable "assetAmount"
        And Asignar el valor "0x21534455766A80d11724eCbD3017425c77a014d3" a la variable "withdrawAddress"
        And Asignar el valor "POLYGON" a la variable "withdrawNetwork"
        And Ejecutar el método Post al endpoint "/v1/synthetics/ramp-on"
        Then Se obtiene una respuesta 201
        And Se validan atributos para sintético ramp-on operado en no descubierto

    @Regression @Smoke @RampOn
    Scenario: Generar deposito Fiat
        Given Contar con la api-key "C10XB2Z-AG243CS-G42KB2M-4085WTF"
        And Contar con la api-secret "rcrgtDnGxjY2AYC5qs"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "100008214" a la variable "userId"
        And Asignar el valor "amount" a la variable "amount"
        And Asignar el valor "coin" a la variable "coin"
        # And Asignar el valor "10000000000000000000" a la variable "bank" opcional (LOCALPAYMENT por ejemplo)
        And Ejecutar el método Post al endpoint "/v1/fiat/deposit"
        Then Se obtiene una respuesta 201

    @Regression @Smoke @RampOn
    Scenario: Validar ejecución del sintético Ramp-On
        Given Contar con la api-key "P0H3ZHM-N2EM338-PRP6BA7-S3NTRJD"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Esperar procesamiento de la "orden" por 40 segundos
        And Ejecutar el método Get al endpoint "/v2/synthetics/{syntheticId}"
        Then Se obtiene una respuesta 200 y status COMPLETED

    @Regression @Smoke @RampOn
    Scenario: Creación de sintético Ramp-On con against
        Given Contar con la api-key "P0H3ZHM-N2EM338-PRP6BA7-S3NTRJD"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "100008214" a la variable "userAnyId"
        And Asignar el valor "automation-test-n" a la variable "sessionId"
        And Asignar el valor "USDT" a la variable "asset"
        And Asignar el valor "ARS" a la variable "against"
        And Asignar el valor "15000" a la variable "againstAmount"
        And Asignar el valor "0x21534455766A80d11724eCbD3017425c77a014d3" a la variable "withdrawAddress"
        And Asignar el valor "POLYGON" a la variable "withdrawNetwork"
        And Ejecutar el método Post al endpoint "/v1/synthetics/ramp-on"
        Then Se obtiene una respuesta 201
        And Se validan atributos para sintético ramp-on operado en no descubierto

    @Regression @Smoke @RampOn
    Scenario: Generar deposito Fiat
        Given Contar con la api-key "C10XB2Z-AG243CS-G42KB2M-4085WTF"
        And Contar con la api-secret "rcrgtDnGxjY2AYC5qs"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "100008214" a la variable "userId"
        And Asignar el valor "amount" a la variable "amount"
        And Asignar el valor "coin" a la variable "coin"
        # And Asignar el valor "10000000000000000000" a la variable "bank" opcional (LOCALPAYMENT por ejemplo)
        And Ejecutar el método Post al endpoint "/v1/fiat/deposit"
        Then Se obtiene una respuesta 201

    @Regression @Smoke @RampOn
    Scenario: Validar ejecución del sintético Ramp-On
        Given Contar con la api-key "P0H3ZHM-N2EM338-PRP6BA7-S3NTRJD"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Esperar procesamiento de la "orden" por 40 segundos
        And Ejecutar el método Get al endpoint "/v2/synthetics/{syntheticId}"
        Then Se obtiene una respuesta 200 y status COMPLETED

    @Regression @RampOn
    Scenario: Creación de sintético Ramp-On con asset valor limite mínimo
        Given Contar con la api-key "P0H3ZHM-N2EM338-PRP6BA7-S3NTRJD"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "100008214" a la variable "userAnyId"
        And Asignar el valor "automation-test-n" a la variable "sessionId"
        And Asignar el valor "USDT" a la variable "asset"
        And Asignar el valor "ARS" a la variable "against"
        And Asignar el valor "0.1" a la variable "assetAmount"
        And Asignar el valor "0x21534455766A80d11724eCbD3017425c77a014d3" a la variable "withdrawAddress"
        And Asignar el valor "POLYGON" a la variable "withdrawNetwork"
        And Ejecutar el método Post al endpoint "/v1/synthetics/ramp-on"
        Then Se obtiene una respuesta 201
        And Se validan atributos para sintético ramp-on operado en no descubierto

    @Regression @RampOn
    Scenario: Generar deposito Fiat
        Given Contar con la api-key "C10XB2Z-AG243CS-G42KB2M-4085WTF"
        And Contar con la api-secret "rcrgtDnGxjY2AYC5qs"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "100008214" a la variable "userId"
        And Asignar el valor "amount" a la variable "amount"
        And Asignar el valor "coin" a la variable "coin"
        # And Asignar el valor "10000000000000000000" a la variable "bank" opcional (LOCALPAYMENT por ejemplo)
        And Ejecutar el método Post al endpoint "/v1/fiat/deposit"
        Then Se obtiene una respuesta 201

    @Regression @RampOn
    Scenario: Validar ejecución del sintético Ramp-On
        Given Contar con la api-key "P0H3ZHM-N2EM338-PRP6BA7-S3NTRJD"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Esperar procesamiento de la "orden" por 40 segundos
        And Ejecutar el método Get al endpoint "/v2/synthetics/{syntheticId}"
        Then Se obtiene una respuesta 200 y status COMPLETED

    @Regression @RampOn
    Scenario: Creación de sintético Ramp-On con against valor limite mínimo
        Given Contar con la api-key "P0H3ZHM-N2EM338-PRP6BA7-S3NTRJD"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "100008214" a la variable "userAnyId"
        And Asignar el valor "automation-test-n" a la variable "sessionId"
        And Asignar el valor "USDT" a la variable "asset"
        And Asignar el valor "ARS" a la variable "against"
        And Asignar el valor "130" a la variable "againstAmount"
        And Asignar el valor "0x21534455766A80d11724eCbD3017425c77a014d3" a la variable "withdrawAddress"
        And Asignar el valor "POLYGON" a la variable "withdrawNetwork"
        And Ejecutar el método Post al endpoint "/v1/synthetics/ramp-on"
        Then Se obtiene una respuesta 201
        And Se validan atributos para sintético ramp-on operado en no descubierto

    @Regression @RampOn
    Scenario: Generar deposito Fiat
        Given Contar con la api-key "C10XB2Z-AG243CS-G42KB2M-4085WTF"
        And Contar con la api-secret "rcrgtDnGxjY2AYC5qs"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "100008214" a la variable "userId"
        And Asignar el valor "amount" a la variable "amount"
        And Asignar el valor "coin" a la variable "coin"
        # And Asignar el valor "10000000000000000000" a la variable "bank" opcional (LOCALPAYMENT por ejemplo)
        And Ejecutar el método Post al endpoint "/v1/fiat/deposit"
        Then Se obtiene una respuesta 201

    @Regression @RampOn
    Scenario: Validar ejecución del sintético Ramp-On
        Given Contar con la api-key "P0H3ZHM-N2EM338-PRP6BA7-S3NTRJD"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Esperar procesamiento de la "orden" por 40 segundos
        And Ejecutar el método Get al endpoint "/v2/synthetics/{syntheticId}"
        Then Se obtiene una respuesta 200 y status COMPLETED

    @Regression @E2EFlow
    Scenario Outline: Flujo E2E Ramp-On con Depósito
        # Parte 1: Creación de sintético
        Given Contar con la api-key "P0H3ZHM-N2EM338-PRP6BA7-S3NTRJD"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "<sessionId>" a la variable "sessionId"
        And Asignar el valor "<asset>" a la variable "asset"
        And Asignar el valor "<against>" a la variable "against"
        And Asignar el valor "<assetAmount>" a la variable "assetAmount"
        And Asignar el valor "<withdrawAddress>" a la variable "withdrawAddress"
        And Asignar el valor "<withdrawNetwork>" a la variable "withdrawNetwork"
        And Ejecutar el método Post al endpoint "/v1/synthetics/ramp-on"
        Then Se obtiene una respuesta 201
        # And Se validan atributos para sintético ramp-on operado en no descubierto

        # Parte 2: Generar depósito
        Given Contar con la api-key "C10XB2Z-AG243CS-G42KB2M-4085WTF"
        And Contar con la api-secret "rcrgtDnGxjY2AYC5qs"
        When Asignar el valor "100008214" a la variable "userId"
        And Asignar el valor "amount" a la variable "amount"
        And Asignar el valor "coin" a la variable "coin"
        And Ejecutar el método Post al endpoint "/v1/fiat/deposit"
        Then Se obtiene una respuesta 201

        # Parte 2: Validar ejeccución del sintético
        Given Contar con la api-key "P0H3ZHM-N2EM338-PRP6BA7-S3NTRJD"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Esperar procesamiento de la "orden" por 40 segundos
        And Ejecutar el método Get al endpoint "/v2/synthetics/{syntheticId}"
        Then Se obtiene una respuesta 200 y status COMPLETED

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

    @Regression @Smoke @E2EFlow @RampOn
    Scenario Outline: Flujo E2E Ramp-On con Depósito
        # Parte 1: Creación de sintético
        Given Contar con la api-key "P0H3ZHM-N2EM338-PRP6BA7-S3NTRJD"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "<sessionId>" a la variable "sessionId"
        And Asignar el valor "<asset>" a la variable "asset"
        And Asignar el valor "<against>" a la variable "against"
        And Asignar el valor "<assetAmount>" a la variable "assetAmount"
        And Asignar el valor "<withdrawAddress>" a la variable "withdrawAddress"
        And Asignar el valor "<withdrawNetwork>" a la variable "withdrawNetwork"
        And Ejecutar el método Post al endpoint "/v1/synthetics/ramp-on"
        Then Se obtiene una respuesta 201
        # And Se validan atributos para sintético ramp-on operado en no descubierto

        # Parte 2: Generar depósito
        Given Contar con la api-key "C10XB2Z-AG243CS-G42KB2M-4085WTF"
        And Contar con la api-secret "6RcTZScYUFb2bq9qWq"
        When Asignar el valor "100008214" a la variable "userId"
        And Asignar el valor "amount" a la variable "amount"
        And Asignar el valor "coin" a la variable "coin"
        And Ejecutar el método Post al endpoint "/v1/fiat/deposit"
        Then Se obtiene una respuesta 201

        # Parte 2: Validar ejeccución del sintético
        Given Contar con la api-key "P0H3ZHM-N2EM338-PRP6BA7-S3NTRJD"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Esperar procesamiento de la "orden" por 40 segundos
        And Ejecutar el método Get al endpoint "/v2/synthetics/{syntheticId}"
        Then Se obtiene una respuesta 200 y status COMPLETED

        Examples:
            | userAnyId | sessionId    | asset | against | assetAmount | withdrawAddress                            | withdrawNetwork |
            | 100008214 | smoke-test-n | WLD   | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | WORLDCHAIN      |
            | 100008214 | smoke-test-n | USDT  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | POLYGON         |
            | 100008214 | smoke-test-n | DAI   | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | POLYGON         |
            | 100008214 | smoke-test-n | USDC  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | POLYGON         |
            | 100008214 | smoke-test-n | USDCB | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | POLYGON         |
            | 100008214 | smoke-test-n | USDT  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | BINANCE         |
            | 100008214 | smoke-test-n | DAI   | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | BINANCE         |
            | 100008214 | smoke-test-n | USDC  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | BINANCE         |
            # | 100008214 | smoke-test-n | USDCB | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | BINANCE         |
            # | 100008214 | smoke-test-n | UST   | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | BINANCE         |
            | 100008214 | smoke-test-n | ETH   | ARS     | 0.01        | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | BINANCE         |
            | 100008214 | smoke-test-n | BNB   | ARS     | 0.01        | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | BINANCE         |
            | 100008214 | smoke-test-n | BTC   | ARS     | 0.01        | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | BINANCE         |
            # | 100008214 | smoke-test-n | SOL   | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | BINANCE         |
            | 100008214 | smoke-test-n | USDC  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | OPTIMISM        |
    # | 100008214 | smoke-test-n | DAI   | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | OPTIMISM        |
    # | 100008214 | smoke-test-n | USDC  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | OPTIMISM        |
    # | 100008214 | smoke-test-n | USDCB | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | OPTIMISM        |
    # | 100008214 | smoke-test-n | ETH   | ARS     | 1           | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | OPTIMISM        |
    # | 100008214 | smoke-test-n | BNB   | ARS     | 1           | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | OPTIMISM        |
    # | 100008214 | smoke-test-n | SDAI  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | OPTIMISM        |

    @Regression @Smoke @E2EFlow @RampOff
    Scenario Outline: Flujo E2E Ramp-Off con Depósito
        # Parte 1: Creación de sintético
        Given Contar con la api-key "P0H3ZHM-N2EM338-PRP6BA7-S3NTRJD"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "<sessionId>" a la variable "sessionId"
        And Asignar el valor "<asset>" a la variable "asset"
        And Asignar el valor "<against>" a la variable "against"
        And Asignar el valor "<assetAmount>" a la variable "assetAmount"
        And Asignar el valor "<withdrawAddress>" a la variable "withdrawAddress"
        And Asignar el valor "<withdrawNetwork>" a la variable "withdrawNetwork"
        And Ejecutar el método Post al endpoint "/v1/synthetics/ramp-off"
        Then Se obtiene una respuesta 201
        # And Se validan atributos para sintético ramp-on operado en no descubierto

        # Parte 2: Generar depósito
        Given Contar con la api-key "C10XB2Z-AG243CS-G42KB2M-4085WTF"
        And Contar con la api-secret "6RcTZScYUFb2bq9qWq"
        When Asignar el valor "0of00s808a0s0a0d0000129tfd00000f00f0c0cz00fi00efb0000t00000i1g0f" a la variable "hash"
        And Asignar el valor "0x9bD31d82B6212dd60a9328CCe7277161e5975fB5" a la variable "from"
        And Asignar el valor "<to>" a la variable "to"
        And Asignar el valor "10000000000000000000" a la variable "wei"
        And Asignar el valor "10" a la variable "human"
        And Asignar el valor "<ticker>" a la variable "ticker"
        And Asignar el valor <chain> a la variable "chain"
        And Ejecutar el método Post al endpoint "/v1/transaction/deposit"
        Then Se obtiene una respuesta 201

        # Parte 2: Validar ejeccución del sintético
        Given Contar con la api-key "P0H3ZHM-N2EM338-PRP6BA7-S3NTRJD"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Esperar procesamiento de la "orden" por 40 segundos
        And Ejecutar el método Get al endpoint "/v2/synthetics/{syntheticId}"
        Then Se obtiene una respuesta 200 y status COMPLETED

        Examples:
            | userAnyId | sessionId    | asset | against | assetAmount | withdrawAddress        | withdrawNetwork | to                                         | ticker | chain |
            | 100009688 | smoke-test-n | WLD   | ARS     | 10          | 4530000800015017168564 | WORLDCHAIN      | 0xFFb66dD89211C43Dd76cF7fbE287172bDF35A187 | WLD    | 6     |
            | 100009688 | smoke-test-n | USDT  | ARS     | 10          | 4530000800015017168564 | POLYGON         | 0xFFb66dD89211C43Dd76cF7fbE287172bDF35A187 | USDT   | 0     |
            | 100009688 | smoke-test-n | DAI   | ARS     | 10          | 4530000800015017168564 | POLYGON         | 0xFFb66dD89211C43Dd76cF7fbE287172bDF35A187 | DAI    | 0     |
            | 100009688 | smoke-test-n | USDC  | ARS     | 10          | 4530000800015017168564 | POLYGON         | 0xFFb66dD89211C43Dd76cF7fbE287172bDF35A187 | USDC   | 0     |
            | 100009688 | smoke-test-n | USDCB | ARS     | 10          | 4530000800015017168564 | POLYGON         | 0xFFb66dD89211C43Dd76cF7fbE287172bDF35A187 | USDCB  | 0     |
            | 100009688 | smoke-test-n | USDT  | ARS     | 10          | 4530000800015017168564 | BINANCE         | 0xFFb66dD89211C43Dd76cF7fbE287172bDF35A187 | USDT   | 1     |
            | 100009688 | smoke-test-n | DAI   | ARS     | 10          | 4530000800015017168564 | BINANCE         | 0xFFb66dD89211C43Dd76cF7fbE287172bDF35A187 | DAI    | 1     |
            | 100009688 | smoke-test-n | BNB   | ARS     | 0.01        | 4530000800015017168564 | BINANCE         | 0xFFb66dD89211C43Dd76cF7fbE287172bDF35A187 | BNB    | 1     |
            | 100009688 | smoke-test-n | ETH   | ARS     | 0.01        | 4530000800015017168564 | BINANCE         | 0xFFb66dD89211C43Dd76cF7fbE287172bDF35A187 | ETH    | 1     |
            | 100009688 | smoke-test-n | NUARS | ARS     | 10          | 4530000800015017168564 | BINANCE         | 0xFFb66dD89211C43Dd76cF7fbE287172bDF35A187 | NUARS  | 1     |
            | 100009688 | smoke-test-n | USDC  | ARS     | 10          | 4530000800015017168564 | BINANCE         | 0xFFb66dD89211C43Dd76cF7fbE287172bDF35A187 | USDC   | 1     |
            | 100009688 | smoke-test-n | USDC  | ARS     | 10          | 4530000800015017168564 | OPTIMISM        | 0xFFb66dD89211C43Dd76cF7fbE287172bDF35A187 | USDC   | 5     |


    @Regression @Smoke @E2EFlow @PartialRampOn
    Scenario Outline: Flujo E2E Partial-Ramp-On con Depósito
        # Parte 1: Creación de sintético
        Given Contar con la api-key "P0H3ZHM-N2EM338-PRP6BA7-S3NTRJD"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "<sessionId>" a la variable "sessionId"
        And Asignar el valor "<asset>" a la variable "asset"
        And Asignar el valor "<against>" a la variable "against"
        And Asignar el valor "<assetAmount>" a la variable "assetAmount"
        And Asignar el valor "<withdrawAddress>" a la variable "withdrawAddress"
        And Asignar el valor "<withdrawNetwork>" a la variable "withdrawNetwork"
        And Ejecutar el método Post al endpoint "/v1/synthetics/partial-ramp-on"
        Then Se obtiene una respuesta 201
        # And Se validan atributos para sintético ramp-on operado en no descubierto

        # Parte 2: Generar depósito
        Given Contar con la api-key "C10XB2Z-AG243CS-G42KB2M-4085WTF"
        And Contar con la api-secret "6RcTZScYUFb2bq9qWq"
        When Asignar el valor "100008214" a la variable "userId"
        And Asignar el valor "amount" a la variable "amount"
        And Asignar el valor "coin" a la variable "coin"
        And Ejecutar el método Post al endpoint "/v1/fiat/deposit"
        Then Se obtiene una respuesta 201

        # Parte 2: Validar ejeccución del sintético
        Given Contar con la api-key "P0H3ZHM-N2EM338-PRP6BA7-S3NTRJD"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Esperar procesamiento de la "orden" por 40 segundos
        And Ejecutar el método Get al endpoint "/v2/synthetics/{syntheticId}"
        Then Se obtiene una respuesta 200 y status COMPLETED

        Examples:
            | userAnyId | sessionId                  | asset | against | assetAmount | withdrawAddress                            | withdrawNetwork |
            | 100009719 | smoke-partialRampOn-test-n | WLD   | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | WORLDCHAIN      |
            | 100009719 | smoke-partialRampOn-test-n | USDT  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | POLYGON         |
            | 100009719 | smoke-partialRampOn-test-n | DAI   | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | POLYGON         |
            | 100009719 | smoke-partialRampOn-test-n | USDC  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | POLYGON         |
            | 100009719 | smoke-partialRampOn-test-n | USDCB | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | POLYGON         |
            | 100009719 | smoke-partialRampOn-test-n | USDT  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | BINANCE         |
            | 100009719 | smoke-partialRampOn-test-n | DAI   | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | BINANCE         |
            | 100009719 | smoke-partialRampOn-test-n | USDC  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | BINANCE         |
            # | 100009719 | smoke-partialRampOn-test-n | USDCB | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | BINANCE         |
            # | 100009719 | smoke-partialRampOn-test-n | UST   | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | BINANCE         |
            | 100009719 | smoke-partialRampOn-test-n | ETH   | ARS     | 0.01        | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | BINANCE         |
            | 100009719 | smoke-partialRampOn-test-n | BNB   | ARS     | 0.01        | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | BINANCE         |
            | 100009719 | smoke-partialRampOn-test-n | BTC   | ARS     | 0.01        | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | BINANCE         |
            # | 100009719 | smoke-partialRampOn-test-n | SOL   | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | BINANCE         |
            | 100009719 | smoke-partialRampOn-test-n | USDC  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | OPTIMISM        |
    # | 100009719 | smoke-partialRampOn-test-n | DAI   | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | OPTIMISM        |
    # | 100009719 | smoke-partialRampOn-test-n | USDC  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | OPTIMISM        |
    # | 100009719 | smoke-partialRampOn-test-n | USDCB | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | OPTIMISM        |
    # | 100009719 | smoke-partialRampOn-test-n | ETH   | ARS     | 1           | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | OPTIMISM        |
    # | 100009719 | smoke-partialRampOn-test-n | BNB   | ARS     | 1           | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | OPTIMISM        |
    # | 100009719 | smoke-partialRampOn-test-n | SDAI  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | OPTIMISM        |

    @Regression @Smoke @E2EFlow @PartialRampOff
    Scenario Outline: Flujo E2E Partial-Ramp-Off con Depósito
        # Parte 1: Creación de sintético
        Given Contar con la api-key "P0H3ZHM-N2EM338-PRP6BA7-S3NTRJD"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "<sessionId>" a la variable "sessionId"
        And Asignar el valor "<asset>" a la variable "asset"
        And Asignar el valor "<against>" a la variable "against"
        And Asignar el valor "<assetAmount>" a la variable "assetAmount"
        And Asignar el valor "<withdrawAddress>" a la variable "withdrawAddress"
        And Asignar el valor "<withdrawNetwork>" a la variable "withdrawNetwork"
        And Ejecutar el método Post al endpoint "/v1/synthetics/partial-ramp-off"
        Then Se obtiene una respuesta 201
        # And Se validan atributos para sintético ramp-on operado en no descubierto

        # Parte 2: Generar depósito
        Given Contar con la api-key "C10XB2Z-AG243CS-G42KB2M-4085WTF"
        And Contar con la api-secret "6RcTZScYUFb2bq9qWq"
        When Asignar el valor "0of00s808a0s0a0d0000129tfd00000f00f0c0cz00fi00efb0000t00000i1g0f" a la variable "hash"
        And Asignar el valor "0x9bD31d82B6212dd60a9328CCe7277161e5975fB5" a la variable "from"
        And Asignar el valor "<to>" a la variable "to"
        And Asignar el valor "10000000000000000000" a la variable "wei"
        And Asignar el valor "10" a la variable "human"
        And Asignar el valor "<ticker>" a la variable "ticker"
        And Asignar el valor <chain> a la variable "chain"
        And Ejecutar el método Post al endpoint "/v1/transaction/deposit"
        Then Se obtiene una respuesta 201

        # Parte 2: Validar ejeccución del sintético
        Given Contar con la api-key "P0H3ZHM-N2EM338-PRP6BA7-S3NTRJD"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Esperar procesamiento de la "orden" por 40 segundos
        And Ejecutar el método Get al endpoint "/v2/synthetics/{syntheticId}"
        Then Se obtiene una respuesta 200 y status COMPLETED

        Examples:
            | userAnyId | sessionId                   | asset | against | assetAmount | withdrawAddress        | withdrawNetwork | to                                         | ticker | chain |
            | 100009774 | smoke-partialRampOff-test-n | WLD   | ARS     | 10          | 4530000800015017168564 | WORLDCHAIN      | 0x367b5Aa470049B722ce815b8f9EB66064D0415d4 | WLD    | 6     |
            | 100009774 | smoke-partialRampOff-test-n | USDT  | ARS     | 10          | 4530000800015017168564 | POLYGON         | 0x367b5Aa470049B722ce815b8f9EB66064D0415d4 | USDT   | 0     |
            | 100009774 | smoke-partialRampOff-test-n | DAI   | ARS     | 10          | 4530000800015017168564 | POLYGON         | 0x367b5Aa470049B722ce815b8f9EB66064D0415d4 | DAI    | 0     |
            | 100009774 | smoke-partialRampOff-test-n | USDC  | ARS     | 10          | 4530000800015017168564 | POLYGON         | 0x367b5Aa470049B722ce815b8f9EB66064D0415d4 | USDC   | 0     |
            | 100009774 | smoke-partialRampOff-test-n | USDCB | ARS     | 10          | 4530000800015017168564 | POLYGON         | 0x367b5Aa470049B722ce815b8f9EB66064D0415d4 | USDCB  | 0     |
            | 100009774 | smoke-partialRampOff-test-n | USDT  | ARS     | 10          | 4530000800015017168564 | BINANCE         | 0x367b5Aa470049B722ce815b8f9EB66064D0415d4 | USDT   | 1     |
            | 100009774 | smoke-partialRampOff-test-n | DAI   | ARS     | 10          | 4530000800015017168564 | BINANCE         | 0x367b5Aa470049B722ce815b8f9EB66064D0415d4 | DAI    | 1     |
            | 100009774 | smoke-partialRampOff-test-n | BNB   | ARS     | 0.01        | 4530000800015017168564 | BINANCE         | 0x367b5Aa470049B722ce815b8f9EB66064D0415d4 | BNB    | 1     |
            | 100009774 | smoke-partialRampOff-test-n | ETH   | ARS     | 0.01        | 4530000800015017168564 | BINANCE         | 0x367b5Aa470049B722ce815b8f9EB66064D0415d4 | ETH    | 1     |
            | 100009774 | smoke-partialRampOff-test-n | NUARS | ARS     | 10          | 4530000800015017168564 | BINANCE         | 0x367b5Aa470049B722ce815b8f9EB66064D0415d4 | NUARS  | 1     |
            | 100009774 | smoke-partialRampOff-test-n | USDC  | ARS     | 10          | 4530000800015017168564 | BINANCE         | 0x367b5Aa470049B722ce815b8f9EB66064D0415d4 | USDC   | 1     |
            | 100009774 | smoke-partialRampOff-test-n | USDC  | ARS     | 10          | 4530000800015017168564 | OPTIMISM        | 0x367b5Aa470049B722ce815b8f9EB66064D0415d4 | USDC   | 5     |