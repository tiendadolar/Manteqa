@Integrations @LockPayment
Feature: Lock Payment Integrations

    Background:
        Given The urlBase is available "https://sandbox.manteca.dev/crypto"

    @HappyPath @PA
    Scenario Outline: Validate success lock payment response for <pay> from principal account exchange <accountExc>
        Given The API key is available "<apiKEY>"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<paymentDestination>" to the variable "paymentDestination"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<exchange>" to the variable "exchange"
        And Assign the value "<legalId>" to the variable "legalId"
        And Assign the value "<name>" to the variable "name"
        And Assign the value "<surname>" to the variable "surname"
        And Execute the POST method on the endpoint "/v2/payment-locks"
        Then Obtain a response 201 for lock payment
        And Validate lock payment response attributes

        @ARG
        Examples:
            | apiKEY                          | pay | exchange | legalId     | name          | surname  | userAnyId | paymentDestination | against | amount | accountExc |
            | SG0EPCX-9XW4G7Y-NQDMP1Q-52X6MB9 | PIX | BRAZIL   | 40842073817 | DARIO AUGUSTO | DA SILVA | 100014295 | pixmanualamount    |         | 10     | ARGENTINA  |
            | SG0EPCX-9XW4G7Y-NQDMP1Q-52X6MB9 | PIX | BRAZIL   | 40842073817 | DARIO AUGUSTO | DA SILVA | 100014295 | pixmanualamount    | BRL     | 10     | ARGENTINA  |
            | SG0EPCX-9XW4G7Y-NQDMP1Q-52X6MB9 | QR3 | BRAZIL   | 40842073817 | DARIO AUGUSTO | DA SILVA | 100014295 | qr3manualamount    | USDT    | 10     | ARGENTINA  |
            | SG0EPCX-9XW4G7Y-NQDMP1Q-52X6MB9 | QR3 | BRAZIL   | 40842073817 | DARIO AUGUSTO | DA SILVA | 100014295 | qr3manualamount    | USDC    | 10     | ARGENTINA  |
            | SG0EPCX-9XW4G7Y-NQDMP1Q-52X6MB9 | QR3 | BRAZIL   | 40842073817 | DARIO AUGUSTO | DA SILVA | 100014295 | qr3manualamount    | WLD     | 10     | ARGENTINA  |
            | SG0EPCX-9XW4G7Y-NQDMP1Q-52X6MB9 | QR3 | BRAZIL   | 40842073817 | DARIO AUGUSTO | DA SILVA | 100014295 | qr3manualamount    | ARS     | 10     | ARGENTINA  |

        @BRA
        Examples:
            | apiKEY                          | pay | exchange | legalId     | name          | surname  | userAnyId | paymentDestination                                                                                                                           | against | amount | accountExc |
            | SG0EPCX-9XW4G7Y-NQDMP1Q-52X6MB9 | PIX | BRAZIL   | 40842073817 | DARIO AUGUSTO | DA SILVA | 100014296 | pixmanualamount                                                                                                                              | USDT    | 10     | BRAZIL     |
            | SG0EPCX-9XW4G7Y-NQDMP1Q-52X6MB9 | PIX | BRAZIL   | 40842073817 | DARIO AUGUSTO | DA SILVA | 100014296 | pixmanualamount                                                                                                                              | BRL     | 10     | BRAZIL     |
            | SG0EPCX-9XW4G7Y-NQDMP1Q-52X6MB9 | QR  | BRAZIL   | 40842073817 | DARIO AUGUSTO | DA SILVA | 100014296 | 00020101021140200010com.yacare02022350150011336972350495204739953030325802AR5910HAVANNA SA6012BUENOS AIRES81220010com.yacare0204Y2156304E401 | USDT    | 1000   | BRAZIL     |
            | SG0EPCX-9XW4G7Y-NQDMP1Q-52X6MB9 | QR  | BRAZIL   | 40842073817 | DARIO AUGUSTO | DA SILVA | 100014296 | 00020101021140200010com.yacare02022350150011336972350495204739953030325802AR5910HAVANNA SA6012BUENOS AIRES81220010com.yacare0204Y2156304E401 | USDC    | 1000   | BRAZIL     |
            | SG0EPCX-9XW4G7Y-NQDMP1Q-52X6MB9 | QR  | BRAZIL   | 40842073817 | DARIO AUGUSTO | DA SILVA | 100014296 | 00020101021140200010com.yacare02022350150011336972350495204739953030325802AR5910HAVANNA SA6012BUENOS AIRES81220010com.yacare0204Y2156304E401 | WLD     | 1000   | BRAZIL     |
            | SG0EPCX-9XW4G7Y-NQDMP1Q-52X6MB9 | QR  | BRAZIL   | 40842073817 | DARIO AUGUSTO | DA SILVA | 100014296 | 00020101021140200010com.yacare02022350150011336972350495204739953030325802AR5910HAVANNA SA6012BUENOS AIRES81220010com.yacare0204Y2156304E401 | ARS     | 1000   | BRAZIL     |

        @PER
        Examples:
            | apiKEY                          | pay | exchange  | legalId     | name          | surname  | userAnyId | paymentDestination                                                                                                                           | against | amount | accountExc |
            | SG0EPCX-9XW4G7Y-NQDMP1Q-52X6MB9 | PIX | ARGENTINA | 27414298732 | BETO LUIS     | SOLARI   | 100014302 | pixmanualamount                                                                                                                              | USDT    | 10     | PERU       |
            | SG0EPCX-9XW4G7Y-NQDMP1Q-52X6MB9 | QR  | BRAZIL    | 40842073817 | DARIO AUGUSTO | DA SILVA | 100014302 | 00020101021140200010com.yacare02022350150011336972350495204739953030325802AR5910HAVANNA SA6012BUENOS AIRES81220010com.yacare0204Y2156304E401 | USDT    | 1000   | PERU       |

    @HappyPath @UA
    Scenario Outline: Validate success lock payment response for <pay> from user account
        Given The API key is available "<apiKEY>"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<paymentDestination>" to the variable "paymentDestination"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<amount>" to the variable "amount"
        And Execute the POST method on the endpoint "/v2/payment-locks"
        Then Obtain a response 201 for lock payment
        And Validate lock payment response attributes

        @ARG
        Examples:
            | apiKEY                          | pay | userAnyId | paymentDestination | against | amount |
            | SG0EPCX-9XW4G7Y-NQDMP1Q-52X6MB9 | PIX | 100014295 | pixmanualamount    |         | 10     |
            | SG0EPCX-9XW4G7Y-NQDMP1Q-52X6MB9 | PIX | 100014295 | pixmanualamount    | BRL     | 10     |
            | SG0EPCX-9XW4G7Y-NQDMP1Q-52X6MB9 | QR3 | 100014295 | qr3manualamount    | USDT    | 10     |
            | SG0EPCX-9XW4G7Y-NQDMP1Q-52X6MB9 | QR3 | 100014295 | qr3manualamount    | USDC    | 10     |
            | SG0EPCX-9XW4G7Y-NQDMP1Q-52X6MB9 | QR3 | 100014295 | qr3manualamount    | WLD     | 10     |
            | SG0EPCX-9XW4G7Y-NQDMP1Q-52X6MB9 | QR3 | 100014295 | qr3manualamount    | ARS     | 10     |

        @BRA
        Examples:
            | apiKEY                          | pay | userAnyId | paymentDestination                                                                                                                           | against | amount |
            | SG0EPCX-9XW4G7Y-NQDMP1Q-52X6MB9 | PIX | 100014296 | pixmanualamount                                                                                                                              | USDT    | 10     |
            | SG0EPCX-9XW4G7Y-NQDMP1Q-52X6MB9 | PIX | 100014296 | pixmanualamount                                                                                                                              | BRL     | 10     |
            | SG0EPCX-9XW4G7Y-NQDMP1Q-52X6MB9 | QR  | 100014296 | 00020101021140200010com.yacare02022350150011336972350495204739953030325802AR5910HAVANNA SA6012BUENOS AIRES81220010com.yacare0204Y2156304E401 | USDT    | 1000   |
            | SG0EPCX-9XW4G7Y-NQDMP1Q-52X6MB9 | QR  | 100014296 | 00020101021140200010com.yacare02022350150011336972350495204739953030325802AR5910HAVANNA SA6012BUENOS AIRES81220010com.yacare0204Y2156304E401 | USDC    | 1000   |
            | SG0EPCX-9XW4G7Y-NQDMP1Q-52X6MB9 | QR  | 100014296 | 00020101021140200010com.yacare02022350150011336972350495204739953030325802AR5910HAVANNA SA6012BUENOS AIRES81220010com.yacare0204Y2156304E401 | WLD     | 1000   |
            | SG0EPCX-9XW4G7Y-NQDMP1Q-52X6MB9 | QR  | 100014296 | 00020101021140200010com.yacare02022350150011336972350495204739953030325802AR5910HAVANNA SA6012BUENOS AIRES81220010com.yacare0204Y2156304E401 | ARS     | 1000   |

        @PER
        Examples:
            | apiKEY                          | pay | userAnyId | paymentDestination                                                                                                                           | against | amount |
            | SG0EPCX-9XW4G7Y-NQDMP1Q-52X6MB9 | PIX | 100014302 | pixmanualamount                                                                                                                              | USDT    | 10     |
            | SG0EPCX-9XW4G7Y-NQDMP1Q-52X6MB9 | QR  | 100014302 | 00020101021140200010com.yacare02022350150011336972350495204739953030325802AR5910HAVANNA SA6012BUENOS AIRES81220010com.yacare0204Y2156304E401 | USDT    | 1000   |


    # ------------------------------- Error Path -------------------------------

    @ErrorPath
    Scenario Outline: Validate error lock payment response sending empty <case>
        Given The API key is available "<apiKEY>"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<paymentDestination>" to the variable "paymentDestination"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<amount>" to the variable "amount"
        And Execute the POST method on the endpoint "/v2/payment-locks"
        Then Obtain a response <statusCode>
        And Validate response attributes with internalStatus: "<internalStatus>" and message: "<message>" and error: "<errors>"

        Examples:
            | case               | apiKEY                          | pay | userAnyId | paymentDestination | against | amount | statusCode | internalStatus | message        | errors                         |
            | paymentDestination | SG0EPCX-9XW4G7Y-NQDMP1Q-52X6MB9 | PIX | 100014296 |                    | USDT    | 10     | 400        | BAD_REQUEST    | Bad request.   | paymentDestination is missing. |
            | userAnyId          | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 | PIX |           | qr3manualamount    | USDT    | 10     | 404        | USER_NF        | User not found |                                |


    @ErrorPath
    Scenario Outline: Validate error lock payment with sender response sending invalid <case>
        Given The API key is available "<apiKEY>"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<paymentDestination>" to the variable "paymentDestination"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<exchange>" to the variable "exchange"
        And Assign the value "<legalId>" to the variable "legalId"
        And Assign the value "<name>" to the variable "name"
        And Assign the value "<surname>" to the variable "surname"
        And Execute the POST method on the endpoint "/v2/payment-locks"
        Then Obtain a response <statusCode>
        And Validate response attributes with internalStatus: "<internalStatus>" and message: "<message>" and error: "<errors>"

        Examples:
            | case     | apiKEY                          | pay | exchange | legalId     | name          | surname  | userAnyId | paymentDestination | against | amount | accountExc | statusCode | internalStatus | message      | errors                                                                                                                                                                                                                                                                                                                |
            | exchange | SG0EPCX-9XW4G7Y-NQDMP1Q-52X6MB9 | PIX | INVALID  | 40842073817 | DARIO AUGUSTO | DA SILVA | 100014295 | qr3manualamount    | USDT    | 10     | ARGENTINA  | 400        | BAD_REQUEST    | Bad request. | sender.exchange has wrong value INVALID. Possible values are ARGENTINA,CHILE,COLOMBIA,BRAZIL,GUATEMALA,COSTA_RICA,PANAMA,MEXICO,PHILIPPINES,BOLIVIA,PERU,PARAGUAY,SPAIN,ITALY,GLOBAL,AFGHANISTAN,ALAND_ISLANDS,ALBANIA,ALGERIA,AMERICAN_SAMOA,ANDORRA,ANGOLA,ANGUILLA,ANTARCTICA,ANTIGUA_AND_BARBUDA,...and 221 more. |
            | legalId  | SG0EPCX-9XW4G7Y-NQDMP1Q-52X6MB9 | PIX | BRAZIL   |             | DARIO AUGUSTO | DA SILVA | 100014295 | qr3manualamount    | USDT    | 10     | ARGENTINA  | 400        | BAD_REQUEST    | Bad request. | sender.legalId has wrong value . Value should be a generic legal id defined as some combination of letters, numbers, dashes and dots like 1234.5678-a.                                                                                                                                                                |
            | name     | SG0EPCX-9XW4G7Y-NQDMP1Q-52X6MB9 | PIX | BRAZIL   | 40842073817 |               | DA SILVA | 100014295 | qr3manualamount    | USDT    | 10     | ARGENTINA  | 400        | BAD_REQUEST    | Bad request. | sender.name is missing.                                                                                                                                                                                                                                                                                               |
            | surname  | SG0EPCX-9XW4G7Y-NQDMP1Q-52X6MB9 | PIX | BRAZIL   | 40842073817 | DARIO AUGUSTO |          | 100014295 | qr3manualamount    | USDT    | 10     | ARGENTINA  | 400        | BAD_REQUEST    | Bad request. | sender.surname is missing.                                                                                                                                                                                                                                                                                            |

    @ErrorPath
    Scenario Outline: Validate error lock payment response sending invalid enviroment
        Given The urlBase is available "https://api.manteca.dev/crypto"
        And The API key is available "<apiKEY>"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<paymentDestination>" to the variable "paymentDestination"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<amount>" to the variable "amount"
        And Execute the POST method on the endpoint "/v2/payment-locks"
        Then Obtain a response <statusCode>
        And Validate response attributes with internalStatus: "<internalStatus>" and message: "<message>" and error: "<errors>"

        Examples:
            | apiKEY                          | pay | userAnyId | paymentDestination | against | amount | statusCode | internalStatus | message                                                                                                 | errors |
            | SG0EPCX-9XW4G7Y-NQDMP1Q-52X6MB9 | PIX | 100014296 |                    | USDT    | 10     | 403        | FORBIDDEN      | You do not have enough permissions to access the resource with the provided authentication credentials. |        |