@Withdraw
Feature: Retiros Fiat

    @Smoke @Fiat @V1 @Automated
    Scenario Outline: Crear retiro fiat user por country por V1 "<coin>"
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<userId>" to the variable "userId"
        And Assign the value "<coin>" to the variable "coin"
        And Assign the value "<accountIndex>" to the variable "accountIndex"
        And Assign the value "<cbu>" to the variable "cbu"
        And Assign the value "<amount>" to the variable "amount"
        And Execute the POST method on the endpoint "/v1/fiat/withdraw"
        Then Obtain a response 200

        # Parte 2: Validar ejeccución del sintético
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Wait for the processing of the "orden" por 2 seconds
        And Execute the GET method on the endpoint "/v1/fiat/withdraw/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED for fiat withdraw

        Examples:
            | companyId                | userId    | coin | cbu                    | amount | accountIndex |
            | 6864a82d08430ed74bf6296f | 100009883 | CRC  | CR09010402346674053515 | 500    | 0            |
            | 6864a82d08430ed74bf6296f | 100009884 | BRL  | 06383835793            | 10     |              |
            | 6864a82d08430ed74bf6296f | 100009892 | CLP  | 13661544               | 10000  |              |
            | 6864a82d08430ed74bf6296f | 100009891 | COP  | 1362017052             | 100    |              |
            | 6864a82d08430ed74bf6296f | 100009886 | GTQ  | 972004709              | 100    |              |
            | 6864a82d08430ed74bf6296f | 100009889 | MXN  | 638180010139391962     | 100    |              |
            | 6864a82d08430ed74bf6296f | 100009885 | PHP  | 20867104660592         | 100    |              |
            | 6864a82d08430ed74bf6296f | 100009887 | PUSD | 0472001494028          | 100    |              |
            | 6864a82d08430ed74bf6296f | 100009893 | USD  | 1430001714039384360025 | 10     |              |
            | 6864a82d08430ed74bf6296f | 100009893 | ARS  | 1430001713039384360017 | 1000   |              |
            | 6864a82d08430ed74bf6296f | 100067281 | PYG  | 111121996495           | 1000   |              |


    @Smoke @Fiat @V2 @Automated
    Scenario Outline: Crear retiro fiat user por country por V2 "<asset>"
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        # And Assign the value "<network>" to the variable "network"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<address>" to the variable "address"
        And Assign the value "<network>" to the variable "network"
        And Assign the value "<bankCode>" to the variable "bankCode"
        And Assign the value "<accountType>" to the variable "accountType"
        And Execute the POST method on the endpoint "/v2/withdraws"
        Then Obtain a response 201

        # Parte 2: Validar ejeccución del sintético
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Wait for the processing of the "orden" por 5 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED for fiat withdraw

        Examples:
            | companyId                | userAnyId | asset | address                | amount | bankCode  | accountType | network       |
            | 6864976a08430ed74bf61d0c | 100009881 | CRC   | CR14010200009650656758 | 500    | 0102      | SAVINGS     |               |
            | 6864976a08430ed74bf61d0c | 100009874 | BRL   | 02103213262            | 10     |           |             |               |
            | 6864976a08430ed74bf61d0c | 100009875 | CLP   | 13033517               | 10000  | 317       | RUT         |               |
            | 6864976a08430ed74bf61d0c | 100009876 | COP   | 3172655787             | 100    | 1507      | SAVINGS     | BANK_TRANSFER |
            | 6864976a08430ed74bf61d0c | 100009879 | GTQ   | 00980725433            | 100    | 042       | SAVINGS     |               |
            | 6864976a08430ed74bf61d0c | 100009877 | MXN   | 4189143297879093       | 100    | 002       | DEBIT       |               |
            | 6864976a08430ed74bf61d0c | 100009880 | PHP   | 09931984160            | 100    | shopeepay | SAVINGS     |               |
            | 6864976a08430ed74bf61d0c | 100009878 | PUSD  | 117353318              | 100    | 0026      | SAVINGS     |               |
            | 6864976a08430ed74bf61d0c | 100009873 | USD   | 1430001714039384360025 | 10     |           |             |               |
            | 6864976a08430ed74bf61d0c | 100009873 | ARS   | 1430001713039384360017 | 1000   |           |             |               |
            | 6864976a08430ed74bf61d0c | 100036551 | PEN   | 00219400342961406492   | 1000   | 002       | SAVINGS     |               |
            | 6864976a08430ed74bf61d0c | 100067267 | PYG   | 111121996495           | 1000   | 003       | SAVINGS     |               |


    @Smoke @Fiat @V2 @Aggregator @Automated
    Scenario Outline: Crear retiro fiat user por country por V2 "<asset>" con aggregator
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<address>" to the variable "address"
        And Assign the value "<network>" to the variable "network"
        And Assign the value "<bankCode>" to the variable "bankCode"
        And Assign the value "<accountType>" to the variable "accountType"
        And Execute the POST method on the endpoint "/v2/withdraws"
        Then Obtain a response 201

        When The urlBase is available "https://sandbox.manteca.dev/crypto"
        And Wait for the processing of the "orden" por 5 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED for fiat withdraw
        And validate aggregator propierties

        #ARS Withdraw must be consume for WALLET_ARG
        #USD Withdraw must be consume for CRYPTO_ARG
        Examples:
            | companyId                | sessionId                | userAnyId | asset | address                | amount | bankCode | accountType | network       |
            | 69d80588cdd32301bed406ab | test-withdraw-aggregator | 100065187 | ARS   | 1430001713039384360017 | 1000   |          |             | BANK_TRANSFER |
            | 69d80588cdd32301bed406ab | test-withdraw-aggregator | 100065187 | USD   | 1430001713039384360017 | 1      |          |             | BANK_TRANSFER |


    @Smoke @Remesas @Automated
    Scenario Outline: Crear retiro fiat user por country por V2 "<asset>"
        Given Get credentials for company "<companyId>"
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
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Wait for the processing of the "orden" por 5 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED for fiat withdraw

        Examples:
            | companyId                | userAnyId | asset | address                | amount | bankCode | accountType | senderExchange | senderLegalId | senderName | senderSurname | recipientExchange | recipientLegalId   | recipientName | recipientSurname  |
            | 6864976a08430ed74bf61d0c | 100009873 | ARS   | 1430001713039384360017 | 10000  |          |             | VIETNAM        | 1512121354    | Phong Cao  | Nguyen        | ARGENTINA         | 20344554332        | Lucas         | Segura            |
            | 6864976a08430ed74bf61d0c | 100009874 | BRL   | 02103213262            | 100    |          |             | VIETNAM        | 1512121354    | Phong Cao  | Nguyen        | BRAZIL            | 62757666380        | Lucas         | Helano De Freitas |
            | 6864976a08430ed74bf61d0c | 100009875 | CLP   | 13033517               | 10000  | 317      | RUT         | VIETNAM        | 1512121354    | Phong Cao  | Nguyen        | CHILE             | 189274130          | Maricela      | Castro            |
            | 6864976a08430ed74bf61d0c | 100009876 | COP   | 3172655787             | 1000   | 1507     | SAVINGS     | VIETNAM        | 1512121354    | Phong Cao  | Nguyen        | COLOMBIA          | 1073714929         | Juan Camilo   | Prieto            |
            | 6864976a08430ed74bf61d0c | 100009877 | MXN   | 4189143297879093       | 1000   | 002      | DEBIT       | VIETNAM        | 1512121354    | Phong Cao  | Nguyen        | MEXICO            | lorp000601hdfpmba6 | Pablo Agustin | Lopez Roman       |
            | 6864976a08430ed74bf61d0c | 100009878 | PUSD  | 117353318              | 1000   | 0026     | CHECKING    | VIETNAM        | 1512121354    | Phong Cao  | Nguyen        | PANAMA            | 17601100           | Jhonnyel      | Yosimar           |
            | 6864976a08430ed74bf61d0c | 100009879 | GTQ   | 32992083658602         | 1000   | 016      | CHECKING    | VIETNAM        | 1512121354    | Phong Cao  | Nguyen        | GUATEMALA         | 2573057420101      | Mónica        | Michelle          |
            | 6864976a08430ed74bf61d0c | 100009881 | CRC   | CR14010200009650656758 | 1000   | 0102     | CHECKING    | VIETNAM        | 1512121354    | Phong Cao  | Nguyen        | COSTA_RICA        | 116800458          | Gloriana      | Aguilar           |
            | 6864976a08430ed74bf61d0c | 100067267 | PYG   | 111121996495           | 1000   | 003      | SAVINGS     | VIETNAM        | 1512121354    | Phong Cao  | Nguyen        | PARAGUAY          | 116800458          | Gloriana      | Aguilar           |

    @Smoke @Remesas @Aggregator @Automated
    Scenario Outline: Crear retiro fiat user por country por V2 "<asset>" con aggregator
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
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

        When Wait for the processing of the "orden" por 5 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED for fiat withdraw
        And validate aggregator propierties

        #ARS Withdraw must be consume for WALLET_ARG
        Examples:
            | companyId                | userAnyId | asset | address                | amount | bankCode | accountType | senderExchange | senderLegalId | senderName | senderSurname | recipientExchange | recipientLegalId | recipientName | recipientSurname |
            | 69d80588cdd32301bed406ab | 100065187 | ARS   | 1430001713039384360017 | 1000   |          |             | ARGENTINA      | 20293755311   | CESAR      | MANRIQUE      | ARGENTINA         | 20344554332      | Lucas         | Segura           |
            | 69d80588cdd32301bed406ab | 100065187 | ARS   | 1430001713039384360017 | 1000   |          |             | BRAZIL         | 64406822100   | ALTINA     | DOS REIS      | ARGENTINA         | 20344554332      | Lucas         | Segura           |

    @Regression @Fiat @pendingAdmin
    Scenario Outline: Crear retiro fiat user por country por V2 ADMIN_PENDING "<asset>"
        Given Get credentials for company "<companyId>"
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
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Wait for the processing of the "orden" por 2 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED for fiat withdraw

        Examples:
            | companyId                | userAnyId | asset | address                | amount   | bankCode  | accountType |
            | 6864976a08430ed74bf61d0c | 100009881 | CRC   | CR14010200009650656758 | 10000000 | 0102      | SAVINGS     |
            | 6864976a08430ed74bf61d0c | 100009874 | BRL   | 02103213262            | 500000   |           |             |
            | 6864976a08430ed74bf61d0c | 100009875 | CLP   | 13033517               | 1000000  | 317       | RUT         |
            | 6864976a08430ed74bf61d0c | 100009876 | COP   | 00870206780            | 1000000  | 1507      | PHONE       |
            | 6864976a08430ed74bf61d0c | 100009879 | GTQ   | 32992083658602         | 10000000 | 049       | SAVINGS     |
            | 6864976a08430ed74bf61d0c | 100009877 | MXN   | 4189143297879093       | 1000000  | 002       | DEBIT       |
            | 6864976a08430ed74bf61d0c | 100009880 | PHP   | 09931984160            | 10000000 | shopeepay | SAVINGS     |
            | 6864976a08430ed74bf61d0c | 100009878 | PUSD  | 117353318              | 10000000 | 0026      | SAVINGS     |
            | 6864976a08430ed74bf61d0c | 100009873 | USD   | 1430001714039384360025 | 10       |           |             |
            | 6864976a08430ed74bf61d0c | 100009873 | ARS   | 1430001713039384360017 | 12000000 |           |             |
            | 6864976a08430ed74bf61d0c | 100009991 | ARS   | 1430001713039384360017 | 12000000 |           |             |

    @Regression @Fiat @coinag @Takenos
    Scenario Outline: Crear retiro fiat user por country por V2 ADMIN_PENDING TAKENOS
        Given Get credentials for company "64384a51425c3800077683da"
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
        Given Get credentials for company "64384a51425c3800077683da"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Wait for the processing of the "orden" por 2 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED for fiat withdraw

        Examples:
            | userAnyId | asset | address                | amount    | bankCode | accountType |
            | 100009991 | ARS   | 1430001713039384360017 | 120000000 |          |             |

    @Regression @Fiat @coinag @others
    Scenario Outline: Crear retiro fiat user por country por V2 ADMIN_PENDING WALLBIT
        Given Get credentials for company "647a31b320bd80000770e8ed"
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
        Given Get credentials for company "647a31b320bd80000770e8ed"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Wait for the processing of the "orden" por 2 seconds
        And Execute the GET method on the endpoint "/v2/withdraws/{withdrawAnyId}"
        Then Obtain a response 200 and status EXECUTED for fiat withdraw

        Examples:
            | userAnyId | asset | address                | amount   | bankCode | accountType |
            | 100009997 | ARS   | 1430001713039384360017 | 12000000 |          |             |
