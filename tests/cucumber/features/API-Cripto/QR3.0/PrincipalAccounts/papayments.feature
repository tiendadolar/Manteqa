@QR @Regression
Feature: Sintéticos de Pago Principal Accounts

    #***************** Funds: User Balance ********************

    @Smoke @PpalAccount @UserBalance @Automated
    Scenario Outline: Principal Account <country>: Ejecutar pago desde balance contra <against>
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        # Validate initial balance before execute qr payment
        And Obtain "<against>" balance for "<userAnyId>" user
        # Request de lock payment
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<paymentDestination>" to the variable "paymentDestination"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<exchange>" to the variable "exchange"
        And Assign the value "<legalId>" to the variable "legalId"
        And Assign the value "<name>" to the variable "name"
        And Assign the value "<surname>" to the variable "surname"
        And Execute the POST method on the endpoint "/v2/payment-locks"
        Then Obtain a response 201 for lock payment
        # Execute synthetic payment
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "true" to the variable "skipDeposit"
        And Assign the value "pixCode" to the variable "pixCode"
        And Execute the POST method on the endpoint "/v2/synthetics/qr-payment"
        Then Obtain a response 201
        And Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic
        # Validate balance after execute qr payment
        And Obtain "<against>" balance for "<userAnyId>" user


        Examples:
            | companyId                | country   | userAnyId | paymentDestination            | amount    | sessionId           | against | exchange  | legalId       | name    | surname |
            | 699a62cc6e3dd6fb25fa5e91 | Argentina | 100056098 | qr3manualamount               | 1000      | QR-UserBalance-V1-n | USDT    | BRAZIL    | 731.443.71149 | MIGUEL  | ACOSTA  |
            | 699a62cc6e3dd6fb25fa5e91 | Brasil    | 100056099 | +5511949227612                | 10        | QR-UserBalance-V1-n | USDT    | BRAZIL    | 731.443.71149 | MIGUEL  | ACOSTA  |
            | 699a62cc6e3dd6fb25fa5e91 | Colombia  | 100056101 | manteca-breb-qa-manual-amount | 500       | QR-UserBalance-V1-n | USDT    | BRAZIL    | 731.443.71149 | MIGUEL  | ACOSTA  |
            | 699a62cc6e3dd6fb25fa5e91 | Bolivia   | 100056102 | qr3BOBmanualamount            | 61.980000 | QR-UserBalance-V1-n | USDT    | BRAZIL    | 731.443.71149 | MIGUEL  | ACOSTA  |
            | 699a62cc6e3dd6fb25fa5e91 | Argentina | 100056098 | qr3manualamount               | 1000      | QR-UserBalance-V1-n | ARS     | ARGENTINA | 20167417435   | MARIO   | ABBADI  |
            | 699a62cc6e3dd6fb25fa5e91 | Brasil    | 100056099 | +5511949227612                | 10        | QR-UserBalance-V1-n | BRL     | BRAZIL    | 731.443.71149 | MIGUEL  | ACOSTA  |
            | 699a62cc6e3dd6fb25fa5e91 | Colombia  | 100056101 | manteca-breb-qa-manual-amount | 500       | QR-UserBalance-V1-n | COP     | COLOMBIA  | 1.977.392     | ROGER   | SANCHEZ |
            | 699a62cc6e3dd6fb25fa5e91 | Bolivia   | 100056102 | qr3BOBmanualamount            | 61.980000 | QR-UserBalance-V1-n | BOB     | BOLIVIA   | 4563732       | ABRAHAM | GARCIA  |


    @Smoke @PpalAccount @UserBalance @Automated
    Scenario Outline: Principal Account <country>: Ejecutar pago desde balance contra <against>
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        # Validate initial balance before execute qr payment
        And Obtain "<against>" balance for "<userAnyId>" user
        # Request de lock payment
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<paymentDestination>" to the variable "paymentDestination"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<against>" to the variable "against"
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
        # Execute synthetic payment
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "true" to the variable "skipDeposit"
        And Assign the value "pixCode" to the variable "pixCode"
        And Execute the POST method on the endpoint "/v2/synthetics/qr-payment"
        Then Obtain a response 201
        And Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic
        # Validate balance after execute qr payment
        And Obtain "<against>" balance for "<userAnyId>" user


        Examples:
            | companyId                | country | userAnyId | paymentDestination | amount | sessionId           | against | exchange | legalId       | name   | surname | work     | email              | phoneNumber  | gender | street         | birthDate  |
            | 699a62cc6e3dd6fb25fa5e91 | Peru    | 100056100 | +51986667537       | 1.5    | QR-UserBalance-V1-n | USDT    | BRAZIL   | 731.443.71149 | MIGUEL | ACOSTA  | EMPLEADO | polanque@gmail.com | +51953605263 | MALE   | Av. Corrientes | 1960-05-06 |
            | 699a62cc6e3dd6fb25fa5e91 | Peru    | 100056100 | +51986667537       | 1.5    | QR-UserBalance-V1-n | PEN     | PERU     | 74162704      | ALICIA | ALCARAZ | EMPLEADO | polanque@gmail.com | +51953605263 | MALE   | Av. Corrientes | 1960-05-06 |

    #***************** Funds: Deposito Cripto ********************

    @Smoke @PpalAccount @Deposit @Automated
    Scenario Outline: Principal Account <country>: Ejecutar pago mediante deposito cripto contra <against>
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        # Validate initial balance before execute qr payment
        And Obtain "<against>" balance for "<userAnyId>" user
        # Request de lock payment
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<paymentDestination>" to the variable "paymentDestination"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<exchange>" to the variable "exchange"
        And Assign the value "<legalId>" to the variable "legalId"
        And Assign the value "<name>" to the variable "name"
        And Assign the value "<surname>" to the variable "surname"
        And Execute the POST method on the endpoint "/v2/payment-locks"
        Then Obtain a response 201 for lock payment
        # Execute synthetic payment
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "pixCode" to the variable "pixCode"
        And Execute the POST method on the endpoint "/v2/synthetics/qr-payment"
        Then Obtain a response 201
        And The attributes of the QR "<against>" synthetic are validated
        # Execute deposit
        And Execute crypto deposit
        # Get status synthetic payment
        And Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic
        # Validate balance after execute qr payment
        And Obtain "<against>" balance for "<userAnyId>" user

        #QR BOB monto nuy bajo, falla contra USDT
        Examples:
            | companyId                | country   | userAnyId | paymentDestination            | amount | sessionId    | against | exchange | legalId       | name   | surname |
            | 69972e13e4c6077150f16ce8 | Argentina | 100055871 | qr3manualamount               | 1000   | QR-V2-DESC-n | USDT    | BRAZIL   | 731.443.71149 | MIGUEL | ACOSTA  |
            | 69972e13e4c6077150f16ce8 | Brasil    | 100055872 | +5511949227612                | 10     | QR-V2-DESC-n | USDT    | BRAZIL   | 731.443.71149 | MIGUEL | ACOSTA  |
            | 69972e13e4c6077150f16ce8 | Colombia  | 100055874 | manteca-breb-qa-manual-amount | 500    | QR-V2-DESC-n | USDT    | BRAZIL   | 731.443.71149 | MIGUEL | ACOSTA  |
            | 69972e13e4c6077150f16ce8 | Bolivia   | 100055875 | qr3BOBmanualamount            | 61.98  | QR-V2-DESC-n | USDT    | BRAZIL   | 731.443.71149 | MIGUEL | ACOSTA  |

    @Smoke @PpalAccount @Deposit @Automated
    Scenario Outline: Principal Account <country>: Ejecutar pago mediante deposito cripto contra <against>
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        # And The API secret is available "abc12345"
        # Validate initial balance before execute qr payment
        And Obtain "<against>" balance for "<userAnyId>" user
        # Request de lock payment
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<paymentDestination>" to the variable "paymentDestination"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<exchange>" to the variable "exchange"
        And Assign the value "<legalId>" to the variable "legalId"
        And Assign the value "<name>" to the variable "name"
        And Assign the value "<surname>" to the variable "surname"
        And Assign the value "<work>" to the variable "work"
        And Assign the value "<email>" to the variable "email"
        And Assign the value "<phoneNumber>" to the variable "phoneNumber"
        And Assign the value "<gender>" to the variable "gender"
        And Execute the POST method on the endpoint "/v2/payment-locks"
        Then Obtain a response 201 for lock payment
        # Execute synthetic payment
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "pixCode" to the variable "pixCode"
        And Execute the POST method on the endpoint "/v2/synthetics/qr-payment"
        Then Obtain a response 201
        And The attributes of the QR "<against>" synthetic are validated
        # Execute deposit
        And Execute crypto deposit
        # Get status synthetic payment
        And Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic
        # Validate balance after execute qr payment
        And Obtain "<against>" balance for "<userAnyId>" user

        #QR BOB monto nuy bajo, falla contra USDT
        Examples:
            | companyId                | country | userAnyId | paymentDestination | amount | sessionId    | against | exchange | legalId  | name   | surname | work     | email              | phoneNumber  | gender |
            | 69972e13e4c6077150f16ce8 | Peru    | 100055873 | +51986667537       | 1.5    | QR-V2-DESC-n | USDT    | PERU     | 74162704 | ALICIA | ALCARAZ | EMPLEADO | polanque@gmail.com | +51953605263 | MALE   |

    #***************** Funds: Descubierto ********************

    @Smoke @PpalAccount @Smoke @Desc @Sender @Peru @Foreigns @Automated
    Scenario Outline: Principal Account Peru: Ejecutar pago enviando sender extranjero descubierto
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        # Get company balance before execute qr payment
        When Obtain a company debt "<against>" balance
        # Request de lock payment
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
        # Execute synthetic payment
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "pixCode" to the variable "pixCode"
        And Execute the POST method on the endpoint "/v2/synthetics/qr-payment"
        Then Obtain a response 201
        # Get status synthetic payment
        And Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic
        And Validate sender info
        # Get company balance after execute qr payment
        And Obtain a company debt "<against>" balance

        Examples:
            | companyId                | pay     | exchange  | legalId       | name         | surname | work     | email                | phoneNumber    | gender | birthDate  | street               | userAnyId | paymentDestination                                                                                                                                                                                                                                                                                                     | against | amount | sessionId                      |
            | 6913d6f4db01142cde3fb7e0 | QR_PERU | ARGENTINA | 27-32244493-7 | PEDRO        | PEREZ   | EMPLEADO | peperez@gmail.com    | +5491153605263 | MALE   | 1960-05-06 | Av. Corrientes       | 100014302 | 00020101021102164096230055528616041553015000555286109166499890055528615123900111000000040610740923902707005552861826800011FACILITADOR0161IZIPAYVIR;1771899483420;5552861;989931923;348518349303003;;;252045999530360454030.05802PE5922IZI*FAST STORE PREMIUM6008TRUJILLO6103PER82270009FECHAVCTO01102036-02-2463048443 | USDT    | 1.5    | PixKey-Sender-manual-V2-DESC-n |
            | 6913d6f4db01142cde3fb7e0 | QR_PERU | BRAZIL    | 22373020149   | YAMIL        | SOUZA   | EMPLEADO | jsouza@gmail.com     | +5291153605263 | MALE   | 1960-05-06 | Av. Paulista         | 100014302 | 00020101021102164096230055528616041553015000555286109166499890055528615123900111000000040610740923902707005552861826800011FACILITADOR0161IZIPAYVIR;1771899483420;5552861;989931923;348518349303003;;;252045999530360454030.05802PE5922IZI*FAST STORE PREMIUM6008TRUJILLO6103PER82270009FECHAVCTO01102036-02-2463048443 | USDT    | 1.5    | PixKey-Sender-manual-V2-DESC-n |
            | 6913d6f4db01142cde3fb7e0 | QR_PERU | ANDORRA   | 22373020149   | SANTIAGO     | MARCO   | EMPLEADO | smarco@gmail.com     | +5291153605263 | MALE   | 1960-05-06 | Av. Andorra          | 100014302 | 00020101021102164096230055528616041553015000555286109166499890055528615123900111000000040610740923902707005552861826800011FACILITADOR0161IZIPAYVIR;1771899483420;5552861;989931923;348518349303003;;;252045999530360454030.05802PE5922IZI*FAST STORE PREMIUM6008TRUJILLO6103PER82270009FECHAVCTO01102036-02-2463048443 | USDT    | 1.5    | PixKey-Sender-manual-V2-DESC-n |
            | 6913d6f4db01142cde3fb7e0 | QR_PERU | MEXICO    | ROCS720312186 | JOSE SALOMON | ROMERO  | EMPLEADO | joseromero@gmail.com | +5291153605263 | MALE   | 1960-05-06 | Av. Distrito Federal | 100014302 | 00020101021102164096230055528616041553015000555286109166499890055528615123900111000000040610740923902707005552861826800011FACILITADOR0161IZIPAYVIR;1771899483420;5552861;989931923;348518349303003;;;252045999530360454030.05802PE5922IZI*FAST STORE PREMIUM6008TRUJILLO6103PER82270009FECHAVCTO01102036-02-2463048443 | USDT    | 1.5    | PixKey-Sender-manual-V2-DESC-n |
            | 6913d6f4db01142cde3fb7e0 | QR_PERU | CHILE     | 17720072-7    | MACARENA     | VAZQUEZ | EMPLEADO | vama@gmail.com       | +5291153605263 | MALE   | 1960-05-06 | Av. Santiago         | 100014302 | 00020101021102164096230055528616041553015000555286109166499890055528615123900111000000040610740923902707005552861826800011FACILITADOR0161IZIPAYVIR;1771899483420;5552861;989931923;348518349303003;;;252045999530360454030.05802PE5922IZI*FAST STORE PREMIUM6008TRUJILLO6103PER82270009FECHAVCTO01102036-02-2463048443 | USDT    | 1.5    | PixKey-Sender-manual-V2-DESC-n |

    @Smoke @PpalAccount @Automated
    Scenario Outline: Principal Account <country>: Ejecutar pago mediante descubierto <against>
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        # Validate initial balance before execute qr payment
        And Obtain a company debt "<against>" balance
        # Request de lock payment
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<paymentDestination>" to the variable "paymentDestination"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<exchange>" to the variable "exchange"
        And Assign the value "<legalId>" to the variable "legalId"
        And Assign the value "<name>" to the variable "name"
        And Assign the value "<surname>" to the variable "surname"
        And Execute the POST method on the endpoint "/v2/payment-locks"
        Then Obtain a response 201 for lock payment
        # Execute synthetic payment
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<externalId>" to the variable "externalId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "pixCode" to the variable "pixCode"
        And Execute the POST method on the endpoint "/v2/synthetics/qr-payment"
        Then Obtain a response 201
        And The attributes of the QR "<against>" synthetic are validated
        # Get status synthetic payment
        And Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic
        # Validate balance after execute qr payment
        And Obtain a company debt "<against>" balance

        #QR BOB monto nuy bajo, falla contra USDT
        Examples:
            | companyId                | country   | userAnyId | paymentDestination            | amount | sessionId                  | externalId                 | against | exchange | legalId       | name   | surname |
            | 6981ff2f4af353838a534bc4 | Argentina | 100038486 | qr3manualamount               | 1000   | s-payment-ppalaccount-desc | e-payment-ppalaccount-desc | USDT    | BRAZIL   | 731.443.71149 | MIGUEL | ACOSTA  |
            | 6981ff2f4af353838a534bc4 | Brasil    | 100038487 | +5511949227612                | 10     | s-payment-ppalaccount-desc | e-payment-ppalaccount-desc | USDT    | BRAZIL   | 731.443.71149 | MIGUEL | ACOSTA  |
            | 6981ff2f4af353838a534bc4 | Colombia  | 100038489 | manteca-breb-qa-manual-amount | 500    | s-payment-ppalaccount-desc | e-payment-ppalaccount-desc | USDT    | BRAZIL   | 731.443.71149 | MIGUEL | ACOSTA  |
            | 6981ff2f4af353838a534bc4 | Bolivia   | 100038490 | qr3BOBmanualamount            | 61.98  | s-payment-ppalaccount-desc | e-payment-ppalaccount-desc | USDT    | BRAZIL   | 731.443.71149 | MIGUEL | ACOSTA  |

    @Smoke @PpalAccount @Automated
    Scenario Outline: Principal Account Peru: Ejecutar pago con sender peruano mediante descubierto <against>
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        # Validate initial balance before execute qr payment
        And Obtain a company debt "<against>" balance
        # Request de lock payment
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<paymentDestination>" to the variable "paymentDestination"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<exchange>" to the variable "exchange"
        And Assign the value "<legalId>" to the variable "legalId"
        And Assign the value "<name>" to the variable "name"
        And Assign the value "<surname>" to the variable "surname"
        And Assign the value "<work>" to the variable "work"
        And Assign the value "<email>" to the variable "email"
        And Assign the value "<phoneNumber>" to the variable "phoneNumber"
        And Assign the value "<gender>" to the variable "gender"
        And Execute the POST method on the endpoint "/v2/payment-locks"
        Then Obtain a response 201 for lock payment
        # Execute synthetic payment
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<externalId>" to the variable "externalId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "pixCode" to the variable "pixCode"
        And Execute the POST method on the endpoint "/v2/synthetics/qr-payment"
        Then Obtain a response 201
        And The attributes of the QR "<against>" synthetic are validated
        # Get status synthetic payment
        And Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic
        # Validate balance after execute qr payment
        And Obtain a company debt "<against>" balance

        #QR BOB monto nuy bajo, falla contra USDT
        Examples:
            | companyId                | country   | userAnyId | paymentDestination | amount | sessionId                  | externalId                 | against | exchange | legalId  | name  | surname | work     | email              | phoneNumber  | gender |
            | 6981ff2f4af353838a534bc4 | Argentina | 100038488 | +51986667537       | 1000   | s-payment-ppalaccount-desc | e-payment-ppalaccount-desc | USDT    | PERU     | 74162704 | PEDRO | PEREZ   | EMPLEADO | polanque@gmail.com | +51953605263 | MALE   |
