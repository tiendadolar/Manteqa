@OrderApiCambio
Feature: Orders API-Cambio

    @Order
    Scenario: Creación de una orden de <side> USD de tipo <type> sin lock-price
        Given The API key is available "66ce-7686-b472-6cac-4430-13db-9654-009a-6b88bc83"
        And The urlBase is available "https://api-qa.tiendadolar.com.ar"
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<side>" to the variable "side"
        And Assign the value "<type>" to the variable "type"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Execute the POST method on the endpoint "/v3/api/orders/"
        Then Obtain a response 201

        Examples:
            | userAnyId                | side | type   | assetAmount |
            | 681df60f8dffa19a1c05d4ab | BUY  | DIRECT | 100         |
            | 681df60f8dffa19a1c05d4ab | SELL | DIRECT | 50          |
            | 681df60f8dffa19a1c05d4ab | BUY  | MARKET | 100         |
            | 681df60f8dffa19a1c05d4ab | SELL | MARKET | 100         |
            | 681df60f8dffa19a1c05d4ab | BUY  | LIMIT  | 100         |
            | 681df60f8dffa19a1c05d4ab | SELL | LIMIT  | 100         |

    @LockPriceBuy
    Scenario: Generación de un lock-price de compra
        Given The API key is available "66ce-7686-b472-6cac-4430-13db-9654-009a-6b88bc83"
        And The urlBase is available "https://sandbox.manteca.dev/cambio"
        When Assign the value "681df60f8dffa19a1c05d4ab" to the variable "userAnyId"
        And Assign the value "BUY" to the variable "side"
        And Assign the value "USD" to the variable "asset"
        And Assign the value "ARS" to the variable "against"
        And Execute the POST method on the endpoint "/v3/price-locks"
        Then Obtain a response 201

    @LockPriceBuy
    Scenario: Creación de una orden de compra USD de tipo direct con lock-price
        Given The API key is available "66ce-7686-b472-6cac-4430-13db-9654-009a-6b88bc83"
        And The urlBase is available "https://api-qa.tiendadolar.com.ar"
        When Assign the value "681df60f8dffa19a1c05d4ab" to the variable "userAnyId"
        And Assign the value "BUY" to the variable "side"
        And Assign the value "DIRECT" to the variable "type"
        And Assign the value "10" to the variable "assetAmount"
        And Assign the value "pixCode" to the variable "pixCode"
        And Execute the POST method on the endpoint "/v3/api/orders/"
        Then Obtain a response 201

    @LockPriceSell
    Scenario: Generación de un lock-price de venta
        Given The API key is available "66ce-7686-b472-6cac-4430-13db-9654-009a-6b88bc83"
        And The urlBase is available "https://sandbox.manteca.dev/cambio"
        When Assign the value "6812e5c9da0292039eb0fc71" to the variable "userAnyId"
        And Assign the value "SELL" to the variable "side"
        And Assign the value "USD" to the variable "asset"
        And Assign the value "ARS" to the variable "against"
        And Execute the POST method on the endpoint "/v3/price-locks"
        Then Obtain a response 201

    @LockPriceSell
    Scenario: Creación de una orden de venta USD de tipo direct con lock-price
        Given The API key is available "66ce-7686-b472-6cac-4430-13db-9654-009a-6b88bc83"
        And The urlBase is available "https://api-qa.tiendadolar.com.ar"
        When Assign the value "6812e5c9da0292039eb0fc71" to the variable "userAnyId"
        And Assign the value "SELL" to the variable "side"
        And Assign the value "DIRECT" to the variable "type"
        And Assign the value "10" to the variable "assetAmount"
        And Assign the value "pixCode" to the variable "pixCode"
        And Execute the POST method on the endpoint "/v3/api/orders/"
        Then Obtain a response 201



# #Datos utilizados
# | company               | apikey                                           | companyId                | userAnyId                | opera          |
# | Company Orders (Desc) | 66ce-7686-b472-6cac-4430-13db-9654-009a-6b88bc83 | 6812e5c9da0292039eb0fc71 | 681df60f8dffa19a1c05d4ab | DESCUBIERTO    |
# | Company Orders NoDesc | bc0f-6187-d2c1-67e7-5f88-5504-075a-caa8-66c24e68 | 681e3eef53061c3925f3556c | 681e3fedad113b8233600f1d | NO DESCUBIERTO |
