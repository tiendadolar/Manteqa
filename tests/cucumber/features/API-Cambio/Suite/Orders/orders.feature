@OrderApiCambioRegression @Regression
Feature: Orders API-Cambio suite

    Background:
        Given Contar con la api-key "35c1-346c-3340-ef74-669b-6792-7f81-66d3-59a808fc"

    Scenario Outline: Validar lock-price de <operacion>
        And Contar con la urlBase "https://sandbox.manteca.dev/cambio"
        When Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "<side>" a la variable "side"
        And Asignar el valor "<asset>" a la variable "asset"
        And Asignar el valor "<against>" a la variable "against"
        And Ejecutar el método Post al endpoint "/v3/price-locks"
        Then Se obtiene una respuesta 201
        And Se crea el lock-price

        Examples:
            | operacion | userAnyId                | side | asset | against |
            | Compra    | 6810c53d28bd8cdec8d64b83 | BUY  | USD   | ARS     |
            | Venta     | 6810c53d28bd8cdec8d64b83 | SELL | USD   | ARS     |
