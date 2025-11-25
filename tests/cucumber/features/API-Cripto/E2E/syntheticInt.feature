@synInt
Feature: Test de intragación sintético

    Background:
        Given The API key is available "B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"

    Scenario Outline: Validar onboarding exitoso de usuario
        When Assign the value "<name>" to the variable "name"
        And Assign the value "<email>" to the variable "email"
        And Assign the value "<legalId>" to the variable "legalId"
        And Assign the value "<phoneNumber>" to the variable "phoneNumber"
        And Assign the value "<country>" to the variable "country"
        And Assign the value "<civilState>" to the variable "civilState"
        And Execute the POST method on the endpoint "/v1/user/"
        Then Obtain a response 200
        And The user is created

        #Add Bank Account
        When Assign the value "<sessionId>" to the variable "sessionId"
        When Assign the value "0140420703690150418728" to the variable "cbu"
        And Assign the value "Galicia" to the variable "description"
        And Execute the POST method on the endpoint "/v1/user/{userId}/bankaccount/ARS"
        Then Obtain a response 200
        And The bank account is added

        #Add Documentation
        When Assign the value "DNI" to the variable "docType"
        When Assign the value "DNI_FRONT" to the variable "docType"
        And Assign the value "picfront.jpg" to the variable "fileName"
        And Execute the POST method on the endpoint "/v1/documentation/{userId}/uploadUrl"
        Then Obtain a response 200

        When Execute the PUT method on the endpoint
        Then Obtain a response 200

        #Add Documentation
        When Assign the value "DNI_BACK" to the variable "docType"
        And Assign the value "picback.jpg" to the variable "fileName"
        And Execute the POST method on the endpoint "/v1/documentation/{userId}/uploadUrl"
        Then Obtain a response 200

        When Execute the PUT method on the endpoint
        Then Obtain a response 200
        And Wait for the processing of the "validación de documentación" por 20 seconds

        # Create Ramp On Synthetic
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Assign the value "<withdrawAddress>" to the variable "withdrawAddress"
        And Assign the value "<withdrawNetwork>" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v1/synthetics/ramp-on"
        Then Obtain a response 201

        # Create Fiat Deposit
        Given The API key is available "C10XB2Z-AG243CS-G42KB2M-4085WTF"
        And The API secret is available "mZJ5r9KCdRjnWCdPJg"
        When Assign the value "userNumberId" to the variable "userId"
        And Assign the value "amount" to the variable "amount"
        And Assign the value "coin" to the variable "coin"
        And Execute the POST method on the endpoint "/v1/fiat/deposit"
        Then Obtain a response 201

        Examples:
            | name                | email                          | legalId     | phoneNumber   | country   | civilState | sessionId          | asset | against | assetAmount | withdrawAddress                            | withdrawNetwork |
            | TestOnboardingV1230 | boddeuquipure_1030@yopmail.com | 20270001409 | 5492625051030 | Argentina | SOLTERO    | integration-test-n | USDT  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | POLYGON         |