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

    @Smoke @Fiat @V1
    Scenario Outline: Crear retiro fiat user por country por V1
        Given Contar con la api-key "Y2HQYTM-BHQ4377-Q9XS7RX-17PPS04"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "<userId>" a la variable "userId"
        And Asignar el valor "<coin>" a la variable "coin"
        And Asignar el valor "<accountIndex>" a la variable "accountIndex"
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
            | userId    | coin | cbu                    | amount | accountIndex |
            | 100009883 | CRC  | CR09010402346674053515 | 500    | 0            |
            | 100009884 | BRL  | 06383835793            | 10     |              |
            | 100009892 | CLP  | 13661544               | 10000  |              |
            | 100009891 | COP  | 3142959505             | 100    |              |
            | 100009886 | GTQ  | 972004709              | 100    |              |
            | 100009889 | MXN  | 638180010139391962     | 100    |              |
            | 100009885 | PHP  | 20867104660592         | 100    |              |
            | 100009887 | PUSD | 0472001494028          | 100    |              |
            | 100009893 | USD  | 1430001714039384360025 | 10     |              |
            | 100009893 | ARS  | 1430001713039384360017 | 1000   |              |


    @Smoke @Fiat @V2
    Scenario Outline: Crear retiro fiat user por country por V2
        Given Contar con la api-key "PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "<sessionId>" a la variable "sessionId"
        And Asignar el valor "<userAnyId>" a la variable "userAnyId"
        # And Asignar el valor "<network>" a la variable "network"
        And Asignar el valor "<asset>" a la variable "asset"
        And Asignar el valor "<amount>" a la variable "amount"
        And Asignar el valor "<address>" a la variable "address"
        And Asignar el valor "<bankCode>" a la variable "bankCode"
        And Asignar el valor "<accountType>" a la variable "accountType"
        And Ejecutar el método Post al endpoint "/v2/withdraws"
        Then Se obtiene una respuesta 201

        # Parte 2: Validar ejeccución del sintético
        Given Contar con la api-key "PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Esperar procesamiento de la "orden" por 5 segundos
        And Ejecutar el método Get al endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Se obtiene una respuesta 200 y status EXECUTED para retiro fiat

        Examples:
            | userAnyId | asset | address                | amount | bankCode  | accountType |
            | 100009881 | CRC   | CR14010200009650656758 | 500    | 0102      | SAVINGS     |
            | 100009874 | BRL   | 02103213262            | 10     |           |             |
            | 100009875 | CLP   | 13033517               | 10000  | 317       | RUT         |
            | 100009876 | COP   | 3172655787             | 100    | 1507      | SAVINGS     |
            | 100009879 | GTQ   | 00980725433            | 100    | 042       | SAVINGS     |
            | 100009877 | MXN   | 4189143297879093       | 100    | 002       | DEBIT       |
            | 100009880 | PHP   | 09931984160            | 100    | shopeepay | SAVINGS     |
            | 100009878 | PUSD  | 117353318              | 100    | 0026      | SAVINGS     |
            | 100009873 | USD   | 1430001714039384360025 | 10     |           |             |
            | 100009873 | ARS   | 1430001713039384360017 | 1000   |           |             |

    @Smoke @Fiat @pendingAdmin
    Scenario Outline: Crear retiro fiat user por country por V2 ADMIN_PENDING
        Given Contar con la api-key "PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "<sessionId>" a la variable "sessionId"
        And Asignar el valor "<userAnyId>" a la variable "userAnyId"
        # And Asignar el valor "<network>" a la variable "network"
        And Asignar el valor "<asset>" a la variable "asset"
        And Asignar el valor "<amount>" a la variable "amount"
        And Asignar el valor "<address>" a la variable "address"
        And Asignar el valor "<bankCode>" a la variable "bankCode"
        And Asignar el valor "<accountType>" a la variable "accountType"
        And Ejecutar el método Post al endpoint "/v2/withdraws"
        Then Se obtiene una respuesta 201

        # Parte 2: Validar ejeccución del sintético
        Given Contar con la api-key "PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Esperar procesamiento de la "orden" por 2 segundos
        And Ejecutar el método Get al endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Se obtiene una respuesta 200 y status EXECUTED para retiro fiat

        Examples:
            | userAnyId | asset | address                | amount   | bankCode  | accountType |
            | 100009881 | CRC   | CR14010200009650656758 | 10000000 | 0102      | SAVINGS     |
            | 100009874 | BRL   | 02103213262            | 500000   |           |             |
            | 100009875 | CLP   | 13033517               | 1000000  | 317       | RUT         |
            | 100009876 | COP   | 00870206780            | 1000000  | 1507      | PHONE       |
            | 100009879 | GTQ   | 32992083658602         | 10000000 | 049       | SAVINGS     |
            | 100009877 | MXN   | 4189143297879093       | 1000000  | 002       | DEBIT       |
            | 100009880 | PHP   | 09931984160            | 10000000 | shopeepay | SAVINGS     |
            | 100009878 | PUSD  | 117353318              | 10000000 | 0026      | SAVINGS     |
            | 100009873 | USD   | 1430001714039384360025 | 10       |           |             |
            | 100009873 | ARS   | 1430001713039384360017 | 12000000 |           |             |
            | 100009991 | ARS   | 1430001713039384360017 | 12000000 |           |             |

    @Smoke @Fiat @coinag
    Scenario Outline: Crear retiro fiat user por country por V2 ADMIN_PENDING TAKENOS
        Given Contar con la api-key "4J05H32-N4JM9ZB-QYQRNH1-3E6V8ZN"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "<sessionId>" a la variable "sessionId"
        And Asignar el valor "<userAnyId>" a la variable "userAnyId"
        # And Asignar el valor "<network>" a la variable "network"
        And Asignar el valor "<asset>" a la variable "asset"
        And Asignar el valor "<amount>" a la variable "amount"
        And Asignar el valor "<address>" a la variable "address"
        And Asignar el valor "<bankCode>" a la variable "bankCode"
        And Asignar el valor "<accountType>" a la variable "accountType"
        And Ejecutar el método Post al endpoint "/v2/withdraws"
        Then Se obtiene una respuesta 201

        # Parte 2: Validar ejeccución del sintético
        Given Contar con la api-key "4J05H32-N4JM9ZB-QYQRNH1-3E6V8ZN"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Esperar procesamiento de la "orden" por 2 segundos
        And Ejecutar el método Get al endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Se obtiene una respuesta 200 y status EXECUTED para retiro fiat

        Examples:
            | userAnyId | asset | address                | amount   | bankCode | accountType |
            | 100009991 | ARS   | 1430001713039384360017 | 12000000 |          |             |

    @Smoke @Fiat @coinag
    Scenario Outline: Crear retiro fiat user por country por V2 ADMIN_PENDING WALLBIT
        Given Contar con la api-key "1TP79KS-KPX4QYG-J0T505E-Z8PT3CC"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "<sessionId>" a la variable "sessionId"
        And Asignar el valor "<userAnyId>" a la variable "userAnyId"
        # And Asignar el valor "<network>" a la variable "network"
        And Asignar el valor "<asset>" a la variable "asset"
        And Asignar el valor "<amount>" a la variable "amount"
        And Asignar el valor "<address>" a la variable "address"
        And Asignar el valor "<bankCode>" a la variable "bankCode"
        And Asignar el valor "<accountType>" a la variable "accountType"
        And Ejecutar el método Post al endpoint "/v2/withdraws"
        Then Se obtiene una respuesta 201

        # Parte 2: Validar ejeccución del sintético
        Given Contar con la api-key "1TP79KS-KPX4QYG-J0T505E-Z8PT3CC"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Esperar procesamiento de la "orden" por 2 segundos
        And Ejecutar el método Get al endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Se obtiene una respuesta 200 y status EXECUTED para retiro fiat

        Examples:
            | userAnyId | asset | address                | amount   | bankCode | accountType |
            | 100009997 | ARS   | 1430001713039384360017 | 12000000 |          |             |

    @Smoke @Fiat @coinag
    Scenario Outline: Crear retiro fiat user por country por V2 ADMIN_PENDING MERU
        Given Contar con la api-key "JHD27DA-1KNMGS7-KZS2V9R-963H29E"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "<sessionId>" a la variable "sessionId"
        And Asignar el valor "<userAnyId>" a la variable "userAnyId"
        # And Asignar el valor "<network>" a la variable "network"
        And Asignar el valor "<asset>" a la variable "asset"
        And Asignar el valor "<amount>" a la variable "amount"
        And Asignar el valor "<address>" a la variable "address"
        And Asignar el valor "<bankCode>" a la variable "bankCode"
        And Asignar el valor "<accountType>" a la variable "accountType"
        And Ejecutar el método Post al endpoint "/v2/withdraws"
        Then Se obtiene una respuesta 201

        # Parte 2: Validar ejeccución del sintético
        Given Contar con la api-key "JHD27DA-1KNMGS7-KZS2V9R-963H29E"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Esperar procesamiento de la "orden" por 2 segundos
        And Ejecutar el método Get al endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Se obtiene una respuesta 200 y status EXECUTED para retiro fiat

        Examples:
            | userAnyId | asset | address                | amount   | bankCode | accountType |
            | 100009999 | ARS   | 1430001713039384360017 | 12000000 |          |             |