@OnboardingApiCambio
Feature: Onboarding API-Cambio

    @InitialOnboarding
    Scenario: Onboarding inicial de usuario
        Given The API key is available "2f96-0dcb-175b-9e8a-3197-e714-0813-a924-04894ac9"
        And The urlBase is available "https://api-qa.tiendadolar.com.ar"
        When Assign the value "<email>" to the variable "email"
        And Assign the value "<legalId>" to the variable "legalId"
        And Assign the value "<sex>" to the variable "sex"
        And Assign the value "<work>" to the variable "work"
        And Assign the value "<birthDate>" to the variable "birthDate"
        And Assign the value "<maritalStatus>" to the variable "maritalStatus"
        And Assign the value "<isPep>" to the variable "isPep"
        And Assign the value "<isFep>" to the variable "isFep"
        And Assign the value "<isFatca>" to the variable "isFatca"
        And Assign the value "<isUif>" to the variable "isUif"
        And Assign the value "<phoneNumber>" to the variable "phoneNumber"
        And Assign the value "<nationality>" to the variable "nationality"
        And Assign the value "<ARScbu>" to the variable "ARScbu"
        And Assign the value "<ARScurrency>" to the variable "ARScurrency"
        And Assign the value "<ARSdescription>" to the variable "ARSdescription"
        And Assign the value "<USDcbu>" to the variable "USDcbu"
        And Assign the value "<USDcurrency>" to the variable "USDcurrency"
        And Assign the value "<USDdescription>" to the variable "USDdescription"
        And Execute the POST method on the endpoint "/v3/api/onboarding-actions/initial"
        Then Obtain a response 201
        And The user is created

        Examples:
            | email                 | legalId     | sex | work             | birthDate  | maritalStatus | isPep | isFep | isFatca | isUif | phoneNumber | nationality | ARScbu                 | ARScurrency | ARSdescription | USDcbu                 | USDcurrency | USDdescription |
            | testcvu13@yopmail.com | 20270001409 | M   | CULTIVO DE ARROZ | 1999-05-15 | Soltero       | false | false | false   | false | 1124001116  | Argentina   | 0000003100086679972343 | ARS         | HSBC           | 0000003100000341514293 | USD         | CHASE          |

    Scenario: Obtener S3 url para carga de DNI FRONT
        Given The API key is available "2f96-0dcb-175b-9e8a-3197-e714-0813-a924-04894ac9"
        And The urlBase is available "https://api-qa.tiendadolar.com.ar"
        When Assign the value "userAnyId" to the variable "userAnyId"
        And Assign the value "FRONT" to the variable "side"
        And Assign the value "dni-front.jpg" to the variable "fileName"
        And Execute the POST method on the endpoint "/v3/api/onboarding-actions/upload-identity-image"
        Then Obtain a response 200

    Scenario: Subir DNI FRONT
        When Execute the PUT method on the endpoint
        Then Obtain a response 200

    Scenario: Obtener S3 url para carga de DNI BACK
        Given The API key is available "2f96-0dcb-175b-9e8a-3197-e714-0813-a924-04894ac9"
        And The urlBase is available "https://api-qa.tiendadolar.com.ar"
        When Assign the value "userAnyId" to the variable "userAnyId"
        And Assign the value "BACK" to the variable "side"
        And Assign the value "dni-back.jpg" to the variable "fileName"
        And Execute the POST method on the endpoint "/v3/api/onboarding-actions/upload-identity-image"
        Then Obtain a response 200

    Scenario: Subir DNI BACK
        When Execute the PUT method on the endpoint
        Then Obtain a response 200

    Scenario: Obtener S3 url para carga de selfie
        Given The API key is available "2f96-0dcb-175b-9e8a-3197-e714-0813-a924-04894ac9"
        And The urlBase is available "https://api-qa.tiendadolar.com.ar"
        When Assign the value "userAnyId" to the variable "userAnyId"
        And Assign the value "selfie.jpg" to the variable "fileName"
        And Execute the POST method on the endpoint "/v3/api/onboarding-actions/upload-selfie-image"
        Then Obtain a response 200

    Scenario: Subir imagen selfie
        When Execute the PUT method on the endpoint
        Then Obtain a response 200

    Scenario: Obtener S3 url para subir documento UIF
        Given The API key is available "2f96-0dcb-175b-9e8a-3197-e714-0813-a924-04894ac9"
        And The urlBase is available "https://api-qa.tiendadolar.com.ar"
        When Assign the value "userAnyId" to the variable "userAnyId"
        And Assign the value "example-uif-documentation.jpg" to the variable "fileName"
        And Execute the POST method on the endpoint "/v3/api/onboarding-actions/upload-pep-documentation"
        Then Obtain a response 200

    Scenario: Subir documento UIF
        When Execute the PUT method on the endpoint
        Then Obtain a response 200


    Scenario: Agregar cuenta bancaria
        Given The API key is available "2f96-0dcb-175b-9e8a-3197-e714-0813-a924-04894ac9"
        And The urlBase is available "https://sandbox.manteca.dev/cambio"
        When Assign the value "userAnyId" to the variable "userAnyId"
        And Assign the value "1430001713018822310016" to the variable "address"
        And Assign the value "ARS" to the variable "currency"
        And Assign the value "MP" to the variable "description"
        And Execute the POST method on the endpoint "/v3/onboarding-actions/add-bank-account"
        Then Obtain a response 204
