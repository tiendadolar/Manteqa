@OnboardingApiCambioRegression @Regression
Feature: Onboarding API-Cambio

    @InitialOnboarding
    Scenario: Onboarding inicial de usuario
        Given The API key is available "bd69-f82c-c372-5bb6-3248-45e9-99f5-5035-7581106d"
        And The urlBase is available "https://api-qa.tiendadolar.com.ar"
        When Assign the value "yop@gmail.com" to the variable "email"
        And Assign the value "20377382122" to the variable "legalId"
        And Assign the value "M" to the variable "sex"
        And Assign the value "CULTIVO DE ARROZ" to the variable "work"
        And Assign the value "1999-05-15" to the variable "birthDate"
        And Assign the value "Soltero" to the variable "maritalStatus"
        And Assign the value "false" to the variable "isPep"
        And Assign the value "false" to the variable "isFep"
        And Assign the value "false" to the variable "isFatca"
        And Assign the value "false" to the variable "isUif"
        And Assign the value "1124001061" to the variable "phoneNumber"
        And Assign the value "Argentina" to the variable "nationality"
        And Assign the value "0000003100000341514293" to the variable "ARScbu"
        And Assign the value "ARS" to the variable "ARScurrency"
        And Assign the value "HSCB ARS" to the variable "ARSdescription"
        And Assign the value "0000003100000341514293" to the variable "USDcbu"
        And Assign the value "USD" to the variable "USDcurrency"
        And Assign the value "Galicia USD" to the variable "USDdescription"
        And Execute the POST method on the endpoint "/v3/api/onboarding-actions/initial"
        Then Obtain a response 201
        And The user is created