@Withdraw
Feature: Retiros Fiat

    @Smoke @Fiat
    Scenario Outline: Crear retiro fiat
        Given Contar con la api-key "BM2YZT6-MR5M5YY-QYZ5CY4-E8E9HYB"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "<userId>" a la variable "userId"
        And Asignar el valor "<coin>" a la variable "coin"
        And Asignar el valor "<cbu>" a la variable "cbu"
        And Asignar el valor "<amount>" a la variable "amount"
        And Ejecutar el método Post al endpoint "/v1/fiat/withdraw"
        Then Se obtiene una respuesta 200

        # Parte 2: Validar ejeccución del sintético
        Given Contar con la api-key "BM2YZT6-MR5M5YY-QYZ5CY4-E8E9HYB"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Esperar procesamiento de la "orden" por 2 segundos
        And Ejecutar el método Get al endpoint "/v1/fiat/withdraw/{withdrawAnyId}"
        Then Se obtiene una respuesta 200 y status EXECUTED para retiro fiat

        Examples:
            | userId    | coin | cbu                    | amount |
            | 100009791 | ARS  | 0070703130004000381667 | 1000   |
            | 100009791 | BRL  | 0070703130004000381667 | 10     |
            | 100009791 | CLP  | 0070703130004000381667 | 10000  |
            | 100009791 | COP  | 3232145116             | 100    |
            | 100009791 | GTQ  | 0070703130004000381667 | 100    |
            | 100009791 | MXN  | 0070703130004000381667 | 100    |
            | 100009791 | PHP  | 0070703130004000381667 | 100    |
            | 100009791 | PUSD | 0070703130004000381667 | 100    |
            | 100009791 | USD  | 0070703130004000381667 | 10     |
            | 100009791 | CRC  | 0070703130004000381667 | 100    |