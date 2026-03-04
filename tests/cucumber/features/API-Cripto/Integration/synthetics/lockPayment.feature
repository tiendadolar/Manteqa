@Integrations @LockPayment @Regression
Feature: Lock Payment Integrations

    Background:
        Given The urlBase is available "https://sandbox.manteca.dev/crypto"

    @HappyPath @PA @Automated
    Scenario Outline: Validate success lock payment response for <pay> from principal account exchange <accountExc>
        Given Get credentials for company "<companyId>"
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
            | companyId                | pay | exchange | legalId     | name          | surname  | userAnyId | paymentDestination | against | amount | accountExc |
            | 6913d6f4db01142cde3fb7e0 | PIX | BRAZIL   | 40842073817 | DARIO AUGUSTO | DA SILVA | 100014296 | pixmanualamount    |         | 10     | ARGENTINA  |
            | 6913d6f4db01142cde3fb7e0 | PIX | BRAZIL   | 40842073817 | DARIO AUGUSTO | DA SILVA | 100014296 | pixmanualamount    | BRL     | 10     | ARGENTINA  |
            | 6913d6f4db01142cde3fb7e0 | QR3 | BRAZIL   | 40842073817 | DARIO AUGUSTO | DA SILVA | 100014295 | qr3manualamount    | USDT    | 10     | ARGENTINA  |
            | 6913d6f4db01142cde3fb7e0 | QR3 | BRAZIL   | 40842073817 | DARIO AUGUSTO | DA SILVA | 100014295 | qr3manualamount    | USDC    | 10     | ARGENTINA  |
            | 6913d6f4db01142cde3fb7e0 | QR3 | BRAZIL   | 40842073817 | DARIO AUGUSTO | DA SILVA | 100014295 | qr3manualamount    | WLD     | 10     | ARGENTINA  |

        @BRA
        Examples:
            | companyId                | pay | exchange | legalId     | name          | surname  | userAnyId | paymentDestination | against | amount | accountExc |
            | 6913d6f4db01142cde3fb7e0 | PIX | BRAZIL   | 40842073817 | DARIO AUGUSTO | DA SILVA | 100014296 | pixmanualamount    | USDT    | 10     | BRAZIL     |
            | 6913d6f4db01142cde3fb7e0 | PIX | BRAZIL   | 40842073817 | DARIO AUGUSTO | DA SILVA | 100014296 | pixmanualamount    | BRL     | 10     | BRAZIL     |


    @HappyPath @PA @Automated
    Scenario Outline: Validate success lock payment response for <pay> from principal account exchange <accountExc>
        Given Get credentials for company "<companyId>"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<paymentDestination>" to the variable "paymentDestination"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<exchange>" to the variable "exchange"
        And Assign the value "<legalId>" to the variable "legalId"
        And Assign the value "<name>" to the variable "name"
        And Assign the value "<surname>" to the variable "surname"
        And Assign the value "<work>" to the variable "work"
        And Assign the value "<email>" to the variable "email"
        And Assign the value "<phoneNumber>" to the variable "phoneNumber"
        And Assign the value "<gender>" to the variable "gender"
        And Assign the value "<birthDate>" to the variable "birthDate"
        And Assign the value "<street>" to the variable "street"
        And Execute the POST method on the endpoint "/v2/payment-locks"
        Then Obtain a response 201 for lock payment
        And Validate lock payment response attributes

        @PER
        Examples:
            | companyId                | pay  | exchange  | legalId     | name          | surname  | work     | email          | phoneNumber  | gender | birthDate  | street        | userAnyId | paymentDestination                                                                                                                                                                                                                                                                                                     | against | amount | accountExc |
            | 6913d6f4db01142cde3fb7e0 | PERU | ARGENTINA | 27414298732 | BETO LUIS     | SOLARI   | EMPLEADO | test@gmail.com | +51953605263 | MALE   | 1993-07-23 | Av.Corrientes | 100014302 | 00020101021102164096230055528616041553015000555286109166499890055528615123900111000000040610740923902707005552861826800011FACILITADOR0161IZIPAYVIR;1771899483420;5552861;989931923;348518349303003;;;252045999530360454030.05802PE5922IZI*FAST STORE PREMIUM6008TRUJILLO6103PER82270009FECHAVCTO01102036-02-2463048443 | USDT    | 10     | PERU       |
            | 6913d6f4db01142cde3fb7e0 | PERU | BRAZIL    | 40842073817 | DARIO AUGUSTO | DA SILVA | EMPLEADO | test@gmail.com | +51953605263 | MALE   | 1993-07-23 | Av.Corrientes | 100014302 | 00020101021102164096230055528616041553015000555286109166499890055528615123900111000000040610740923902707005552861826800011FACILITADOR0161IZIPAYVIR;1771899483420;5552861;989931923;348518349303003;;;252045999530360454030.05802PE5922IZI*FAST STORE PREMIUM6008TRUJILLO6103PER82270009FECHAVCTO01102036-02-2463048443 | USDT    | 1000   | PERU       |


    @HappyPath @UA @Automated
    Scenario Outline: Validate success lock payment response for <pay> from user account
        Given Get credentials for company "<companyId>"
        And login user admin "<credential>"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<paymentDestination>" to the variable "paymentDestination"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<principalAccount>" to the variable "principalAccount"
        And Execute the POST method on the endpoint "/v2/payment-locks"
        Then Obtain a response 201 for lock payment
        And Validate lock payment routing response attributes

        @ARG
        Examples:
            | credential                | companyId                | pay | userAnyId | paymentDestination | against | amount | principalAccount |
            | andresperalta@manteca.dev | 6961c8e3be02a1dde6bcffcb | QR3 | 100038167 | qr3manualamount    | USDT    | 10     | 100037733        |
            | andresperalta@manteca.dev | 6961c8e3be02a1dde6bcffcb | QR3 | 100038167 | qr3manualamount    | USDC    | 10     | 100037733        |
            | andresperalta@manteca.dev | 6961c8e3be02a1dde6bcffcb | QR3 | 100038167 | qr3manualamount    | WLD     | 10     | 100037733        |

        @BRA
        Examples:
            | credential                | companyId                | pay | userAnyId | paymentDestination | against | amount | principalAccount |
            | andresperalta@manteca.dev | 6961c8e3be02a1dde6bcffcb | QR3 | 100038167 | pixmanualamount    | USDT    | 10     | 100037715        |


        @PER
        Examples:
            | credential                | companyId                | pay | userAnyId | paymentDestination | against | amount | principalAccount |
            | andresperalta@manteca.dev | 6961c8e3be02a1dde6bcffcb | QR3 | 100038167 | +51986667537       | USDT    | 10     | 100037706        |


    # ------------------------------- Error Path -------------------------------

    @ErrorPath @Automated
    Scenario Outline: Validate error lock payment response sending empty <case>
        Given Get credentials for company "<companyId>"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<paymentDestination>" to the variable "paymentDestination"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<amount>" to the variable "amount"
        And Execute the POST method on the endpoint "/v2/payment-locks"
        Then Obtain a response <statusCode>
        And Validate response attributes with internalStatus: "<internalStatus>" and message: "<message>" and error: "<errors>"

        Examples:
            | case               | companyId                | pay | userAnyId | paymentDestination | against | amount | statusCode | internalStatus | message        | errors                         |
            | paymentDestination | 6913d6f4db01142cde3fb7e0 | PIX | 100014296 |                    | USDT    | 10     | 400        | BAD_REQUEST    | Bad request.   | paymentDestination is missing. |
            | userAnyId          | 684b2f25dcca16d5557fd8b2 | PIX |           | qr3manualamount    | USDT    | 10     | 404        | USER_NF        | User not found |                                |


    @ErrorPath @Automated
    Scenario Outline: Validate error lock payment with sender response sending invalid <case>
        Given Get credentials for company "<companyId>"
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
            | case        | companyId                | pay | exchange | legalId     | name          | surname  | userAnyId | paymentDestination | against | amount | accountExc | statusCode | internalStatus    | message            | errors                                                                                                                                                                                                                                                                                                                |
            | exchange    | 6913d6f4db01142cde3fb7e0 | PIX | INVALID  | 40842073817 | DARIO AUGUSTO | DA SILVA | 100014295 | qr3manualamount    | USDT    | 10     | ARGENTINA  | 400        | BAD_REQUEST       | Bad request.       | sender.exchange has wrong value INVALID. Possible values are ARGENTINA,CHILE,COLOMBIA,BRAZIL,GUATEMALA,COSTA_RICA,PANAMA,MEXICO,PHILIPPINES,BOLIVIA,PERU,PARAGUAY,SPAIN,ITALY,GLOBAL,AFGHANISTAN,ALAND_ISLANDS,ALBANIA,ALGERIA,AMERICAN_SAMOA,ANDORRA,ANGOLA,ANGUILLA,ANTARCTICA,ANTIGUA_AND_BARBUDA,...and 221 more. |
            | legalId     | 6913d6f4db01142cde3fb7e0 | PIX | BRAZIL   |             | DARIO AUGUSTO | DA SILVA | 100014295 | qr3manualamount    | USDT    | 10     | ARGENTINA  | 400        | BAD_REQUEST       | Bad request.       | sender.legalId has wrong value . Value should be a generic legal id defined as some combination of letters, numbers, dashes and dots like 1234.5678-a.                                                                                                                                                                |
            | name        | 6913d6f4db01142cde3fb7e0 | PIX | BRAZIL   | 40842073817 |               | DA SILVA | 100014295 | qr3manualamount    | USDT    | 10     | ARGENTINA  | 400        | BAD_REQUEST       | Bad request.       | sender.name is missing.                                                                                                                                                                                                                                                                                               |
            | surname     | 6913d6f4db01142cde3fb7e0 | PIX | BRAZIL   | 40842073817 | DARIO AUGUSTO |          | 100014295 | qr3manualamount    | USDT    | 10     | ARGENTINA  | 400        | BAD_REQUEST       | Bad request.       | sender.surname is missing.                                                                                                                                                                                                                                                                                            |
            | user status | 683cce15397feba125068c9b | PIX | BRAZIL   | 40842073817 | DARIO AUGUSTO | DA SILVA | 100036843 | qr3manualamount    | USDT    | 10     | ARGENTINA  | 400        | DNI_NOT_VALIDATED | DNI not validated. |                                                                                                                                                                                                                                                                                                                       |

    @ErrorPath @Automated
    Scenario Outline: Validate error lock payment response sending invalid enviroment
        Given The urlBase is available "https://api.manteca.dev/crypto"
        And Get credentials for company "<companyId>"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<paymentDestination>" to the variable "paymentDestination"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<amount>" to the variable "amount"
        And Execute the POST method on the endpoint "/v2/payment-locks"
        Then Obtain a response <statusCode>
        And Validate response attributes with internalStatus: "<internalStatus>" and message: "<message>" and error: "<errors>"

        Examples:
            | companyId                | pay | userAnyId | paymentDestination | against | amount | statusCode | internalStatus | message                                                                                                 | errors |
            | 6913d6f4db01142cde3fb7e0 | PIX | 100014296 |                    | USDT    | 10     | 403        | FORBIDDEN      | You do not have enough permissions to access the resource with the provided authentication credentials. |        |