@OrderApiCambioRegression @Regression
Feature: Orders API-Cambio suite

    Background:
        Given The API key is available "35c1-346c-3340-ef74-669b-6792-7f81-66d3-59a808fc"

    Scenario Outline: Validar lock-price de <operacion>
        And The urlBase is available "https://sandbox.manteca.dev/cambio"
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<side>" to the variable "side"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Execute the POST method on the endpoint "/v3/price-locks"
        Then Obtain a response 201
        And The lock-price is created

        Examples:
            | operacion | userAnyId                | side | asset | against |
            | Compra    | 6810c53d28bd8cdec8d64b83 | BUY  | USD   | ARS     |
            | Venta     | 6810c53d28bd8cdec8d64b83 | SELL | USD   | ARS     |
