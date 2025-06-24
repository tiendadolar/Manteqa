@synInt
Feature: Test de intragación sintético

    Background:
        Given Contar con la api-key "B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"

    Scenario Outline: Validar onboarding exitoso de usuario
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

        # Create Ramp On Synthetic
        When Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "<sessionId>" a la variable "sessionId"
        And Asignar el valor "<asset>" a la variable "asset"
        And Asignar el valor "<against>" a la variable "against"
        And Asignar el valor "<assetAmount>" a la variable "assetAmount"
        And Asignar el valor "<withdrawAddress>" a la variable "withdrawAddress"
        And Asignar el valor "<withdrawNetwork>" a la variable "withdrawNetwork"
        And Ejecutar el método Post al endpoint "/v1/synthetics/ramp-on"
        Then Se obtiene una respuesta 201

        # Create Fiat Deposit
        Given Contar con la api-key "C10XB2Z-AG243CS-G42KB2M-4085WTF"
        And Contar con la api-secret "mZJ5r9KCdRjnWCdPJg"
        When Asignar el valor "userNumberId" a la variable "userId"
        And Asignar el valor "amount" a la variable "amount"
        And Asignar el valor "coin" a la variable "coin"
        And Ejecutar el método Post al endpoint "/v1/fiat/deposit"
        Then Se obtiene una respuesta 201

        Examples:
            | name                | email                          | legalId     | phoneNumber   | country   | civilState | sessionId          | asset | against | assetAmount | withdrawAddress                            | withdrawNetwork |
            | TestOnboardingV1230 | boddeuquipure_1030@yopmail.com | 20270001409 | 5492625051030 | Argentina | SOLTERO    | integration-test-n | USDT  | ARS     | 10          | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | POLYGON         |