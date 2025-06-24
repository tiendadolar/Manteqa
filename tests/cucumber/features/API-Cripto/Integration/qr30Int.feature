@QRInt
Feature: QR3.0

    Background:
        Given Contar con la api-key "B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"

    Scenario Outline: Test de integración QR 3.0
        #Onboarding initial
        When Asignar el valor "<name>" a la variable "name"
        And Asignar el valor "<email>" a la variable "email"
        And Asignar el valor "<legalId>" a la variable "legalId"
        And Asignar el valor "<phoneNumber>" a la variable "phoneNumber"
        And Asignar el valor "<country>" a la variable "country"
        And Asignar el valor "<civilState>" a la variable "civilState"
        And Ejecutar el método Post al endpoint "/v1/user/"
        Then Se obtiene una respuesta 200
        And Se crea el usuario

        #Add Bank Account
        When Asignar el valor "<sessionId>" a la variable "sessionId"
        When Asignar el valor "0140420703690150418728" a la variable "cbu"
        And Asignar el valor "Galicia" a la variable "description"
        And Ejecutar el método Post al endpoint "/v1/user/{userId}/bankaccount/ARS"
        Then Se obtiene una respuesta 200
        And Se agrega la cuenta bancaria

        #Add Documentation
        When Asignar el valor "DNI" a la variable "docType"
        When Asignar el valor "DNI_FRONT" a la variable "docType"
        And Asignar el valor "picfront.jpg" a la variable "fileName"
        And Ejecutar el método Post al endpoint "/v1/documentation/{userId}/uploadUrl"
        Then Se obtiene una respuesta 200

        When Ejecutar el método Put al endpoint
        Then Se obtiene una respuesta 200

        #Add Documentation
        When Asignar el valor "DNI_BACK" a la variable "docType"
        And Asignar el valor "picback.jpg" a la variable "fileName"
        And Ejecutar el método Post al endpoint "/v1/documentation/{userId}/uploadUrl"
        Then Se obtiene una respuesta 200

        When Ejecutar el método Put al endpoint
        Then Se obtiene una respuesta 200
        And Esperar procesamiento de la "validación de documentación" por 20 segundos

        # Create lock price QR 3.0
        When Asignar el valor "<userAnyId>" a la variable "userAnyId"
        When Asignar el valor "userAnyId" a la variable "userAnyId"
        And Asignar el valor "00020101021140200010com.yacare02022350150011336972350495204858553030325802AR5910HAVANNA SA6012BUENOS AIRES81220010com.yacare0204Y2156304E401" a la variable "qrCode"
        And Asignar el valor "2200" a la variable "amount"
        And Ejecutar el método Post al endpoint "/v2/payment-locks"
        Then Se obtiene una respuesta 201
        And Se crea el LockPix de precio
        And Esperar procesamiento de la "lock price" por 3 segundos

        # Create synthetic payment QR 3.0
        When Asignar el valor "<sessionId>" a la variable "sessionId"
        And Asignar el valor "userAnyId" a la variable "userAnyId"
        And Asignar el valor "pixCode" a la variable "pixCode"
        And Ejecutar el método Post al endpoint "/v2/synthetics/qr-payment"
        Then Se obtiene una respuesta 201
        And Se crea el sintetico de pago

        #Create Fiat deposit
        Given Contar con la api-key "C10XB2Z-AG243CS-G42KB2M-4085WTF"
        And Contar con la api-secret "mZJ5r9KCdRjnWCdPJg"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "hash" a la variable "hash"
        And Asignar el valor "0x9bD31d82B6212dd60a9328CCe7277161e5975fB5" a la variable "from"
        And Asignar el valor "depositAddress" a la variable "to"
        And Asignar el valor "wei" a la variable "wei"
        And Asignar el valor "human" a la variable "human"
        And Asignar el valor "USDT" a la variable "ticker"
        And Asignar el valor 0 a la variable "chain"
        And Ejecutar el método Post al endpoint "/v1/transaction/deposit"
        Then Se obtiene una respuesta 201

        Examples:
            | name                | email                          | legalId     | phoneNumber   | country   | civilState | sessionId          | asset | against | assetAmount | withdrawAddress                            | withdrawNetwork |
            | TestOnboardingV1223 | boddeuquipure_1023@yopmail.com | 20270001409 | 5492625051024 | Argentina | SOLTERO    | integration-test-n | USDT  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | POLYGON         |