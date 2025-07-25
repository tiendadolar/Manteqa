@Pix
Feature: Sintetico Pix

  #Setear apikeys y users de acuerdo a la tabla examples al final del feature
  #Mantenerla actualizada
  @V1endpoint @Fiat @Desc
  Scenario: Ejecución del lock de pago Pix vía pix endpoint
    Given The API key is available "99QM9HQ-9JWM288-NHEZ6RB-2NBDZP3"
    And The urlBase is available "https://sandbox.manteca.dev/crypto"
    When Assign the value "100007955" to the variable "userAnyId"
    And Assign the value "pixmanualamount" to the variable "qrCode"
    And Assign the value "10" to the variable "amount"
    And Assign the value "ARS" to the variable "against"
    And Execute the POST method on the endpoint "/v2/pix-locks"
    Then Obtain a response 201
    And The price LockPix is created

  # Examples:
  #   | endpoint          | userAnyId | qrCode          | amount | against |
  #   | /v2/pix-locks     | test-1    | pixmanualamount | 10     | ARS     |
  #   | /v2/payment-locks | test-1    | pixmanualamount | 10     | ARS     |

  @V1endpoint @Fiat @Desc
  Scenario: Creación del síntetico de pago Pix vía pix endpoint
    Given The API key is available "99QM9HQ-9JWM288-NHEZ6RB-2NBDZP3"
    And The urlBase is available "https://sandbox.manteca.dev/crypto"
    When Assign the value "automation-test-n" to the variable "sessionId"
    And Assign the value "100007955" to the variable "userAnyId"
    And Assign the value "pixCode" to the variable "pixCode"
    And Execute the POST method on the endpoint "/v2/synthetics/pix-payment"
    Then Obtain a response 201
    And The payment synthetic is created

  # Examples:
  #   | userAnyId | qrCode          | amount | against |
  #   | test-1    | pixmanualamount | 10     | ARS     |
  #   | test-1    | pixmanualamount | 10     | ARS     |

  @depositoFiat @V1endpoint @Fiat
  Scenario: Generar deposito Fiat
    Given The API key is available "C10XB2Z-AG243CS-G42KB2M-4085WTF"
    And The API secret is available "rcrgtDnGxjY2AYC5qs"
    And The urlBase is available "https://sandbox.manteca.dev/crypto"
    When Assign the value "100007955" to the variable "userId"
    And Assign the value "amount" to the variable "amount"
    And Assign the value "coin" to the variable "coin"
    # And Assign the value "10000000000000000000" to the variable "bank" opcional (LOCALPAYMENT por ejemplo)
    And Execute the POST method on the endpoint "/v1/fiat/deposit"
    Then Obtain a response 201

  @V1endpoint @Crypto @Desc
  Scenario: Ejecución del lock de pago Pix vía pix endpoint
    Given The API key is available "JYM3AK8-XXGME8N-JZDQCP7-Q16T2NX"
    And The urlBase is available "https://sandbox.manteca.dev/crypto"
    When Assign the value "100007951" to the variable "userAnyId"
    And Assign the value "pixmanualamount" to the variable "qrCode"
    And Assign the value "10" to the variable "amount"
    And Assign the value "USDT" to the variable "against"
    And Execute the POST method on the endpoint "/v2/pix-locks"
    Then Obtain a response 201
    And The price LockPix is created

  @V1endpoint @Crypto @Desc
  Scenario: Creación del síntetico de pago Pix vía pix endpoint
    Given The API key is available "JYM3AK8-XXGME8N-JZDQCP7-Q16T2NX"
    And The urlBase is available "https://sandbox.manteca.dev/crypto"
    When Assign the value "automation-test-n" to the variable "sessionId"
    And Assign the value "100007951" to the variable "userAnyId"
    And Assign the value "pixCode" to the variable "pixCode"
    And Execute the POST method on the endpoint "/v2/synthetics/pix-payment"
    Then Obtain a response 201
    And The payment synthetic is created

  @depositoCrypto @V1endpoint @Crypto
  Scenario: Generar deposito Crypto
    Given The API key is available "C10XB2Z-AG243CS-G42KB2M-4085WTF"
    And The API secret is available "BuFJx56wuzdQArJktt"
    And The urlBase is available "https://sandbox.manteca.dev/crypto"
    When Assign the value "0of00s808a0s0a0d0000129tfd00000f00f0c0cz00fi00efb0000t00000i1g0f" to the variable "hash"
    And Assign the value "0x9bD31d82B6212dd60a9328CCe7277161e5975fB5" to the variable "from"
    And Assign the value "0xcE1A444CeAFB3E5b4ee801d8C3cEe75a7a1aE7dE" to the variable "to"
    And Assign the value "10000000000000000000" to the variable "wei"
    And Assign the value "10" to the variable "human"
    And Assign the value "USDT" to the variable "ticker"
    And Assign the value 0 to the variable "chain"
    And Execute the POST method on the endpoint "/v1/transaction/deposit"
    Then Obtain a response 201

  @V2endpoint @Crypto
  Scenario: Ejecución del lock de pago Pix vía qr3.0 endpoint
    Given The API key is available "GHJXE4N-J4C432Z-KCNNAN3-PYC7X1N"
    And The urlBase is available "https://sandbox.manteca.dev/crypto"
    When Assign the value "100007676" to the variable "userAnyId"
    And Assign the value "pixmanualamount" to the variable "qrCode"
    And Assign the value "8" to the variable "amount"
    And Assign the value "USDT" to the variable "against"
    And Execute the POST method on the endpoint "/v2/payment-locks"
    Then Obtain a response 201
    And The price LockPix is created

  @V2endpoint @Crypto
  Scenario: Creación del síntetico de pago Pix vía qr3.0 endpoint
    Given The API key is available "GHJXE4N-J4C432Z-KCNNAN3-PYC7X1N"
    And The urlBase is available "https://sandbox.manteca.dev/crypto"
    When Assign the value "automation-test-n" to the variable "sessionId"
    And Assign the value "100007676" to the variable "userAnyId"
    And Assign the value "pixCode" to the variable "pixCode"
    And Execute the POST method on the endpoint "/v2/synthetics/qr-payment"
    Then Obtain a response 201
    And The payment synthetic is created

  @depositoCrypto @V2endpoint @Crypto
  Scenario: Generar deposito Crypto
    Given The API key is available "C10XB2Z-AG243CS-G42KB2M-4085WTF"
    And The API secret is available "BuFJx56wuzdQArJktt"
    And The urlBase is available "https://sandbox.manteca.dev/crypto"
    When Assign the value "0of00s808a0s0a0d0000129tfd00000f00f0c0cz00fi00efb0000t00000i1g0f" to the variable "hash"
    And Assign the value "0x9bD31d82B6212dd60a9328CCe7277161e5975fB5" to the variable "from"
    And Assign the value "0x96E8C5474f4D1fa9f4097b9B9de3f14E65Cb98Ed" to the variable "to"
    And Assign the value "10000000000000000000" to the variable "wei"
    And Assign the value "10" to the variable "human"
    And Assign the value "USDT" to the variable "ticker"
    And Assign the value 0 to the variable "chain"
    And Execute the POST method on the endpoint "/v1/transaction/deposit"
    Then Obtain a response 201

  @V2endpoint @Fiat @Desc
  Scenario: Ejecución del lock de pago Pix vía qr3.0 endpoint
    Given The API key is available "99QM9HQ-9JWM288-NHEZ6RB-2NBDZP3"
    And The urlBase is available "https://sandbox.manteca.dev/crypto"
    When Assign the value "100007955" to the variable "userAnyId"
    And Assign the value "pixmanualamount" to the variable "qrCode"
    And Assign the value "5" to the variable "amount"
    And Assign the value "ARS" to the variable "against"
    And Execute the POST method on the endpoint "/v2/payment-locks"
    Then Obtain a response 201
    And The price LockPix is created

  @V2endpoint @Fiat @Desc
  Scenario: Creación del síntetico de pago Pix vía qr3.0 endpoint
    Given The API key is available "99QM9HQ-9JWM288-NHEZ6RB-2NBDZP3"
    And The urlBase is available "https://sandbox.manteca.dev/crypto"
    When Assign the value "automation-test-n" to the variable "sessionId"
    And Assign the value "100007955" to the variable "userAnyId"
    And Assign the value "pixCode" to the variable "pixCode"
    And Execute the POST method on the endpoint "/v2/synthetics/qr-payment"
    Then Obtain a response 201
    And The payment synthetic is created

  @depositoFiat @V2endpoint @Fiat
  Scenario: Generar deposito Fiat
    Given The API key is available "C10XB2Z-AG243CS-G42KB2M-4085WTF"
    And The API secret is available "BuFJx56wuzdQArJktt"
    And The urlBase is available "https://sandbox.manteca.dev/crypto"
    When Assign the value "100007959" to the variable "userId"
    And Assign the value "amount" to the variable "amount"
    And Assign the value "coin" to the variable "coin"
    # And Assign the value "10000000000000000000" to the variable "bank" opcional (LOCALPAYMENT por ejemplo)
    And Execute the POST method on the endpoint "/v1/fiat/deposit"
    Then Obtain a response 201

# Scenario: Obtener el síntetico
#   Given The API key is available "GHJXE4N-J4C432Z-KCNNAN3-PYC7X1N"
#   And The urlBase is available "https://sandbox.manteca.dev/crypto"
#   When Execute the GET method on the endpoint "/v2/synthetics/{syntheticId}"
#   Then Obtain a response 200


# Examples:
#   | APIkey                          | apiSecret          | Company            | Operatoria     | User1     | Descripcion |
#   | GHJXE4N-J4C432Z-KCNNAN3-PYC7X1N | BuFJx56wuzdQArJktt | TestAutomation     | No descubierto | 100007673 | Para QR     |
#   | GHJXE4N-J4C432Z-KCNNAN3-PYC7X1N | BuFJx56wuzdQArJktt | TestAutomation     | No descubierto | 100007670 | Comodín     |
#   | JYM3AK8-XXGME8N-JZDQCP7-Q16T2NX | 15GevXUvmSAn6cyKqx | TestAutomationDesc | Descubierto    |           |             |
#   | 18V66YM-29CMYWF-Q6K7BJE-D22YR9G |                    | TestAutomationDesc | Descubierto    | 100007670 |             |