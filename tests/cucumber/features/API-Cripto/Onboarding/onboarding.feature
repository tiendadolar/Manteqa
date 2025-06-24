@Onboarding
Feature: Onboarding User - V1

  Background:
    Given Contar con la api-key "95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6"
    And Contar con la urlBase "https://sandbox.manteca.dev/crypto"


  # E2E
  @f
  Scenario Outline: Registro exitoso de usuario
    When Asignar el valor "<name>" a la variable "name"
    And Asignar el valor "<email>" a la variable "email"
    And Asignar el valor "<legalId>" a la variable "legalId"
    And Asignar el valor "<phoneNumber>" a la variable "phoneNumber"
    And Asignar el valor "<country>" a la variable "country"
    And Asignar el valor "<civilState>" a la variable "civilState"
    And Ejecutar el método Post al endpoint "/v1/user/"
    Then Se obtiene una respuesta 200
    And Se crea el usuario

    #Para generar nuevos usuarios ingresar CUIL válido e incrementar en uno el numero de email y phoneNumber en Examples
    Examples:
      | name              | email                  | legalId     | phoneNumber   | country   | civilState |
      | User QR V2 NoDesc | no_tocar13@yopmail.com | 23213974629 | 5492696621080 | Argentina | SOLTERO    |
  @f
  Scenario: Agregar cuenta bancaria
    When Asignar el valor "0140420703690150418728" a la variable "cbu"
    And Asignar el valor "Galicia" a la variable "description"
    And Ejecutar el método Post al endpoint "/v1/user/{userId}/bankaccount/ARS"
    Then Se obtiene una respuesta 200
    And Se agrega la cuenta bancaria
  @f
  Scenario: Obtener S3 url
    When Asignar el valor "DNI_FRONT" a la variable "docType"
    And Asignar el valor "picfront.jpg" a la variable "fileName"
    And Ejecutar el método Post al endpoint "/v1/documentation/{userId}/uploadUrl"
    Then Se obtiene una respuesta 200
  @f
  Scenario: Subir documento
    When Ejecutar el método Put al endpoint
    Then Se obtiene una respuesta 200
  @f
  Scenario: Obtener S3 url
    When Asignar el valor "DNI_BACK" a la variable "docType"
    And Asignar el valor "picback.jpg" a la variable "fileName"
    And Ejecutar el método Post al endpoint "/v1/documentation/{userId}/uploadUrl"
    Then Se obtiene una respuesta 200
  @f
  Scenario: Subir documento
    When Ejecutar el método Put al endpoint
    Then Se obtiene una respuesta 200

  # -----
  @SmokeOnboarding1
  Scenario Outline: Validar onboarding exitoso de usuario
    When Asignar el valor "<name>" a la variable "name"
    And Asignar el valor "<email>" a la variable "email"
    And Asignar el valor "<legalId>" a la variable "legalId"
    And Asignar el valor "<phoneNumber>" a la variable "phoneNumber"
    And Asignar el valor "<country>" a la variable "country"
    And Asignar el valor "<civilState>" a la variable "civilState"
    And Ejecutar el método Post al endpoint "/v1/user/"
    Then Se obtiene una respuesta 200
    And Se crea el usuario

    When Asignar el valor "0140420703690150418728" a la variable "cbu"
    And Asignar el valor "Galicia" a la variable "description"
    And Ejecutar el método Post al endpoint "/v1/user/{userId}/bankaccount/ARS"
    Then Se obtiene una respuesta 200
    And Se agrega la cuenta bancaria

    When Asignar el valor "DNI_FRONT" a la variable "docType"
    And Asignar el valor "picfront.jpg" a la variable "fileName"
    And Ejecutar el método Post al endpoint "/v1/documentation/{userId}/uploadUrl"
    Then Se obtiene una respuesta 200

    When Ejecutar el método Put al endpoint
    Then Se obtiene una respuesta 200

    When Asignar el valor "DNI_BACK" a la variable "docType"
    And Asignar el valor "picback.jpg" a la variable "fileName"
    And Ejecutar el método Post al endpoint "/v1/documentation/{userId}/uploadUrl"
    Then Se obtiene una respuesta 200

    When Ejecutar el método Put al endpoint
    Then Se obtiene una respuesta 200

    Examples:
      | name        | email                 | legalId     | phoneNumber   | country   | civilState |
      | User QR V1  | NO_TOCAR5@yopmail.com | 20222128766 | 5492616621074 | Argentina | SOLTERO    |
      | User QR V2  | NO_TOCAR6@yopmail.com | 20142323940 | 5492616621074 | Argentina | SOLTERO    |
      | User PIX V1 | NO_TOCAR7@yopmail.com | 27240898352 | 5492616621074 | Argentina | SOLTERO    |
      | User PIX V2 | NO_TOCAR8@yopmail.com | 20312394503 | 5492616621074 | Argentina | SOLTERO    |



  @OnboardingPEP @SmokeOnboarding
  Scenario Outline: Validar onboarding exitoso de usuario PEP
    When Asignar el valor "<name>" a la variable "name"
    And Asignar el valor "<email>" a la variable "email"
    And Asignar el valor "<legalId>" a la variable "legalId"
    And Asignar el valor "<phoneNumber>" a la variable "phoneNumber"
    And Asignar el valor "<country>" a la variable "country"
    And Asignar el valor "<civilState>" a la variable "civilState"
    And Ejecutar el método Post al endpoint "/v1/user/"
    Then Se obtiene una respuesta 200
    And Se crea el usuario

    When Asignar el valor "0140420703690150418728" a la variable "cbu"
    And Asignar el valor "Galicia" a la variable "description"
    And Ejecutar el método Post al endpoint "/v1/user/{userId}/bankaccount/ARS"
    Then Se obtiene una respuesta 200
    And Se agrega la cuenta bancaria

    When Asignar el valor "DNI_FRONT" a la variable "docType"
    And Asignar el valor "picfront.jpg" a la variable "fileName"
    And Ejecutar el método Post al endpoint "/v1/documentation/{userId}/uploadUrl"
    Then Se obtiene una respuesta 200

    When Ejecutar el método Put al endpoint
    Then Se obtiene una respuesta 200

    When Asignar el valor "DNI_BACK" a la variable "docType"
    And Asignar el valor "picback.jpg" a la variable "fileName"
    And Ejecutar el método Post al endpoint "/v1/documentation/{userId}/uploadUrl"
    Then Se obtiene una respuesta 200

    When Ejecutar el método Put al endpoint
    Then Se obtiene una respuesta 200

    When Asignar el valor "<charge>" a la variable "charge"
    And Asignar el valor "<authority>" a la variable "authority"
    And Asignar el valor "<character>" a la variable "character"
    And Ejecutar el método Put al endpoint "/v1/documentation/{userId}/pep"
    Then Se obtiene una respuesta 204

    Examples:
      | name               | email                          | legalId     | phoneNumber   | country   | civilState | charge     | authority           | character |
      | TestOnboardingV140 | boddeuquipure15081@yopmail.com | 20270270353 | 5492615859817 | Argentina | SOLTERO    | Secretario | Ministerio de Salud | Público   |

  @OnboardingError
  Scenario Outline: Validar onboarding fallido con legalId repetido
    When Asignar el valor "Pedro López" a la variable "name"
    And Asignar el valor "legalidrepetido@yopmail.com" a la variable "email"
    And Asignar el valor "20345897446" a la variable "legalId"
    And Asignar el valor "549261669000" a la variable "phoneNumber"
    And Asignar el valor "Argentina" a la variable "country"
    And Asignar el valor "SOLTERO" a la variable "civilState"
    And Ejecutar el método Post al endpoint "/v1/user/"
    Then Se obtiene una respuesta 409
  # And Se obtiene el error "name is mising."

  @OnboardingError
  Scenario Outline: Validar onboarding fallido enviando el campo "<campo>" vacio
    When Asignar el valor "<name>" a la variable "name"
    And Asignar el valor "<email>" a la variable "email"
    And Asignar el valor "<legalId>" a la variable "legalId"
    And Asignar el valor "<phoneNumber>" a la variable "phoneNumber"
    And Asignar el valor "<country>" a la variable "country"
    And Asignar el valor "<civilState>" a la variable "civilState"
    And Ejecutar el método Post al endpoint "/v1/user/"
    Then Se obtiene una respuesta 400
    And Se obtiene el error "<mensaje>"

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
    When Asignar el valor "boddeuquipure-8563@yopmail.com" a la variable "email"
    And Asignar el valor "20345897446" a la variable "legalId"
    And Asignar el valor "5492616621073" a la variable "phoneNumber"
    And Asignar el valor "Argentina" a la variable "country"
    And Asignar el valor "SOLTERO" a la variable "civilState"
    And Ejecutar el método Post al endpoint "/v1/user/"
    Then Se obtiene una respuesta 400
    And Se obtiene el error "name is mising."

  @OnboardingError
  Scenario Outline: Validar onboarding fallido sin enviar el campo "email"
    When Asignar el valor "Fallido6" a la variable "name"
    And Asignar el valor "20345897446" a la variable "legalId"
    And Asignar el valor "5492616621073" a la variable "phoneNumber"
    And Asignar el valor "Argentina" a la variable "country"
    And Asignar el valor "SOLTERO" a la variable "civilState"
    And Ejecutar el método Post al endpoint "/v1/user/"
    Then Se obtiene una respuesta 400
    And Se obtiene el error "email is missing."

  @OnboardingError
  Scenario Outline: Validar onboarding fallido sin enviar el campo "legalId"
    When Asignar el valor "Fallido6" a la variable "name"
    And Asignar el valor "boddeuquipure-8563@yopmail.com" a la variable "email"
    And Asignar el valor "5492616621073" a la variable "phoneNumber"
    And Asignar el valor "Argentina" a la variable "country"
    And Asignar el valor "SOLTERO" a la variable "civilState"
    And Ejecutar el método Post al endpoint "/v1/user/"
    Then Se obtiene una respuesta 400
    And Se obtiene el error "legalId is missing."

  @OnboardingError
  Scenario Outline: Validar onboarding fallido sin enviar el campo "phoneNumber"
    When Asignar el valor "Fallido6" a la variable "name"
    And Asignar el valor "boddeuquipure-8563@yopmail.com" a la variable "email"
    And Asignar el valor "20345897446" a la variable "legalId"
    And Asignar el valor "Argentina" a la variable "country"
    And Asignar el valor "SOLTERO" a la variable "civilState"
    And Ejecutar el método Post al endpoint "/v1/user/"
    Then Se obtiene una respuesta 400
    And Se obtiene el error "phoneNumber is missing."

  @OnboardingError
  Scenario Outline: Validar onboarding fallido sin enviar el campo "country"
    When Asignar el valor "Fallido6" a la variable "name"
    And Asignar el valor "boddeuquipure-8563@yopmail.com" a la variable "email"
    And Asignar el valor "20345897446" a la variable "legalId"
    And Asignar el valor "5492616621073" a la variable "phoneNumber"
    And Asignar el valor "SOLTERO" a la variable "civilState"
    And Ejecutar el método Post al endpoint "/v1/user/"
    Then Se obtiene una respuesta 400
    And Se obtiene el error "country is missing."

  @OnboardingError
  Scenario Outline: Validar onboarding fallido sin enviar el campo "civilState"
    When Asignar el valor "Fallido6" a la variable "name"
    And Asignar el valor "boddeuquipure-8563@yopmail.com" a la variable "email"
    And Asignar el valor "20345897446" a la variable "legalId"
    And Asignar el valor "5492616621073" a la variable "phoneNumber"
    And Asignar el valor "Argentina" a la variable "country"
    And Ejecutar el método Post al endpoint "/v1/user/"
    Then Se obtiene una respuesta 400
    And Se obtiene el error "civilState is missing."
