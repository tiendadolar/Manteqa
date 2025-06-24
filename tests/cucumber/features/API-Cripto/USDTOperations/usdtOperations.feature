@USDTOrders
Feature: Operaciones USDT_ARS

  Scenario: Obtener precio de par
    Given Contar con la api-key "BM2YZT6-MR5M5YY-QYZ5CY4-E8E9HYB"
    And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
    When Ejecutar el método Get al endpoint "<endpoint>"
    Then Se obtiene una respuesta 200
    # Pulir check de las respuestas then

    Examples:
      | endpoint           |
      | /v1/price/USDT_ARS |
      | /v1/price/USDC_ARS |
      | /v1/price/WLD_ARS  |

  Scenario: Obtener precio de par histórico
    Given Contar con la api-key "BM2YZT6-MR5M5YY-QYZ5CY4-E8E9HYB"
    And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
    When Ejecutar el método Get al endpoint "<endpoint>"
    Then Se obtiene una respuesta 200
    # Pulir check de las respuestas then

    Examples:
      | endpoint                                   |
      | /v1/price/USDT_ARS/history?timeframe=daily |
      | /v1/price/USDC_ARS/history?timeframe=daily |
      | /v1/price/WLD_ARS/history?timeframe=daily  |

  Scenario: Obtener precio de par vía Doug
    Given Contar con la api-key "BM2YZT6-MR5M5YY-QYZ5CY4-E8E9HYB"
    And Contar con la urlBase "https://doug-qa.tiendacrypto.com"
    When Ejecutar el método Get al endpoint "<endpoint>"
    Then Se obtiene una respuesta 200
    # Pulir check de las respuestas then

    Examples:
      | endpoint           |
      | /v1/price/USDT_ARS |
      | /v1/price/USDC_ARS |
      | /v1/price/WLD_ARS  |

  Scenario: Obtener todas las ordenes por company
    Given Contar con la api-key "BM2YZT6-MR5M5YY-QYZ5CY4-E8E9HYB"
    And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
    When Ejecutar el método Get al endpoint "/v1/order/all"
    Then Se obtiene una respuesta 200
    And Se obtienen las ordenes de la company

  # Para usuarios no descubiertos, modificar looselyManaged en la company
  Scenario Outline: Crear Lock de precio para compra de USDT
    Given Contar con la api-key "BM2YZT6-MR5M5YY-QYZ5CY4-E8E9HYB"
    And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
    When Asignar el valor "<coin>" a la variable "coin"
    And Asignar el valor "<operation>" a la variable "operation"
    And Asignar el valor "<userId>" a la variable "userId"
    And Ejecutar el método Post al endpoint "/v1/order/lock"
    Then Se obtiene una respuesta 200
    And Se crea el Lock de precio

    Examples:
      | coin     | operation | userId    |
      | USDT_ARS | BUY       | 100007516 |

  # Se reutiliza la lógica de pixCode para almacenar el lockCodePrice
  Scenario: Crear orden de compra de USDT
    Given Contar con la api-key "BM2YZT6-MR5M5YY-QYZ5CY4-E8E9HYB"
    And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
    When Asignar el valor "automation-test-n" a la variable "sessionId"
    And Asignar el valor "100007516" a la variable "userId"
    And Asignar el valor "2" a la variable "amount"
    And Asignar el valor "USDT_ARS" a la variable "coin"
    And Asignar el valor "BUY" a la variable "operation"
    And Asignar el valor "pixCode" a la variable "code"
    And Ejecutar el método Post al endpoint "/v1/order"
    Then Se obtiene una respuesta 200
    And Se crea la orden de compra

  Scenario Outline: Crear Lock de precio para venta de USDT
    Given Contar con la api-key "BM2YZT6-MR5M5YY-QYZ5CY4-E8E9HYB"
    And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
    When Asignar el valor "<coin>" a la variable "coin"
    And Asignar el valor "<operation>" a la variable "operation"
    And Asignar el valor "<userId>" a la variable "userId"
    And Ejecutar el método Post al endpoint "/v1/order/lock"
    Then Se obtiene una respuesta 200
    And Se crea el Lock de precio

    Examples:
      | coin     | operation | userId    |
      | USDT_ARS | SELL      | 100007516 |

  Scenario: Crear orden de venta de USDT
    Given Contar con la api-key "BM2YZT6-MR5M5YY-QYZ5CY4-E8E9HYB"
    And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
    When Asignar el valor "automation-test-n" a la variable "sessionId"
    And Asignar el valor "100007516" a la variable "userId"
    And Asignar el valor "1" a la variable "amount"
    And Asignar el valor "USDT_ARS" a la variable "coin"
    And Asignar el valor "SELL" a la variable "operation"
    And Asignar el valor "pixCode" a la variable "code"
    And Ejecutar el método Post al endpoint "/v1/order"
    Then Se obtiene una respuesta 200
    And Se crea la orden de compra

  Scenario: Crear retiro
    Given Contar con la api-key "BM2YZT6-MR5M5YY-QYZ5CY4-E8E9HYB"
    And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
    When Asignar el valor "automation-test-n" a la variable "sessionId"
    And Asignar el valor "100007516" a la variable "userId"
    And Asignar el valor "ARS" a la variable "coin"
    And Asignar el valor "999999999999995" a la variable "cbu"
    And Asignar el valor "2" a la variable "amount"
    And Ejecutar el método Post al endpoint "/v1/fiat/withdraw"
    Then Se obtiene una respuesta 200
    And Se opera el retiro


