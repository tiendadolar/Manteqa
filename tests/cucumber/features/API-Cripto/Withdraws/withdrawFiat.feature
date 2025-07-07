@Withdraw
Feature: Retiros Fiat

    @Fiat
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

        # Solo ARS/USD se puede retirar a un cbu declarado en el user, las demas son por accountIndex
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

    @Smoke @Fiat
    Scenario Outline: Crear retiro fiat user por country
        Given Contar con la api-key "Y2HQYTM-BHQ4377-Q9XS7RX-17PPS04"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "<userId>" a la variable "userId"
        And Asignar el valor "<coin>" a la variable "coin"
        And Asignar el valor "<cbu>" a la variable "cbu"
        And Asignar el valor "<amount>" a la variable "amount"
        And Ejecutar el método Post al endpoint "/v1/fiat/withdraw"
        Then Se obtiene una respuesta 200

        # Parte 2: Validar ejeccución del sintético
        Given Contar con la api-key "Y2HQYTM-BHQ4377-Q9XS7RX-17PPS04"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Esperar procesamiento de la "orden" por 2 segundos
        And Ejecutar el método Get al endpoint "/v1/fiat/withdraw/{withdrawAnyId}"
        Then Se obtiene una respuesta 200 y status EXECUTED para retiro fiat

        Examples:
            | userId    | coin | cbu                    | amount |
            | 100009883 | CRC  | CR09010402346674053515 | 500    |
            | 100009884 | BRL  | 06383835793            | 10     |
            | 100009892 | CLP  | 13661544               | 10000  |
            | 100009891 | COP  | 3142959505             | 100    |
            | 100009886 | GTQ  | 972004709              | 100    |
            | 100009889 | MXN  | 638180010139391962     | 100    |
            | 100009885 | PHP  | 20867104660592         | 100    |
            | 100009887 | PUSD | 0472001494028          | 100    |
            | 100009893 | USD  | 1430001714039384360025 | 10     |
            | 100009893 | ARS  | 1430001713039384360017 | 1000   |