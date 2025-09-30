@Withdraw
Feature: Retiros Fiat

    @Smoke @Fiat @V1 @Automated
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


    @Smoke @Fiat @V2 @Automated
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

    @Smoke @Fiat  @V2 @Remesas @Automated
    Scenario Outline: Crear retiro fiat user por country por V2
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
        And Assign the value "<senderExchange>" to the variable "senderExchange"
        And Assign the value "<senderLegalId>" to the variable "senderLegalId"
        And Assign the value "<senderName>" to the variable "senderName"
        And Assign the value "<senderSurname>" to the variable "senderSurname"
        And Assign the value "<recipientExchange>" to the variable "recipientExchange"
        And Assign the value "<recipientLegalId>" to the variable "recipientLegalId"
        And Assign the value "<recipientName>" to the variable "recipientName"
        And Assign the value "<recipientSurname>" to the variable "recipientSurname"
        And Execute the POST method on the endpoint "/v2/withdraws"
        Then Obtain a response 201

        # Parte 2: Validar ejeccución del sintético
        Given The API key is available "<apiKEY>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Wait for the processing of the "orden" por 5 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED for fiat withdraw

        Examples:
            | apiKEY                          | userAnyId | asset | address                | amount | bankCode | accountType | senderExchange | senderLegalId | senderName | senderSurname | recipientExchange | recipientLegalId   | recipientName | recipientSurname  |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | 100009873 | ARS   | 1430001713039384360017 | 10000  |          |             | VIETNAM        | 1512121354    | Phong Cao  | Nguyen        | ARGENTINA         | 20344554332        | Lucas         | Segura            |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | 100009874 | BRL   | 02103213262            | 100    |          |             | VIETNAM        | 1512121354    | Phong Cao  | Nguyen        | BRAZIL            | 62757666380        | Lucas         | Helano De Freitas |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | 100009875 | CLP   | 13033517               | 10000  | 317      | RUT         | VIETNAM        | 1512121354    | Phong Cao  | Nguyen        | CHILE             | 189274130          | Maricela      | Castro            |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | 100009876 | COP   | 3172655787             | 1000   | 1507     | SAVINGS     | VIETNAM        | 1512121354    | Phong Cao  | Nguyen        | COLOMBIA          | 1073714929         | Juan Camilo   | Prieto            |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | 100009877 | MXN   | 4189143297879093       | 1000   | 002      | DEBIT       | VIETNAM        | 1512121354    | Phong Cao  | Nguyen        | MEXICO            | lorp000601hdfpmba6 | Pablo Agustin | Lopez Roman       |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | 100009878 | PUSD  | 117353318              | 1000   | 0026     | CHECKING    | VIETNAM        | 1512121354    | Phong Cao  | Nguyen        | PANAMA            | 17601100           | Jhonnyel      | Yosimar           |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | 100009879 | GTQ   | 32992083658602         | 1000   | 016      | CHECKING    | VIETNAM        | 1512121354    | Phong Cao  | Nguyen        | GUATEMALA         | 2573057420101      | Mónica        | Michelle          |
            | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | 100009881 | CRC   | CR14010200009650656758 | 1000   | 0102     | CHECKING    | VIETNAM        | 1512121354    | Phong Cao  | Nguyen        | COSTA_RICA        | 116800458          | Gloriana      | Aguilar           |


    @Regression @Fiat @pendingAdmin
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

    @Regression @Fiat @coinag
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

    @Regression @Fiat @coinag @others
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
            | apiKEY                          | userAnyId | asset | address                | amount   | bankCode | accountType |
            | 1TP79KS-KPX4QYG-J0T505E-Z8PT3CC | 100009997 | ARS   | 1430001713039384360017 | 12000000 |          |             |
    # | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | 100008501 | ARS   | 0140420703690150418728 | 9200000 |          |             |

    @Regression @Fiat @coinag
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