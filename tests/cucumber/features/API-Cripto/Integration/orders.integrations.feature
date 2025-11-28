@Integrations @Orders
Feature: Orders Integrations

    Background:
        Given The urlBase is available "https://sandbox.manteca.dev/crypto"

    @HappyPath
    Scenario Outline: Validate success order response sending assetAmount
        Given The API key is available "<apiKEY>"
        When Assign the value "<externalId>" to the variable "externalId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<side>" to the variable "side"
        And Assign the value "pixCode" to the variable "code"
        And Execute the POST method on the endpoint "/v2/orders"
        Then Obtain a response 201
        And Validate response attributes

        Examples:
            | apiKEY                          | externalId | sessionId             | trade  | asset | side | userAnyId | assetAmount | against |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | ext-n      | integrationc-orders-n | compra | USDT  | BUY  | 100008501 | 5           | ARS     |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | ext-n      | integrationc-orders-n | compra | USDT  | SELL | 100008501 | 5           | ARS     |

    @HappyPath
    Scenario Outline: Validate success order response sending againstAmount
        Given The API key is available "<apiKEY>"
        When Assign the value "<externalId>" to the variable "externalId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<againstAmount>" to the variable "againstAmount"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<side>" to the variable "side"
        And Assign the value "pixCode" to the variable "code"
        And Execute the POST method on the endpoint "/v2/orders"
        Then Obtain a response 201
        And Validate response attributes

        Examples:
            | apiKEY                          | externalId | sessionId             | trade  | asset | side | userAnyId | againstAmount | against |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | ext-n      | integrationc-orders-n | compra | USDT  | BUY  | 100008501 | 5000          | ARS     |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | ext-n      | integrationc-orders-n | compra | USDT  | SELL | 100008501 | 5000          | ARS     |

    # ------------------------------- Error Path -------------------------------

    @testing
    Scenario Outline: Validate error order response sending <case>
        Given The API key is available "<apiKEY>"
        When Assign the value "<externalId>" to the variable "externalId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<side>" to the variable "side"
        And Assign the value "<priceCode>" to the variable "priceCode"
        And Execute the POST method on the endpoint "/v2/orders"
        Then Obtain a response <statusCode>
        And Validate response attributes with internalStatus: "<internalStatus>" and message: "<message>"

        Examples:
            | case              | apiKEY                          | externalId | sessionId             | trade  | asset | side | userAnyId | assetAmount | against | priceCode                            | statusCode | internalStatus | message                                                                                                 |
            | empty api-KEY     |                                 | ext-n      | integrationc-orders-n | compra | USDT  | BUY  | 100008501 | 10          | ARS     |                                      | 400        | INVALID_PARAMS | Invalid parameters.                                                                                     |
            | invalid api-KEY   | B8HJ3SS-2JQM6XD-HW4Z877-KZCESA  | ext-n      | integrationc-orders-n | compra | USDT  | BUY  | 100008501 | 10          | ARS     |                                      | 403        | FORBIDDEN      | You do not have enough permissions to access the resource with the provided authentication credentials. |
            | invalid userAnyId | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | ext-n      | integrationc-orders-n | compra | USDT  | BUY  | 100008502 | 10          | ARS     |                                      | 404        | USER_NF        | User not found                                                                                          |
            | invalid pixCode   | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | ext-n      | integrationc-orders-n | compra | USDT  | BUY  | 100008501 | 10          | ARS     | cc22e6af-d3c9-426d-acff-cc1f9e40a137 | 400        | EXPIRED_LOCK   | Expired price code.                                                                                     |
            | invalid pixCode   | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | ext-n      | integrationc-orders-n | compra | USDT  | BUY  | 100014663 | 10          | ARS     |                                      | 400        | NO_FUNDS       | Insufficient funds.                                                                                     |
            | min assetAmount   | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | ext-n      | integrationc-orders-n | compra | USDT  | BUY  | 100014663 | 0           | ARS     |                                      | 400        | MIN_SIZE       | Invalid order size (min).                                                                               |


    @testing
    Scenario Outline: Validate error order response sending wrong <case>
        Given The urlBase is available "https://api.manteca.dev/crypto"
        And The API key is available "<apiKEY>"
        When Assign the value "<externalId>" to the variable "externalId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<side>" to the variable "side"
        And Assign the value "pixCode" to the variable "code"
        And Execute the POST method on the endpoint "/v2/orders"
        Then Obtain a response <statusCode>
        And Validate response attributes with internalStatus: "<internalStatus>" and message: "<message>"

        Examples:
            | case               | apiKEY                          | externalId | sessionId             | trade  | asset | side | userAnyId | assetAmount | against | statusCode | internalStatus | message                                                                                                 |
            | enviroment api-KEY | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | ext-n      | integrationc-orders-n | compra | USDT  | BUY  | 100008501 | 10          | ARS     | 403        | FORBIDDEN      | You do not have enough permissions to access the resource with the provided authentication credentials. |

    @UnhappyPath
    Scenario Outline: Validate error order response sending empty <case>
        Given The urlBase is available "https://sandbox.manteca.dev/crypto"
        And The API key is available "<apiKEY>"
        When Assign the value "<externalId>" to the variable "externalId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<side>" to the variable "side"
        And Assign the value "pixCode" to the variable "code"
        And Execute the POST method on the endpoint "/v2/orders"
        Then Obtain a response <statusCode>
        And Validate response attributes with internalStatus: "<internalStatus>" and message: "<message>" and error: "<errors>"

        Examples:
            | case              | apiKEY                          | externalId | sessionId             | trade  | asset | side | userAnyId | assetAmount | against | statusCode | internalStatus | message      | errors                                                                                                                                                                                                 |
            | userAnyId         | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | ext-n      | integrationc-orders-n | compra | USDT  | BUY  |           | 10          | ARS     | 400        | BAD_REQUEST    | Bad request. | userAnyId is missing.                                                                                                                                                                                  |
            | assetAmount       | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | ext-n      | integrationc-orders-n | compra | USDT  | BUY  | 100008501 |             | ARS     | 400        | BAD_REQUEST    | Bad request. | One of these fields needs to be provided [assetAmount, againstAmount].                                                                                                                                 |
            | asset coin        | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | ext-n      | integrationc-orders-n | compra |       | BUY  | 100008501 | 10          | ARS     | 400        | BAD_REQUEST    | Bad request. | asset has wrong value . Possible values are DAI,USDT,BUSD,USDC,USDCB,ETH,BNB,ARB,POL,TRX,UST,AUST,BTC,LUNA,LUNA2,SOL,MATIC,NUARS,WLD,USDL,SDAI,AXS,MANA,ENJ,SAND,PSG,ATM,BAR,CITY,EURS,WETH,WBTC,WARS. |
            | against coin      | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | ext-n      | integrationc-orders-n | compra | USDT  | BUY  | 100008501 | 10          |         | 400        | BAD_REQUEST    | Bad request. | against has wrong value . Possible values are ARS,USD,CLP,COP,BRL,GTQ,CRC,PUSD,MXN,PHP,PEN,BOB,EUR,DAI,USDT,BUSD,USDC,USDCB.                                                                           |
            | side              | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | ext-n      | integrationc-orders-n | compra | USDT  |      | 100008501 | 10          | ARS     | 400        | BAD_REQUEST    | Bad request. | side has wrong value . Possible values are BUY,SELL.                                                                                                                                                   |
            | number externalId | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | 122        | integrationc-orders-n | compra | USDT  | BUY  | 100008501 | 10          | ARS     | 400        | BAD_REQUEST    | Bad request. | externalId has wrong value 123. Value should be a string different than a 24 character hex string and different than an integer number.                                                                |

    @testing
    Scenario Outline: Validate error order response sending empty <case>
        Given The urlBase is available "https://sandbox.manteca.dev/crypto"
        And The API key is available "<apiKEY>"
        When Assign the value "<externalId>" to the variable "externalId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<againstAmount>" to the variable "againstAmount"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<side>" to the variable "side"
        And Assign the value "pixCode" to the variable "code"
        And Execute the POST method on the endpoint "/v2/orders"
        Then Obtain a response <statusCode>
        And Validate response attributes with internalStatus: "<internalStatus>" and message: "<message>" and error: "<errors>"

        Examples:
            | case                  | apiKEY                          | externalId | sessionId             | trade  | asset | side | userAnyId | againstAmount | against | statusCode | internalStatus | message                   | errors                                                                 |
            | againstAmountAmount   | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | ext-n      | integrationc-orders-n | compra | USDT  | BUY  | 100008501 |               | ARS     | 400        | BAD_REQUEST    | Bad request.              | One of these fields needs to be provided [assetAmount, againstAmount]. |
            | againstAmountAmount 0 | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | ext-n      | integrationc-orders-n | compra | USDT  | BUY  | 100008501 | 0             | ARS     | 400        | MIN_SIZE       | Invalid order size (min). |                                                                        |

    @testing
    Scenario Outline: Validate error order response sending both <case>
        Given The urlBase is available "https://sandbox.manteca.dev/crypto"
        And The API key is available "<apiKEY>"
        When Assign the value "<externalId>" to the variable "externalId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Assign the value "<againstAmount>" to the variable "againstAmount"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<side>" to the variable "side"
        And Assign the value "pixCode" to the variable "code"
        And Execute the POST method on the endpoint "/v2/orders"
        Then Obtain a response <statusCode>
        And Validate response attributes with internalStatus: "<internalStatus>" and message: "<message>" and error: "<errors>"

        Examples:
            | case                | apiKEY                          | externalId | sessionId             | trade  | asset | side | userAnyId | againstAmount | assetAmount | against | statusCode | internalStatus | message      | errors                                                                                           |
            | againstAmountAmount | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | ext-n      | integrationc-orders-n | compra | USDT  | BUY  | 100008501 | 10            | 20          | ARS     | 400        | BAD_REQUEST    | Bad request. | Only one field is allowed between [assetAmount, againstAmount]. Please provide only one of them. |
