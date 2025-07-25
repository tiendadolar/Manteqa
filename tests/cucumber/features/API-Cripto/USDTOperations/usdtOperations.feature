@USDTOrders
Feature: Operaciones USDT_ARS

  Scenario: Obtener precio de par
    Given The API key "BM2YZT6-MR5M5YY-QYZ5CY4-E8E9HYB" is available
    And The urlBase is available "https://sandbox.manteca.dev/crypto"
    When Execute the GET method on the endpoint "<endpoint>"
    Then Obtain a response 200
    # Pulir check de las respuestas then

    Examples:
      | endpoint           |
      | /v1/price/USDT_ARS |
      | /v1/price/USDC_ARS |
      | /v1/price/WLD_ARS  |

  Scenario: Obtener precio de par histórico
    Given The API key is available "BM2YZT6-MR5M5YY-QYZ5CY4-E8E9HYB"
    And The urlBase is available "https://sandbox.manteca.dev/crypto"
    When Execute the GET method on the endpoint "<endpoint>"
    Then Obtain a response 200
    # Pulir check de las respuestas then

    Examples:
      | endpoint                                   |
      | /v1/price/USDT_ARS/history?timeframe=daily |
      | /v1/price/USDC_ARS/history?timeframe=daily |
      | /v1/price/WLD_ARS/history?timeframe=daily  |

  Scenario: Obtener precio de par vía Doug
    Given The API key is available "BM2YZT6-MR5M5YY-QYZ5CY4-E8E9HYB"
    And The urlBase is available "https://doug-qa.tiendacrypto.com"
    When Execute the GET method on the endpoint "<endpoint>"
    Then Obtain a response 200
    # Pulir check de las respuestas then

    Examples:
      | endpoint           |
      | /v1/price/USDT_ARS |
      | /v1/price/USDC_ARS |
      | /v1/price/WLD_ARS  |

  Scenario: Obtener todas las ordenes por company
    Given The API key is available "BM2YZT6-MR5M5YY-QYZ5CY4-E8E9HYB"
    And The urlBase is available "https://sandbox.manteca.dev/crypto"
    When Execute the GET method on the endpoint "/v1/order/all"
    Then Obtain a response 200
    And The orders of the company are obtained

  # Para usuarios no descubiertos, modificar looselyManaged en la company
  Scenario Outline: Crear Lock de precio para compra de USDT
    Given The API key is available "BM2YZT6-MR5M5YY-QYZ5CY4-E8E9HYB"
    And The urlBase is available "https://sandbox.manteca.dev/crypto"
    When Assign the value "<coin>" to the variable "coin"
    And Assign the value "<operation>" to the variable "operation"
    And Assign the value "<userId>" to the variable "userId"
    And Execute the POST method on the endpoint "/v1/order/lock"
    Then Obtain a response 200
    And The price lock is created

    Examples:
      | coin     | operation | userId    |
      | USDT_ARS | BUY       | 100007516 |

  # Se reutiliza la lógica de pixCode para almacenar el lockCodePrice
  Scenario: Crear orden de compra de USDT
    Given The API key is available "BM2YZT6-MR5M5YY-QYZ5CY4-E8E9HYB"
    And The urlBase is available "https://sandbox.manteca.dev/crypto"
    When Assign the value "automation-test-n" to the variable "sessionId"
    And Assign the value "100007516" to the variable "userId"
    And Assign the value "2" to the variable "amount"
    And Assign the value "USDT_ARS" to the variable "coin"
    And Assign the value "BUY" to the variable "operation"
    And Assign the value "pixCode" to the variable "code"
    And Execute the POST method on the endpoint "/v1/order"
    Then Obtain a response 200
    And The purchase order is created

  Scenario Outline: Crear Lock de precio para venta de USDT
    Given The API key is available "BM2YZT6-MR5M5YY-QYZ5CY4-E8E9HYB"
    And The urlBase is available "https://sandbox.manteca.dev/crypto"
    When Assign the value "<coin>" to the variable "coin"
    And Assign the value "<operation>" to the variable "operation"
    And Assign the value "<userId>" to the variable "userId"
    And Execute the POST method on the endpoint "/v1/order/lock"
    Then Obtain a response 200
    And The price lock is created

    Examples:
      | coin     | operation | userId    |
      | USDT_ARS | SELL      | 100007516 |

  Scenario: Crear orden de venta de USDT
    Given The API key is available "BM2YZT6-MR5M5YY-QYZ5CY4-E8E9HYB"
    And The urlBase is available "https://sandbox.manteca.dev/crypto"
    When Assign the value "automation-test-n" to the variable "sessionId"
    And Assign the value "100007516" to the variable "userId"
    And Assign the value "1" to the variable "amount"
    And Assign the value "USDT_ARS" to the variable "coin"
    And Assign the value "SELL" to the variable "operation"
    And Assign the value "pixCode" to the variable "code"
    And Execute the POST method on the endpoint "/v1/order"
    Then Obtain a response 200
    And The purchase order is created

  Scenario: Crear retiro
    Given The API key is available "BM2YZT6-MR5M5YY-QYZ5CY4-E8E9HYB"
    And The urlBase is available "https://sandbox.manteca.dev/crypto"
    When Assign the value "automation-test-n" to the variable "sessionId"
    And Assign the value "100007516" to the variable "userId"
    And Assign the value "ARS" to the variable "coin"
    And Assign the value "999999999999995" to the variable "cbu"
    And Assign the value "2" to the variable "amount"
    And Execute the POST method on the endpoint "/v1/fiat/withdraw"
    Then Obtain a response 200
    And The withdraw is processed


