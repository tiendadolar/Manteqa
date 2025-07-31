@Orders
Feature: Ordenes

    Scenario Outline: Ejecutar ordenes de <trade> de <coin> contra <against> V1
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

        @Buy @USDT
        Examples:
            | sessionId   | trade  | coin      | operation | userId    | amount | against |
            | order-qaa-n | compra | USDT_ARS  | BUY       | 100010451 | 5      | ARS     |
            | order-qaa-n | compra | USDT_USD  | BUY       | 100010451 | 5      | USD     |
            | order-qaa-n | compra | USDT_CLP  | BUY       | 100010451 | 5      | CLP     |
            | order-qaa-n | compra | USDT_COP  | BUY       | 100010451 | 5      | COP     |
            | order-qaa-n | compra | USDT_BRL  | BUY       | 100010451 | 5      | BRL     |
            | order-qaa-n | compra | USDT_GTQ  | BUY       | 100010451 | 5      | GTQ     |
            | order-qaa-n | compra | USDT_CRC  | BUY       | 100010451 | 5      | CRC     |
            | order-qaa-n | compra | USDT_PUSD | BUY       | 100010451 | 5      | PUSD    |
            | order-qaa-n | compra | USDT_MXN  | BUY       | 100010451 | 5      | MXN     |
            | order-qaa-n | compra | USDT_PHP  | BUY       | 100010451 | 5      | PHP     |

        @Buy @USDC
        Examples:
            | sessionId   | trade  | coin      | operation | userId    | amount | against |
            | order-qaa-n | compra | USDC_ARS  | BUY       | 100010451 | 5      | ARS     |
            | order-qaa-n | compra | USDC_USD  | BUY       | 100010451 | 5      | USD     |
            | order-qaa-n | compra | USDC_CLP  | BUY       | 100010451 | 5      | CLP     |
            | order-qaa-n | compra | USDC_COP  | BUY       | 100010451 | 5      | COP     |
            | order-qaa-n | compra | USDC_BRL  | BUY       | 100010451 | 5      | BRL     |
            | order-qaa-n | compra | USDC_GTQ  | BUY       | 100010451 | 5      | GTQ     |
            | order-qaa-n | compra | USDC_CRC  | BUY       | 100010451 | 5      | CRC     |
            | order-qaa-n | compra | USDC_PUSD | BUY       | 100010451 | 5      | PUSD    |
            | order-qaa-n | compra | USDC_MXN  | BUY       | 100010451 | 5      | MXN     |
            | order-qaa-n | compra | USDC_PHP  | BUY       | 100010451 | 5      | PHP     |

        @BuyByCountry @USDT
        Examples:
            | sessionId   | trade  | coin      | operation | userId    | amount | against |
            | order-qaa-n | compra | USDT_ARS  | BUY       | 100010451 | 5      | ARS     |
            | order-qaa-n | compra | USDT_USD  | BUY       | 100010451 | 5      | USD     |
            | order-qaa-n | compra | USDT_CLP  | BUY       | 100009020 | 5      | CLP     |
            | order-qaa-n | compra | USDT_COP  | BUY       | 100009042 | 5      | COP     |
            | order-qaa-n | compra | USDT_BRL  | BUY       | 100008848 | 5      | BRL     |
            | order-qaa-n | compra | USDT_GTQ  | BUY       | 100009413 | 5      | GTQ     |
            | order-qaa-n | compra | USDT_CRC  | BUY       | 100009603 | 5      | CRC     |
            | order-qaa-n | compra | USDT_PUSD | BUY       | 100009508 | 5      | PUSD    |
            | order-qaa-n | compra | USDT_MXN  | BUY       | 100009051 | 5      | MXN     |
            | order-qaa-n | compra | USDT_PHP  | BUY       | 100009089 | 5      | PHP     |

        @BuyByCountry @USDC
        Examples:
            | sessionId   | trade  | coin      | operation | userId    | amount | against |
            | order-qaa-n | compra | USDC_ARS  | BUY       | 100010451 | 5      | ARS     |
            | order-qaa-n | compra | USDC_USD  | BUY       | 100010451 | 5      | USD     |
            | order-qaa-n | compra | USDC_CLP  | BUY       | 100009020 | 5      | CLP     |
            | order-qaa-n | compra | USDC_COP  | BUY       | 100009042 | 5      | COP     |
            | order-qaa-n | compra | USDC_BRL  | BUY       | 100008848 | 5      | BRL     |
            | order-qaa-n | compra | USDC_GTQ  | BUY       | 100009413 | 5      | GTQ     |
            | order-qaa-n | compra | USDC_CRC  | BUY       | 100009603 | 5      | CRC     |
            | order-qaa-n | compra | USDC_PUSD | BUY       | 100009508 | 5      | PUSD    |
            | order-qaa-n | compra | USDC_MXN  | BUY       | 100009051 | 5      | MXN     |
            | order-qaa-n | compra | USDC_PHP  | BUY       | 100009089 | 5      | PHP     |

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

        @Sell @USDT
        Examples:
            | sessionId   | trade | coin      | operation | userId    | amount | against |
            | order-qaa-n | venta | USDT_ARS  | SELL      | 100010451 | 5      | ARS     |
            | order-qaa-n | venta | USDT_USD  | SELL      | 100010451 | 5      | USD     |
            | order-qaa-n | venta | USDT_CLP  | SELL      | 100010451 | 5      | CLP     |
            | order-qaa-n | venta | USDT_COP  | SELL      | 100010451 | 5      | COP     |
            | order-qaa-n | venta | USDT_BRL  | SELL      | 100010451 | 5      | BRL     |
            | order-qaa-n | venta | USDT_GTQ  | SELL      | 100010451 | 5      | GTQ     |
            | order-qaa-n | venta | USDT_CRC  | SELL      | 100010451 | 5      | CRC     |
            | order-qaa-n | venta | USDT_PUSD | SELL      | 100010451 | 5      | PUSD    |
            | order-qaa-n | venta | USDT_MXN  | SELL      | 100010451 | 5      | MXN     |
            | order-qaa-n | venta | USDT_PHP  | SELL      | 100010451 | 5      | PHP     |

        @Sell @USDC
        Examples:
            | sessionId   | trade | coin      | operation | userId    | amount | against |
            | order-qaa-n | venta | USDC_ARS  | SELL      | 100010451 | 5      | ARS     |
            | order-qaa-n | venta | USDC_USD  | SELL      | 100010451 | 5      | USD     |
            | order-qaa-n | venta | USDC_CLP  | SELL      | 100010451 | 5      | CLP     |
            | order-qaa-n | venta | USDC_COP  | SELL      | 100010451 | 5      | COP     |
            | order-qaa-n | venta | USDC_BRL  | SELL      | 100010451 | 5      | BRL     |
            | order-qaa-n | venta | USDC_GTQ  | SELL      | 100010451 | 5      | GTQ     |
            | order-qaa-n | venta | USDC_CRC  | SELL      | 100010451 | 5      | CRC     |
            | order-qaa-n | venta | USDC_PUSD | SELL      | 100010451 | 5      | PUSD    |
            | order-qaa-n | venta | USDC_MXN  | SELL      | 100010451 | 5      | MXN     |
            | order-qaa-n | venta | USDC_PHP  | SELL      | 100010451 | 5      | PHP     |

        @BuyByCountry @USDT
        Examples:
            | sessionId   | trade | coin      | operation | userId    | amount | against |
            | order-qaa-n | venta | USDT_ARS  | SELL      | 100010451 | 5      | ARS     |
            | order-qaa-n | venta | USDT_USD  | SELL      | 100010451 | 5      | USD     |
            | order-qaa-n | venta | USDT_CLP  | SELL      | 100009020 | 5      | CLP     |
            | order-qaa-n | venta | USDT_COP  | SELL      | 100009042 | 5      | COP     |
            | order-qaa-n | venta | USDT_BRL  | SELL      | 100008848 | 5      | BRL     |
            | order-qaa-n | venta | USDT_GTQ  | SELL      | 100009413 | 5      | GTQ     |
            | order-qaa-n | venta | USDT_CRC  | SELL      | 100009603 | 5      | CRC     |
            | order-qaa-n | venta | USDT_PUSD | SELL      | 100009508 | 5      | PUSD    |
            | order-qaa-n | venta | USDT_MXN  | SELL      | 100009051 | 5      | MXN     |
            | order-qaa-n | venta | USDT_PHP  | SELL      | 100009089 | 5      | PHP     |

        @BuyByCountry @USDC
        Examples:
            | sessionId   | trade | coin      | operation | userId    | amount | against |
            | order-qaa-n | venta | USDC_ARS  | SELL      | 100010451 | 5      | ARS     |
            | order-qaa-n | venta | USDC_USD  | SELL      | 100010451 | 5      | USD     |
            | order-qaa-n | venta | USDC_CLP  | SELL      | 100009020 | 5      | CLP     |
            | order-qaa-n | venta | USDC_COP  | SELL      | 100009042 | 5      | COP     |
            | order-qaa-n | venta | USDC_BRL  | SELL      | 100008848 | 5      | BRL     |
            | order-qaa-n | venta | USDC_GTQ  | SELL      | 100009413 | 5      | GTQ     |
            | order-qaa-n | venta | USDC_CRC  | SELL      | 100009603 | 5      | CRC     |
            | order-qaa-n | venta | USDC_PUSD | SELL      | 100009508 | 5      | PUSD    |
            | order-qaa-n | venta | USDC_MXN  | SELL      | 100009051 | 5      | MXN     |
            | order-qaa-n | venta | USDC_PHP  | SELL      | 100009089 | 5      | PHP     |

    @BuyByCountry
    Scenario Outline: Ejecutar ordenes de <trade> de <coin> contra <against> V1
        Given The API key is available "B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV"
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

        @BuyByCountry @USDT
        Examples:
            | sessionId   | trade  | coin      | operation | userId    | amount | against |
            | order-qaa-n | compra | USDT_ARS  | BUY       | 100010451 | 5      | ARS     |
            | order-qaa-n | compra | USDT_USD  | BUY       | 100010451 | 5      | USD     |
            | order-qaa-n | compra | USDT_CLP  | BUY       | 100009020 | 5      | CLP     |
            | order-qaa-n | compra | USDT_COP  | BUY       | 100009042 | 5      | COP     |
            | order-qaa-n | compra | USDT_BRL  | BUY       | 100008848 | 5      | BRL     |
            | order-qaa-n | compra | USDT_GTQ  | BUY       | 100009413 | 5      | GTQ     |
            | order-qaa-n | compra | USDT_CRC  | BUY       | 100009603 | 5      | CRC     |
            | order-qaa-n | compra | USDT_PUSD | BUY       | 100009508 | 5      | PUSD    |
            | order-qaa-n | compra | USDT_MXN  | BUY       | 100009051 | 5      | MXN     |
            | order-qaa-n | compra | USDT_PHP  | BUY       | 100009089 | 5      | PHP     |

        @BuyByCountry @USDC
        Examples:
            | sessionId   | trade  | coin      | operation | userId    | amount | against |
            | order-qaa-n | compra | USDC_ARS  | BUY       | 100010451 | 5      | ARS     |
            | order-qaa-n | compra | USDC_USD  | BUY       | 100010451 | 5      | USD     |
            | order-qaa-n | compra | USDC_CLP  | BUY       | 100009020 | 5      | CLP     |
            | order-qaa-n | compra | USDC_COP  | BUY       | 100009042 | 5      | COP     |
            | order-qaa-n | compra | USDC_BRL  | BUY       | 100008848 | 5      | BRL     |
            | order-qaa-n | compra | USDC_GTQ  | BUY       | 100009413 | 5      | GTQ     |
            | order-qaa-n | compra | USDC_CRC  | BUY       | 100009603 | 5      | CRC     |
            | order-qaa-n | compra | USDC_PUSD | BUY       | 100009508 | 5      | PUSD    |
            | order-qaa-n | compra | USDC_MXN  | BUY       | 100009051 | 5      | MXN     |
            | order-qaa-n | compra | USDC_PHP  | BUY       | 100009089 | 5      | PHP     |

        @BuyByCountry @USDT
        Examples:
            | sessionId   | trade | coin      | operation | userId    | amount | against |
            | order-qaa-n | venta | USDT_ARS  | SELL      | 100010451 | 5      | ARS     |
            | order-qaa-n | venta | USDT_USD  | SELL      | 100010451 | 5      | USD     |
            | order-qaa-n | venta | USDT_CLP  | SELL      | 100009020 | 5      | CLP     |
            | order-qaa-n | venta | USDT_COP  | SELL      | 100009042 | 5      | COP     |
            | order-qaa-n | venta | USDT_BRL  | SELL      | 100008848 | 5      | BRL     |
            | order-qaa-n | venta | USDT_GTQ  | SELL      | 100009413 | 5      | GTQ     |
            | order-qaa-n | venta | USDT_CRC  | SELL      | 100009603 | 5      | CRC     |
            | order-qaa-n | venta | USDT_PUSD | SELL      | 100009508 | 5      | PUSD    |
            | order-qaa-n | venta | USDT_MXN  | SELL      | 100009051 | 5      | MXN     |
            | order-qaa-n | venta | USDT_PHP  | SELL      | 100009089 | 5      | PHP     |

        @BuyByCountry @USDC
        Examples:
            | sessionId   | trade | coin      | operation | userId    | amount | against |
            | order-qaa-n | venta | USDC_ARS  | SELL      | 100010451 | 5      | ARS     |
            | order-qaa-n | venta | USDC_USD  | SELL      | 100010451 | 5      | USD     |
            | order-qaa-n | venta | USDC_CLP  | SELL      | 100009020 | 5      | CLP     |
            | order-qaa-n | venta | USDC_COP  | SELL      | 100009042 | 5      | COP     |
            | order-qaa-n | venta | USDC_BRL  | SELL      | 100008848 | 5      | BRL     |
            | order-qaa-n | venta | USDC_GTQ  | SELL      | 100009413 | 5      | GTQ     |
            | order-qaa-n | venta | USDC_CRC  | SELL      | 100009603 | 5      | CRC     |
            | order-qaa-n | venta | USDC_PUSD | SELL      | 100009508 | 5      | PUSD    |
            | order-qaa-n | venta | USDC_MXN  | SELL      | 100009051 | 5      | MXN     |
            | order-qaa-n | venta | USDC_PHP  | SELL      | 100009089 | 5      | PHP     |




    #*---------------- V2 -----------------*



    @V2
    Scenario Outline: Ejecutar ordenes de <trade> de <coin> contra <against> V2
        Given The API key is available "B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<side>" to the variable "side"
        And Assign the value "pixCode" to the variable "code"
        And Execute the POST method on the endpoint "/v2/orders"
        Then Obtain a response 201
        # And The purchase order is created

        When Wait for the processing of the "orden" por 1 seconds
        And Execute the GET method on the endpoint "/v2/orders/{orderNumberId}"
        Then Obtain a response 200 y status COMPLETED

        @BuyByCountry @USDT
        Examples:
            | sessionId   | trade  | asset | side | userAnyId | assetAmount | against |
            | order-qaa-n | compra | USDT  | BUY  | 100008501 | 5           | ARS     |
            | order-qaa-n | compra | USDT  | BUY  | 100008501 | 5           | USD     |
            | order-qaa-n | compra | USDT  | BUY  | 100009020 | 5           | CLP     |
            | order-qaa-n | compra | USDT  | BUY  | 100009042 | 5           | COP     |
            | order-qaa-n | compra | USDT  | BUY  | 100008848 | 5           | BRL     |
            | order-qaa-n | compra | USDT  | BUY  | 100009413 | 5           | GTQ     |
            | order-qaa-n | compra | USDT  | BUY  | 100009603 | 5           | CRC     |
            | order-qaa-n | compra | USDT  | BUY  | 100009508 | 5           | PUSD    |
            | order-qaa-n | compra | USDT  | BUY  | 100009051 | 5           | MXN     |
            | order-qaa-n | compra | USDT  | BUY  | 100009089 | 5           | PHP     |

        @BuyByCountry @USDC
        Examples:
            | sessionId   | trade  | asset | side | userAnyId | assetAmount | against |
            | order-qaa-n | compra | USDC  | BUY  | 100008501 | 5           | ARS     |
            | order-qaa-n | compra | USDC  | BUY  | 100008501 | 5           | USD     |
            | order-qaa-n | compra | USDC  | BUY  | 100009020 | 5           | CLP     |
            | order-qaa-n | compra | USDC  | BUY  | 100009042 | 5           | COP     |
            | order-qaa-n | compra | USDC  | BUY  | 100008848 | 5           | BRL     |
            | order-qaa-n | compra | USDC  | BUY  | 100009413 | 5           | GTQ     |
            | order-qaa-n | compra | USDC  | BUY  | 100009603 | 5           | CRC     |
            | order-qaa-n | compra | USDC  | BUY  | 100009508 | 5           | PUSD    |
            | order-qaa-n | compra | USDC  | BUY  | 100009051 | 5           | MXN     |
            | order-qaa-n | compra | USDC  | BUY  | 100009089 | 5           | PHP     |

        @SellByCountry @USDT
        Examples:
            | sessionId   | trade | asset | side | userAnyId | assetAmount | against |
            | order-qaa-n | venta | USDT  | SELL | 100008501 | 5           | ARS     |
            | order-qaa-n | venta | USDT  | SELL | 100008501 | 5           | USD     |
            | order-qaa-n | venta | USDT  | SELL | 100009020 | 5           | CLP     |
            | order-qaa-n | venta | USDT  | SELL | 100009042 | 5           | COP     |
            | order-qaa-n | venta | USDT  | SELL | 100008848 | 5           | BRL     |
            | order-qaa-n | venta | USDT  | SELL | 100009413 | 5           | GTQ     |
            | order-qaa-n | venta | USDT  | SELL | 100009603 | 5           | CRC     |
            | order-qaa-n | venta | USDT  | SELL | 100009508 | 5           | PUSD    |
            | order-qaa-n | venta | USDT  | SELL | 100009051 | 5           | MXN     |
            | order-qaa-n | venta | USDT  | SELL | 100009089 | 5           | PHP     |

        @SellByCountry @USDC
        Examples:
            | sessionId   | trade | asset | side | userAnyId | assetAmount | against |
            | order-qaa-n | venta | USDC  | SELL | 100008501 | 5           | ARS     |
            | order-qaa-n | venta | USDC  | SELL | 100008501 | 5           | USD     |
            | order-qaa-n | venta | USDC  | SELL | 100009020 | 5           | CLP     |
            | order-qaa-n | venta | USDC  | SELL | 100009042 | 5           | COP     |
            | order-qaa-n | venta | USDC  | SELL | 100008848 | 5           | BRL     |
            | order-qaa-n | venta | USDC  | SELL | 100009413 | 5           | GTQ     |
            | order-qaa-n | venta | USDC  | SELL | 100009603 | 5           | CRC     |
            | order-qaa-n | venta | USDC  | SELL | 100009508 | 5           | PUSD    |
            | order-qaa-n | venta | USDC  | SELL | 100009051 | 5           | MXN     |
            | order-qaa-n | venta | USDC  | SELL | 100009089 | 5           | PHP     |





