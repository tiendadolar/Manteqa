@OrderApiCambio
Feature: Orders API-Cambio

    @Order
    Scenario: Creación de una orden de <side> USD de tipo <type> sin lock-price
        Given Contar con la api-key "66ce-7686-b472-6cac-4430-13db-9654-009a-6b88bc83"
        And Contar con la urlBase "https://api-qa.tiendadolar.com.ar"
        When Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "<side>" a la variable "side"
        And Asignar el valor "<type>" a la variable "type"
        And Asignar el valor "<assetAmount>" a la variable "assetAmount"
        And Ejecutar el método Post al endpoint "/v3/api/orders/"
        Then Se obtiene una respuesta 201

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
        Given Contar con la api-key "66ce-7686-b472-6cac-4430-13db-9654-009a-6b88bc83"
        And Contar con la urlBase "https://sandbox.manteca.dev/cambio"
        When Asignar el valor "681df60f8dffa19a1c05d4ab" a la variable "userAnyId"
        And Asignar el valor "BUY" a la variable "side"
        And Asignar el valor "USD" a la variable "asset"
        And Asignar el valor "ARS" a la variable "against"
        And Ejecutar el método Post al endpoint "/v3/price-locks"
        Then Se obtiene una respuesta 201

    @LockPriceBuy
    Scenario: Creación de una orden de compra USD de tipo direct con lock-price
        Given Contar con la api-key "66ce-7686-b472-6cac-4430-13db-9654-009a-6b88bc83"
        And Contar con la urlBase "https://api-qa.tiendadolar.com.ar"
        When Asignar el valor "681df60f8dffa19a1c05d4ab" a la variable "userAnyId"
        And Asignar el valor "BUY" a la variable "side"
        And Asignar el valor "DIRECT" a la variable "type"
        And Asignar el valor "10" a la variable "assetAmount"
        And Asignar el valor "pixCode" a la variable "pixCode"
        And Ejecutar el método Post al endpoint "/v3/api/orders/"
        Then Se obtiene una respuesta 201

    @LockPriceSell
    Scenario: Generación de un lock-price de venta
        Given Contar con la api-key "66ce-7686-b472-6cac-4430-13db-9654-009a-6b88bc83"
        And Contar con la urlBase "https://sandbox.manteca.dev/cambio"
        When Asignar el valor "6812e5c9da0292039eb0fc71" a la variable "userAnyId"
        And Asignar el valor "SELL" a la variable "side"
        And Asignar el valor "USD" a la variable "asset"
        And Asignar el valor "ARS" a la variable "against"
        And Ejecutar el método Post al endpoint "/v3/price-locks"
        Then Se obtiene una respuesta 201

    @LockPriceSell
    Scenario: Creación de una orden de venta USD de tipo direct con lock-price
        Given Contar con la api-key "66ce-7686-b472-6cac-4430-13db-9654-009a-6b88bc83"
        And Contar con la urlBase "https://api-qa.tiendadolar.com.ar"
        When Asignar el valor "6812e5c9da0292039eb0fc71" a la variable "userAnyId"
        And Asignar el valor "SELL" a la variable "side"
        And Asignar el valor "DIRECT" a la variable "type"
        And Asignar el valor "10" a la variable "assetAmount"
        And Asignar el valor "pixCode" a la variable "pixCode"
        And Ejecutar el método Post al endpoint "/v3/api/orders/"
        Then Se obtiene una respuesta 201



# #Datos utilizados
# | company               | apikey                                           | companyId                | userAnyId                | opera          |
# | Company Orders (Desc) | 66ce-7686-b472-6cac-4430-13db-9654-009a-6b88bc83 | 6812e5c9da0292039eb0fc71 | 681df60f8dffa19a1c05d4ab | DESCUBIERTO    |
# | Company Orders NoDesc | bc0f-6187-d2c1-67e7-5f88-5504-075a-caa8-66c24e68 | 681e3eef53061c3925f3556c | 681e3fedad113b8233600f1d | NO DESCUBIERTO |
