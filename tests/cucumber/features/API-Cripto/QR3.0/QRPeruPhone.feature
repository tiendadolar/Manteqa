@PeruPhone
Feature: QR 3.0 Peru Mobile Payment

    @Descubiertos
    Scenario Outline: Ejecutar sintético de pago "<pay>" "<accion>" contra "<against>" en descubierto para usuario "<nacionality>"
        Given The API key is available "HCV8JDA-P574VG5-MR5JYEG-HRZCP74"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        And Obtain a company debt "<coin>" balance

        # Request de lock payment
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<paymentDestination>" to the variable "paymentDestination"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<amount>" to the variable "amount"
        And Execute the POST method on the endpoint "/v2/payment-locks"
        Then Obtain a response 201 for lock payment

        # Execute synthetic payment
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "pixCode" to the variable "pixCode"
        And Execute the POST method on the endpoint "/v2/synthetics/qr-payment"
        Then Obtain a response 201

        # Get status synthetic payment
        When Wait for the processing of the "orden PIX" por 45 seconds
        And Execute the GET method on the endpoint "/v1/synthetics/{syntheticId}"
        Then Obtain a response 200 y status "COMPLETED" for payment synthetics
        And Obtain a company debt "<coin>" balance

        Examples:
            | pay | nacionality | coin | accion                  | userAnyId | paymentDestination | against | amount | sessionId      | to                                         | ticker |
            | QR  | Argentina   | USDT | pago a teléfono celular | 100010503 | +51987365083       | USDT    | 1000   | QR-PeruPhone-n | 0x862Acf26956DCEf54F4726CF88709bFE9128e500 | USDT   |
            | QR  | Peru        | USDT | pago a teléfono celular | 100010539 | +51987365083       | USDT    | 1000   | QR-PeruPhone-n | 0x862Acf26956DCEf54F4726CF88709bFE9128e500 | USDT   |

    @NoDescubiertos
    Scenario Outline: Ejecutar sintético de pago "<pay>" "<accion>" contra "<against>" en descubierto para usuario "<nacionality>" sobre el Balance User
        Given The API key is available "MBA68YQ-RXW46ZS-P4K4BAZ-D2KX43F"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        And Obtain "<against>" balance for "<userAnyId>" user

        # Request de lock payment
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<paymentDestination>" to the variable "paymentDestination"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<amount>" to the variable "amount"
        And Execute the POST method on the endpoint "/v2/payment-locks"
        Then Obtain a response 201 for lock payment

        # Execute synthetic payment
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "pixCode" to the variable "pixCode"
        And Execute the POST method on the endpoint "/v2/synthetics/qr-payment"
        Then Obtain a response 201

        # Get status synthetic payment
        When Wait for the processing of the "orden PIX" por 45 seconds
        And Execute the GET method on the endpoint "/v1/synthetics/{syntheticId}"
        Then Obtain a response 200 y status "COMPLETED" for payment synthetics
        And Obtain "<against>" balance for "<userAnyId>" user

        Examples:
            | pay | nacionality | coin | accion                  | userAnyId | paymentDestination | against | amount | sessionId      | to                                         | ticker |
            | QR  | Argentina   | USDT | pago a teléfono celular | 100010488 | +51987365083       | PEN     | 1000   | QR-PeruPhone-n | 0x862Acf26956DCEf54F4726CF88709bFE9128e500 | USDT   |
            | QR  | Peru        | USDT | pago a teléfono celular | 100010538 | +51987365083       | PEN     | 1000   | QR-PeruPhone-n | 0x862Acf26956DCEf54F4726CF88709bFE9128e500 | USDT   |


    @NoDescubiertosDeposito
    Scenario Outline: Ejecutar sintético de pago "<pay>" "<accion>" contra "<against>" no descubierto para usuario "<nacionality>"
        Given The API key is available "MBA68YQ-RXW46ZS-P4K4BAZ-D2KX43F"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"

        # Request de lock payment
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<paymentDestination>" to the variable "paymentDestination"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<amount>" to the variable "amount"
        And Execute the POST method on the endpoint "/v2/payment-locks"
        Then Obtain a response 201 for lock payment

        # Execute synthetic payment
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "pixCode" to the variable "pixCode"
        And Execute the POST method on the endpoint "/v2/synthetics/qr-payment"
        Then Obtain a response 201

        Given Execute crypto deposit

        # Get status synthetic payment
        When Wait for the processing of the "orden PIX" por 45 seconds
        And Execute the GET method on the endpoint "/v1/synthetics/{syntheticId}"
        Then Obtain a response 200 y status "COMPLETED" for payment synthetics

        Examples:
            | pay | nacionality | coin | accion                  | userAnyId | paymentDestination | against | amount | sessionId      | to                                         | ticker |
            | QR  | Argentina   | USDT | pago a teléfono celular | 100010488 | +51987365083       | USDT    | 1000   | QR-PeruPhone-n | 0x862Acf26956DCEf54F4726CF88709bFE9128e500 | USDT   |
            | QR  | Peru        | USDT | pago a teléfono celular | 100010538 | +51987365083       | USDT    | 1000   | QR-PeruPhone-n | 0x862Acf26956DCEf54F4726CF88709bFE9128e500 | USDT   |

    @BRLA
    Scenario Outline: Ejecutar sintético de pago "<pay>" "<accion>" contra "<against>" en descubierto para usuario "<nacionality>"
        Given The API key is available "M6WGHFR-DG24ABS-JDTGGRF-F3YJCW2"
        And The urlBase is available "https://api.manteca.dev/crypto"

        # Request de lock payment
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<paymentDestination>" to the variable "paymentDestination"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<amount>" to the variable "amount"
        And Execute the POST method on the endpoint "/v2/payment-locks"
        Then Obtain a response 201 for lock payment

        # Execute synthetic payment
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "pixCode" to the variable "pixCode"
        And Execute the POST method on the endpoint "/v2/synthetics/qr-payment"
        Then Obtain a response 201

        # Get status synthetic payment
        When Wait for the processing of the "orden PIX" por 45 seconds
        And Execute the GET method on the endpoint "/v1/synthetics/{syntheticId}"
        Then Obtain a response 200 y status "COMPLETED" for payment synthetics
        And Obtain a company debt "<coin>" balance

        @conco
        Examples:
            | pay | nacionality | coin | accion                  | userAnyId | paymentDestination | against | amount | sessionId      | to                                         | ticker |
            | QR  | Brasil      | BRL  | pago a teléfono celular | 2399998   | +5511949227612     | BRL     | 1000   | QR-PeruPhone-n | 0x862Acf26956DCEf54F4726CF88709bFE9128e500 | USDT   |

        @sinco
        Examples:
            | pay | nacionality | coin | accion                  | userAnyId | paymentDestination | against | amount | sessionId      | to                                         | ticker |
            | QR  | Brasil      | BRL  | pago a teléfono celular | 2399998   | +5511949227612     | BRL     | 1000   | QR-PeruPhone-n | 0x862Acf26956DCEf54F4726CF88709bFE9128e500 | USDT   |