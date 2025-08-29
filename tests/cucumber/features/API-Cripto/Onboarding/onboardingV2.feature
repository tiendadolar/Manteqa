@OnboardingV2
Feature: Onboarding User - V2

    # Background:
    #     Given The API key is available "B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV"
    #     And The urlBase is available "https://sandbox.manteca.dev/crypto/v2"

    @test
    Scenario: Onboarding inicial de usuario
        Given The API key is available "M6WGHFR-DG24ABS-JDTGGRF-F3YJCW2"
        And The urlBase is available "https://api.manteca.dev/crypto"
        When Assign the value "<externalId>" to the variable "externalId"
        And Assign the value "<email>" to the variable "email"
        And Assign the value "<legalId>" to the variable "legalId"
        And Assign the value "<exchange>" to the variable "exchange"
        And Assign the value "<name>" to the variable "name"
        And Assign the value "<surname>" to the variable "surname"
        And Assign the value "<sex>" to the variable "sex"
        And Assign the value "<work>" to the variable "work"
        And Assign the value "<birthDate>" to the variable "birthDate"
        And Assign the value "<maritalStatus>" to the variable "maritalStatus"
        And Assign the value "<isPep>" to the variable "isPep"
        And Assign the value "<isFep>" to the variable "isFep"
        And Assign the value "<isFatca>" to the variable "isFatca"
        And Assign the value "<phoneNumber>" to the variable "phoneNumber"
        And Assign the value "<nationality>" to the variable "nationality"
        And Assign the value "<street>" to the variable "street"
        And Assign the value "<ARScbu>" to the variable "ARScbu"
        And Assign the value "<ARScurrency>" to the variable "ARScurrency"
        And Assign the value "<ARSdescription>" to the variable "ARSdescription"
        And Assign the value "<USDcbu>" to the variable "USDcbu"
        And Assign the value "<USDcurrency>" to the variable "USDcurrency"
        And Assign the value "<USDdescription>" to the variable "USDdescription"
        And Execute the POST method on the endpoint "/v2/onboarding-actions/initial"
        Then Obtain a response 201

        Examples:
            | externalId | email               | legalId     | exchange | name       | surname           | sex | work     | birthDate  | maritalStatus | isPep | isFep | isFatca | phoneNumber | nationality | street               | ARScbu       | ARScurrency | ARSdescription | USDcbu                 | USDcurrency | USDdescription |
            | brlatest1  | brlatest1@gmail.com | 43813879100 | BRAZIL   | DENIO LUIZ | FERNANDES CAIXETA | M   | empleado | 1970-12-12 | Soltero       | false | false | false   | 112400135   | Brasil      | SAMUEL PIRES DE MELO | 777921280526 | ARS         | HSBC           | 0000003100000341514293 | USD         | CHASE          |
    # | TestOnboardingV2test-005@yopmail.com | 164408116 | CHILE     | PAOLA | BARRIOS | M   | CULTIVO DE ARROZ | 1999-05-15 | Soltero       | false | false | false   | 1124001128  | Chile       | Cochabamba | 21939624     | ARS         | HSBC           |                        |             |                |


    @test
    Scenario: Obtener S3 url para carga de DNI FRONT
        Given The API key is available "M6WGHFR-DG24ABS-JDTGGRF-F3YJCW2"
        And The urlBase is available "https://api.manteca.dev/crypto"
        When Assign the value "userAnyId" to the variable "userAnyId"
        And Assign the value "FRONT" to the variable "side"
        And Assign the value "dni-front.jpg" to the variable "fileName"
        And Execute the POST method on the endpoint "/v2/onboarding-actions/upload-identity-image"
        Then Obtain a response 200

    @test
    Scenario: Subir DNI FRONT
        When Execute the PUT method on the endpoint
        Then Obtain a response 200

    @test
    Scenario: Obtener S3 url para carga de DNI BACK
        Given The API key is available "M6WGHFR-DG24ABS-JDTGGRF-F3YJCW2"
        And The urlBase is available "https://api.manteca.dev/crypto"
        When Assign the value "userAnyId" to the variable "userAnyId"
        And Assign the value "BACK" to the variable "side"
        And Assign the value "dni-back.jpg" to the variable "fileName"
        And Execute the POST method on the endpoint "/v2/onboarding-actions/upload-identity-image"
        Then Obtain a response 200

    @test
    Scenario: Subir DNI BACK
        When Execute the PUT method on the endpoint
        Then Obtain a response 200

    @test
    Scenario: Obtener S3 url para carga de selfie
        Given The API key is available "M6WGHFR-DG24ABS-JDTGGRF-F3YJCW2"
        And The urlBase is available "https://api.manteca.dev/crypto"
        When Assign the value "userAnyId" to the variable "userAnyId"
        And Assign the value "selfie.jpg" to the variable "fileName"
        And Execute the POST method on the endpoint "/v2/onboarding-actions/upload-selfie-image"
        Then Obtain a response 200

    @test
    Scenario: Subir imagen selfie
        When Execute the PUT method on the endpoint
        Then Obtain a response 200

    @OnbV2Smoke
    Scenario Outline: Onboarding de un usuario de "<nationality>" mediante API V2
        Given The API key is available "NQ6PJXJ-40VMYVK-NFXSKXG-RC7NDWF"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<email>" to the variable "email"
        And Assign the value "<legalId>" to the variable "legalId"
        And Assign the value "<exchange>" to the variable "exchange"
        And Assign the value "<name>" to the variable "name"
        And Assign the value "<surname>" to the variable "surname"
        And Assign the value "<sex>" to the variable "sex"
        And Assign the value "<work>" to the variable "work"
        And Assign the value "<birthDate>" to the variable "birthDate"
        And Assign the value "<maritalStatus>" to the variable "maritalStatus"
        And Assign the value "<isPep>" to the variable "isPep"
        And Assign the value "<isFep>" to the variable "isFep"
        And Assign the value "<isFatca>" to the variable "isFatca"
        And Assign the value "<phoneNumber>" to the variable "phoneNumber"
        And Assign the value "<nationality>" to the variable "nationality"
        And Assign the value "<street>" to the variable "street"
        And Assign the value "<ARScbu>" to the variable "ARScbu"
        And Assign the value "<ARScurrency>" to the variable "ARScurrency"
        And Assign the value "<ARSdescription>" to the variable "ARSdescription"
        And Assign the value "<bankCode>" to the variable "bankCode"
        And Assign the value "<accountType>" to the variable "accountType"
        And Assign the value "<USDcbu>" to the variable "USDcbu"
        And Assign the value "<USDcurrency>" to the variable "USDcurrency"
        And Assign the value "<USDdescription>" to the variable "USDdescription"
        And Execute the POST method on the endpoint "/v2/onboarding-actions/initial"
        Then Obtain a response 201

        When Assign the value "userAnyId" to the variable "userAnyId"
        And Assign the value "FRONT" to the variable "side"
        And Assign the value "dni-front.jpg" to the variable "fileName"
        And Execute the POST method on the endpoint "/v2/onboarding-actions/upload-identity-image"
        Then Obtain a response 200

        When Execute the PUT method on the endpoint
        Then Obtain a response 200

        When Assign the value "userAnyId" to the variable "userAnyId"
        And Assign the value "BACK" to the variable "side"
        And Assign the value "dni-back.jpg" to the variable "fileName"
        And Execute the POST method on the endpoint "/v2/onboarding-actions/upload-identity-image"
        Then Obtain a response 200

        When Execute the PUT method on the endpoint
        Then Obtain a response 200

        When Assign the value "userAnyId" to the variable "userAnyId"
        And Assign the value "selfie.jpg" to the variable "fileName"
        And Execute the POST method on the endpoint "/v2/onboarding-actions/upload-selfie-image"
        Then Obtain a response 200

        When Execute the PUT method on the endpoint
        Then Obtain a response 200

        Examples:
            | email                                | legalId  | exchange | name | surname    | sex | work             | birthDate  | maritalStatus | isPep | isFep | isFatca | phoneNumber | street         | nationality | ARScbu        | ARScurrency | ARSdescription | USDcbu                 | USDcurrency | USDdescription | bankCode | accountType |
            # | TestOnboardingV2arg-001@yopmail.com  | 27225605144        | ARGENTINA   | TEST | AUTOMATION | M   | CULTIVO DE ARROZ | 1999-05-15 | Soltero       | false | false | false   | 1124001115  | Av. Libertador | Argentina   | 0000003100086679972343 | ARS         | HSBC           | 0000003100000341514293 | USD         | CHASE          |           |             |
            # | TestOnboardingV2c-001@yopmail.com    | 46625832847        | BRAZIL      | TEST | AUTOMATION | M   | CULTIVO DE ARROZ | 1999-05-15 | Soltero       | false | false | false   | 1124001116  | Av. Libertador | Brasil      | 05671773350            | BRL         | HSBC           | 07338896895            | BRL         | CHASE          |           |             |
            # # | TestOnboardingV2b-032@yopmail.com   | 05671773350        | BRAZIL      | TEST | AUTOMATION | M   | CULTIVO DE ARROZ | 1999-05-15 | Soltero       | false | false | false   | 1124001116  | Av. Libertador | Brasil      | TestOnboardingV2b-032@yopmail.com    | BRL         | HSBC           | 0000003100000341514293 | BRL         | CHASE          |           |             |
            # # | TestOnboardingV2b-033@yopmail.com   | 14085386875        | BRAZIL      | TEST | AUTOMATION | M   | CULTIVO DE ARROZ | 1999-05-15 | Soltero       | false | false | false   | 1124001116  | Av. Libertador | Brasil      | 5522978963214                        | BRL         | HSBC           | 0000003100000341514293 | BRL         | CHASE          |           |             |
            # # | TestOnboardingV2b-034@yopmail.com   | 37753057855        | BRAZIL      | TEST | AUTOMATION | M   | CULTIVO DE ARROZ | 1999-05-15 | Soltero       | false | false | false   | 1124001116  | Av. Libertador | Brasil      | 3f6d0eeb-9837-493a-8f02-b0d1cbb5e5f4 | BRL         | HSBC           | 0000003100000341514293 | BRL         | CHASE          |           |             |
            # | TestOnboardingV2chic-001@yopmail.com | 214918021          | CHILE       | TEST | AUTOMATION | M   | CULTIVO DE ARROZ | 1999-05-15 | Soltero       | false | false | false   | 1124001116  | Av. Libertador | Chile       | 164408116              | CLP         | HSBC           |                        |             |                | 317       | RUT         |
            # # | TestOnboardingV2chi-032@yopmail.com | 193774601          | CHILE       | TEST | AUTOMATION | M   | CULTIVO DE ARROZ | 1999-05-15 | Soltero       | false | false | false   | 1124001116  | Av. Libertador | Chile       | 19377460                             | CLP         | HSBC           | 0000003100000341514293 | CLP         | CHASE          | 323       | RUT         |
            # # | TestOnboardingV2chi-033@yopmail.com | 130888550          | CHILE       | TEST | AUTOMATION | M   | CULTIVO DE ARROZ | 1999-05-15 | Soltero       | false | false | false   | 1124001116  | Av. Libertador | Chile       | 13088855                             | CLP         | HSBC           | 0000003100000341514293 | CLP         | CHASE          | 318       | RUT         |
            #         | TestOnboardingV2colc-002@yopmail.com | 1018479359 | COLOMBIA | TEST | AUTOMATION | M   | CULTIVO DE ARROZ | 1999-05-15 | Soltero       | false | false | false   | 1124001116  | Av. Libertador | Colombia    | 3004442949 | COP         | HSBC           | 0000003100000341514293 | COP         | CHASE          | 1507     | PHONE       |
            # # | TestOnboardingV2c-032@yopmail.com   | 1012352927         | COLOMBIA    | TEST | AUTOMATION | M   | CULTIVO DE ARROZ | 1999-05-15 | Soltero       | false | false | false   | 1124001116  | Av. Libertador | Colombia    | 03206981788                          | COP         | HSBC           | 0000003100000341514293 | COP         | CHASE          | 1007      | CHECKING    |
            # # | TestOnboardingV2c-033@yopmail.com   | 1046340371         | COLOMBIA    | TEST | AUTOMATION | M   | CULTIVO DE ARROZ | 1999-05-15 | Soltero       | false | false | false   | 1124001116  | Av. Libertador | Colombia    | 3013203754                           | COP         | HSBC           | 0000003100000341514293 | COP         | CHASE          | 1007      | SAVINGS     |
            # | TestOnboardingV2crc-001@yopmail.com  | 701370085          | COSTA_RICA  | TEST | AUTOMATION | M   | CULTIVO DE ARROZ | 1999-05-15 | Soltero       | false | false | false   | 1124001116  | Av. Libertador | Costa Rica  | CR18010402840511853818 | CRC         | HSBC           | 0000003100000341514293 | CRC         | CHASE          | 102       | CHECKING    |
            # # | TestOnboardingV2cr-032@yopmail.com  | 503850450          | COSTA_RICA  | TEST | AUTOMATION | M   | CULTIVO DE ARROZ | 1999-05-15 | Soltero       | false | false | false   | 1124001116  | Av. Libertador | Costa Rica  | CR43015120820012587874               | CRC         | HSBC           | 0000003100000341514293 | CRC         | CHASE          | 120       | CHECKING    |
            # # | TestOnboardingV2cr-033@yopmail.com  | 112400167533       | COSTA_RICA  | TEST | AUTOMATION | M   | CULTIVO DE ARROZ | 1999-05-15 | Soltero       | false | false | false   | 1124001116  | Av. Libertador | Costa Rica  | CR68010200009182613229               | CRC         | HSBC           | 0000003100000341514293 | CRC         | CHASE          | 152       | PHONE       |
            # | TestOnboardingV2guac-001@yopmail.com | 2617555360116      | GUATEMALA   | TEST | AUTOMATION | M   | CULTIVO DE ARROZ | 1999-05-15 | Soltero       | false | false | false   | 1124001116  | Av. Libertador | Guatemala   | 4739056173             | GTQ         | HSBC           | 0000003100000341514293 | GTQ         | CHASE          | 001       | SAVINGS     |
            # # | TestOnboardingV2gua-032@yopmail.com | 2387558511221      | GUATEMALA   | TEST | AUTOMATION | M   | CULTIVO DE ARROZ | 1999-05-15 | Soltero       | false | false | false   | 1124001116  | Av. Libertador | Guatemala   | 02995010406234                       | GTQ         | HSBC           | 0000003100000341514293 | GTQ         | CHASE          | 016       | CHECKING    |
            # # | TestOnboardingV2gua-033@yopmail.com | 3710425930101      | GUATEMALA   | TEST | AUTOMATION | M   | CULTIVO DE ARROZ | 1999-05-15 | Soltero       | false | false | false   | 1124001116  | Av. Libertador | Guatemala   | 5010406234                           | GTQ         | HSBC           | 0000003100000341514293 | GTQ         | CHASE          | 016       | CHECKING    |
            # | TestOnboardingV2mexc-001@yopmail.com | aafl881004mdfllr01 | MEXICO      | TEST | AUTOMATION | M   | CULTIVO DE ARROZ | 1999-05-15 | Soltero       | false | false | false   | 1124001116  | Av. Libertador | México      | 4741745703581930       | MXN         | HSBC           | 0000003100000341514293 | MXN         | CHASE          | 610       | DEBIT       |
            # # | TestOnboardingV2mex-031@yopmail.com | paae860828hdflvr08 | MEXICO      | TEST | AUTOMATION | M   | CULTIVO DE ARROZ | 1999-05-15 | Soltero       | false | false | false   | 1124001116  | Av. Libertador | México      | 5703581930                           | MXN         | HSBC           | 0000003100000341514293 | MXN         | CHASE          | 614       | PHONE       |
            # # | TestOnboardingV2mex-032@yopmail.com | namg880219mmcvrd02 | MEXICO      | TEST | AUTOMATION | M   | CULTIVO DE ARROZ | 1999-05-15 | Soltero       | false | false | false   | 1124001116  | Av. Libertador | México      | 638180010183866948                   | MXN         | HSBC           | 0000003100000341514293 | MXN         | CHASE          | 615       | SAVINGS     |
            | TestOnboardingV2panc-002@yopmail.com | 88351072 | PANAMA   | TEST | AUTOMATION | M   | CULTIVO DE ARROZ | 1999-05-15 | Soltero       | false | false | false   | 1124001116  | Av. Libertador | Panamá      | 0472962071284 | PUSD        | HSBC           | 0000003100000341514293 | PUSD        | CHASE          | 0013     | CHECKING    |
    # # | TestOnboardingV2pan-032@yopmail.com | 8222955            | PANAMA      | TEST | AUTOMATION | M   | CULTIVO DE ARROZ | 1999-05-15 | Soltero       | false | false | false   | 1124001116  | Av. Libertador | Panamá      | 0472018417970                        | PUSD        | HSBC           | 0000003100000341514293 | PUSD        | CHASE          | 0013      | SAVINGS     |
    # | TestOnboardingV2phic-001@yopmail.com | 2193480756459814   | PHILIPPINES | TEST | AUTOMATION | M   | CULTIVO DE ARROZ | 1999-05-15 | Soltero       | false | false | false   | 1124001116  | Av. Libertador | Filipinas   | 09694243149            | PHP         | HSBC           | 0000003100000341514293 | PHP         | CHASE          | shopeepay | SAVINGS     |




    # Validar en DB, para realizar nuevamente el test eliminar bankAccounts en DB
    # No tocar datos de userAnyId, en caso de reutilizar elimnar datos de banking en DB. Maximo 15 banks por user
    #* Para volver a realizar test se debe limpiar el bankAddress de la DB de casa user
    @testBankingCHL
    Scenario: Agregar cuenta bancaria a usuario de "<country>"
        Given The API key is available "B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<address>" to the variable "address"
        And Assign the value "<currency>" to the variable "currency"
        And Assign the value "<description>" to the variable "description"
        And Assign the value "<bankCode>" to the variable "bankCode"
        And Assign the value "<accountType>" to the variable "accountType"
        And Execute the POST method on the endpoint "/v2/onboarding-actions/add-bank-account"
        Then Obtain a response 204
        And Wait for the processing of the "DB" por 3 seconds

        Examples:
            | country | userAnyId | address     | currency | description | bankCode | accountType |
            | Chile   | 100009266 | 01710280807 | CLP      | HSBC        | 317      | RUT         |
            | Chile   | 100009266 | 01710280817 | CLP      | CHASE       | 323      | CHECKING    |
            | Chile   | 100009266 | 01710280818 | CLP      | CHASE       | 323      | SAVINGS     |
            | Chile   | 100009266 | 01710280827 | CLP      | BANCO       | 318      | CHECKING    |
            | Chile   | 100009266 | 01710280828 | CLP      | BANCO       | 318      | SAVINGS     |
            | Chile   | 100009266 | 01710280837 | CLP      | HSBC        | 314      | SAVINGS     |
            | Chile   | 100009266 | 01710280838 | CLP      | HSBC        | 314      | CHECKING    |
            | Chile   | 100009266 | 01710280847 | CLP      | CHASE       | 962      | CHECKING    |
            | Chile   | 100009266 | 01710280848 | CLP      | CHASE       | 962      | SAVINGS     |
            | Chile   | 100009266 | 01710280857 | CLP      | BANCO       | 310      | SAVINGS     |
            | Chile   | 100009266 | 01710280858 | CLP      | BANCO       | 310      | CHECKING    |
            | Chile   | 100009266 | 01710280867 | CLP      | HSBC        | 976      | SAVINGS     |
            | Chile   | 100009266 | 01710280868 | CLP      | HSBC        | 976      | CHECKING    |
            | Chile   | 100009266 | 01710280877 | CLP      | CHASE       | 325      | CHECKING    |
            | Chile   | 100009266 | 01710280878 | CLP      | CHASE       | 325      | SAVINGS     |
            | Chile   | 100009511 | 01710280887 | CLP      | BANCO       | 309      | CHECKING    |
            | Chile   | 100009511 | 01710280888 | CLP      | BANCO       | 309      | SAVINGS     |
            | Chile   | 100009511 | 01710280897 | CLP      | HSBC        | 322      | SAVINGS     |
            | Chile   | 100009511 | 01710280898 | CLP      | HSBC        | 322      | CHECKING    |
            | Chile   | 100009511 | 01710280903 | CLP      | CHASE       | 959      | CHECKING    |
            | Chile   | 100009511 | 01710280904 | CLP      | CHASE       | 959      | SAVINGS     |
            | Chile   | 100009511 | 01710280917 | CLP      | BANCO       | 319      | SAVINGS     |
            | Chile   | 100009511 | 01710280918 | CLP      | BANCO       | 319      | CHECKING    |
            | Chile   | 100009511 | 01710280927 | CLP      | CHASE       | 315      | SAVINGS     |
            | Chile   | 100009511 | 01710280928 | CLP      | CHASE       | 315      | CHECKING    |
            | Chile   | 100009511 | 01710280937 | CLP      | BANCO       | 312      | CHECKING    |
            | Chile   | 100009511 | 01710280938 | CLP      | BANCO       | 312      | SAVINGS     |
            | Chile   | 100009511 | 01710280937 | CLP      | BANCO       | 321      | CHECKING    |
            | Chile   | 100009511 | 01710280138 | CLP      | BANCO       | 321      | SAVINGS     |
            | Chile   | 100009511 | 01710280133 | CLP      | BANCO       | 960      | CHECKING    |
            | Chile   | 100009512 | 01710280134 | CLP      | BANCO       | 960      | SAVINGS     |
            | Chile   | 100009512 | 01710280141 | CLP      | BANCO       | 324      | CHECKING    |
            | Chile   | 100009512 | 01710280142 | CLP      | BANCO       | 324      | SAVINGS     |
            | Chile   | 100009512 | 01710280143 | CLP      | BANCO       | 961      | CHECKING    |
            | Chile   | 100009512 | 01710280144 | CLP      | BANCO       | 961      | SAVINGS     |
            | Chile   | 100009512 | 01710280145 | CLP      | BANCO       | 980      | CHECKING    |
            | Chile   | 100009512 | 01710280146 | CLP      | BANCO       | 980      | SAVINGS     |
            | Chile   | 100009512 | 01710280151 | CLP      | BANCO       | 308      | CHECKING    |
            | Chile   | 100009512 | 01710280152 | CLP      | BANCO       | 308      | SAVINGS     |
            | Chile   | 100009512 | 01710280153 | CLP      | BANCO       | 311      | CHECKING    |
            | Chile   | 100009512 | 01710280154 | CLP      | BANCO       | 311      | SAVINGS     |

    @testBankingPAN
    Scenario: Agregar cuenta bancaria a usuario de "<country>"
        Given The API key is available "B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<address>" to the variable "address"
        And Assign the value "<currency>" to the variable "currency"
        And Assign the value "<description>" to the variable "description"
        And Assign the value "<bankCode>" to the variable "bankCode"
        And Assign the value "<accountType>" to the variable "accountType"
        And Execute the POST method on the endpoint "/v2/onboarding-actions/add-bank-account"
        Then Obtain a response 204
        And Wait for the processing of the "DB" por 3 seconds

        Examples:
            | country | userAnyId | address       | currency | description | bankCode | accountType |
            | Panama  | 100009521 | 0472018417951 | PUSD     | HSBC        | 0013     | CHECKING    |
            | Panama  | 100009521 | 0472018417970 | PUSD     | HSBC        | 0013     | SAVINGS     |
            | Panama  | 100009521 | 0472018417971 | PUSD     | CHASE       | 0026     | CHECKING    |
            | Panama  | 100009521 | 0472018417972 | PUSD     | CHASE       | 0026     | SAVINGS     |
            | Panama  | 100009521 | 0472018417973 | PUSD     | BANCO       | 0039     | CHECKING    |
            | Panama  | 100009521 | 0472018417974 | PUSD     | BANCO       | 0039     | SAVINGS     |
            | Panama  | 100009521 | 0472018417975 | PUSD     | HSBC        | 0071     | SAVINGS     |
            | Panama  | 100009521 | 0472018417976 | PUSD     | HSBC        | 0071     | CHECKING    |
            | Panama  | 100009521 | 0472018417977 | PUSD     | CHASE       | 0181     | CHECKING    |
            | Panama  | 100009521 | 0472018417978 | PUSD     | CHASE       | 0181     | SAVINGS     |
            | Panama  | 100009521 | 0472018417979 | PUSD     | BANCO       | 0372     | SAVINGS     |
            | Panama  | 100009521 | 0472018417980 | PUSD     | BANCO       | 0372     | CHECKING    |
            | Panama  | 100009521 | 0472018417981 | PUSD     | HSBC        | 0408     | SAVINGS     |
            | Panama  | 100009521 | 0472018417982 | PUSD     | HSBC        | 0408     | CHECKING    |
            | Panama  | 100009521 | 0472018417983 | PUSD     | CHASE       | 0424     | CHECKING    |
            | Panama  | 100009522 | 0472018417984 | PUSD     | CHASE       | 0424     | SAVINGS     |
            | Panama  | 100009522 | 0472018417985 | PUSD     | BANCO       | 0518     | CHECKING    |
            | Panama  | 100009522 | 0472018417986 | PUSD     | BANCO       | 0518     | SAVINGS     |
            | Panama  | 100009522 | 0472018417987 | PUSD     | HSBC        | 0712     | SAVINGS     |
            | Panama  | 100009522 | 0472018417988 | PUSD     | HSBC        | 0712     | CHECKING    |
            | Panama  | 100009522 | 0472018417989 | PUSD     | CHASE       | 0767     | CHECKING    |
            | Panama  | 100009522 | 0472018417990 | PUSD     | CHASE       | 0767     | SAVINGS     |
            | Panama  | 100009522 | 0472018417991 | PUSD     | BANCO       | 0770     | SAVINGS     |
            | Panama  | 100009522 | 0472018417992 | PUSD     | BANCO       | 0770     | CHECKING    |
            | Panama  | 100009522 | 0472018417993 | PUSD     | CHASE       | 0916     | SAVINGS     |
            | Panama  | 100009522 | 0472018417954 | PUSD     | CHASE       | 0916     | CHECKING    |
            | Panama  | 100009522 | 0472018417995 | PUSD     | BANCO       | 1067     | CHECKING    |
            | Panama  | 100009522 | 0472018417996 | PUSD     | BANCO       | 1067     | SAVINGS     |
            | Panama  | 100009522 | 0472018417997 | PUSD     | BANCO       | 1083     | CHECKING    |
            | Panama  | 100009522 | 0472018417998 | PUSD     | BANCO       | 1083     | SAVINGS     |
            | Panama  | 100009523 | 0472018417999 | PUSD     | BANCO       | 1106     | CHECKING    |
            | Panama  | 100009523 | 0472018417960 | PUSD     | BANCO       | 1106     | SAVINGS     |
            | Panama  | 100009523 | 0472018417961 | PUSD     | BANCO       | 1151     | CHECKING    |
            | Panama  | 100009523 | 0472018417962 | PUSD     | BANCO       | 1151     | SAVINGS     |
            | Panama  | 100009523 | 0472018417963 | PUSD     | BANCO       | 1164     | CHECKING    |
            | Panama  | 100009523 | 0472018417964 | PUSD     | BANCO       | 1164     | SAVINGS     |
            | Panama  | 100009523 | 0472018417965 | PUSD     | BANCO       | 1258     | CHECKING    |
            | Panama  | 100009523 | 0472018417966 | PUSD     | BANCO       | 1258     | SAVINGS     |
            | Panama  | 100009523 | 0472018417967 | PUSD     | BANCO       | 1384     | CHECKING    |
            | Panama  | 100009523 | 0472018417968 | PUSD     | BANCO       | 1384     | SAVINGS     |
            | Panama  | 100009523 | 0472018417969 | PUSD     | BANCO       | 1397     | CHECKING    |
            | Panama  | 100009523 | 0472018417950 | PUSD     | BANCO       | 1397     | SAVINGS     |

    @testBankingCOL
    Scenario: Agregar cuenta bancaria a usuario de "<country>" con tipo de cuenta <accountType>
        Given The API key is available "B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<address>" to the variable "address"
        And Assign the value "<currency>" to the variable "currency"
        And Assign the value "<description>" to the variable "description"
        And Assign the value "<bankCode>" to the variable "bankCode"
        And Assign the value "<accountType>" to the variable "accountType"
        And Execute the POST method on the endpoint "/v2/onboarding-actions/add-bank-account"
        Then Obtain a response 204
        And Wait for the processing of the "DB" por 3 seconds

        Examples:
            | country  | userAnyId | address         | currency | description | bankCode | accountType |
            | Colombia | 100009524 | 3511234567      | COP      | HSBC        | 1507     | SAVINGS     |
            # | Colombia | 100009524 | 3009876543         | COP      | HSBC        | 1507     | SAVINGS     |
            | Colombia | 100009524 | 1234567890      | COP      | CHASE       | 1007     | CHECKING    |
            # | Colombia | 100009524 | 09876543210        | COP      | CHASE       | 1007     | SAVINGS     |
            # | Colombia | 100009524 | 12345678           | COP      | BANCO       | 1809     | CHECKING    |
            | Colombia | 100009524 | 1234567891      | COP      | BANCO       | 1809     | CHECKING    |
            | Colombia | 100009524 | 03012345678     | COP      | HSBC        | 1551     | SAVINGS     |
            # | Colombia | 100009524 | 3519876543         | COP      | HSBC        | 1551     | CHECKING    |
            # | Colombia | 100009524 | 8123456789012345   | COP      | CHASE       | 1051     | CHECKING    |
            | Colombia | 100009524 | 0123456789      | COP      | CHASE       | 1051     | SAVINGS     |
            | Colombia | 100009524 | 987654321       | COP      | BANCO       | 1001     | SAVINGS     |
            | Colombia | 100009524 | 987654587       | COP      | BANCO       | 1001     | CHECKING    |
            # | Colombia | 100009524 | 0472018417981      | COP      | HSBC        | 1032     | CHECKING    |
            | Colombia | 100009524 | 49999999999     | COP      | HSBC        | 1032     | CHECKING    |
            # | Colombia | 100009524 | 123456789012345678 | COP      | CHASE       | 1013     | CHECKING    |
            | Colombia | 100009524 | 12345678901234  | COP      | CHASE       | 1013     | SAVINGS     |
            # | Colombia | 100009525 | 467890123       | COP      | BANCO       | 1052     | CHECKING    |
            | Colombia | 100009524 | 987654323       | COP      | BANCO       | 1052     | SAVINGS     |
            # | Colombia | 100009525 | 1234937892      | COP      | HSBC        | 1801     | SAVINGS     |
            | Colombia | 100009524 | 1234467884      | COP      | HSBC        | 1801     | CHECKING    |
            # | Colombia | 100009525 | 1234567890      | COP      | CHASE       | 1804     | CHECKING    |
            | Colombia | 100009524 | 123456789012345 | COP      | CHASE       | 1804     | SAVINGS     |
            | Colombia | 100009524 | 1234567893      | COP      | BANCO       | 1019     | CHECKING    |
            # | Colombia | 100009525 | 2234567890      | COP      | BANCO       | 1019     | CHECKING    |
            | Colombia | 100009524 | 512345678901    | COP      | CHASE       | 1062     | SAVINGS     |
            # | Colombia | 100009525 | 512345678901    | COP      | CHASE       | 1062     | CHECKING    |
            | Colombia | 100009524 | 0472018417995   | COP      | BANCO       | 1070     | CHECKING    |
            | Colombia | 100009525 | 0472018417996   | COP      | BANCO       | 1070     | SAVINGS     |
            | Colombia | 100009525 | 1123456789012   | COP      | BANCO       | 1002     | CHECKING    |
            # | Colombia | 100009525 | 512345678901    | COP      | BANCO       | 1002     | SAVINGS     |
            | Colombia | 100009525 | 0472018417999   | COP      | BANCO       | 1292     | CHECKING    |
            | Colombia | 100009525 | 0472018417960   | COP      | BANCO       | 1292     | SAVINGS     |

    @testBankingGUA
    Scenario: Agregar cuenta bancaria a usuario de "<country>"
        Given The API key is available "B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<address>" to the variable "address"
        And Assign the value "<currency>" to the variable "currency"
        And Assign the value "<description>" to the variable "description"
        And Assign the value "<bankCode>" to the variable "bankCode"
        And Assign the value "<accountType>" to the variable "accountType"
        And Execute the POST method on the endpoint "/v2/onboarding-actions/add-bank-account"
        Then Obtain a response 204
        And Wait for the processing of the "DB" por 3 seconds

        Examples:
            | country   | userAnyId | address        | currency | description | bankCode | accountType |
            | Guatemala | 100009543 | 1234567        | GTQ      | HSBC        | 001      | CHECKING    |
            | Guatemala | 100009543 | 119876543210   | GTQ      | CHASE       | 004      | CHECKING    |
            | Guatemala | 100009543 | 021000000000   | GTQ      | CHASE       | 004      | SAVINGS     |
            | Guatemala | 100009543 | 5123456789     | GTQ      | BANCO       | 012      | CHECKING    |
            | Guatemala | 100009543 | 81234          | GTQ      | BANCO       | 012      | SAVINGS     |
            | Guatemala | 100009543 | 11234567890    | GTQ      | HSBC        | 013      | SAVINGS     |
            | Guatemala | 100009543 | 512345678901   | GTQ      | HSBC        | 013      | CHECKING    |
            | Guatemala | 100009543 | 1234581890     | GTQ      | CHASE       | 015      | CHECKING    |
            | Guatemala | 100009543 | 1274567        | GTQ      | CHASE       | 015      | SAVINGS     |
            | Guatemala | 100009543 | 0123456789012  | GTQ      | BANCO       | 016      | SAVINGS     |
            | Guatemala | 100009543 | 3123456789     | GTQ      | BANCO       | 016      | CHECKING    |
            | Guatemala | 100009543 | 1239461890     | GTQ      | HSBC        | 019      | SAVINGS     |
            | Guatemala | 100009543 | 1211281890     | GTQ      | HSBC        | 019      | CHECKING    |
            | Guatemala | 100009543 | 0001288567     | GTQ      | CHASE       | 030      | CHECKING    |
            | Guatemala | 100009543 | 987657851098   | GTQ      | BANCO       | 036      | CHECKING    |
            | Guatemala | 100009544 | 987654321115   | GTQ      | BANCO       | 036      | SAVINGS     |
            | Guatemala | 100009544 | 59876543211    | GTQ      | HSBC        | 039      | SAVINGS     |
            | Guatemala | 100009544 | 517345678      | GTQ      | HSBC        | 039      | CHECKING    |
            | Guatemala | 100009544 | 98765437879876 | GTQ      | CHASE       | 040      | CHECKING    |
            | Guatemala | 100009544 | 98114432109876 | GTQ      | CHASE       | 040      | SAVINGS     |
            | Guatemala | 100009544 | 4127173451589  | GTQ      | BANCO       | 041      | SAVINGS     |
            | Guatemala | 100009544 | 961234569      | GTQ      | CHASE       | 042      | SAVINGS     |
            | Guatemala | 100009544 | 00012345674    | GTQ      | CHASE       | 042      | CHECKING    |
            | Guatemala | 100009544 | 01234567810    | GTQ      | BANCO       | 044      | CHECKING    |
            | Guatemala | 100009544 | 01234567710    | GTQ      | BANCO       | 044      | SAVINGS     |
            | Guatemala | 100009544 | 12345678362    | GTQ      | BANCO       | 045      | CHECKING    |
            | Guatemala | 100009544 | 12345678315    | GTQ      | BANCO       | 045      | SAVINGS     |
            | Guatemala | 100009544 | 98765438909876 | GTQ      | BANCO       | 047      | CHECKING    |
            | Guatemala | 100009544 | 099999991799   | GTQ      | BANCO       | 048      | CHECKING    |
            | Guatemala | 100009544 | 099999915999   | GTQ      | BANCO       | 048      | SAVINGS     |

    @testBankingCTR
    Scenario: Agregar cuenta bancaria a usuario de "<country>"
        Given The API key is available "B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<address>" to the variable "address"
        And Assign the value "<currency>" to the variable "currency"
        And Assign the value "<description>" to the variable "description"
        And Assign the value "<bankCode>" to the variable "bankCode"
        And Assign the value "<accountType>" to the variable "accountType"
        And Execute the POST method on the endpoint "/v2/onboarding-actions/add-bank-account"
        Then Obtain a response 204
        And Wait for the processing of the "DB" por 3 seconds

        Examples:
            | country    | userAnyId | address                | currency | description | bankCode | accountType |
            | Costa Rica | 100009602 | CR1066456789123456789  | CRC      | HSBC        | 0102     | CHECKING    |
            | Costa Rica | 100009602 | CR8541567891234567145  | CRC      | HSBC        | 0102     | SAVINGS     |
            | Costa Rica | 100009602 | CR1252567891234561597  | CRC      | CHASE       | 0104     | CHECKING    |
            | Costa Rica | 100009602 | CR125456789123456885   | CRC      | CHASE       | 0104     | SAVINGS     |
            | Costa Rica | 100009602 | CR1234567891234566965  | CRC      | BANCO       | 0107     | CHECKING    |
            | Costa Rica | 100009602 | CR1234567157234566987  | CRC      | BANCO       | 0107     | SAVINGS     |
            | Costa Rica | 100009602 | CR1234567891234567635  | CRC      | HSBC        | 0114     | SAVINGS     |
            | Costa Rica | 100009602 | CR12345678912345677896 | CRC      | HSBC        | 0114     | CHECKING    |
            | Costa Rica | 100009602 | CR1234567891234545471  | CRC      | CHASE       | 0116     | CHECKING    |
            | Costa Rica | 100009602 | CR12345678912344546983 | CRC      | CHASE       | 0116     | SAVINGS     |
            | Costa Rica | 100009602 | CR123556789123456911   | CRC      | BANCO       | 0120     | SAVINGS     |
            | Costa Rica | 100009602 | CR1234458589123226711  | CRC      | BANCO       | 0120     | CHECKING    |
            | Costa Rica | 100009602 | CR12345678912345671123 | CRC      | HSBC        | 0123     | SAVINGS     |
            | Costa Rica | 100009602 | CR523456789123452259   | CRC      | HSBC        | 0123     | CHECKING    |
            | Costa Rica | 100009602 | CR122226789123456766   | CRC      | CHASE       | 0125     | CHECKING    |
            | Costa Rica | 100009603 | CR1234567891234447548  | CRC      | CHASE       | 0125     | SAVINGS     |
            | Costa Rica | 100009603 | CR123456789123456789   | CRC      | BANCO       | 0126     | CHECKING    |
            | Costa Rica | 100009603 | CR1234567895554561123  | CRC      | BANCO       | 0126     | SAVINGS     |
            | Costa Rica | 100009603 | CR1247567891234567788  | CRC      | HSBC        | 0127     | SAVINGS     |
            | Costa Rica | 100009603 | CR1774567891234564564  | CRC      | HSBC        | 0127     | CHECKING    |
            | Costa Rica | 100009603 | CR663456789123445789   | CRC      | CHASE       | 0151     | CHECKING    |
            | Costa Rica | 100009603 | CR1234567891232267366  | CRC      | CHASE       | 0151     | SAVINGS     |
            | Costa Rica | 100009603 | CR1215156789993456789  | CRC      | BANCO       | 0152     | SAVINGS     |
            | Costa Rica | 100009603 | CR1234567892224567151  | CRC      | BANCO       | 0152     | CHECKING    |
            | Costa Rica | 100009603 | CR9634567891234567966  | CRC      | CHASE       | 0161     | SAVINGS     |
            | Costa Rica | 100009603 | CR2234567891234567811  | CRC      | CHASE       | 0161     | CHECKING    |
            | Costa Rica | 100009603 | CR123456795123456755   | CRC      | BANCO       | 0162     | CHECKING    |
            | Costa Rica | 100009603 | CR1234777891234567999  | CRC      | BANCO       | 0162     | SAVINGS     |
            | Costa Rica | 100009603 | CR123452287123456744   | CRC      | BANCO       | 0231     | CHECKING    |
            | Costa Rica | 100009603 | CR12345674451236656789 | CRC      | BANCO       | 0231     | SAVINGS     |
            | Costa Rica | 100009604 | CR123456789123776789   | CRC      | BANCO       | 0312     | CHECKING    |
            | Costa Rica | 100009604 | CR123456789123451189   | CRC      | BANCO       | 0312     | SAVINGS     |

    @testBankingMXN
    Scenario: Agregar cuenta bancaria a usuario de "<country>"
        Given The API key is available "B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<address>" to the variable "address"
        And Assign the value "<currency>" to the variable "currency"
        And Assign the value "<description>" to the variable "description"
        And Assign the value "<bankCode>" to the variable "bankCode"
        And Assign the value "<accountType>" to the variable "accountType"
        And Execute the POST method on the endpoint "/v2/onboarding-actions/add-bank-account"
        Then Obtain a response 204
        And Wait for the processing of the "DB" por 3 seconds

        Examples:
            | country | userAnyId | address            | currency | description | bankCode | accountType |
            | Mexico  | 100009607 | 156356784125789654 | MXN      | HSBC        | 002      | CHECKING    |
            | Mexico  | 100009607 | 4342562861667390   | MXN      | HSBC        | 002      | DEBIT       |
            | Mexico  | 100009607 | 1563567841         | MXN      | CHASE       | 002      | PHONE       |
            | Mexico  | 100009607 | 124585858796321452 | MXN      | CHASE       | 006      | CHECKING    |
            | Mexico  | 100009607 | 4342562861667390   | MXN      | BANCO       | 006      | DEBIT       |
            | Mexico  | 100009607 | 1245858587         | MXN      | BANCO       | 006      | PHONE       |
            | Mexico  | 100009607 | 323245789654122125 | MXN      | HSBC        | 009      | CHECKING    |
            | Mexico  | 100009607 | 4342562861667390   | MXN      | HSBC        | 009      | DEBIT       |
            | Mexico  | 100009607 | 3232457896         | MXN      | CHASE       | 009      | SAVINGS     |
            | Mexico  | 100009607 | 856565322791366478 | MXN      | CHASE       | 012      | CHECKING    |
            | Mexico  | 100009607 | 4342562861667390   | MXN      | BANCO       | 012      | DEBIT       |
            | Mexico  | 100009607 | 8565653227         | MXN      | BANCO       | 012      | CHECKING    |
            | Mexico  | 100009607 | 968851447362144586 | MXN      | HSBC        | 014      | SAVINGS     |
            | Mexico  | 100009607 | 4342562861667390   | MXN      | HSBC        | 014      | DEBIT       |
            | Mexico  | 100009607 | 9688514415         | MXN      | CHASE       | 014      | SAVINGS     |
            | Mexico  | 100009608 | 669878485123659878 | MXN      | CHASE       | 019      | CHECKING    |
            | Mexico  | 100009608 | 4342562861667390   | MXN      | BANCO       | 019      | DEBIT       |
            | Mexico  | 100009608 | 6698784851         | MXN      | BANCO       | 019      | CHECKING    |
            | Mexico  | 100009608 | 599633214454612257 | MXN      | HSBC        | 021      | CHECKING    |
            | Mexico  | 100009608 | 4342562861667390   | MXN      | HSBC        | 021      | DEBIT       |
            | Mexico  | 100009608 | 5996332144         | MXN      | CHASE       | 021      | SAVINGS     |
            | Mexico  | 100009608 | 152248798866547891 | MXN      | CHASE       | 030      | CHECKING    |
            | Mexico  | 100009608 | 4342562861667390   | MXN      | BANCO       | 030      | DEBIT       |
            | Mexico  | 100009608 | 1522487988         | MXN      | BANCO       | 030      | CHECKING    |
            | Mexico  | 100009608 | 225578961977833259 | MXN      | CHASE       | 124      | CHECKING    |
            | Mexico  | 100009608 | 4342562861667390   | MXN      | CHASE       | 124      | DEBIT       |
            | Mexico  | 100009608 | 2255789619         | MXN      | BANCO       | 124      | SAVINGS     |
            | Mexico  | 100009608 | 996632647782201019 | MXN      | BANCO       | 126      | CHECKING    |
            | Mexico  | 100009608 | 4342562861667390   | MXN      | BANCO       | 126      | DEBIT       |
            | Mexico  | 100009608 | 9966326477         | MXN      | BANCO       | 126      | CHECKING    |

    # E2E
    @E2E
    Scenario: Onboarding inicial de usuario
        Given The API key is available "B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        And login user admin "<credential>"
        And Validate existing user '<legalId>'
        When Assign the value "<externalId>" to the variable "externalId"
        And Assign the value "<email>" to the variable "email"
        And Assign the value "<legalId>" to the variable "legalId"
        And Assign the value "<exchange>" to the variable "exchange"
        And Assign the value "<name>" to the variable "name"
        And Assign the value "<surname>" to the variable "surname"
        And Assign the value "<sex>" to the variable "sex"
        And Assign the value "<work>" to the variable "work"
        And Assign the value "<birthDate>" to the variable "birthDate"
        And Assign the value "<maritalStatus>" to the variable "maritalStatus"
        And Assign the value "<isPep>" to the variable "isPep"
        And Assign the value "<isFep>" to the variable "isFep"
        And Assign the value "<isFatca>" to the variable "isFatca"
        And Assign the value "<phoneNumber>" to the variable "phoneNumber"
        And Assign the value "<nationality>" to the variable "nationality"
        And Assign the value "<street>" to the variable "street"
        And Assign the value "<ARScbu>" to the variable "ARScbu"
        And Assign the value "<ARScurrency>" to the variable "ARScurrency"
        And Assign the value "<ARSdescription>" to the variable "ARSdescription"
        And Assign the value "<USDcbu>" to the variable "USDcbu"
        And Assign the value "<USDcurrency>" to the variable "USDcurrency"
        And Assign the value "<USDdescription>" to the variable "USDdescription"
        And Execute the POST method on the endpoint "/v2/onboarding-actions/initial"
        Then Obtain a response 201
        And Upload "FRONT ID" image
        And Upload "BACK ID" image
        And Upload "selfie" image

        # Do not change data
        Examples:
            | credential                | externalId | email            | legalId     | exchange  | name | surname | sex | work     | birthDate  | maritalStatus | isPep | isFep | isFatca | phoneNumber | nationality | street               | ARScbu       | ARScurrency | ARSdescription | USDcbu                 | USDcurrency | USDdescription |
            | andresperalta@manteca.dev | testOnbE2E | onbe2e@gmail.com | 23452216604 | ARGENTINA | Test | OnbE2E  | M   | empleado | 1999-05-15 | Soltero       | false | false | false   | 112400130   | Argentina   | SAMUEL PIRES DE MELO | 777921280526 | ARS         | HSBC           | 0000003100000341514293 | USD         | CHASE          |
