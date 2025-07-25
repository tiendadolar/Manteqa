@QRInt
Feature: QR3.0

    Background:
        Given The API key is available "B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"

    Scenario Outline: Test de integración QR 3.0
        #Onboarding initial
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

        # Create lock price QR 3.0
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        When Assign the value "userAnyId" to the variable "userAnyId"
        And Assign the value "00020101021140200010com.yacare02022350150011336972350495204858553030325802AR5910HAVANNA SA6012BUENOS AIRES81220010com.yacare0204Y2156304E401" to the variable "qrCode"
        And Assign the value "2200" to the variable "amount"
        And Execute the POST method on the endpoint "/v2/payment-locks"
        Then Obtain a response 201
        And The price LockPix is created
        And Wait for the processing of the "lock price" por 3 seconds

        # Create synthetic payment QR 3.0
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "userAnyId" to the variable "userAnyId"
        And Assign the value "pixCode" to the variable "pixCode"
        And Execute the POST method on the endpoint "/v2/synthetics/qr-payment"
        Then Obtain a response 201
        And The payment synthetic is created

        #Create Fiat deposit
        Given The API key is available "C10XB2Z-AG243CS-G42KB2M-4085WTF"
        And The API secret is available "mZJ5r9KCdRjnWCdPJg"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "hash" to the variable "hash"
        And Assign the value "0x9bD31d82B6212dd60a9328CCe7277161e5975fB5" to the variable "from"
        And Assign the value "depositAddress" to the variable "to"
        And Assign the value "wei" to the variable "wei"
        And Assign the value "human" to the variable "human"
        And Assign the value "USDT" to the variable "ticker"
        And Assign the value 0 to the variable "chain"
        And Execute the POST method on the endpoint "/v1/transaction/deposit"
        Then Obtain a response 201

        Examples:
            | name                | email                          | legalId     | phoneNumber   | country   | civilState | sessionId          | asset | against | assetAmount | withdrawAddress                            | withdrawNetwork |
            | TestOnboardingV1223 | boddeuquipure_1023@yopmail.com | 20270001409 | 5492625051024 | Argentina | SOLTERO    | integration-test-n | USDT  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | POLYGON         |