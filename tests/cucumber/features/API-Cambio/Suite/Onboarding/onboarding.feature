@OnboardingApiCambioRegression @Regression
Feature: Onboarding API-Cambio

    @InitialOnboarding
    Scenario: Onboarding inicial de usuario
        Given Contar con la api-key "bd69-f82c-c372-5bb6-3248-45e9-99f5-5035-7581106d"
        And Contar con la urlBase "https://api-qa.tiendadolar.com.ar"
        When Asignar el valor "yop@gmail.com" a la variable "email"
        And Asignar el valor "20377382122" a la variable "legalId"
        And Asignar el valor "M" a la variable "sex"
        And Asignar el valor "CULTIVO DE ARROZ" a la variable "work"
        And Asignar el valor "1999-05-15" a la variable "birthDate"
        And Asignar el valor "Soltero" a la variable "maritalStatus"
        And Asignar el valor "false" a la variable "isPep"
        And Asignar el valor "false" a la variable "isFep"
        And Asignar el valor "false" a la variable "isFatca"
        And Asignar el valor "false" a la variable "isUif"
        And Asignar el valor "1124001061" a la variable "phoneNumber"
        And Asignar el valor "Argentina" a la variable "nationality"
        And Asignar el valor "0000003100000341514293" a la variable "ARScbu"
        And Asignar el valor "ARS" a la variable "ARScurrency"
        And Asignar el valor "HSCB ARS" a la variable "ARSdescription"
        And Asignar el valor "0000003100000341514293" a la variable "USDcbu"
        And Asignar el valor "USD" a la variable "USDcurrency"
        And Asignar el valor "Galicia USD" a la variable "USDdescription"
        And Ejecutar el método Post al endpoint "/v3/api/onboarding-actions/initial"
        Then Se obtiene una respuesta 201
        And Se crea el usuario