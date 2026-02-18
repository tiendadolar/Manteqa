@Billing @Regression
Feature: Sintético billing payments

    # ------ DESCUBIERTOS -------

    @Descubierto @PA @ARG @Automated
    Scenario Outline: Ejecutar sintético billing en descubierto operando contra <against> desde principal account ARG enviando sender <exchange>
        Given The API key is available "<apiKEY>"
        And The API secret is available "1RpvdT7Vc7ukKeGKdU"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        And Get billId from billing provider
        And Obtain "<against>" debt balance "company"
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "billId" to the variable "billId"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<exchange>" to the variable "exchange"
        And Assign the value "<legalId>" to the variable "legalId"
        And Assign the value "<name>" to the variable "name"
        And Execute the POST method on the endpoint "/v2/bill-locks"
        Then Obtain a response 201 for bill payment overdraw
        When Assign the value "<externalId>" to the variable "externalId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "pixCode" to the variable "billCode"
        And Execute the POST method on the endpoint "/v2/synthetics/bill-payment"
        Then Obtain a response 201
        And Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic
        And Obtain "<against>" debt balance "company"

        Examples:
            | apiKEY                          | externalId     | userAnyId | against | amount | exchange  | legalId       | name                          |
            | BG16CDQ-H9B4WK5-PQQN0W1-8HCD1QK | billing-test-n | 100036128 | USDT    | 1000   | ARGENTINA | 27-16749876-6 | MIGUEL GRANADOS               |
            | BG16CDQ-H9B4WK5-PQQN0W1-8HCD1QK | billing-test-n | 100036128 | USDT    | 2000   | CHILE     | 17710453-1    | ESTEFANIA ESPINOZA            |
            | BG16CDQ-H9B4WK5-PQQN0W1-8HCD1QK | billing-test-n | 100036128 | USDT    | 3000   | MEXICO    | CAOD421009K78 | DIONICIO CARRILLO OLVERA      |
            | BG16CDQ-H9B4WK5-PQQN0W1-8HCD1QK | billing-test-n | 100036128 | USDT    | 80000  | PERU      | 28316206      | CURI QUISPE WILDHER CHRISTIAN |
            | BG16CDQ-H9B4WK5-PQQN0W1-8HCD1QK | billing-test-n | 100036128 | USDC    | 1000   | ARGENTINA | 27-16749876-6 | MIGUEL GRANADOS               |

        @Smoke
        Examples:
            | apiKEY                          | externalId     | userAnyId | against | amount | exchange  | legalId       | name            |
            | BG16CDQ-H9B4WK5-PQQN0W1-8HCD1QK | billing-test-n | 100036128 | USDT    | 1000   | ARGENTINA | 27-16749876-6 | MIGUEL GRANADOS |

    @Balance @PA @ARG @Automated
    Scenario Outline: Ejecutar sintético billing sobre user balance operando contra <against> desde principal account ARG enviando sender <exchange>
        Given The API key is available "<apiKEY>"
        And The API secret is available "1RpvdT7Vc7ukKeGKdU"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        And Get billId from billing provider
        And Get "<against>" balance for "<userAnyId>"
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "billId" to the variable "billId"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<exchange>" to the variable "exchange"
        And Assign the value "<legalId>" to the variable "legalId"
        And Assign the value "<name>" to the variable "name"
        And Execute the POST method on the endpoint "/v2/bill-locks"
        Then Obtain a response 201 for bill payment overdraw
        When Assign the value "<externalId>" to the variable "externalId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "true" to the variable "skipDeposit"
        And Assign the value "pixCode" to the variable "billCode"
        And Execute the POST method on the endpoint "/v2/synthetics/bill-payment"
        Then Obtain a response 201
        And Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic
        And Get "<against>" balance for "<userAnyId>"
        And Validate "user" balance due

        @Smoke
        Examples:
            | apiKEY                          | externalId     | userAnyId | against | amount | exchange  | legalId       | name            |
            | BG16CDQ-H9B4WK5-PQQN0W1-8HCD1QK | billing-test-n | 100036128 | ARS     | 1000   | ARGENTINA | 27-16749876-6 | MIGUEL GRANADOS |

    # ------ NO DESCUBIERTOS -------

    @NoDescubierto @UA @Crypto @ARG @Automated
    Scenario Outline: Ejecutar sintético billing en no descubierto operando contra <against> desde user account ARG
        Given The API key is available "<apiKEY>"
        And The API secret is available "1RpvdT7Vc7ukKeGKdU"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        And Get billId from billing provider
        And Obtain "<against>" balance for "<userAnyId>" user over "balance"
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "billId" to the variable "billId"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<amount>" to the variable "amount"
        And Execute the POST method on the endpoint "/v2/bill-locks"
        Then Obtain a response 201 for bill payment overdraw
        When Assign the value "<externalId>" to the variable "externalId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "true" to the variable "disallowDebt"
        And Assign the value "pixCode" to the variable "billCode"
        And Execute the POST method on the endpoint "/v2/synthetics/bill-payment"
        Then Obtain a response 201
        And Execute crypto deposit
        And Obtain a response 200 and status "COMPLETED" for "billing payment" synthetic
        And Obtain "<against>" balance for "<userAnyId>" user over "balance"

        Examples:
            | apiKEY                          | externalId     | userAnyId | against | amount |
            | BG16CDQ-H9B4WK5-PQQN0W1-8HCD1QK | billing-test-n | 100036761 | USDT    | 1000   |
            | BG16CDQ-H9B4WK5-PQQN0W1-8HCD1QK | billing-test-n | 100036761 | USDC    | 1000   |

    @NoDescubierto @UA @Fiat @ARG @Automated
    Scenario Outline: Ejecutar sintético billing en no descubierto operando contra <against> desde user account ARG
        Given The API key is available "<apiKEY>"
        And The API secret is available "1RpvdT7Vc7ukKeGKdU"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        And Get billId from billing provider
        And Obtain "<against>" balance for "<userAnyId>" user over "balance"
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "billId" to the variable "billId"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<amount>" to the variable "amount"
        And Execute the POST method on the endpoint "/v2/bill-locks"
        Then Obtain a response 201 for bill payment overdraw
        When Assign the value "<externalId>" to the variable "externalId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "true" to the variable "disallowDebt"
        And Assign the value "pixCode" to the variable "billCode"
        And Execute the POST method on the endpoint "/v2/synthetics/bill-payment"
        Then Obtain a response 201
        And Execute fiat deposit
        And Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic
        And Obtain "<against>" balance for "<userAnyId>" user over "balance"

        Examples:
            | apiKEY                          | externalId     | userAnyId | against | amount |
            | BG16CDQ-H9B4WK5-PQQN0W1-8HCD1QK | billing-test-n | 100036761 | ARS     | 1000   |
            | BG16CDQ-H9B4WK5-PQQN0W1-8HCD1QK | billing-test-n | 100036761 | ARS     | 1000   |