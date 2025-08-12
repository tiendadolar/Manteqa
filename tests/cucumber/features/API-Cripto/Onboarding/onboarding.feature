@Onboarding
Feature: Onboarding User - V1

  Background:
    Given The API key is available "95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6"
    And The urlBase is available "https://sandbox.manteca.dev/crypto"


  # E2E
  @f
  Scenario Outline: Registro exitoso de usuario
    When Assign the value "<name>" to the variable "name"
    And Assign the value "<email>" to the variable "email"
    And Assign the value "<legalId>" to the variable "legalId"
    And Assign the value "<phoneNumber>" to the variable "phoneNumber"
    And Assign the value "<country>" to the variable "country"
    And Assign the value "<civilState>" to the variable "civilState"
    And Execute the POST method on the endpoint "/v1/user/"
    Then Obtain a response 200
    And The user is created

    #Para generar nuevos usuarios ingresar CUIL válido e incrementar en uno el numero de email y phoneNumber en Examples
    Examples:
      | name              | email                  | legalId     | phoneNumber   | country   | civilState |
      | User QR V2 NoDesc | no_tocar13@yopmail.com | 23213974629 | 5492696621080 | Argentina | SOLTERO    |
  @f
  Scenario: Agregar cuenta bancaria
    When Assign the value "0140420703690150418728" to the variable "cbu"
    And Assign the value "Galicia" to the variable "description"
    And Execute the POST method on the endpoint "/v1/user/{userId}/bankaccount/ARS"
    Then Obtain a response 200
    And The bank account is added
  @f
  Scenario: Obtener S3 url
    When Assign the value "DNI_FRONT" to the variable "docType"
    And Assign the value "picfront.jpg" to the variable "fileName"
    And Execute the POST method on the endpoint "/v1/documentation/{userId}/uploadUrl"
    Then Obtain a response 200
  @f
  Scenario: Subir documento
    When Execute the PUT method on the endpoint
    Then Obtain a response 200
  @f
  Scenario: Obtener S3 url
    When Assign the value "DNI_BACK" to the variable "docType"
    And Assign the value "picback.jpg" to the variable "fileName"
    And Execute the POST method on the endpoint "/v1/documentation/{userId}/uploadUrl"
    Then Obtain a response 200
  @f
  Scenario: Subir documento
    When Execute the PUT method on the endpoint
    Then Obtain a response 200

  # -----

  @SmokeOnboarding5
  Scenario Outline: Validar onboarding exitoso de usuario
    When Assign the value "<name>" to the variable "name"
    And Assign the value "<email>" to the variable "email"
    And Assign the value "<legalId>" to the variable "legalId"
    And Assign the value "<phoneNumber>" to the variable "phoneNumber"
    And Assign the value "<country>" to the variable "country"
    And Assign the value "<civilState>" to the variable "civilState"
    And Execute the POST method on the endpoint "/v1/user/"
    Then Obtain a response 200
    And The user is created

    When Assign the value "0140420703690150418728" to the variable "cbu"
    And Assign the value "Galicia" to the variable "description"
    And Execute the POST method on the endpoint "/v1/user/{userId}/bankaccount/ARS"
    Then Obtain a response 200
    And The bank account is added

    When Assign the value "DNI_FRONT" to the variable "docType"
    And Assign the value "picfront.jpg" to the variable "fileName"
    And Execute the POST method on the endpoint "/v1/documentation/{userId}/uploadUrl"
    Then Obtain a response 200

    When Execute the PUT method on the endpoint
    Then Obtain a response 200

    When Assign the value "DNI_BACK" to the variable "docType"
    And Assign the value "picback.jpg" to the variable "fileName"
    And Execute the POST method on the endpoint "/v1/documentation/{userId}/uploadUrl"
    Then Obtain a response 200

    When Execute the PUT method on the endpoint
    Then Obtain a response 200

    Examples:
      | name               | email           | legalId     | phoneNumber   | country   | civilState |
      | TestUserAutomation | tua@yopmail.com | 20337447504 | 5492616621075 | Argentina | SOLTERO    |

  @SmokeOnboarding1
  Scenario Outline: Validar onboarding exitoso de usuario
    When Assign the value "<name>" to the variable "name"
    And Assign the value "<email>" to the variable "email"
    And Assign the value "<legalId>" to the variable "legalId"
    And Assign the value "<phoneNumber>" to the variable "phoneNumber"
    And Assign the value "<country>" to the variable "country"
    And Assign the value "<civilState>" to the variable "civilState"
    And Execute the POST method on the endpoint "/v1/user/"
    Then Obtain a response 200
    And The user is created

    When Assign the value "0140420703690150418728" to the variable "cbu"
    And Assign the value "Galicia" to the variable "description"
    And Execute the POST method on the endpoint "/v1/user/{userId}/bankaccount/ARS"
    Then Obtain a response 200
    And The bank account is added

    When Assign the value "DNI_FRONT" to the variable "docType"
    And Assign the value "picfront.jpg" to the variable "fileName"
    And Execute the POST method on the endpoint "/v1/documentation/{userId}/uploadUrl"
    Then Obtain a response 200

    When Execute the PUT method on the endpoint
    Then Obtain a response 200

    When Assign the value "DNI_BACK" to the variable "docType"
    And Assign the value "picback.jpg" to the variable "fileName"
    And Execute the POST method on the endpoint "/v1/documentation/{userId}/uploadUrl"
    Then Obtain a response 200

    When Execute the PUT method on the endpoint
    Then Obtain a response 200

    Examples:
      | name        | email                 | legalId     | phoneNumber   | country   | civilState |
      | User QR V1  | NO_TOCAR5@yopmail.com | 20222128766 | 5492616621074 | Argentina | SOLTERO    |
      | User QR V2  | NO_TOCAR6@yopmail.com | 20142323940 | 5492616621074 | Argentina | SOLTERO    |
      | User PIX V1 | NO_TOCAR7@yopmail.com | 27240898352 | 5492616621074 | Argentina | SOLTERO    |
      | User PIX V2 | NO_TOCAR8@yopmail.com | 20312394503 | 5492616621074 | Argentina | SOLTERO    |



  @OnboardingPEP @SmokeOnboarding
  Scenario Outline: Validar onboarding exitoso de usuario PEP
    When Assign the value "<name>" to the variable "name"
    And Assign the value "<email>" to the variable "email"
    And Assign the value "<legalId>" to the variable "legalId"
    And Assign the value "<phoneNumber>" to the variable "phoneNumber"
    And Assign the value "<country>" to the variable "country"
    And Assign the value "<civilState>" to the variable "civilState"
    And Execute the POST method on the endpoint "/v1/user/"
    Then Obtain a response 200
    And The user is created

    When Assign the value "0140420703690150418728" to the variable "cbu"
    And Assign the value "Galicia" to the variable "description"
    And Execute the POST method on the endpoint "/v1/user/{userId}/bankaccount/ARS"
    Then Obtain a response 200
    And The bank account is added

    When Assign the value "DNI_FRONT" to the variable "docType"
    And Assign the value "picfront.jpg" to the variable "fileName"
    And Execute the POST method on the endpoint "/v1/documentation/{userId}/uploadUrl"
    Then Obtain a response 200

    When Execute the PUT method on the endpoint
    Then Obtain a response 200

    When Assign the value "DNI_BACK" to the variable "docType"
    And Assign the value "picback.jpg" to the variable "fileName"
    And Execute the POST method on the endpoint "/v1/documentation/{userId}/uploadUrl"
    Then Obtain a response 200

    When Execute the PUT method on the endpoint
    Then Obtain a response 200

    When Assign the value "<charge>" to the variable "charge"
    And Assign the value "<authority>" to the variable "authority"
    And Assign the value "<character>" to the variable "character"
    And Execute the PUT method on the endpoint "/v1/documentation/{userId}/pep"
    Then Obtain a response 204

    Examples:
      | name               | email                          | legalId     | phoneNumber   | country   | civilState | charge     | authority           | character |
      | TestOnboardingV140 | boddeuquipu5081@yopmail.com | 20270270353 | 5492615859817 | Argentina | SOLTERO    | Secretario | Ministerio de Salud | Público   |

  @OnboardingError
  Scenario Outline: Validar onboarding fallido con legalId repetido
    When Assign the value "Pedro López" to the variable "name"
    And Assign the value "legalidrepetido@yopmail.com" to the variable "email"
    And Assign the value "20345897446" to the variable "legalId"
    And Assign the value "549261669000" to the variable "phoneNumber"
    And Assign the value "Argentina" to the variable "country"
    And Assign the value "SOLTERO" to the variable "civilState"
    And Execute the POST method on the endpoint "/v1/user/"
    Then Obtain a response 409
  # And The error is received "name is mising."

  @OnboardingError
  Scenario Outline: Validar onboarding fallido enviando el campo "<campo>" vacio
    When Assign the value "<name>" to the variable "name"
    And Assign the value "<email>" to the variable "email"
    And Assign the value "<legalId>" to the variable "legalId"
    And Assign the value "<phoneNumber>" to the variable "phoneNumber"
    And Assign the value "<country>" to the variable "country"
    And Assign the value "<civilState>" to the variable "civilState"
    And Execute the POST method on the endpoint "/v1/user/"
    Then Obtain a response 400
    And The error is received "<mensaje>"

    Examples:
      | campo       | name     | email                          | legalId     | phoneNumber   | country   | civilState | mensaje                                                                |
      | name        |          | boddeuquipure-8563@yopmail.com | 20345897446 | 5492616621073 | Argentina | SOLTERO    | name is mising.                                                        |
      | email       | Fallido1 |                                | 20345897446 | 5492616621073 | Argentina | SOLTERO    | email has wrong value . Value should be something@something.something. |
      | legalId     | Fallido2 | boddeuquipure-8563@yopmail.com |             | 5492616621073 | Argentina | SOLTERO    | legalId is missing.                                                    |
      | phoneNumber | Fallido3 | boddeuquipure-8563@yopmail.com | 20345897446 |               | Argentina | SOLTERO    | phoneNumber is missing.                                                |
      | country     | Fallido4 | boddeuquipure-8563@yopmail.com | 20345897446 | 5492616621073 |           | SOLTERO    | country is missing.                                                    |
      | civilState  | Fallido5 | boddeuquipure-8563@yopmail.com | 20345897446 | 5492616621073 | Argentina |            | civilState is missing.                                                 |

  @OnboardingError
  Scenario Outline: Validar onboarding fallido sin enviar el campo "name"
    When Assign the value "boddeuquipure-8563@yopmail.com" to the variable "email"
    And Assign the value "20345897446" to the variable "legalId"
    And Assign the value "5492616621073" to the variable "phoneNumber"
    And Assign the value "Argentina" to the variable "country"
    And Assign the value "SOLTERO" to the variable "civilState"
    And Execute the POST method on the endpoint "/v1/user/"
    Then Obtain a response 400
    And The error is received "name is mising."

  @OnboardingError
  Scenario Outline: Validar onboarding fallido sin enviar el campo "email"
    When Assign the value "Fallido6" to the variable "name"
    And Assign the value "20345897446" to the variable "legalId"
    And Assign the value "5492616621073" to the variable "phoneNumber"
    And Assign the value "Argentina" to the variable "country"
    And Assign the value "SOLTERO" to the variable "civilState"
    And Execute the POST method on the endpoint "/v1/user/"
    Then Obtain a response 400
    And The error is received "email is missing."

  @OnboardingError
  Scenario Outline: Validar onboarding fallido sin enviar el campo "legalId"
    When Assign the value "Fallido6" to the variable "name"
    And Assign the value "boddeuquipure-8563@yopmail.com" to the variable "email"
    And Assign the value "5492616621073" to the variable "phoneNumber"
    And Assign the value "Argentina" to the variable "country"
    And Assign the value "SOLTERO" to the variable "civilState"
    And Execute the POST method on the endpoint "/v1/user/"
    Then Obtain a response 400
    And The error is received "legalId is missing."

  @OnboardingError
  Scenario Outline: Validar onboarding fallido sin enviar el campo "phoneNumber"
    When Assign the value "Fallido6" to the variable "name"
    And Assign the value "boddeuquipure-8563@yopmail.com" to the variable "email"
    And Assign the value "20345897446" to the variable "legalId"
    And Assign the value "Argentina" to the variable "country"
    And Assign the value "SOLTERO" to the variable "civilState"
    And Execute the POST method on the endpoint "/v1/user/"
    Then Obtain a response 400
    And The error is received "phoneNumber is missing."

  @OnboardingError
  Scenario Outline: Validar onboarding fallido sin enviar el campo "country"
    When Assign the value "Fallido6" to the variable "name"
    And Assign the value "boddeuquipure-8563@yopmail.com" to the variable "email"
    And Assign the value "20345897446" to the variable "legalId"
    And Assign the value "5492616621073" to the variable "phoneNumber"
    And Assign the value "SOLTERO" to the variable "civilState"
    And Execute the POST method on the endpoint "/v1/user/"
    Then Obtain a response 400
    And The error is received "country is missing."

  @OnboardingError
  Scenario Outline: Validar onboarding fallido sin enviar el campo "civilState"
    When Assign the value "Fallido6" to the variable "name"
    And Assign the value "boddeuquipure-8563@yopmail.com" to the variable "email"
    And Assign the value "20345897446" to the variable "legalId"
    And Assign the value "5492616621073" to the variable "phoneNumber"
    And Assign the value "Argentina" to the variable "country"
    And Execute the POST method on the endpoint "/v1/user/"
    Then Obtain a response 400
    And The error is received "civilState is missing."
