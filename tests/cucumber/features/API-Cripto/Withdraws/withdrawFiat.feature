@Withdraw
Feature: Retiros Fiat

    @Fiattest
    Scenario Outline: Crear retiro fiat
        Given The API key is available "B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<userId>" to the variable "userId"
        And Assign the value "<coin>" to the variable "coin"
        And Assign the value "<cbu>" to the variable "cbu"
        And Assign the value "<amount>" to the variable "amount"
        And Execute the POST method on the endpoint "/v1/fiat/withdraw"
        Then Obtain a response 200

        # Parte 2: Validar ejeccución del sintético
        Given The API key is available "B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Wait for the processing of the "orden" por 2 seconds
        And Execute the GET method on the endpoint "/v1/fiat/withdraw/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED for fiat withdraw

        # Solo ARS/USD se puede retirar a un cbu declarado en el user, las demas son por accountIndex
        Examples:
            | userId    | coin | cbu                    | amount |
            | 100011177 | ARS  | 1430001713039384360017 | 1000   |
            | 100011177 | USD  | 1430001713039384360017 | 10     |
            | 100011177 | CLP  | 1430001713039384360017 | 1000   |
    # | 100009791 | ARS  | 0070703130004000381667 | 1000   |
    # | 100009791 | BRL  | 0070703130004000381667 | 10     |
    # | 100009791 | CLP  | 0070703130004000381667 | 10000  |
    # | 100009791 | COP  | 3232145116             | 100    |
    # | 100009791 | GTQ  | 0070703130004000381667 | 100    |
    # | 100009791 | MXN  | 0070703130004000381667 | 100    |
    # | 100009791 | PHP  | 0070703130004000381667 | 100    |
    # | 100009791 | PUSD | 0070703130004000381667 | 100    |
    # | 100009791 | USD  | 0070703130004000381667 | 10     |
    # | 100009791 | CRC  | 0070703130004000381667 | 100    |

    @Smoke @Fiat @V1
    Scenario Outline: Crear retiro fiat user por country por V1
        Given The API key is available "Y2HQYTM-BHQ4377-Q9XS7RX-17PPS04"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<userId>" to the variable "userId"
        And Assign the value "<coin>" to the variable "coin"
        And Assign the value "<accountIndex>" to the variable "accountIndex"
        And Assign the value "<cbu>" to the variable "cbu"
        And Assign the value "<amount>" to the variable "amount"
        And Execute the POST method on the endpoint "/v1/fiat/withdraw"
        Then Obtain a response 200

        # Parte 2: Validar ejeccución del sintético
        Given The API key is available "Y2HQYTM-BHQ4377-Q9XS7RX-17PPS04"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Wait for the processing of the "orden" por 2 seconds
        And Execute the GET method on the endpoint "/v1/fiat/withdraw/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED for fiat withdraw

        Examples:
            | userId    | coin | cbu                    | amount | accountIndex |
            | 100009883 | CRC  | CR09010402346674053515 | 500    | 0            |
            | 100009884 | BRL  | 06383835793            | 10     |              |
            | 100009892 | CLP  | 13661544               | 10000  |              |
            | 100009891 | COP  | 1362017052             | 100    |              |
            | 100009886 | GTQ  | 972004709              | 100    |              |
            | 100009889 | MXN  | 638180010139391962     | 100    |              |
            | 100009885 | PHP  | 20867104660592         | 100    |              |
            | 100009887 | PUSD | 0472001494028          | 100    |              |
            | 100009893 | USD  | 1430001714039384360025 | 10     |              |
            | 100009893 | ARS  | 1430001713039384360017 | 1000   |              |


    @Smoke @Fiat @V2
    Scenario Outline: Crear retiro fiat user por country por V2
        Given The API key is available "PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        # And Assign the value "<network>" to the variable "network"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<address>" to the variable "address"
        And Assign the value "<bankCode>" to the variable "bankCode"
        And Assign the value "<accountType>" to the variable "accountType"
        And Execute the POST method on the endpoint "/v2/withdraws"
        Then Obtain a response 201

        # Parte 2: Validar ejeccución del sintético
        Given The API key is available "PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Wait for the processing of the "orden" por 5 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED for fiat withdraw

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
        Given The API key is available "PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        # And Assign the value "<network>" to the variable "network"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<address>" to the variable "address"
        And Assign the value "<bankCode>" to the variable "bankCode"
        And Assign the value "<accountType>" to the variable "accountType"
        And Execute the POST method on the endpoint "/v2/withdraws"
        Then Obtain a response 201

        # Parte 2: Validar ejeccución del sintético
        Given The API key is available "PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Wait for the processing of the "orden" por 2 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED for fiat withdraw

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
        Given The API key is available "4J05H32-N4JM9ZB-QYQRNH1-3E6V8ZN"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        # And Assign the value "<network>" to the variable "network"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<address>" to the variable "address"
        And Assign the value "<bankCode>" to the variable "bankCode"
        And Assign the value "<accountType>" to the variable "accountType"
        And Execute the POST method on the endpoint "/v2/withdraws"
        Then Obtain a response 201

        # Parte 2: Validar ejeccución del sintético
        Given The API key is available "4J05H32-N4JM9ZB-QYQRNH1-3E6V8ZN"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Wait for the processing of the "orden" por 2 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED for fiat withdraw

        Examples:
            | userAnyId | asset | address                | amount   | bankCode | accountType |
            | 100009991 | ARS   | 1430001713039384360017 | 12000000 |          |             |

    @Smoke @Fiat @coinag @others
    Scenario Outline: Crear retiro fiat user por country por V2 ADMIN_PENDING WALLBIT
        Given The API key is available "<apiKEY>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        # And Assign the value "<network>" to the variable "network"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<address>" to the variable "address"
        And Assign the value "<bankCode>" to the variable "bankCode"
        And Assign the value "<accountType>" to the variable "accountType"
        And Execute the POST method on the endpoint "/v2/withdraws"
        Then Obtain a response 201

        # Parte 2: Validar ejeccución del sintético
        Given The API key is available "<apiKEY>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Wait for the processing of the "orden" por 2 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED for fiat withdraw

        Examples:
            | apiKEY                          | userAnyId | asset | address                | amount  | bankCode | accountType |
            | 1TP79KS-KPX4QYG-J0T505E-Z8PT3CC | 100009997 | ARS   | 1430001713039384360017 | 1200000 |          |             |
    # | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | 100008501 | ARS   | 0140420703690150418728 | 9200000 |          |             |

    @Smoke @Fiat @coinag
    Scenario Outline: Crear retiro fiat user por country por V2 ADMIN_PENDING MERU
        Given The API key is available "JHD27DA-1KNMGS7-KZS2V9R-963H29E"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        # And Assign the value "<network>" to the variable "network"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<address>" to the variable "address"
        And Assign the value "<bankCode>" to the variable "bankCode"
        And Assign the value "<accountType>" to the variable "accountType"
        And Execute the POST method on the endpoint "/v2/withdraws"
        Then Obtain a response 201

        # Parte 2: Validar ejeccución del sintético
        Given The API key is available "JHD27DA-1KNMGS7-KZS2V9R-963H29E"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Wait for the processing of the "orden" por 2 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED for fiat withdraw

        Examples:
            | userAnyId | asset | address                | amount   | bankCode | accountType |
            | 100009999 | ARS   | 1430001713039384360017 | 12000000 |          |             |