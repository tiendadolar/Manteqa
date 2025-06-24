@OnboardingApiCambio
Feature: Onboarding API-Cambio

    @InitialOnboarding
    Scenario: Onboarding inicial de usuario
        Given Contar con la api-key "2f96-0dcb-175b-9e8a-3197-e714-0813-a924-04894ac9"
        And Contar con la urlBase "https://api-qa.tiendadolar.com.ar"
        When Asignar el valor "<email>" a la variable "email"
        And Asignar el valor "<legalId>" a la variable "legalId"
        And Asignar el valor "<sex>" a la variable "sex"
        And Asignar el valor "<work>" a la variable "work"
        And Asignar el valor "<birthDate>" a la variable "birthDate"
        And Asignar el valor "<maritalStatus>" a la variable "maritalStatus"
        And Asignar el valor "<isPep>" a la variable "isPep"
        And Asignar el valor "<isFep>" a la variable "isFep"
        And Asignar el valor "<isFatca>" a la variable "isFatca"
        And Asignar el valor "<isUif>" a la variable "isUif"
        And Asignar el valor "<phoneNumber>" a la variable "phoneNumber"
        And Asignar el valor "<nationality>" a la variable "nationality"
        And Asignar el valor "<ARScbu>" a la variable "ARScbu"
        And Asignar el valor "<ARScurrency>" a la variable "ARScurrency"
        And Asignar el valor "<ARSdescription>" a la variable "ARSdescription"
        And Asignar el valor "<USDcbu>" a la variable "USDcbu"
        And Asignar el valor "<USDcurrency>" a la variable "USDcurrency"
        And Asignar el valor "<USDdescription>" a la variable "USDdescription"
        And Ejecutar el método Post al endpoint "/v3/api/onboarding-actions/initial"
        Then Se obtiene una respuesta 201
        And Se crea el usuario

        Examples:
            | email                 | legalId     | sex | work             | birthDate  | maritalStatus | isPep | isFep | isFatca | isUif | phoneNumber | nationality | ARScbu                 | ARScurrency | ARSdescription | USDcbu                 | USDcurrency | USDdescription |
            | testcvu13@yopmail.com | 20270001409 | M   | CULTIVO DE ARROZ | 1999-05-15 | Soltero       | false | false | false   | false | 1124001116  | Argentina   | 0000003100086679972343 | ARS         | HSBC           | 0000003100000341514293 | USD         | CHASE          |

    Scenario: Obtener S3 url para carga de DNI FRONT
        Given Contar con la api-key "2f96-0dcb-175b-9e8a-3197-e714-0813-a924-04894ac9"
        And Contar con la urlBase "https://api-qa.tiendadolar.com.ar"
        When Asignar el valor "userAnyId" a la variable "userAnyId"
        And Asignar el valor "FRONT" a la variable "side"
        And Asignar el valor "dni-front.jpg" a la variable "fileName"
        And Ejecutar el método Post al endpoint "/v3/api/onboarding-actions/upload-identity-image"
        Then Se obtiene una respuesta 200

    Scenario: Subir DNI FRONT
        When Ejecutar el método Put al endpoint
        Then Se obtiene una respuesta 200

    Scenario: Obtener S3 url para carga de DNI BACK
        Given Contar con la api-key "2f96-0dcb-175b-9e8a-3197-e714-0813-a924-04894ac9"
        And Contar con la urlBase "https://api-qa.tiendadolar.com.ar"
        When Asignar el valor "userAnyId" a la variable "userAnyId"
        And Asignar el valor "BACK" a la variable "side"
        And Asignar el valor "dni-back.jpg" a la variable "fileName"
        And Ejecutar el método Post al endpoint "/v3/api/onboarding-actions/upload-identity-image"
        Then Se obtiene una respuesta 200

    Scenario: Subir DNI BACK
        When Ejecutar el método Put al endpoint
        Then Se obtiene una respuesta 200

    Scenario: Obtener S3 url para carga de selfie
        Given Contar con la api-key "2f96-0dcb-175b-9e8a-3197-e714-0813-a924-04894ac9"
        And Contar con la urlBase "https://api-qa.tiendadolar.com.ar"
        When Asignar el valor "userAnyId" a la variable "userAnyId"
        And Asignar el valor "selfie.jpg" a la variable "fileName"
        And Ejecutar el método Post al endpoint "/v3/api/onboarding-actions/upload-selfie-image"
        Then Se obtiene una respuesta 200

    Scenario: Subir imagen selfie
        When Ejecutar el método Put al endpoint
        Then Se obtiene una respuesta 200

    Scenario: Obtener S3 url para subir documento UIF
        Given Contar con la api-key "2f96-0dcb-175b-9e8a-3197-e714-0813-a924-04894ac9"
        And Contar con la urlBase "https://api-qa.tiendadolar.com.ar"
        When Asignar el valor "userAnyId" a la variable "userAnyId"
        And Asignar el valor "example-uif-documentation.jpg" a la variable "fileName"
        And Ejecutar el método Post al endpoint "/v3/api/onboarding-actions/upload-pep-documentation"
        Then Se obtiene una respuesta 200

    Scenario: Subir documento UIF
        When Ejecutar el método Put al endpoint
        Then Se obtiene una respuesta 200


    Scenario: Agregar cuenta bancaria
        Given Contar con la api-key "2f96-0dcb-175b-9e8a-3197-e714-0813-a924-04894ac9"
        And Contar con la urlBase "https://sandbox.manteca.dev/cambio"
        When Asignar el valor "userAnyId" a la variable "userAnyId"
        And Asignar el valor "1430001713018822310016" a la variable "address"
        And Asignar el valor "ARS" a la variable "currency"
        And Asignar el valor "MP" a la variable "description"
        And Ejecutar el método Post al endpoint "/v3/onboarding-actions/add-bank-account"
        Then Se obtiene una respuesta 204
