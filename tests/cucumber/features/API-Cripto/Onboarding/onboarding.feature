@Onboarding
Feature: Onboarding User - V1

  Background:
    Given The API key is available "95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6"
    And The urlBase is available "https://sandbox.manteca.dev/crypto"

  @Smoke
  Scenario Outline: Validar onboarding exitoso de usuario por V1
    And login user admin "<credential>"
    And Validate existing user '<legalId>'
    When Assign the value "<name>" to the variable "name"
    And Assign the value "<email>" to the variable "email"
    And Assign the value "<legalId>" to the variable "legalId"
    And Assign the value "<phoneNumber>" to the variable "phoneNumber"
    And Assign the value "<country>" to the variable "country"
    And Assign the value "<civilState>" to the variable "civilState"
    And Execute the POST method on the endpoint "/v1/user/"
    Then Obtain a response 200

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
      | credential                | name      | email             | legalId     | phoneNumber   | country   | civilState |
      | andresperalta@manteca.dev | TestOnbV1 | onbv1@yopmail.com | 27453162848 | 5492616621076 | Argentina | SOLTERO    |

  @Regression
  Scenario Outline: Validar onboarding exitoso de usuario PEP por V1
    And login user admin "<credential>"
    And Validate existing user '<legalId>'
    When Assign the value "<name>" to the variable "name"
    And Assign the value "<email>" to the variable "email"
    And Assign the value "<legalId>" to the variable "legalId"
    And Assign the value "<phoneNumber>" to the variable "phoneNumber"
    And Assign the value "<country>" to the variable "country"
    And Assign the value "<civilState>" to the variable "civilState"
    And Execute the POST method on the endpoint "/v1/user/"
    Then Obtain a response 200

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
    And Execute the PUT method on the endpoint "/v1/documentation/100012166/pep"
    Then Obtain a response 204

    Examples:
      | credential                | name              | email                | legalId     | phoneNumber   | country   | civilState | charge     | authority           | character |
      | andresperalta@manteca.dev | TestOnboardingPep | onbv1pep@yopmail.com | 27244952904 | 5492615859818 | Argentina | SOLTERO    | Secretario | Ministerio de Salud | Público   |
