@Orders
Feature: Ordenes

    Scenario Outline: Ejecutar ordenes de compra de <coin> contra <against>
        Given Contar con la api-key "95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "<coin>" a la variable "coin"
        And Asignar el valor "<operation>" a la variable "operation"
        And Asignar el valor "<userId>" a la variable "userId"
        And Ejecutar el método Post al endpoint "/v1/order/lock"
        Then Se obtiene una respuesta 200
        And Se crea el Lock de precio

        When Asignar el valor "<sessionId>" a la variable "sessionId"
        And Asignar el valor "<userId>" a la variable "userId"
        And Asignar el valor "<amount>" a la variable "amount"
        And Asignar el valor "<coin>" a la variable "coin"
        And Asignar el valor "<operation>" a la variable "operation"
        And Asignar el valor "pixCode" a la variable "code"
        And Ejecutar el método Post al endpoint "/v1/order"
        Then Se obtiene una respuesta 200
        And Se crea la orden de compra

        When Esperar procesamiento de la "orden" por 1 segundos
        And Ejecutar el método Get al endpoint "/v1/order/{orderNumberId}"
        Then Se obtiene una respuesta 200 y status COMPLETED

        Examples:
            | sessionId   | coin     | operation | userId    | amount | against |
            | order-qaa-n | USDT_ARS | BUY       | 100010451 | 5      | ARS     |