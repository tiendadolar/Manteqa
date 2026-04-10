@Orders
Feature: Ordenes

    Scenario Outline: Ejecutar ordenes de <trade> de <coin> contra <against> V1
        Given Get credentials for company "<companyId>"
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
        Then Obtain a response 200 y status "COMPLETED"

        @PYG
        Examples:
            | companyId                | sessionId   | trade  | coin     | operation | userId    | amount | against |
            | 683cce15397feba125068c9b | order-qaa-n | compra | WLD_PYG  | BUY       | 100061435 | 5      | PYG     |
            | 683cce15397feba125068c9b | order-qaa-n | compra | USDT_PYG | BUY       | 100061435 | 5      | PYG     |
            | 683cce15397feba125068c9b | order-qaa-n | compra | USDC_PYG | BUY       | 100061435 | 5      | PYG     |

        @Buy
        Examples:
            | companyId                | sessionId   | trade  | coin     | operation | userId    | amount | against |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | WLD_ARS  | BUY       | 100010451 | 5      | ARS     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | USDT_ARS | BUY       | 100010451 | 5      | ARS     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | DAI_ARS  | BUY       | 100010451 | 5      | ARS     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | USDC_ARS | BUY       | 100010451 | 5      | ARS     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | ETH_ARS  | BUY       | 100010451 | 0.01   | ARS     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | BNB_ARS  | BUY       | 100010451 | 0.01   | ARS     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | BTC_ARS  | BUY       | 100010451 | 0.01   | ARS     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | POL_ARS  | BUY       | 100010451 | 5      | ARS     |

        @Buy @USDT
        Examples:
            | companyId                | sessionId   | trade  | coin      | operation | userId    | amount | against |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | USDT_ARS  | BUY       | 100010451 | 5      | ARS     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | USDT_USD  | BUY       | 100010451 | 5      | USD     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | USDT_CLP  | BUY       | 100010451 | 5      | CLP     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | USDT_COP  | BUY       | 100010451 | 5      | COP     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | USDT_BRL  | BUY       | 100010451 | 5      | BRL     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | USDT_GTQ  | BUY       | 100010451 | 5      | GTQ     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | USDT_CRC  | BUY       | 100010451 | 5      | CRC     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | USDT_PUSD | BUY       | 100010451 | 5      | PUSD    |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | USDT_MXN  | BUY       | 100010451 | 5      | MXN     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | USDT_PHP  | BUY       | 100010451 | 5      | PHP     |

        @Buy @USDC
        Examples:
            | companyId                | sessionId   | trade  | coin      | operation | userId    | amount | against |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | USDC_ARS  | BUY       | 100010451 | 5      | ARS     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | USDC_USD  | BUY       | 100010451 | 5      | USD     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | USDC_CLP  | BUY       | 100010451 | 5      | CLP     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | USDC_COP  | BUY       | 100010451 | 5      | COP     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | USDC_BRL  | BUY       | 100010451 | 5      | BRL     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | USDC_GTQ  | BUY       | 100010451 | 5      | GTQ     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | USDC_CRC  | BUY       | 100010451 | 5      | CRC     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | USDC_PUSD | BUY       | 100010451 | 5      | PUSD    |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | USDC_MXN  | BUY       | 100010451 | 5      | MXN     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | USDC_PHP  | BUY       | 100010451 | 5      | PHP     |

        @BuyByCountry @USDT
        Examples:
            | companyId                | sessionId   | trade  | coin      | operation | userId    | amount | against |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | USDT_ARS  | BUY       | 100010451 | 5      | ARS     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | USDT_USD  | BUY       | 100010451 | 5      | USD     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | USDT_CLP  | BUY       | 100009020 | 5      | CLP     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | USDT_COP  | BUY       | 100009042 | 5      | COP     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | USDT_BRL  | BUY       | 100008848 | 5      | BRL     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | USDT_GTQ  | BUY       | 100009413 | 5      | GTQ     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | USDT_CRC  | BUY       | 100009603 | 5      | CRC     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | USDT_PUSD | BUY       | 100009508 | 5      | PUSD    |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | USDT_MXN  | BUY       | 100009051 | 5      | MXN     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | USDT_PHP  | BUY       | 100009089 | 5      | PHP     |

        @BuyByCountry @USDC
        Examples:
            | companyId                | sessionId   | trade  | coin      | operation | userId    | amount | against |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | USDC_ARS  | BUY       | 100010451 | 5      | ARS     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | USDC_USD  | BUY       | 100010451 | 5      | USD     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | USDC_CLP  | BUY       | 100009020 | 5      | CLP     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | USDC_COP  | BUY       | 100009042 | 5      | COP     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | USDC_BRL  | BUY       | 100008848 | 5      | BRL     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | USDC_GTQ  | BUY       | 100009413 | 5      | GTQ     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | USDC_CRC  | BUY       | 100009603 | 5      | CRC     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | USDC_PUSD | BUY       | 100009508 | 5      | PUSD    |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | USDC_MXN  | BUY       | 100009051 | 5      | MXN     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | USDC_PHP  | BUY       | 100009089 | 5      | PHP     |

        @Sell
        Examples:
            | companyId                | sessionId   | trade | coin     | operation | userId    | amount | against |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | WLD_ARS  | SELL      | 100010451 | 5      | ARS     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | USDT_ARS | SELL      | 100010451 | 5      | ARS     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | DAI_ARS  | SELL      | 100010451 | 5      | ARS     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | USDC_ARS | SELL      | 100010451 | 5      | ARS     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | ETH_ARS  | SELL      | 100010451 | 0.01   | ARS     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | BNB_ARS  | SELL      | 100010451 | 0.01   | ARS     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | BTC_ARS  | SELL      | 100010451 | 0.01   | ARS     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | POL_ARS  | SELL      | 100010451 | 5      | ARS     |

        @Sell @USDT
        Examples:
            | companyId                | sessionId   | trade | coin      | operation | userId    | amount | against |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | USDT_ARS  | SELL      | 100010451 | 5      | ARS     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | USDT_USD  | SELL      | 100010451 | 5      | USD     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | USDT_CLP  | SELL      | 100010451 | 5      | CLP     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | USDT_COP  | SELL      | 100010451 | 5      | COP     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | USDT_BRL  | SELL      | 100010451 | 5      | BRL     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | USDT_GTQ  | SELL      | 100010451 | 5      | GTQ     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | USDT_CRC  | SELL      | 100010451 | 5      | CRC     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | USDT_PUSD | SELL      | 100010451 | 5      | PUSD    |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | USDT_MXN  | SELL      | 100010451 | 5      | MXN     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | USDT_PHP  | SELL      | 100010451 | 5      | PHP     |

        @Sell @USDC
        Examples:
            | companyId                | sessionId   | trade | coin      | operation | userId    | amount | against |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | USDC_ARS  | SELL      | 100010451 | 5      | ARS     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | USDC_USD  | SELL      | 100010451 | 5      | USD     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | USDC_CLP  | SELL      | 100010451 | 5      | CLP     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | USDC_COP  | SELL      | 100010451 | 5      | COP     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | USDC_BRL  | SELL      | 100010451 | 5      | BRL     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | USDC_GTQ  | SELL      | 100010451 | 5      | GTQ     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | USDC_CRC  | SELL      | 100010451 | 5      | CRC     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | USDC_PUSD | SELL      | 100010451 | 5      | PUSD    |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | USDC_MXN  | SELL      | 100010451 | 5      | MXN     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | USDC_PHP  | SELL      | 100010451 | 5      | PHP     |

        @BuyByCountry @USDT
        Examples:
            | companyId                | sessionId   | trade | coin      | operation | userId    | amount | against |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | USDT_ARS  | SELL      | 100010451 | 5      | ARS     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | USDT_USD  | SELL      | 100010451 | 5      | USD     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | USDT_CLP  | SELL      | 100009020 | 5      | CLP     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | USDT_COP  | SELL      | 100009042 | 5      | COP     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | USDT_BRL  | SELL      | 100008848 | 5      | BRL     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | USDT_GTQ  | SELL      | 100009413 | 5      | GTQ     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | USDT_CRC  | SELL      | 100009603 | 5      | CRC     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | USDT_PUSD | SELL      | 100009508 | 5      | PUSD    |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | USDT_MXN  | SELL      | 100009051 | 5      | MXN     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | USDT_PHP  | SELL      | 100009089 | 5      | PHP     |

        @BuyByCountry @USDC
        Examples:
            | companyId                | sessionId   | trade | coin      | operation | userId    | amount | against |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | USDC_ARS  | SELL      | 100010451 | 5      | ARS     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | USDC_USD  | SELL      | 100010451 | 5      | USD     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | USDC_CLP  | SELL      | 100009020 | 5      | CLP     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | USDC_COP  | SELL      | 100009042 | 5      | COP     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | USDC_BRL  | SELL      | 100008848 | 5      | BRL     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | USDC_GTQ  | SELL      | 100009413 | 5      | GTQ     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | USDC_CRC  | SELL      | 100009603 | 5      | CRC     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | USDC_PUSD | SELL      | 100009508 | 5      | PUSD    |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | USDC_MXN  | SELL      | 100009051 | 5      | MXN     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | USDC_PHP  | SELL      | 100009089 | 5      | PHP     |

    @Smoke @V1 @Regression
    Scenario Outline: Ejecutar ordenes de <trade> de <coin> contra <against> V1
        Given Get credentials for company "<companyId>"
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
        Then Obtain a response 200 y status "COMPLETED"

        @BuyByCountry @USDT @Automated
        Examples:
            | companyId                | sessionId   | trade  | coin      | operation | userId    | amount | against |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | USDT_ARS  | BUY       | 100010451 | 5      | ARS     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | compra | USDT_USD  | BUY       | 100010451 | 5      | USD     |
            | 683cce15397feba125068c9b | order-qaa-n | compra | USDT_CLP  | BUY       | 100009020 | 5      | CLP     |
            | 683cce15397feba125068c9b | order-qaa-n | compra | USDT_COP  | BUY       | 100009042 | 5      | COP     |
            | 683cce15397feba125068c9b | order-qaa-n | compra | USDT_BRL  | BUY       | 100008848 | 5      | BRL     |
            | 683cce15397feba125068c9b | order-qaa-n | compra | USDT_GTQ  | BUY       | 100009413 | 5      | GTQ     |
            | 683cce15397feba125068c9b | order-qaa-n | compra | USDT_CRC  | BUY       | 100009603 | 5      | CRC     |
            | 683cce15397feba125068c9b | order-qaa-n | compra | USDT_PUSD | BUY       | 100009508 | 5      | PUSD    |
            | 683cce15397feba125068c9b | order-qaa-n | compra | USDT_MXN  | BUY       | 100009051 | 5      | MXN     |
            | 683cce15397feba125068c9b | order-qaa-n | compra | USDT_PHP  | BUY       | 100009089 | 5      | PHP     |

        @BuyByCountry @USDC
        Examples:
            | companyId                | sessionId   | trade  | coin      | operation | userId    | amount | against |
            | 683cce15397feba125068c9b | order-qaa-n | compra | USDC_ARS  | BUY       | 100010451 | 5      | ARS     |
            | 683cce15397feba125068c9b | order-qaa-n | compra | USDC_USD  | BUY       | 100010451 | 5      | USD     |
            | 683cce15397feba125068c9b | order-qaa-n | compra | USDC_CLP  | BUY       | 100009020 | 5      | CLP     |
            | 683cce15397feba125068c9b | order-qaa-n | compra | USDC_COP  | BUY       | 100009042 | 5      | COP     |
            | 683cce15397feba125068c9b | order-qaa-n | compra | USDC_BRL  | BUY       | 100008848 | 5      | BRL     |
            | 683cce15397feba125068c9b | order-qaa-n | compra | USDC_GTQ  | BUY       | 100009413 | 5      | GTQ     |
            | 683cce15397feba125068c9b | order-qaa-n | compra | USDC_CRC  | BUY       | 100009603 | 5      | CRC     |
            | 683cce15397feba125068c9b | order-qaa-n | compra | USDC_PUSD | BUY       | 100009508 | 5      | PUSD    |
            | 683cce15397feba125068c9b | order-qaa-n | compra | USDC_MXN  | BUY       | 100009051 | 5      | MXN     |
            | 683cce15397feba125068c9b | order-qaa-n | compra | USDC_PHP  | BUY       | 100009089 | 5      | PHP     |

        @SellByCountry @USDT @Automated
        Examples:
            | companyId                | sessionId   | trade | coin      | operation | userId    | amount | against |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | USDT_ARS  | SELL      | 100010451 | 5      | ARS     |
            | 684b2f25dcca16d5557fd8b2 | order-qaa-n | venta | USDT_USD  | SELL      | 100010451 | 5      | USD     |
            | 683cce15397feba125068c9b | order-qaa-n | venta | USDT_CLP  | SELL      | 100009020 | 5      | CLP     |
            | 683cce15397feba125068c9b | order-qaa-n | venta | USDT_COP  | SELL      | 100009042 | 5      | COP     |
            | 683cce15397feba125068c9b | order-qaa-n | venta | USDT_BRL  | SELL      | 100008848 | 5      | BRL     |
            | 683cce15397feba125068c9b | order-qaa-n | venta | USDT_GTQ  | SELL      | 100009413 | 5      | GTQ     |
            | 683cce15397feba125068c9b | order-qaa-n | venta | USDT_CRC  | SELL      | 100009603 | 5      | CRC     |
            | 683cce15397feba125068c9b | order-qaa-n | venta | USDT_PUSD | SELL      | 100009508 | 5      | PUSD    |
            | 683cce15397feba125068c9b | order-qaa-n | venta | USDT_MXN  | SELL      | 100009051 | 5      | MXN     |
            | 683cce15397feba125068c9b | order-qaa-n | venta | USDT_PHP  | SELL      | 100009089 | 5      | PHP     |

        @SellByCountry @USDC
        Examples:
            | companyId                | sessionId   | trade | coin      | operation | userId    | amount | against |
            | 683cce15397feba125068c9b | order-qaa-n | venta | USDC_ARS  | SELL      | 100010451 | 5      | ARS     |
            | 683cce15397feba125068c9b | order-qaa-n | venta | USDC_USD  | SELL      | 100010451 | 5      | USD     |
            | 683cce15397feba125068c9b | order-qaa-n | venta | USDC_CLP  | SELL      | 100009020 | 5      | CLP     |
            | 683cce15397feba125068c9b | order-qaa-n | venta | USDC_COP  | SELL      | 100009042 | 5      | COP     |
            | 683cce15397feba125068c9b | order-qaa-n | venta | USDC_BRL  | SELL      | 100008848 | 5      | BRL     |
            | 683cce15397feba125068c9b | order-qaa-n | venta | USDC_GTQ  | SELL      | 100009413 | 5      | GTQ     |
            | 683cce15397feba125068c9b | order-qaa-n | venta | USDC_CRC  | SELL      | 100009603 | 5      | CRC     |
            | 683cce15397feba125068c9b | order-qaa-n | venta | USDC_PUSD | SELL      | 100009508 | 5      | PUSD    |
            | 683cce15397feba125068c9b | order-qaa-n | venta | USDC_MXN  | SELL      | 100009051 | 5      | MXN     |
            | 683cce15397feba125068c9b | order-qaa-n | venta | USDC_PHP  | SELL      | 100009089 | 5      | PHP     |

    #*---------------- PLUS -----------------*

    @Smoke @V1 @Regression @Plus
    Scenario Outline: PLUS: Ejecutar ordenes de <trade> de <coin> contra <against> V1 para user PLUS
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        And Obtain a company debt "<against>" balance
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
        Then Obtain a response 200 y status "COMPLETED"
        And Obtain a company debt "<against>" balance

        @Buy @Automated
        Examples:
            | companyId                | sessionId   | trade  | coin      | operation | userId    | amount | against |
            | 69aa390533ca661b9c97bf94 | order-qaa-n | compra | USDT_ARS  | BUY       | 100058862 | 5      | ARS     |
            | 69aa390533ca661b9c97bf94 | order-qaa-n | compra | USDC_ARS  | BUY       | 100058862 | 5      | ARS     |
            | 69aa390533ca661b9c97bf94 | order-qaa-n | compra | USDCB_ARS | BUY       | 100058862 | 5      | ARS     |
            | 69aa390533ca661b9c97bf94 | order-qaa-n | compra | WLD_ARS   | BUY       | 100058862 | 5      | ARS     |
            | 69aa390533ca661b9c97bf94 | order-qaa-n | compra | DAI_ARS   | BUY       | 100058862 | 5      | ARS     |
            | 69aa390533ca661b9c97bf94 | order-qaa-n | compra | ETH_ARS   | BUY       | 100058862 | 0.01   | ARS     |
            | 69aa390533ca661b9c97bf94 | order-qaa-n | compra | BTC_ARS   | BUY       | 100058862 | 0.01   | ARS     |
            | 69aa390533ca661b9c97bf94 | order-qaa-n | compra | BNB_ARS   | BUY       | 100058862 | 0.1    | ARS     |

    @Smoke @V1 @Regression @Plus
    Scenario Outline: PLUS: Ejecutar ordenes de <trade> de <coin> contra <against> V1 para user PLUS
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        And Obtain "<against>" credit balance "company"
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
        Then Obtain a response 200 y status "COMPLETED"
        And Obtain "<against>" credit balance "company"

        @Sell @Automated
        Examples:
            | companyId                | sessionId   | trade | coin      | operation | userId    | amount | against |
            | 69aa390533ca661b9c97bf94 | order-qaa-n | venta | USDT_ARS  | SELL      | 100058862 | 4      | ARS     |
            | 69aa390533ca661b9c97bf94 | order-qaa-n | venta | USDC_ARS  | SELL      | 100058862 | 4      | ARS     |
            | 69aa390533ca661b9c97bf94 | order-qaa-n | venta | USDCB_ARS | SELL      | 100058862 | 4      | ARS     |
            | 69aa390533ca661b9c97bf94 | order-qaa-n | venta | WLD_ARS   | SELL      | 100058862 | 4      | ARS     |
            | 69aa390533ca661b9c97bf94 | order-qaa-n | venta | DAI_ARS   | SELL      | 100058862 | 4      | ARS     |
            | 69aa390533ca661b9c97bf94 | order-qaa-n | venta | ETH_ARS   | SELL      | 100058862 | 0.01   | ARS     |
            | 69aa390533ca661b9c97bf94 | order-qaa-n | venta | BTC_ARS   | SELL      | 100058862 | 0.01   | ARS     |
            | 69aa390533ca661b9c97bf94 | order-qaa-n | venta | BNB_ARS   | SELL      | 100058862 | 0.1    | ARS     |

    #*---------------- V2 -----------------*

    @Smoke @V2 @Regression
    Scenario Outline: Ejecutar ordenes de <trade> de <coin> contra <against> V2
        Given Get credentials for company "<companyId>"
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
        Then Obtain a response 200 y status "COMPLETED"

        @BuyByCountry @USDT @Automated
        Examples:
            | companyId                | sessionId   | trade  | asset | side | userAnyId | assetAmount | against |
            | 683cce15397feba125068c9b | order-qaa-n | compra | USDT  | BUY  | 100008501 | 5           | ARS     |
            | 683cce15397feba125068c9b | order-qaa-n | compra | USDT  | BUY  | 100008501 | 5           | USD     |
            | 683cce15397feba125068c9b | order-qaa-n | compra | USDT  | BUY  | 100009020 | 5           | CLP     |
            | 683cce15397feba125068c9b | order-qaa-n | compra | USDT  | BUY  | 100009042 | 5           | COP     |
            | 683cce15397feba125068c9b | order-qaa-n | compra | USDT  | BUY  | 100008848 | 5           | BRL     |
            | 683cce15397feba125068c9b | order-qaa-n | compra | USDT  | BUY  | 100009413 | 5           | GTQ     |
            | 683cce15397feba125068c9b | order-qaa-n | compra | USDT  | BUY  | 100009603 | 5           | CRC     |
            | 683cce15397feba125068c9b | order-qaa-n | compra | USDT  | BUY  | 100009508 | 5           | PUSD    |
            | 683cce15397feba125068c9b | order-qaa-n | compra | USDT  | BUY  | 100009051 | 5           | MXN     |
            | 683cce15397feba125068c9b | order-qaa-n | compra | USDT  | BUY  | 100009089 | 5           | PHP     |
            | 683cce15397feba125068c9b | order-qaa-n | compra | USDT  | BUY  | 100010879 | 5           | BOB     |
            | 683cce15397feba125068c9b | order-qaa-n | compra | USDT  | BUY  | 100061435 | 5           | PYG     |

        @BuyByCountry @USDC
        Examples:
            | companyId                | sessionId   | trade  | asset | side | userAnyId | assetAmount | against |
            | 683cce15397feba125068c9b | order-qaa-n | compra | USDC  | BUY  | 100008501 | 5           | ARS     |
            | 683cce15397feba125068c9b | order-qaa-n | compra | USDC  | BUY  | 100008501 | 5           | USD     |
            | 683cce15397feba125068c9b | order-qaa-n | compra | USDC  | BUY  | 100009020 | 5           | CLP     |
            | 683cce15397feba125068c9b | order-qaa-n | compra | USDC  | BUY  | 100009042 | 5           | COP     |
            | 683cce15397feba125068c9b | order-qaa-n | compra | USDC  | BUY  | 100008848 | 5           | BRL     |
            | 683cce15397feba125068c9b | order-qaa-n | compra | USDC  | BUY  | 100009413 | 5           | GTQ     |
            | 683cce15397feba125068c9b | order-qaa-n | compra | USDC  | BUY  | 100009603 | 5           | CRC     |
            | 683cce15397feba125068c9b | order-qaa-n | compra | USDC  | BUY  | 100009508 | 5           | PUSD    |
            | 683cce15397feba125068c9b | order-qaa-n | compra | USDC  | BUY  | 100009051 | 5           | MXN     |
            | 683cce15397feba125068c9b | order-qaa-n | compra | USDC  | BUY  | 100009089 | 5           | PHP     |
            | 683cce15397feba125068c9b | order-qaa-n | compra | USDC  | BUY  | 100010879 | 5           | BOB     |
            | 683cce15397feba125068c9b | order-qaa-n | compra | USDC  | BUY  | 100061435 | 5           | PYG     |

        @BuyByCountry @WLD
        Examples:
            | companyId                | sessionId   | trade  | asset | side | userAnyId | assetAmount | against |
            | 683cce15397feba125068c9b | order-qaa-n | compra | WLD   | BUY  | 100008501 | 5           | ARS     |
            | 683cce15397feba125068c9b | order-qaa-n | compra | WLD   | BUY  | 100008501 | 5           | USD     |
            | 683cce15397feba125068c9b | order-qaa-n | compra | WLD   | BUY  | 100009020 | 5           | CLP     |
            | 683cce15397feba125068c9b | order-qaa-n | compra | WLD   | BUY  | 100009042 | 5           | COP     |
            | 683cce15397feba125068c9b | order-qaa-n | compra | WLD   | BUY  | 100008848 | 5           | BRL     |
            | 683cce15397feba125068c9b | order-qaa-n | compra | WLD   | BUY  | 100009413 | 5           | GTQ     |
            | 683cce15397feba125068c9b | order-qaa-n | compra | WLD   | BUY  | 100009603 | 5           | CRC     |
            | 683cce15397feba125068c9b | order-qaa-n | compra | WLD   | BUY  | 100009508 | 5           | PUSD    |
            | 683cce15397feba125068c9b | order-qaa-n | compra | WLD   | BUY  | 100009051 | 5           | MXN     |
            | 683cce15397feba125068c9b | order-qaa-n | compra | WLD   | BUY  | 100009089 | 5           | PHP     |
            | 683cce15397feba125068c9b | order-qaa-n | compra | WLD   | BUY  | 100010879 | 5           | BOB     |
            | 683cce15397feba125068c9b | order-qaa-n | compra | WLD   | BUY  | 100061435 | 5           | PYG     |

        @SellByCountry @USDT @Automated
        Examples:
            | companyId                | sessionId   | trade | asset | side | userAnyId | assetAmount | against |
            | 683cce15397feba125068c9b | order-qaa-n | venta | USDT  | SELL | 100008501 | 5           | ARS     |
            | 683cce15397feba125068c9b | order-qaa-n | venta | USDT  | SELL | 100008501 | 5           | USD     |
            | 683cce15397feba125068c9b | order-qaa-n | venta | USDT  | SELL | 100009020 | 5           | CLP     |
            | 683cce15397feba125068c9b | order-qaa-n | venta | USDT  | SELL | 100009042 | 5           | COP     |
            | 683cce15397feba125068c9b | order-qaa-n | venta | USDT  | SELL | 100008848 | 5           | BRL     |
            | 683cce15397feba125068c9b | order-qaa-n | venta | USDT  | SELL | 100009413 | 5           | GTQ     |
            | 683cce15397feba125068c9b | order-qaa-n | venta | USDT  | SELL | 100009603 | 5           | CRC     |
            | 683cce15397feba125068c9b | order-qaa-n | venta | USDT  | SELL | 100009508 | 5           | PUSD    |
            | 683cce15397feba125068c9b | order-qaa-n | venta | USDT  | SELL | 100009051 | 5           | MXN     |
            | 683cce15397feba125068c9b | order-qaa-n | venta | USDT  | SELL | 100009089 | 5           | PHP     |
            | 683cce15397feba125068c9b | order-qaa-n | venta | USDT  | SELL | 100061435 | 5           | PYG     |

        @SellByCountry @USDC
        Examples:
            | companyId                | sessionId   | trade | asset | side | userAnyId | assetAmount | against |
            | 683cce15397feba125068c9b | order-qaa-n | venta | USDC  | SELL | 100008501 | 5           | ARS     |
            | 683cce15397feba125068c9b | order-qaa-n | venta | USDC  | SELL | 100008501 | 5           | USD     |
            | 683cce15397feba125068c9b | order-qaa-n | venta | USDC  | SELL | 100009020 | 5           | CLP     |
            | 683cce15397feba125068c9b | order-qaa-n | venta | USDC  | SELL | 100009042 | 5           | COP     |
            | 683cce15397feba125068c9b | order-qaa-n | venta | USDC  | SELL | 100008848 | 5           | BRL     |
            | 683cce15397feba125068c9b | order-qaa-n | venta | USDC  | SELL | 100009413 | 5           | GTQ     |
            | 683cce15397feba125068c9b | order-qaa-n | venta | USDC  | SELL | 100009603 | 5           | CRC     |
            | 683cce15397feba125068c9b | order-qaa-n | venta | USDC  | SELL | 100009508 | 5           | PUSD    |
            | 683cce15397feba125068c9b | order-qaa-n | venta | USDC  | SELL | 100009051 | 5           | MXN     |
            | 683cce15397feba125068c9b | order-qaa-n | venta | USDC  | SELL | 100009089 | 5           | PHP     |
            | 683cce15397feba125068c9b | order-qaa-n | venta | USDC  | SELL | 100061435 | 5           | PYG     |

        @SellByCountry @WLD
        Examples:
            | companyId                | sessionId   | trade | asset | side | userAnyId | assetAmount | against |
            | 683cce15397feba125068c9b | order-qaa-n | venta | WLD   | SELL | 100008501 | 5           | ARS     |
            | 683cce15397feba125068c9b | order-qaa-n | venta | WLD   | SELL | 100008501 | 5           | USD     |
            | 683cce15397feba125068c9b | order-qaa-n | venta | WLD   | SELL | 100009020 | 5           | CLP     |
            | 683cce15397feba125068c9b | order-qaa-n | venta | WLD   | SELL | 100009042 | 5           | COP     |
            | 683cce15397feba125068c9b | order-qaa-n | venta | WLD   | SELL | 100008848 | 5           | BRL     |
            | 683cce15397feba125068c9b | order-qaa-n | venta | WLD   | SELL | 100009413 | 5           | GTQ     |
            | 683cce15397feba125068c9b | order-qaa-n | venta | WLD   | SELL | 100009603 | 5           | CRC     |
            | 683cce15397feba125068c9b | order-qaa-n | venta | WLD   | SELL | 100009508 | 5           | PUSD    |
            | 683cce15397feba125068c9b | order-qaa-n | venta | WLD   | SELL | 100009051 | 5           | MXN     |
            | 683cce15397feba125068c9b | order-qaa-n | venta | WLD   | SELL | 100009089 | 5           | PHP     |
            | 683cce15397feba125068c9b | order-qaa-n | venta | WLD   | SELL | 100061435 | 5           | PYG     |

    @Smoke @Aggregator @V2 @Regression
    Scenario Outline: Ejecutar ordenes de <trade> de <asset> contra <against> V2 con aggregator
        Given Get credentials for company "<companyId>"
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

        When Wait for the processing of the "orden" por 1 seconds
        And Execute the GET method on the endpoint "/v2/orders/{orderNumberId}"
        Then Obtain a response 200 y status "COMPLETED"
        And validate aggregator propierties

        @USDT @Automated
        Examples:
            | companyId                | sessionId   | trade  | asset | side | userAnyId | assetAmount | against |
            | 69d80588cdd32301bed406ab | order-qaa-n | compra | USDT  | BUY  | 100065187 | 5           | ARS     |
            | 69d80588cdd32301bed406ab | order-qaa-n | compra | USDT  | BUY  | 100065187 | 5           | USD     |
            | 69d80588cdd32301bed406ab | order-qaa-n | compra | USDT  | SELL | 100065187 | 5           | ARS     |
            | 69d80588cdd32301bed406ab | order-qaa-n | compra | USDT  | SELL | 100065187 | 5           | USD     |
            

        @USDC @Automated
        Examples:
            | companyId                | sessionId   | trade  | asset | side | userAnyId | assetAmount | against |
            | 69d80588cdd32301bed406ab | order-qaa-n | compra | USDC  | BUY  | 100065187 | 5           | ARS     |
            | 69d80588cdd32301bed406ab | order-qaa-n | compra | USDC  | BUY  | 100065187 | 5           | USD     |
            | 69d80588cdd32301bed406ab | order-qaa-n | compra | USDC  | SELL | 100065187 | 5           | ARS     |
            | 69d80588cdd32301bed406ab | order-qaa-n | compra | USDC  | SELL | 100065187 | 5           | USD     |

    @Smoke @V2 @Regression @Plus
    Scenario Outline: Ejecutar ordenes de <trade> de <asset> contra <against> V2 para user PLUS
        Given Get credentials for company "<companyId>"
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
        Then Obtain a response 200 y status "COMPLETED"

        @Sell @Automated
        Examples:
            | companyId                | sessionId   | trade  | asset | side | userAnyId | assetAmount | against |
            | 69aa390533ca661b9c97bf94 | order-qaa-n | compra | USDT  | BUY  | 100058862 | 5           | ARS     |
            | 69aa390533ca661b9c97bf94 | order-qaa-n | compra | USDC  | BUY  | 100058862 | 5           | ARS     |
            | 69aa390533ca661b9c97bf94 | order-qaa-n | compra | USDCB | BUY  | 100058862 | 5           | ARS     |
            | 69aa390533ca661b9c97bf94 | order-qaa-n | compra | WLD   | BUY  | 100058862 | 5           | ARS     |
            | 69aa390533ca661b9c97bf94 | order-qaa-n | compra | DAI   | BUY  | 100058862 | 5           | ARS     |
            | 69aa390533ca661b9c97bf94 | order-qaa-n | compra | ETH   | BUY  | 100058862 | 0.01        | ARS     |
            | 69aa390533ca661b9c97bf94 | order-qaa-n | compra | BTC   | BUY  | 100058862 | 0.01        | ARS     |
            | 69aa390533ca661b9c97bf94 | order-qaa-n | compra | BNB   | BUY  | 100058862 | 0.1         | ARS     |

        @Sell @Automated
        Examples:
            | companyId                | sessionId   | trade | asset | side | userAnyId | assetAmount | against |
            | 69aa390533ca661b9c97bf94 | order-qaa-n | venta | USDT  | SELL | 100058862 | 5           | ARS     |
            | 69aa390533ca661b9c97bf94 | order-qaa-n | venta | USDC  | SELL | 100058862 | 5           | ARS     |
            | 69aa390533ca661b9c97bf94 | order-qaa-n | venta | USDCB | SELL | 100058862 | 5           | ARS     |
            | 69aa390533ca661b9c97bf94 | order-qaa-n | venta | WLD   | SELL | 100058862 | 5           | ARS     |
            | 69aa390533ca661b9c97bf94 | order-qaa-n | venta | DAI   | SELL | 100058862 | 5           | ARS     |
            | 69aa390533ca661b9c97bf94 | order-qaa-n | venta | ETH   | SELL | 100058862 | 0.01        | ARS     |
            | 69aa390533ca661b9c97bf94 | order-qaa-n | venta | BTC   | SELL | 100058862 | 0.01        | ARS     |
            | 69aa390533ca661b9c97bf94 | order-qaa-n | venta | BNB   | SELL | 100058862 | 0.1         | ARS     |