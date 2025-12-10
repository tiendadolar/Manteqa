@Integrations @OnboardingV2
Feature: Initial Onboarding Integrations

    Background:
        Given The urlBase is available "https://sandbox.manteca.dev/crypto"

    @HappyPath
    Scenario Outline: Validate Onboarding V2
        Given The API key is available "<apiKEY>"
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
        And Validate initial onboarding response attributes

        Examples:
            | apiKEY                          | credential                | externalId            | email                | legalId     | exchange  | name            | surname   | sex | work     | birthDate  | maritalStatus | isPep | isFep | isFatca | phoneNumber | nationality | street         |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | andresperalta@manteca.dev | Integrations-test-Arg | inttestarg@gmail.com | 27293948262 | ARGENTINA | LUCIANA CECILIA | GUGLIELMO | M   | empleado | 1999-05-15 | Soltero       | false | false | false   | 112400201   | Argentina   | Av. Corrientes |

    # ------------------------------- Error Path -------------------------------

    @ErrorPath
    Scenario Outline: Validate error initial onboarding sending <case> V2
        Given The API key is available "<apiKEY>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        And login user admin "<credential>"
        # And Validate existing user '<legalId>'
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
        Then Obtain a response <statusCode>
        And Validate response attributes with internalStatus: "<internalStatus>" and message: "<message>"

        Examples:
            | apiKEY                          | case                                          | credential                | externalId          | email                          | legalId     | exchange  | name   | surname  | sex | work     | birthDate  | maritalStatus | isPep | isFep | isFatca | phoneNumber | nationality | street               | statusCode | internalStatus    | message                              |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | used externalId                               | andresperalta@manteca.dev | externalIdRepeat    | inttestarg@gmail.com           | 27323361083 | ARGENTINA | MALENA | CANTEROS | M   | empleado | 1999-05-15 | Soltero       | false | false | false   | 112400201   | Argentina   | SAMUEL PIRES DE MELO | 409        | USER_EXISTS       | User already exists                  |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | used email                                    | andresperalta@manteca.dev | externalIdNotRepeat | boddeuquipure-8560@yopmail.com | 27323361083 | ARGENTINA | MALENA | CANTEROS | M   | empleado | 1999-05-15 | Soltero       | false | false | false   | 112400201   | Argentina   | SAMUEL PIRES DE MELO | 409        | USER_EXISTS_EMAIL | User with that email already exists. |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | used legalId (deberia ser code 409 i guess..) | andresperalta@manteca.dev | externalIdNotRepeat | boddeuquipure-8562@yopmail.com | 20357891079 | ARGENTINA | MALENA | CANTEROS | M   | empleado | 1999-05-15 | Soltero       | false | false | false   | 112400201   | Argentina   | SAMUEL PIRES DE MELO | 409        | USER_EXISTS       | User already exists.                 |


    @ErrorPath
    Scenario Outline: Validate error initial onboarding sending <case> V2
        Given The API key is available "<apiKEY>"
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
        Then Obtain a response <statusCode>
        And Validate response attributes with internalStatus: "<internalStatus>" and message: "<message>" and error: "<errors>"

        Examples:
            | apiKEY                          | case                    | credential                | externalId | email                | legalId     | exchange  | name   | surname  | sex | work     | birthDate  | maritalStatus | isPep | isFep | isFatca | phoneNumber | nationality | street               | statusCode | internalStatus | message      | errors                                                                                                                                                                         |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | numeric externalId      | andresperalta@manteca.dev |            | inttestarg@gmail.com | 27323361083 | ARGENTINA | MALENA | CANTEROS | M   | empleado | 1999-05-15 | Soltero       | false | false | false   | 112400201   | Argentina   | SAMUEL PIRES DE MELO | 400        | BAD_REQUEST    | Bad request. | externalId has wrong value 123. Value should be a string different than a 24 character hex string and different than an integer number.                                        |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | boolean externalId      | andresperalta@manteca.dev | true       | inttestarg@gmail.com | 27323361083 | ARGENTINA | MALENA | CANTEROS | M   | empleado | 1999-05-15 | Soltero       | false | false | false   | 112400201   | Argentina   | SAMUEL PIRES DE MELO | 400        | BAD_REQUEST    | Bad request. | externalId needs to be of type string but it's of type boolean.                                                                                                                |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | invalid email extention | andresperalta@manteca.dev | external-n | inttestarg@gmail     | 27323361083 | ARGENTINA | MALENA | CANTEROS | M   | empleado | 1999-05-15 | Soltero       | false | false | false   | 112400201   | Argentina   | SAMUEL PIRES DE MELO | 400        | BAD_REQUEST    | Bad request. | email has wrong value inttestarg@gmail. Value should be something@something.something.                                                                                         |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | invalid email structure | andresperalta@manteca.dev | external-n | inttestarggmail.com  | 27323361083 | ARGENTINA | MALENA | CANTEROS | M   | empleado | 1999-05-15 | Soltero       | false | false | false   | 112400201   | Argentina   | SAMUEL PIRES DE MELO | 400        | BAD_REQUEST    | Bad request. | email has wrong value inttestarggmail.com. Value should be something@something.something.                                                                                      |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | invalid email structure | andresperalta@manteca.dev | external-n | inttestarggmail.com  | 27323361083 | ARGENTINA | MALENA | CANTEROS | M   | empleado | 1999-05-15 | Soltero       | false | false | false   | 112400201   | Argentina   | SAMUEL PIRES DE MELO | 400        | BAD_REQUEST    | Bad request. | email has wrong value inttestarggmail.com. Value should be something@something.something.                                                                                      |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | invalid exchange        | andresperalta@manteca.dev | external-n | inttestarg@gmail.com | 27323361083 | INVALID   | MALENA | CANTEROS | M   | empleado | 1999-05-15 | Soltero       | false | false | false   | 112400201   | Argentina   | SAMUEL PIRES DE MELO | 400        | BAD_REQUEST    | Bad request. | exchange has wrong value INVALID. Possible values are ARGENTINA,CHILE,COLOMBIA,BRAZIL,GUATEMALA,COSTA_RICA,PANAMA,MEXICO,PHILIPPINES,BOLIVIA,PERU,PARAGUAY,SPAIN,ITALY,GLOBAL. |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | invalid sex             | andresperalta@manteca.dev | external-n | inttestarg@gmail.com | 27323361083 | ARGENTINA | MALENA | CANTEROS | J   | empleado | 1999-05-15 | Soltero       | false | false | false   | 112400201   | Argentina   | SAMUEL PIRES DE MELO | 400        | BAD_REQUEST    | Bad request. | personalData..sex has wrong value J. Possible values are F,M,X.                                                                                                                |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | invalid date            | andresperalta@manteca.dev | external-n | inttestarg@gmail.com | 27323361083 | ARGENTINA | MALENA | CANTEROS | M   | empleado | 1999-13-15 | Soltero       | false | false | false   | 112400201   | Argentina   | SAMUEL PIRES DE MELO | 400        | BAD_REQUEST    | Bad request. | personalData..birthDate has wrong value 1999-13-15. Value should be valid ISO Date string like 2024-01-20.                                                                     |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | invalid maritalStatus   | andresperalta@manteca.dev | external-n | inttestarg@gmail.com | 27323361083 | ARGENTINA | MALENA | CANTEROS | M   | empleado | 1999-06-15 | INVALID       | false | false | false   | 112400201   | Argentina   | SAMUEL PIRES DE MELO | 400        | BAD_REQUEST    | Bad request. | personalData..maritalStatus has wrong value INVALID. Possible values are Soltero,Casado,Divorciado,Viudo,Otros.                                                                |

    @ErrorPath
    Scenario Outline: Validate error Onboarding sending legalId mismatch <exchange> V2
        Given The API key is available "<apiKEY>"
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
        Then Obtain a response <statusCode>
        And Validate response attributes with internalStatus: "<internalStatus>" and message: "<message>" and error: "<errors>"

        Examples:
            | apiKEY                          | credential                | externalId            | email                | legalId          | exchange    | name   | surname  | sex | work     | birthDate  | maritalStatus | isPep | isFep | isFatca | phoneNumber | nationality | street               | statusCode | internalStatus | message      | errors                                                                                                                                                                    |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | andresperalta@manteca.dev | Integrations-test-Arg | inttestarg@gmail.com | 96362618149      | ARGENTINA   | MALENA | CANTEROS | M   | empleado | 1999-05-15 | Soltero       | false | false | false   | 112400201   | Argentina   | SAMUEL PIRES DE MELO | 400        | BAD_REQUEST    | Bad request. | legalId has wrong value 96362618149. Value should be a valid CUIT or CUIL with optional hyphens like 20-41565338-8 or 20415653388.                                        |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | andresperalta@manteca.dev | Integrations-test-Arg | inttestarg@gmail.com | 27323361083      | BRAZIL      | MALENA | CANTEROS | M   | empleado | 1999-05-15 | Soltero       | false | false | false   | 112400201   | Argentina   | SAMUEL PIRES DE MELO | 400        | BAD_REQUEST    | Bad request. | legalId has wrong value 27323361083. Value should be a valid brazilian CPF like 01234567890 or 012.345.678-90, or a valid CNPJ like 12.345.678/1993-12 or 12345678199312. |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | andresperalta@manteca.dev | Integrations-test-Arg | inttestarg@gmail.com | 478806           | CHILE       | MALENA | CANTEROS | M   | empleado | 1999-05-15 | Soltero       | false | false | false   | 112400201   | Argentina   | SAMUEL PIRES DE MELO | 400        | BAD_REQUEST    | Bad request. | legalId has wrong value 478806. Value should be a valid chilean RUT like 17178882K or 17.178.882-K.                                                                       |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | andresperalta@manteca.dev | Integrations-test-Arg | inttestarg@gmail.com | FOML740513JY6    | COLOMBIA    | MALENA | CANTEROS | M   | empleado | 1999-05-15 | Soltero       | false | false | false   | 112400201   | Argentina   | SAMUEL PIRES DE MELO | 400        | BAD_REQUEST    | Bad request. | legalId has wrong value FOML740513JY6. Value should be a valid colombian NUIP like 1234567890 or valid old colombian CC like 123456.                                      |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | andresperalta@manteca.dev | Integrations-test-Arg | inttestarg@gmail.com | 16240120-3       | MEXICO      | MALENA | CANTEROS | M   | empleado | 1999-05-15 | Soltero       | false | false | false   | 112400201   | Argentina   | SAMUEL PIRES DE MELO | 400        | BAD_REQUEST    | Bad request. | legalId has wrong value 16240120-3. Value should be a valid mexican CURP like RACW050729MMCSHNA2 or RFC like CUPU800825569.                                               |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | andresperalta@manteca.dev | Integrations-test-Arg | inttestarg@gmail.com | 2578794391201    | PANAMA      | MALENA | CANTEROS | M   | empleado | 1999-05-15 | Soltero       | false | false | false   | 112400201   | Argentina   | SAMUEL PIRES DE MELO | 400        | BAD_REQUEST    | Bad request. | legalId has wrong value 2578794391201. Value should be a valid panama RUC like 8-1040-2154 or E-8-136673.                                                                 |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | andresperalta@manteca.dev | Integrations-test-Arg | inttestarg@gmail.com | 119210765        | GUATEMALA   | MALENA | CANTEROS | M   | empleado | 1999-05-15 | Soltero       | false | false | false   | 112400201   | Argentina   | SAMUEL PIRES DE MELO | 400        | BAD_REQUEST    | Bad request. | legalId has wrong value 119210765. Value should be a valid guatemalan CUI like 1266552350807 or 1266-55235-0807.                                                          |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | andresperalta@manteca.dev | Integrations-test-Arg | inttestarg@gmail.com | 4562016          | PHILIPPINES | MALENA | CANTEROS | M   | empleado | 1999-05-15 | Soltero       | false | false | false   | 112400201   | Argentina   | SAMUEL PIRES DE MELO | 400        | BAD_REQUEST    | Bad request. | legalId has wrong value 4562016. Value should be a valid passport like P0000000A or PCN like 1234-1234-1234-1234 or UMID like 1234-1234567-1.                             |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | andresperalta@manteca.dev | Integrations-test-Arg | inttestarg@gmail.com | 6823600500001276 | COSTA_RICA  | MALENA | CANTEROS | M   | empleado | 1999-05-15 | Soltero       | false | false | false   | 112400201   | Argentina   | SAMUEL PIRES DE MELO | 400        | BAD_REQUEST    | Bad request. | legalId has wrong value 6823600500001276. Value should be a valid costa rican CI like 116620841 or 1-1662-0841 or valid DIMEX number.                                     |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | andresperalta@manteca.dev | Integrations-test-Arg | inttestarg@gmail.com | 27323361083      | BOLIVIA     | MALENA | CANTEROS | M   | empleado | 1999-05-15 | Soltero       | false | false | false   | 112400201   | Argentina   | SAMUEL PIRES DE MELO | 400        | BAD_REQUEST    | Bad request. | legalId has wrong value 27323361083. Value should be a valid Bolivian CI, e.g., 1234567, 1234567SC or SC1234567.                                                          |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | andresperalta@manteca.dev | Integrations-test-Arg | inttestarg@gmail.com | 27323361083      | PERU        | MALENA | CANTEROS | M   | empleado | 1999-05-15 | Soltero       | false | false | false   | 112400201   | Argentina   | SAMUEL PIRES DE MELO | 400        | BAD_REQUEST    | Bad request. | legalId has wrong value 27323361083. Value should be a valid Peruvian DNI, e.g., 10714510-4 or 434518267 or 10714510.                                                     |


    # ------------------------------- Error Path by Empty Fields -------------------------------

    @ErrorPath
    Scenario Outline: Validate error initial onboarding sending <case> V2
        Given The API key is available "<apiKEY>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        And login user admin "<credential>"
        And Validate existing user '<legalId>'
        When Assign the value "<externalId>" to the variable "externalId"
        # And Assign the value "<email>" to the variable "email"
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
        Then Obtain a response <statusCode>
        And Validate response attributes with internalStatus: "<internalStatus>" and message: "<message>" and error: "<errors>"

        Examples:
            | apiKEY                          | case        | credential                | externalId | email | legalId     | exchange  | name   | surname  | sex | work     | birthDate  | maritalStatus | isPep | isFep | isFatca | phoneNumber | nationality | street               | statusCode | internalStatus | message      | errors            |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | empty email | andresperalta@manteca.dev | external-n | null  | 27323361083 | ARGENTINA | MALENA | CANTEROS | M   | empleado | 1999-05-15 | Soltero       | false | false | false   | 112400201   | Argentina   | SAMUEL PIRES DE MELO | 400        | BAD_REQUEST    | Bad request. | email is missing. |

    @ErrorPath
    Scenario Outline: Validate error initial onboarding sending <case> V2
        Given The API key is available "<apiKEY>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        And login user admin "<credential>"
        When Assign the value "<externalId>" to the variable "externalId"
        And Assign the value "<email>" to the variable "email"
        # And Assign the value "<legalId>" to the variable "legalId"
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
        Then Obtain a response <statusCode>
        And Validate response attributes with internalStatus: "<internalStatus>" and message: "<message>" and error: "<errors>"

        Examples:
            | apiKEY                          | case          | credential                | externalId | email            | legalId | exchange  | name   | surname  | sex | work     | birthDate  | maritalStatus | isPep | isFep | isFatca | phoneNumber | nationality | street               | statusCode | internalStatus | message      | errors              |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | empty legalId | andresperalta@manteca.dev | external-n | user@manteca.dev | null    | ARGENTINA | MALENA | CANTEROS | M   | empleado | 1999-05-15 | Soltero       | false | false | false   | 112400201   | Argentina   | SAMUEL PIRES DE MELO | 400        | BAD_REQUEST    | Bad request. | legalId is missing. |

    @ErrorPath
    Scenario Outline: Validate error initial onboarding sending <case> V2
        Given The API key is available "<apiKEY>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        And login user admin "<credential>"
        When Assign the value "<externalId>" to the variable "externalId"
        And Assign the value "<email>" to the variable "email"
        And Assign the value "<legalId>" to the variable "legalId"
        # And Assign the value "<exchange>" to the variable "exchange"
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
        Then Obtain a response <statusCode>
        And Validate response attributes with internalStatus: "<internalStatus>" and message: "<message>" and error: "<errors>"

        Examples:
            | apiKEY                          | case           | credential                | externalId | email            | legalId     | exchange | name   | surname  | sex | work     | birthDate  | maritalStatus | isPep | isFep | isFatca | phoneNumber | nationality | street               | statusCode | internalStatus | message      | errors               |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | empty exchange | andresperalta@manteca.dev | external-n | user@manteca.dev | 27323361083 | null     | MALENA | CANTEROS | M   | empleado | 1999-05-15 | Soltero       | false | false | false   | 112400201   | Argentina   | SAMUEL PIRES DE MELO | 400        | BAD_REQUEST    | Bad request. | exchange is missing. |