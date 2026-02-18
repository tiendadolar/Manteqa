@LockPrice @Integrations
Feature: Lock Price Integrations

    Background:
        Given The urlBase is available "https://sandbox.manteca.dev/crypto"

    @HappyPath @Automated
    Scenario Outline: Validate success lock price response <case>
        Given The API key is available "<apiKEY>"
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<side>" to the variable "side"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<expireSeconds>" to the variable "expireSeconds"
        And Assign the value "<allowMultipleUses>" to the variable "allowMultipleUses"
        And Execute the POST method on the endpoint "/v2/price-locks"
        Then Obtain a response 201
        And Validate lock price response attributes

        Examples:
            | case                            | apiKEY                          | userAnyId | side | asset | against | expireSeconds | allowMultipleUses |
            | sending all fields              | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 | 100009352 | BUY  | USDT  | ARS     | 150           | true              |
            | sending sell side               | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 | 100009352 | SELL | USDT  | ARS     | 150           | true              |
            | sending allowMultipleUses false | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 | 100009352 | SELL | USDT  | ARS     | 150           | false             |
            | sending expireSeconds empty     | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 | 100009352 | SELL | USDT  | ARS     |               | true              |

    @ErrorPath @Automated
    Scenario Outline: Validate error reponse lock price response <case>
        Given The API key is available "<apiKEY>"
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<side>" to the variable "side"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<expireSeconds>" to the variable "expireSeconds"
        And Assign the value "<allowMultipleUses>" to the variable "allowMultipleUses"
        And Execute the POST method on the endpoint "/v2/price-locks"
        Then Obtain a response <statusCode>
        And Validate response attributes with internalStatus: "<internalStatus>" and message: "<message>" and error: "<errors>"

        Examples:
            | case                         | apiKEY                          | userAnyId | side    | asset   | against | expireSeconds | allowMultipleUses | statusCode | internalStatus | message         | errors                                                                                                                                                                                 |
            | sending empty userAnyId      | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 |           | BUY     | USDT    | ARS     | 150           | true              | 400        | BAD_REQUEST    | Bad request.    | userAnyId is missing.                                                                                                                                                                  |
            | sending unexisting userAnyId | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 | 100009361 | BUY     | USDT    | ARS     | 150           | true              | 404        | USER_NF        | User not found  |                                                                                                                                                                                        |
            | sending empty side           | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 | 100009352 |         | USDT    | ARS     | 150           | true              | 400        | BAD_REQUEST    | Bad request.    | side has wrong value . Possible values are BUY,SELL.                                                                                                                                   |
            | sending invalid side         | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 | 100009352 | INVALID | USDT    | ARS     | 150           | true              | 400        | BAD_REQUEST    | Bad request.    | side has wrong value INVALID. Possible values are BUY,SELL.                                                                                                                            |
            | sending empty asset          | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 | 100009352 | BUY     |         | ARS     | 150           | true              | 400        | BAD_REQUEST    | Bad request.    | asset has wrong value . Possible values are DAI,USDT,BUSD,USDC,USDCB,ETH,BNB,ARB,POL,TRX,UST,AUST,BTC,LUNA,LUNA2,SOL,MATIC,NUARS,WLD,USDL,SDAI,AXS,MANA,ENJ,SAND,...and 8 more.        |
            | sending invalid asset        | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 | 100009352 | BUY     | INVALID | ARS     | 150           | true              | 400        | BAD_REQUEST    | Bad request.    | asset has wrong value INVALID. Possible values are DAI,USDT,BUSD,USDC,USDCB,ETH,BNB,ARB,POL,TRX,UST,AUST,BTC,LUNA,LUNA2,SOL,MATIC,NUARS,WLD,USDL,SDAI,AXS,MANA,ENJ,SAND,...and 8 more. |
            | sending expire price asset   | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 | 100009352 | BUY     | NUARS   | ARS     | 150           | true              | 400        | EXPIRED_PRICE  | Expired prices. |                                                                                                                                                                                        |
            | sending empty against        | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 | 100009352 | BUY     | USDT    |         | 150           | true              | 400        | BAD_REQUEST    | Bad request.    | against has wrong value . Possible values are ARS,USD,CLP,COP,BRL,GTQ,CRC,PUSD,MXN,PHP,PEN,PYG,BOB,EUR,USDCCL.                                                                         |
            | sending invalid against      | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 | 100009352 | BUY     | USDT    | INVALID | 150           | true              | 400        | BAD_REQUEST    | Bad request.    | against has wrong value INVALID. Possible values are ARS,USD,CLP,COP,BRL,GTQ,CRC,PUSD,MXN,PHP,PEN,PYG,BOB,EUR,USDCCL.                                                                  |

    @ErrorPath @Automated
    Scenario Outline: Validate error reponse lock price response <case>
        Given The API key is available "<apiKEY>"
        When Assign the value <userAnyId> to the variable "userAnyId"
        And Assign the value "<side>" to the variable "side"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<expireSeconds>" to the variable "expireSeconds"
        And Assign the value "<allowMultipleUses>" to the variable "allowMultipleUses"
        And Execute the POST method on the endpoint "/v2/price-locks"
        Then Obtain a response <statusCode>
        And Validate response attributes with internalStatus: "<internalStatus>" and message: "<message>" and error: "<errors>"

        Examples:
            | case                          | apiKEY                          | userAnyId | side | asset | against | expireSeconds | allowMultipleUses | statusCode | internalStatus | message      | errors                                                        |
            | sending userAnyId as a number | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 | 100009352 | BUY  | USDT  | ARS     | 150           | true              | 400        | BAD_REQUEST    | Bad request. | userAnyId needs to be of type string but it's of type number. |

    @ErrorPath @Automated
    Scenario Outline: Validate error reponse lock price response <case>
        Given The API key is available "<apiKEY>"
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value <side> to the variable "side"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<expireSeconds>" to the variable "expireSeconds"
        And Assign the value "<allowMultipleUses>" to the variable "allowMultipleUses"
        And Execute the POST method on the endpoint "/v2/price-locks"
        Then Obtain a response <statusCode>
        And Validate response attributes with internalStatus: "<internalStatus>" and message: "<message>" and error: "<errors>"

        Examples:
            | case                     | apiKEY                          | userAnyId | side | asset | against | expireSeconds | allowMultipleUses | statusCode | internalStatus | message      | errors                                                   |
            | sending side as a number | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 | 100009352 | 123  | USDT  | ARS     | 150           | true              | 400        | BAD_REQUEST    | Bad request. | side needs to be of type string but it's of type number. |
