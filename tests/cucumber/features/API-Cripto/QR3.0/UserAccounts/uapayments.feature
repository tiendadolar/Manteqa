@QR @Regression
Feature: Sintéticos de Pago User Accounts

    #***************** Funds: User Balance ********************

    @Smoke @UserAccount @UserBalance @Automated
    Scenario Outline: User Account <country>: Ejecutar pago desde balance contra <against>
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        # Validate initial balance before execute qr payment
        And Obtain "<against>" balance for "<userAnyId>" user
        # Request de lock payment
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<paymentDestination>" to the variable "paymentDestination"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<against>" to the variable "against"
        And Execute the POST method on the endpoint "/v2/payment-locks"
        Then Obtain a response 201 for lock payment
        # Execute synthetic payment
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<externalId>" to the variable "externalId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "true" to the variable "skipDeposit"
        And Assign the value "pixCode" to the variable "pixCode"
        And Execute the POST method on the endpoint "/v2/synthetics/qr-payment"
        Then Obtain a response 201
        And Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic
        # Validate balance after execute qr payment
        And Obtain "<against>" balance for "<userAnyId>" user


        Examples:
            | companyId                | country   | userAnyId | paymentDestination            | amount | sessionId           | externalId             | against |
            | 699a62cc6e3dd6fb25fa5e91 | Argentina | 100056107 | qr3manualamount               | 1000   | QR-UserBalance-V1-n | uap-userbalance-test-n | USDT    |
            | 699a62cc6e3dd6fb25fa5e91 | Brasil    | 100056104 | +5511949227612                | 10     | QR-UserBalance-V1-n | uap-userbalance-test-n | USDT    |
            | 699a62cc6e3dd6fb25fa5e91 | Colombia  | 100056111 | manteca-breb-qa-manual-amount | 500    | QR-UserBalance-V1-n | uap-userbalance-test-n | USDT    |
            | 699a62cc6e3dd6fb25fa5e91 | Bolivia   | 100056108 | qr3BOBmanualamount            | 61.98  | QR-UserBalance-V1-n | uap-userbalance-test-n | USDT    |
            # | 699a62cc6e3dd6fb25fa5e91 | Peru      | 100056105 | +51986667537       | 1.5    | QR-UserBalance-V1-n | USDT    |uap-userbalance-test-n
            | 699a62cc6e3dd6fb25fa5e91 | Argentina | 100056107 | qr3manualamount               | 1000   | QR-UserBalance-V1-n | uap-userbalance-test-n | ARS     |
            | 699a62cc6e3dd6fb25fa5e91 | Brasil    | 100056104 | +5511949227612                | 10     | QR-UserBalance-V1-n | uap-userbalance-test-n | BRL     |
            | 699a62cc6e3dd6fb25fa5e91 | Colombia  | 100056111 | manteca-breb-qa-manual-amount | 500    | QR-UserBalance-V1-n | uap-userbalance-test-n | COP     |
            | 699a62cc6e3dd6fb25fa5e91 | Bolivia   | 100056108 | qr3BOBmanualamount            | 61.98  | QR-UserBalance-V1-n | uap-userbalance-test-n | BOB     |
            | 699a62cc6e3dd6fb25fa5e91 | Peru      | 100056105 | +51986667537                  | 1.5    | QR-UserBalance-V1-n | uap-userbalance-test-n | PEN     |

    #***************** Funds: Deposito Cripto ********************

    @Smoke @UserAccount @Deposit @Automated
    Scenario Outline: User Account <country>: Ejecutar pago mediante deposito cripto contra <against>
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        # Validate initial balance before execute qr payment
        And Obtain "<against>" balance for "<userAnyId>" user
        # Request de lock payment
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<paymentDestination>" to the variable "paymentDestination"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<against>" to the variable "against"
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
            | companyId                | country   | userAnyId | paymentDestination            | amount | sessionId    | against |
            | 69972e13e4c6077150f16ce8 | Argentina | 100056114 | qr3manualamount               | 1000   | QR-V2-DESC-n | USDT    |
            | 69972e13e4c6077150f16ce8 | Brasil    | 100056115 | +5511949227612                | 10     | QR-V2-DESC-n | USDT    |
            | 69972e13e4c6077150f16ce8 | Bolivia   | 100056117 | qr3BOBmanualamount            | 61.98  | QR-V2-DESC-n | USDT    |
            | 69972e13e4c6077150f16ce8 | Colombia  | 100056118 | manteca-breb-qa-manual-amount | 500    | QR-V2-DESC-n | USDT    |
    # | 69972e13e4c6077150f16ce8 | Peru      | 100056116 | +51986667537                  | 1.5    | QR-V2-DESC-n | USDT    |

    #***************** Funds: Descubierto ********************

    @Smoke @UserAccount @Automated
    Scenario Outline: User Account <country>: Ejecutar pago mediante descubierto <against>
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        # Validate initial balance before execute qr payment
        And Obtain a company debt "<against>" balance
        # Request de lock payment
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<paymentDestination>" to the variable "paymentDestination"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<against>" to the variable "against"
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

        Examples:
            | companyId                | country   | userAnyId | paymentDestination            | amount | sessionId                  | externalId                 | against |
            | 696d44e622cceda591c025cd | Argentina | 100037880 | qr3manualamount               | 1000   | s-ayment-useraccount-desc  | e-payment-useraccount-desc | USDT    |
            | 696d44e622cceda591c025cd | Brasil    | 100037879 | +5511949227612                | 10     | s-payment-useraccount-desc | e-payment-useraccount-desc | USDT    |
            | 696d44e622cceda591c025cd | Bolivia   | 100037877 | qr3BOBmanualamount            | 61.98  | s-payment-useraccount-desc | e-payment-useraccount-desc | USDT    |
            | 696d44e622cceda591c025cd | Colombia  | 100037935 | manteca-breb-qa-manual-amount | 500    | s-payment-useraccount-desc | e-payment-useraccount-desc | USDT    |
    # | 696d44e622cceda591c025cd | Peru      | 100037878 | +51986667537                  | 1.5    | QR-V2-DESC-n | USDT    |

    @Smoke @UserAccount @ErrorPath @Automated
    Scenario Outline: User Account <country>: Validate error response sending externalId repeated
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        # Validate initial balance before execute qr payment
        And Obtain "<against>" balance for "<userAnyId>" user
        # Request de lock payment
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<paymentDestination>" to the variable "paymentDestination"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<against>" to the variable "against"
        And Execute the POST method on the endpoint "/v2/payment-locks"
        Then Obtain a response 201 for lock payment
        # Execute synthetic payment
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<externalId>" to the variable "externalId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "pixCode" to the variable "pixCode"
        And Execute the POST method on the endpoint "/v2/synthetics/qr-payment"
        Then Obtain a response <statusCode>
        And Validate response attributes with internalStatus: "<internalStatus>" and message: "<message>"

        Examples:
            | companyId                | country   | userAnyId | paymentDestination | amount | sessionId    | externalId       | against | statusCode | internalStatus   | message                                  |
            | 69972e13e4c6077150f16ce8 | Argentina | 100056114 | qr3manualamount    | 1000   | QR-V2-DESC-n | externalIdRepeat | USDT    | 409        | SYNTHETIC_EXISTS | Synthetic with given ids already exists. |

