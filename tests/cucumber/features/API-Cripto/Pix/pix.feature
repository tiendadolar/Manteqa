@Pix
Feature: Sintetico Pix

  #Setear apikeys y users de acuerdo a la tabla examples al final del feature
  #Mantenerla actualizada
  @V1endpoint @Fiat @Desc
  Scenario: Ejecución del lock de pago Pix vía pix endpoint
    Given Contar con la api-key "99QM9HQ-9JWM288-NHEZ6RB-2NBDZP3"
    And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
    When Asignar el valor "100007955" a la variable "userAnyId"
    And Asignar el valor "pixmanualamount" a la variable "qrCode"
    And Asignar el valor "10" a la variable "amount"
    And Asignar el valor "ARS" a la variable "against"
    And Ejecutar el método Post al endpoint "/v2/pix-locks"
    Then Se obtiene una respuesta 201
    And Se crea el LockPix de precio

  # Examples:
  #   | endpoint          | userAnyId | qrCode          | amount | against |
  #   | /v2/pix-locks     | test-1    | pixmanualamount | 10     | ARS     |
  #   | /v2/payment-locks | test-1    | pixmanualamount | 10     | ARS     |

  @V1endpoint @Fiat @Desc
  Scenario: Creación del síntetico de pago Pix vía pix endpoint
    Given Contar con la api-key "99QM9HQ-9JWM288-NHEZ6RB-2NBDZP3"
    And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
    When Asignar el valor "automation-test-n" a la variable "sessionId"
    And Asignar el valor "100007955" a la variable "userAnyId"
    And Asignar el valor "pixCode" a la variable "pixCode"
    And Ejecutar el método Post al endpoint "/v2/synthetics/pix-payment"
    Then Se obtiene una respuesta 201
    And Se crea el sintetico de pago

  # Examples:
  #   | userAnyId | qrCode          | amount | against |
  #   | test-1    | pixmanualamount | 10     | ARS     |
  #   | test-1    | pixmanualamount | 10     | ARS     |

  @depositoFiat @V1endpoint @Fiat
  Scenario: Generar deposito Fiat
    Given Contar con la api-key "C10XB2Z-AG243CS-G42KB2M-4085WTF"
    And Contar con la api-secret "rcrgtDnGxjY2AYC5qs"
    And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
    When Asignar el valor "100007955" a la variable "userId"
    And Asignar el valor "amount" a la variable "amount"
    And Asignar el valor "coin" a la variable "coin"
    # And Asignar el valor "10000000000000000000" a la variable "bank" opcional (LOCALPAYMENT por ejemplo)
    And Ejecutar el método Post al endpoint "/v1/fiat/deposit"
    Then Se obtiene una respuesta 201

  @V1endpoint @Crypto @Desc
  Scenario: Ejecución del lock de pago Pix vía pix endpoint
    Given Contar con la api-key "JYM3AK8-XXGME8N-JZDQCP7-Q16T2NX"
    And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
    When Asignar el valor "100007951" a la variable "userAnyId"
    And Asignar el valor "pixmanualamount" a la variable "qrCode"
    And Asignar el valor "10" a la variable "amount"
    And Asignar el valor "USDT" a la variable "against"
    And Ejecutar el método Post al endpoint "/v2/pix-locks"
    Then Se obtiene una respuesta 201
    And Se crea el LockPix de precio

  @V1endpoint @Crypto @Desc
  Scenario: Creación del síntetico de pago Pix vía pix endpoint
    Given Contar con la api-key "JYM3AK8-XXGME8N-JZDQCP7-Q16T2NX"
    And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
    When Asignar el valor "automation-test-n" a la variable "sessionId"
    And Asignar el valor "100007951" a la variable "userAnyId"
    And Asignar el valor "pixCode" a la variable "pixCode"
    And Ejecutar el método Post al endpoint "/v2/synthetics/pix-payment"
    Then Se obtiene una respuesta 201
    And Se crea el sintetico de pago

  @depositoCrypto @V1endpoint @Crypto
  Scenario: Generar deposito Crypto
    Given Contar con la api-key "C10XB2Z-AG243CS-G42KB2M-4085WTF"
    And Contar con la api-secret "BuFJx56wuzdQArJktt"
    And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
    When Asignar el valor "0of00s808a0s0a0d0000129tfd00000f00f0c0cz00fi00efb0000t00000i1g0f" a la variable "hash"
    And Asignar el valor "0x9bD31d82B6212dd60a9328CCe7277161e5975fB5" a la variable "from"
    And Asignar el valor "0xcE1A444CeAFB3E5b4ee801d8C3cEe75a7a1aE7dE" a la variable "to"
    And Asignar el valor "10000000000000000000" a la variable "wei"
    And Asignar el valor "10" a la variable "human"
    And Asignar el valor "USDT" a la variable "ticker"
    And Asignar el valor 0 a la variable "chain"
    And Ejecutar el método Post al endpoint "/v1/transaction/deposit"
    Then Se obtiene una respuesta 201

  @V2endpoint @Crypto
  Scenario: Ejecución del lock de pago Pix vía qr3.0 endpoint
    Given Contar con la api-key "GHJXE4N-J4C432Z-KCNNAN3-PYC7X1N"
    And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
    When Asignar el valor "100007676" a la variable "userAnyId"
    And Asignar el valor "pixmanualamount" a la variable "qrCode"
    And Asignar el valor "8" a la variable "amount"
    And Asignar el valor "USDT" a la variable "against"
    And Ejecutar el método Post al endpoint "/v2/payment-locks"
    Then Se obtiene una respuesta 201
    And Se crea el LockPix de precio

  @V2endpoint @Crypto
  Scenario: Creación del síntetico de pago Pix vía qr3.0 endpoint
    Given Contar con la api-key "GHJXE4N-J4C432Z-KCNNAN3-PYC7X1N"
    And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
    When Asignar el valor "automation-test-n" a la variable "sessionId"
    And Asignar el valor "100007676" a la variable "userAnyId"
    And Asignar el valor "pixCode" a la variable "pixCode"
    And Ejecutar el método Post al endpoint "/v2/synthetics/qr-payment"
    Then Se obtiene una respuesta 201
    And Se crea el sintetico de pago

  @depositoCrypto @V2endpoint @Crypto
  Scenario: Generar deposito Crypto
    Given Contar con la api-key "C10XB2Z-AG243CS-G42KB2M-4085WTF"
    And Contar con la api-secret "BuFJx56wuzdQArJktt"
    And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
    When Asignar el valor "0of00s808a0s0a0d0000129tfd00000f00f0c0cz00fi00efb0000t00000i1g0f" a la variable "hash"
    And Asignar el valor "0x9bD31d82B6212dd60a9328CCe7277161e5975fB5" a la variable "from"
    And Asignar el valor "0x96E8C5474f4D1fa9f4097b9B9de3f14E65Cb98Ed" a la variable "to"
    And Asignar el valor "10000000000000000000" a la variable "wei"
    And Asignar el valor "10" a la variable "human"
    And Asignar el valor "USDT" a la variable "ticker"
    And Asignar el valor 0 a la variable "chain"
    And Ejecutar el método Post al endpoint "/v1/transaction/deposit"
    Then Se obtiene una respuesta 201

  @V2endpoint @Fiat @Desc
  Scenario: Ejecución del lock de pago Pix vía qr3.0 endpoint
    Given Contar con la api-key "99QM9HQ-9JWM288-NHEZ6RB-2NBDZP3"
    And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
    When Asignar el valor "100007955" a la variable "userAnyId"
    And Asignar el valor "pixmanualamount" a la variable "qrCode"
    And Asignar el valor "5" a la variable "amount"
    And Asignar el valor "ARS" a la variable "against"
    And Ejecutar el método Post al endpoint "/v2/payment-locks"
    Then Se obtiene una respuesta 201
    And Se crea el LockPix de precio

  @V2endpoint @Fiat @Desc
  Scenario: Creación del síntetico de pago Pix vía qr3.0 endpoint
    Given Contar con la api-key "99QM9HQ-9JWM288-NHEZ6RB-2NBDZP3"
    And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
    When Asignar el valor "automation-test-n" a la variable "sessionId"
    And Asignar el valor "100007955" a la variable "userAnyId"
    And Asignar el valor "pixCode" a la variable "pixCode"
    And Ejecutar el método Post al endpoint "/v2/synthetics/qr-payment"
    Then Se obtiene una respuesta 201
    And Se crea el sintetico de pago

  @depositoFiat @V2endpoint @Fiat
  Scenario: Generar deposito Fiat
    Given Contar con la api-key "C10XB2Z-AG243CS-G42KB2M-4085WTF"
    And Contar con la api-secret "BuFJx56wuzdQArJktt"
    And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
    When Asignar el valor "100007959" a la variable "userId"
    And Asignar el valor "amount" a la variable "amount"
    And Asignar el valor "coin" a la variable "coin"
    # And Asignar el valor "10000000000000000000" a la variable "bank" opcional (LOCALPAYMENT por ejemplo)
    And Ejecutar el método Post al endpoint "/v1/fiat/deposit"
    Then Se obtiene una respuesta 201

# Scenario: Obtener el síntetico
#   Given Contar con la api-key "GHJXE4N-J4C432Z-KCNNAN3-PYC7X1N"
#   And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
#   When Ejecutar el método Get al endpoint "/v2/synthetics/{syntheticId}"
#   Then Se obtiene una respuesta 200


# Examples:
#   | APIkey                          | apiSecret          | Company            | Operatoria     | User1     | Descripcion |
#   | GHJXE4N-J4C432Z-KCNNAN3-PYC7X1N | BuFJx56wuzdQArJktt | TestAutomation     | No descubierto | 100007673 | Para QR     |
#   | GHJXE4N-J4C432Z-KCNNAN3-PYC7X1N | BuFJx56wuzdQArJktt | TestAutomation     | No descubierto | 100007670 | Comodín     |
#   | JYM3AK8-XXGME8N-JZDQCP7-Q16T2NX | 15GevXUvmSAn6cyKqx | TestAutomationDesc | Descubierto    |           |             |
#   | 18V66YM-29CMYWF-Q6K7BJE-D22YR9G |                    | TestAutomationDesc | Descubierto    | 100007670 |             |