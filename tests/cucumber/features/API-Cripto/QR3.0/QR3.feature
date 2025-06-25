@QR
Feature: Sintético QR 3.0

    @INTest
    Scenario: Ejecución del lock de pago QR 3.0 vía qr endpoint
        Given Contar con la api-key "99QM9HQ-9JWM288-NHEZ6RB-2NBDZP3"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "100007956" a la variable "userAnyId"
        And Asignar el valor "00020101021140200010com.yacare02022350150011336972350495204858553030325802AR5910HAVANNA SA6012BUENOS AIRES81220010com.yacare0204Y2156304E401" a la variable "qrCode"
        And Asignar el valor "2200" a la variable "amount"
        And Ejecutar el método Post al endpoint "/v2/payment-locks"
        Then Se obtiene una respuesta 201
        And Se crea el LockPix de precio

    @INTest
    Scenario: Creación del síntetico de pago QR 3.0 vía qr endpoint
        Given Contar con la api-key "99QM9HQ-9JWM288-NHEZ6RB-2NBDZP3"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "automation-test-n" a la variable "sessionId"
        And Asignar el valor "100007956" a la variable "userAnyId"
        And Asignar el valor "pixCode" a la variable "pixCode"
        And Ejecutar el método Post al endpoint "/v2/synthetics/qr-payment"
        Then Se obtiene una respuesta 201
        And Se crea el sintetico de pago

    @INTest
    Scenario: Generar deposito Crypto
        Given Contar con la api-key "C10XB2Z-AG243CS-G42KB2M-4085WTF"
        And Contar con la api-secret "rcrgtDnGxjY2AYC5qs"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "0of00s808a0s0a0d0000129tfd00000f00f0c0cz00fi00efb0000t00000i1g0f" a la variable "hash"
        And Asignar el valor "0x9bD31d82B6212dd60a9328CCe7277161e5975fB5" a la variable "from"
        And Asignar el valor "0x2C6e6C7B3855EB945bF01DcB715131e039871C74" a la variable "to"
        And Asignar el valor "10000000000000000000" a la variable "wei"
        And Asignar el valor "10" a la variable "human"
        And Asignar el valor "USDT" a la variable "ticker"
        And Asignar el valor 0 a la variable "chain"
        And Ejecutar el método Post al endpoint "/v1/transaction/deposit"
        Then Se obtiene una respuesta 201

    # **** SUITE ****
    # ! NO TOCAR DATOS
    # ------ NO DESCUBIERTOS -------
    # ------ QR V1 ------
    @Smoke @QRV1NoDesc
    Scenario Outline: Ejecutar sintético de pago QR embebido contra USDT en no descubierto vía V1 endpoints
        Given Contar con la api-key "95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "<qrCode>" a la variable "qrCode"
        And Asignar el valor "<amount>" a la variable "amount"
        And Ejecutar el método Post al endpoint "/v2/pix-locks"
        Then Se obtiene una respuesta 201

        When Asignar el valor "<sessionId>" a la variable "sessionId"
        And Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "pixCode" a la variable "pixCode"
        And Ejecutar el método Post al endpoint "/v2/synthetics/pix-payment"
        Then Se obtiene una respuesta 201

        Given Contar con la api-key "C10XB2Z-AG243CS-G42KB2M-4085WTF"
        And Contar con la api-secret "1RpvdT7Vc7ukKeGKdU"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "0of00s808a0s0a0d0000129tfd00000f00f0c0cz00fi00efb0000t00000i1g0f" a la variable "hash"
        And Asignar el valor "0x9bD31d82B6212dd60a9328CCe7277161e5975fB5" a la variable "from"
        And Asignar el valor "<to>" a la variable "to"
        And Asignar el valor "10000000000000000000" a la variable "wei"
        And Asignar el valor "10" a la variable "human"
        And Asignar el valor "<ticker>" a la variable "ticker"
        And Asignar el valor 0 a la variable "chain"
        And Ejecutar el método Post al endpoint "/v1/transaction/deposit"
        Then Se obtiene una respuesta 201

        Given Contar con la api-key "95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6"
        When Esperar procesamiento de la "orden QR" por 15 segundos
        And Ejecutar el método Get al endpoint "/v1/synthetics/{syntheticId}"
        Then Se obtiene una respuesta 200 y status COMPLETED

        Examples:
            | userAnyId | qrCode                                                                                                                                                                                                     | amount | sessionId      | to                                         | ticker |
            | 100009352 | 00020101021226990014br.gov.bcb.pix2577pix-h.bancogenial.com/qrs1/v2/014oS98KbQ7LEFcTdc8P69XEVBEqJRsBDDJtTCs6Kv3DScU52040000530398654042.105802BR5917Transafero Brasil6014Rio de Janeiro62070503***6304211D | 10     | QR-NoDesc-V1-n | 0x7921319332714EBea5c1219439c34309e600DF54 | USDT   |

    @Smoke @QRV1NoDesc
    Scenario Outline: Ejecutar sintético de pago QR embebido contra ARS en no descubierto vía V1 endpoints
        Given Contar con la api-key "95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "<qrCode>" a la variable "qrCode"
        And Asignar el valor "<against>" a la variable "against"
        And Asignar el valor "<amount>" a la variable "amount"
        And Ejecutar el método Post al endpoint "/v2/pix-locks"
        Then Se obtiene una respuesta 201

        When Asignar el valor "<sessionId>" a la variable "sessionId"
        And Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "pixCode" a la variable "pixCode"
        And Ejecutar el método Post al endpoint "/v2/synthetics/pix-payment"
        Then Se obtiene una respuesta 201

        Given Contar con la api-key "C10XB2Z-AG243CS-G42KB2M-4085WTF"
        And Contar con la api-secret "1RpvdT7Vc7ukKeGKdU"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "userAnyId" a la variable "userAnyId"
        And Asignar el valor "amount" a la variable "amount"
        And Asignar el valor "coin" a la variable "coin"
        And Ejecutar el método Post al endpoint "/v1/fiat/deposit"
        Then Se obtiene una respuesta 201

        Given Contar con la api-key "95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6"
        When Esperar procesamiento de la "orden QR" por 5 segundos
        And Ejecutar el método Get al endpoint "/v1/synthetics/{syntheticId}"
        Then Se obtiene una respuesta 200 y status COMPLETED

        Examples:
            | userAnyId | qrCode                                                                                                                                                                                                     | against | amount | sessionId      | to                                         | ticker |
            | 100009352 | 00020101021226990014br.gov.bcb.pix2577pix-h.bancogenial.com/qrs1/v2/014oS98KbQ7LEFcTdc8P69XEVBEqJRsBDDJtTCs6Kv3DScU52040000530398654042.105802BR5917Transafero Brasil6014Rio de Janeiro62070503***6304211D | ARS     | 10     | QR-NoDesc-V1-n | 0x7921319332714EBea5c1219439c34309e600DF54 | USDT   |

    # ------ QR V2 ------

    @Smoke @QRV2NoDesc
    Scenario Outline: Ejecutar sintético de pago QR "<accion>" contra USDT en no descubierto vía V2 endpoints
        Given Contar con la api-key "95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "<qrCode>" a la variable "qrCode"
        And Asignar el valor "<amount>" a la variable "amount"
        And Ejecutar el método Post al endpoint "/v2/payment-locks"
        Then Se obtiene una respuesta 201

        When Asignar el valor "<sessionId>" a la variable "sessionId"
        And Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "pixCode" a la variable "pixCode"
        And Ejecutar el método Post al endpoint "/v2/synthetics/qr-payment"
        Then Se obtiene una respuesta 201
        And Se validan los atributos del sintético QR USDT

        Given Contar con la api-key "C10XB2Z-AG243CS-G42KB2M-4085WTF"
        And Contar con la api-secret "1RpvdT7Vc7ukKeGKdU"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "0of00s808a0s0a0d0000129tfd00000f00f0c0cz00fi00efb0000t00000i1g0f" a la variable "hash"
        And Asignar el valor "0x9bD31d82B6212dd60a9328CCe7277161e5975fB5" a la variable "from"
        And Asignar el valor "<to>" a la variable "to"
        And Asignar el valor "10000000000000000000" a la variable "wei"
        And Asignar el valor "10" a la variable "human"
        And Asignar el valor "<ticker>" a la variable "ticker"
        And Asignar el valor 0 a la variable "chain"
        And Ejecutar el método Post al endpoint "/v1/transaction/deposit"
        Then Se obtiene una respuesta 201

        Given Contar con la api-key "95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6"
        When Esperar procesamiento de la "orden QR" por 15 segundos
        And Ejecutar el método Get al endpoint "/v1/synthetics/{syntheticId}"
        Then Se obtiene una respuesta 200 y status COMPLETED

        Examples:
            | accion   | userAnyId | qrCode          | amount | sessionId    | to                                         | ticker |
            | manual   | 100009502 | qr3manualamount | 1000   | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |
            | embebido | 100009502 | qr3             | 1000   | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |

    # ------ PIX V1 ------

    @Smoke @PixV1NoDesc
    Scenario Outline:  Ejecutar sintético de pago PIX "<accion>" contra USDT en descubierto vía V1 endpoints
        Given Contar con la api-key "95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "<qrCode>" a la variable "qrCode"
        And Asignar el valor "<amount>" a la variable "amount"
        And Ejecutar el método Post al endpoint "/v2/pix-locks"
        Then Se obtiene una respuesta 201

        When Asignar el valor "<sessionId>" a la variable "sessionId"
        And Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "pixCode" a la variable "pixCode"
        And Ejecutar el método Post al endpoint "/v2/synthetics/pix-payment"
        Then Se obtiene una respuesta 201

        Given Contar con la api-key "C10XB2Z-AG243CS-G42KB2M-4085WTF"
        And Contar con la api-secret "1RpvdT7Vc7ukKeGKdU"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "0of00s808a0s0a0d0000129tfd00000f00f0c0cz00fi00efb0000t00000i1g0f" a la variable "hash"
        And Asignar el valor "0x9bD31d82B6212dd60a9328CCe7277161e5975fB5" a la variable "from"
        And Asignar el valor "<to>" a la variable "to"
        And Asignar el valor "10000000000000000000" a la variable "wei"
        And Asignar el valor "10" a la variable "human"
        And Asignar el valor "<ticker>" a la variable "ticker"
        And Asignar el valor 0 a la variable "chain"
        And Ejecutar el método Post al endpoint "/v1/transaction/deposit"
        Then Se obtiene una respuesta 201

        Given Contar con la api-key "95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6"
        When Esperar procesamiento de la "orden PIX" por 15 segundos
        And Ejecutar el método Get al endpoint "/v1/synthetics/{syntheticId}"
        Then Se obtiene una respuesta 200 y status COMPLETED

        Examples:
            | accion   | userAnyId | qrCode          | amount | sessionId                 | to                                         | ticker |
            | embebido | 100009624 | pix             | 10     | PIX-embebido-V1-NO-DESC-n | 0xC19b0041b0D6261FD98BFe753d76D58Ae65e44aD | USDT   |
            | manual   | 100009624 | pixmanualamount | 10     | PIX-manual-V1-NO-DESC-n   | 0xC19b0041b0D6261FD98BFe753d76D58Ae65e44aD | USDT   |

    @Smoke @PixV1NoDesc
    Scenario Outline:  Ejecutar sintético de pago PIX "<accion>" contra ARS en descubierto vía V1 endpoints
        Given Contar con la api-key "95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "<qrCode>" a la variable "qrCode"
        And Asignar el valor "<against>" a la variable "against"
        And Asignar el valor "<amount>" a la variable "amount"
        And Ejecutar el método Post al endpoint "/v2/pix-locks"
        Then Se obtiene una respuesta 201

        When Asignar el valor "<sessionId>" a la variable "sessionId"
        And Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "pixCode" a la variable "pixCode"
        And Ejecutar el método Post al endpoint "/v2/synthetics/pix-payment"
        Then Se obtiene una respuesta 201

        Given Contar con la api-key "C10XB2Z-AG243CS-G42KB2M-4085WTF"
        And Contar con la api-secret "1RpvdT7Vc7ukKeGKdU"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "userAnyId" a la variable "userAnyId"
        And Asignar el valor "amount" a la variable "amount"
        And Asignar el valor "coin" a la variable "coin"
        And Ejecutar el método Post al endpoint "/v1/fiat/deposit"
        Then Se obtiene una respuesta 201

        Given Contar con la api-key "95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6"
        When Esperar procesamiento de la "orden PIX" por 5 segundos
        And Ejecutar el método Get al endpoint "/v1/synthetics/{syntheticId}"
        Then Se obtiene una respuesta 200 y status COMPLETED

        Examples:
            | accion   | userAnyId | qrCode          | against | amount | sessionId              | to                                         | ticker |
            | embebido | 100009624 | pix             | ARS     | 10     | PIX-embebido-V1-DESC-n | 0xC19b0041b0D6261FD98BFe753d76D58Ae65e44aD | USDT   |
            | manual   | 100009624 | pixmanualamount | ARS     | 10     | PIX-manual-V1-DESC-n   | 0xC19b0041b0D6261FD98BFe753d76D58Ae65e44aD | USDT   |

    # ------ PIX V2 ------

    @Smoke @PixV2NoDesc
    Scenario Outline: Ejecutar sintético de pago PIX "<accion>" contra USDT en descubierto vía V2 endpoints
        Given Contar con la api-key "95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "<qrCode>" a la variable "qrCode"
        And Asignar el valor "<amount>" a la variable "amount"
        And Ejecutar el método Post al endpoint "/v2/payment-locks"
        Then Se obtiene una respuesta 201

        When Asignar el valor "<sessionId>" a la variable "sessionId"
        And Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "pixCode" a la variable "pixCode"
        And Ejecutar el método Post al endpoint "/v2/synthetics/qr-payment"
        Then Se obtiene una respuesta 201

        Given Contar con la api-key "C10XB2Z-AG243CS-G42KB2M-4085WTF"
        And Contar con la api-secret "1RpvdT7Vc7ukKeGKdU"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "0of00s808a0s0a0d0000129tfd00000f00f0c0cz00fi00efb0000t00000i1g0f" a la variable "hash"
        And Asignar el valor "0x9bD31d82B6212dd60a9328CCe7277161e5975fB5" a la variable "from"
        And Asignar el valor "<to>" a la variable "to"
        And Asignar el valor "10000000000000000000" a la variable "wei"
        And Asignar el valor "10" a la variable "human"
        And Asignar el valor "<ticker>" a la variable "ticker"
        And Asignar el valor 0 a la variable "chain"
        And Ejecutar el método Post al endpoint "/v1/transaction/deposit"
        Then Se obtiene una respuesta 201

        Given Contar con la api-key "95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6"
        When Esperar procesamiento de la "orden PIX" por 15 segundos
        And Ejecutar el método Get al endpoint "/v1/synthetics/{syntheticId}"
        Then Se obtiene una respuesta 200 y status COMPLETED

        Examples:
            | accion   | userAnyId | qrCode          | amount | sessionId                 | to                                         | ticker |
            | manual   | 100009628 | pixmanualamount | 10     | PIX-manual-V2-NO-DESC-n   | 0x8aD91F66950d65C7a27a123c28fd4f861717bF08 | USDT   |
            | embebido | 100009628 | pix             | 10     | PIX-embebido-V2-NO-DESC-n | 0x8aD91F66950d65C7a27a123c28fd4f861717bF08 | USDT   |

    @Smoke @PixV2NoDesc
    Scenario Outline: Ejecutar sintético de pago PIX "<accion>" contra ARS en descubierto vía V2 endpoints
        Given Contar con la api-key "95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "<qrCode>" a la variable "qrCode"
        And Asignar el valor "<against>" a la variable "against"
        And Asignar el valor "<amount>" a la variable "amount"
        And Ejecutar el método Post al endpoint "/v2/payment-locks"
        Then Se obtiene una respuesta 201

        When Asignar el valor "<sessionId>" a la variable "sessionId"
        And Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "pixCode" a la variable "pixCode"
        And Ejecutar el método Post al endpoint "/v2/synthetics/qr-payment"
        Then Se obtiene una respuesta 201

        Given Contar con la api-key "C10XB2Z-AG243CS-G42KB2M-4085WTF"
        And Contar con la api-secret "1RpvdT7Vc7ukKeGKdU"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "userAnyId" a la variable "userAnyId"
        And Asignar el valor "amount" a la variable "amount"
        And Asignar el valor "coin" a la variable "coin"
        And Ejecutar el método Post al endpoint "/v1/fiat/deposit"
        Then Se obtiene una respuesta 201

        Given Contar con la api-key "95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6"
        When Esperar procesamiento de la "orden PIX" por 5 segundos
        And Ejecutar el método Get al endpoint "/v1/synthetics/{syntheticId}"
        Then Se obtiene una respuesta 200 y status COMPLETED

        Examples:
            | accion   | userAnyId | qrCode          | against | amount | sessionId                 | to                                         | ticker |
            | manual   | 100009628 | pixmanualamount | ARS     | 10     | PIX-manual-V2-NO-DESC-n   | 0xF26A2ECa66d87Dd16225c8507ABbBf3CD14Cfcd2 | USDT   |
            | embebido | 100009628 | pix             | ARS     | 10     | PIX-embebido-V2-NO-DESC-n | 0xF26A2ECa66d87Dd16225c8507ABbBf3CD14Cfcd2 | USDT   |

    #*************************************
    # ------ DESCUBIERTOS -------
    # ------ QR V1 ------
    @Smoke @V1Desc
    Scenario Outline: Ejecutar sintético de pago QR "<accion>" contra USDT en descubierto vía V1 endpoints
        Given Contar con la api-key "F4EZSEW-AMC4Z24-G5CNFS4-880BSHJ"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "<qrCode>" a la variable "qrCode"
        And Asignar el valor "<amount>" a la variable "amount"
        And Ejecutar el método Post al endpoint "/v2/pix-locks"
        Then Se obtiene una respuesta 201

        When Asignar el valor "<sessionId>" a la variable "sessionId"
        And Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "pixCode" a la variable "pixCode"
        And Ejecutar el método Post al endpoint "/v2/synthetics/pix-payment"
        Then Se obtiene una respuesta 201
        And Se validan los atributos del sintético QR USDT

        When Esperar procesamiento de la "orden QR" por 5 segundos
        And Ejecutar el método Get al endpoint "/v1/synthetics/{syntheticId}"
        Then Se obtiene una respuesta 200 y status COMPLETED

        Examples:
            | accion   | userAnyId | qrCode                                                                                                                                                                                                     | amount | sessionId    | to                                         | ticker |
            | embebido | 100009358 | 00020101021226990014br.gov.bcb.pix2577pix-h.bancogenial.com/qrs1/v2/014oS98KbQ7LEFcTdc8P69XEVBEqJRsBDDJtTCs6Kv3DScU52040000530398654042.105802BR5917Transafero Brasil6014Rio de Janeiro62070503***6304211D | 10     | QR-V1-DESC-n | 0x0FE0845Da176E24d9F6Bcf86d19948e592909C8D | USDT   |

    @Smoke @V1Desc
    Scenario Outline: Ejecutar sintético de pago QR "<accion>" contra ARS en descubierto vía V1 endpoints
        Given Contar con la api-key "F4EZSEW-AMC4Z24-G5CNFS4-880BSHJ"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "<qrCode>" a la variable "qrCode"
        And Asignar el valor "<against>" a la variable "against"
        And Asignar el valor "<amount>" a la variable "amount"
        And Ejecutar el método Post al endpoint "/v2/pix-locks"
        Then Se obtiene una respuesta 201

        When Asignar el valor "<sessionId>" a la variable "sessionId"
        And Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "pixCode" a la variable "pixCode"
        And Ejecutar el método Post al endpoint "/v2/synthetics/pix-payment"
        Then Se obtiene una respuesta 201
        And Se validan los atributos del sintético QR ARS

        When Esperar procesamiento de la "orden QR" por 5 segundos
        And Ejecutar el método Get al endpoint "/v1/synthetics/{syntheticId}"
        Then Se obtiene una respuesta 200 y status COMPLETED

        Examples:
            | accion   | userAnyId | qrCode                                                                                                                                                                                                     | amount | against | sessionId    | to                                         | ticker |
            | embebido | 100009358 | 00020101021226990014br.gov.bcb.pix2577pix-h.bancogenial.com/qrs1/v2/014oS98KbQ7LEFcTdc8P69XEVBEqJRsBDDJtTCs6Kv3DScU52040000530398654042.105802BR5917Transafero Brasil6014Rio de Janeiro62070503***6304211D | 10     | ARS     | QR-V1-DESC-n | 0x0FE0845Da176E24d9F6Bcf86d19948e592909C8D | USDT   |

    # ------ QR V2 ------

    @Smoke @QRV2Desc
    Scenario Outline: Ejecutar sintético de pago QR "<accion>" contra USDT en descubierto vía V2 endpoints
        Given Contar con la api-key "F4EZSEW-AMC4Z24-G5CNFS4-880BSHJ"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "<qrCode>" a la variable "qrCode"
        And Asignar el valor "<amount>" a la variable "amount"
        And Ejecutar el método Post al endpoint "/v2/payment-locks"
        Then Se obtiene una respuesta 201

        When Asignar el valor "<sessionId>" a la variable "sessionId"
        And Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "pixCode" a la variable "pixCode"
        And Ejecutar el método Post al endpoint "/v2/synthetics/qr-payment"
        Then Se obtiene una respuesta 201
        And Se validan los atributos del sintético QR USDT

        When Esperar procesamiento de la "orden QR" por 5 segundos
        And Ejecutar el método Get al endpoint "/v1/synthetics/{syntheticId}"
        Then Se obtiene una respuesta 200 y status COMPLETED

        Examples:
            | accion   | userAnyId | qrCode          | amount | sessionId    | to                                         | ticker |
            | manual   | 100009359 | qr3manualamount | 1000   | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |
            | embebido | 100009359 | qr3             | 1000   | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |

    @NoSupportYet
    Scenario Outline: Ejecutar sintético de pago QR "<accion>" contra ARS en descubierto vía V2 endpoints
        Given Contar con la api-key "F4EZSEW-AMC4Z24-G5CNFS4-880BSHJ"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "<qrCode>" a la variable "qrCode"
        And Asignar el valor "<against>" a la variable "against"
        And Asignar el valor "<amount>" a la variable "amount"
        And Ejecutar el método Post al endpoint "/v2/payment-locks"
        Then Se obtiene una respuesta 201

        When Asignar el valor "<sessionId>" a la variable "sessionId"
        And Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "pixCode" a la variable "pixCode"
        And Ejecutar el método Post al endpoint "/v2/synthetics/qr-payment"
        Then Se obtiene una respuesta 201
        And Se validan los atributos del sintético QR ARS

        When Esperar procesamiento de la "orden QR" por 5 segundos
        And Ejecutar el método Get al endpoint "/v1/synthetics/{syntheticId}"
        Then Se obtiene una respuesta 200 y status COMPLETED

        Examples:
            | accion   | userAnyId | qrCode          | against | amount | sessionId    | to                                         | ticker |
            | manual   | 100009359 | qr3manualamount | ARS     | 1000   | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |
            | embebido | 100009359 | qr3             | ARS     | 1000   | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |

    @NoSupportYet
    Scenario Outline: Ejecutar sintético de pago QR "<accion>" contra ARS en descubierto con valores mínimos vía V2 endpoints
        Given Contar con la api-key "F4EZSEW-AMC4Z24-G5CNFS4-880BSHJ"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "<qrCode>" a la variable "qrCode"
        And Asignar el valor "<against>" a la variable "against"
        And Asignar el valor "<amount>" a la variable "amount"
        And Ejecutar el método Post al endpoint "/v2/payment-locks"
        Then Se obtiene una respuesta 201

        When Asignar el valor "<sessionId>" a la variable "sessionId"
        And Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "pixCode" a la variable "pixCode"
        And Ejecutar el método Post al endpoint "/v2/synthetics/qr-payment"
        Then Se obtiene una respuesta 201
        And Se validan los atributos del sintético QR ARS

        When Esperar procesamiento de la "orden QR" por 5 segundos
        And Ejecutar el método Get al endpoint "/v1/synthetics/{syntheticId}"
        Then Se obtiene una respuesta 200 y status COMPLETED

        Examples:
            | accion | userAnyId | qrCode          | against | amount | sessionId    | to                                         | ticker |
            | manual | 100009359 | qr3manualamount | ARS     | 101    | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |

    @NoSupportYet
    Scenario Outline: Validar error al ejecutar sintético de pago QR "<accion>" contra ARS en descubierto con monto inferior al mínimo vía V2 endpoints
        Given Contar con la api-key "F4EZSEW-AMC4Z24-G5CNFS4-880BSHJ"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "<qrCode>" a la variable "qrCode"
        And Asignar el valor "<against>" a la variable "against"
        And Asignar el valor "<amount>" a la variable "amount"
        And Ejecutar el método Post al endpoint "/v2/payment-locks"
        Then Se obtiene una respuesta 201

        When Asignar el valor "<sessionId>" a la variable "sessionId"
        And Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "pixCode" a la variable "pixCode"
        And Ejecutar el método Post al endpoint "/v2/synthetics/qr-payment"
        Then Se obtiene una respuesta 400

        Examples:
            | accion | userAnyId | qrCode          | against | amount | sessionId    | to                                         | ticker |
            | manual | 100009359 | qr3manualamount | ARS     | 9      | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |

    # ------ PIX V1 ------

    @Smoke @PixV1Desc
    Scenario Outline:  Ejecutar sintético de pago PIX "<accion>" contra USDT en descubierto vía V1 endpoints
        Given Contar con la api-key "F4EZSEW-AMC4Z24-G5CNFS4-880BSHJ"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "<qrCode>" a la variable "qrCode"
        And Asignar el valor "<amount>" a la variable "amount"
        And Ejecutar el método Post al endpoint "/v2/pix-locks"
        Then Se obtiene una respuesta 201

        When Asignar el valor "<sessionId>" a la variable "sessionId"
        And Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "pixCode" a la variable "pixCode"
        And Ejecutar el método Post al endpoint "/v2/synthetics/pix-payment"
        Then Se obtiene una respuesta 201

        When Esperar procesamiento de la "orden PIX" por 5 segundos
        And Ejecutar el método Get al endpoint "/v1/synthetics/{syntheticId}"
        Then Se obtiene una respuesta 200 y status COMPLETED

        Examples:
            | accion   | userAnyId | qrCode          | amount | sessionId              | to                                         | ticker |
            | embebido | 100009360 | pix             | 10     | PIX-embebido-V1-DESC-n | 0x966af97f8D14FbAa77d3fdfe214a638b5587BCBA | USDT   |
            | manual   | 100009360 | pixmanualamount | 10     | PIX-manual-V1-DESC-n   | 0x966af97f8D14FbAa77d3fdfe214a638b5587BCBA | USDT   |

    @Smoke @PixV1Desc
    Scenario Outline:  Ejecutar sintético de pago PIX "<accion>" contra ARS en descubierto vía V1 endpoints
        Given Contar con la api-key "F4EZSEW-AMC4Z24-G5CNFS4-880BSHJ"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "<qrCode>" a la variable "qrCode"
        And Asignar el valor "<against>" a la variable "against"
        And Asignar el valor "<amount>" a la variable "amount"
        And Ejecutar el método Post al endpoint "/v2/pix-locks"
        Then Se obtiene una respuesta 201

        When Asignar el valor "<sessionId>" a la variable "sessionId"
        And Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "pixCode" a la variable "pixCode"
        And Ejecutar el método Post al endpoint "/v2/synthetics/pix-payment"
        Then Se obtiene una respuesta 201

        When Esperar procesamiento de la "orden PIX" por 5 segundos
        And Ejecutar el método Get al endpoint "/v1/synthetics/{syntheticId}"
        Then Se obtiene una respuesta 200 y status COMPLETED

        Examples:
            | accion   | userAnyId | qrCode          | against | amount | sessionId              | to                                         | ticker |
            | embebido | 100009360 | pix             | ARS     | 10     | PIX-embebido-V1-DESC-n | 0x966af97f8D14FbAa77d3fdfe214a638b5587BCBA | USDT   |
            | manual   | 100009360 | pixmanualamount | ARS     | 10     | PIX-manual-V1-DESC-n   | 0x966af97f8D14FbAa77d3fdfe214a638b5587BCBA | USDT   |

    # ------ PIX V2 ------

    @Smoke @PixV2Desc
    Scenario Outline: Ejecutar sintético de pago PIX "<accion>" contra USDT en descubierto vía V2 endpoints
        Given Contar con la api-key "F4EZSEW-AMC4Z24-G5CNFS4-880BSHJ"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "<qrCode>" a la variable "qrCode"
        And Asignar el valor "<amount>" a la variable "amount"
        And Ejecutar el método Post al endpoint "/v2/payment-locks"
        Then Se obtiene una respuesta 201

        When Asignar el valor "<sessionId>" a la variable "sessionId"
        And Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "pixCode" a la variable "pixCode"
        And Ejecutar el método Post al endpoint "/v2/synthetics/qr-payment"
        Then Se obtiene una respuesta 201

        When Esperar procesamiento de la "orden PIX" por 5 segundos
        And Ejecutar el método Get al endpoint "/v1/synthetics/{syntheticId}"
        Then Se obtiene una respuesta 200 y status COMPLETED

        Examples:
            | accion   | userAnyId | qrCode          | amount | sessionId              | to                                         | ticker |
            | manual   | 100009361 | pixmanualamount | 10     | PIX-manual-V2-DESC-n   | 0xF26A2ECa66d87Dd16225c8507ABbBf3CD14Cfcd2 | USDT   |
            | embebido | 100009361 | pix             | 10     | PIX-embebido-V2-DESC-n | 0xF26A2ECa66d87Dd16225c8507ABbBf3CD14Cfcd2 | USDT   |

    @Smoke @PixV2Desc
    Scenario Outline: Ejecutar sintético de pago PIX "<accion>" contra ARS en descubierto vía V2 endpoints
        Given Contar con la api-key "F4EZSEW-AMC4Z24-G5CNFS4-880BSHJ"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "<qrCode>" a la variable "qrCode"
        And Asignar el valor "<against>" a la variable "against"
        And Asignar el valor "<amount>" a la variable "amount"
        And Ejecutar el método Post al endpoint "/v2/payment-locks"
        Then Se obtiene una respuesta 201

        When Asignar el valor "<sessionId>" a la variable "sessionId"
        And Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "pixCode" a la variable "pixCode"
        And Ejecutar el método Post al endpoint "/v2/synthetics/qr-payment"
        Then Se obtiene una respuesta 201

        When Esperar procesamiento de la "orden PIX" por 5 segundos
        And Ejecutar el método Get al endpoint "/v1/synthetics/{syntheticId}"
        Then Se obtiene una respuesta 200 y status COMPLETED

        Examples:
            | accion   | userAnyId | qrCode          | against | amount | sessionId              | to                                         | ticker |
            | manual   | 100009361 | pixmanualamount | ARS     | 1000   | PIX-manual-V2-DESC-n   | 0xF26A2ECa66d87Dd16225c8507ABbBf3CD14Cfcd2 | USDT   |
            | embebido | 100009361 | pix             | ARS     | 1000   | PIX-embebido-V2-DESC-n | 0xF26A2ECa66d87Dd16225c8507ABbBf3CD14Cfcd2 | USDT   |

    # ------ PaymentDestinarion ------

    @Smoke @Bybit
    Scenario Outline: Ejecutar sintético de pago "<pay>" "<accion>" contra "<coin>" en descubierto para usuario "<nacionality>" vía ByBit endpoints
        Given Contar con la api-key "F4EZSEW-AMC4Z24-G5CNFS4-880BSHJ"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "<paymentDestination>" a la variable "paymentDestination"
        And Asignar el valor "<against>" a la variable "against"
        And Asignar el valor "<amount>" a la variable "amount"
        And Ejecutar el método Post al endpoint "/v2/payment-locks"
        Then Se obtiene una respuesta 201

        When Asignar el valor "<sessionId>" a la variable "sessionId"
        And Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "pixCode" a la variable "pixCode"
        And Ejecutar el método Post al endpoint "/v2/synthetics/qr-payment"
        Then Se obtiene una respuesta 201

        When Esperar procesamiento de la "orden PIX" por 5 segundos
        And Ejecutar el método Get al endpoint "/v1/synthetics/{syntheticId}"
        Then Se obtiene una respuesta 200 y status COMPLETED

        Examples:
            | pay | nacionality | coin | accion   | userAnyId | paymentDestination | against | amount | sessionId                    | to                                         | ticker |
            | PIX | Argentina   | USDT | manual   | 100009406 | pixmanualamount    |         | 10     | PIX-ByBit-manual-V2-DESC-n   | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
            | PIX | Argentina   | USDT | embebido | 100009406 | pix                |         | 10     | PIX-ByBit-embebido-V2-DESC-n | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
            | QR  | Argentina   | USDT | manual   | 100009406 | qr3manualamount    |         | 1000   | PIX-ByBit-manual-V2-DESC-n   | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
            | QR  | Argentina   | USDT | embebido | 100009406 | qr3                |         | 1000   | PIX-ByBit-embebido-V2-DESC-n | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
            | QR  | Brasil      | USDT | manual   | 100009407 | qr3manualamount    |         | 10     | PIX-ByBit-manual-V2-DESC-n   | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
            | QR  | Brasil      | USDT | embebido | 100009407 | qr3                |         | 1000   | PIX-ByBit-embebido-V2-DESC-n | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
            | QR  | Brasil      | USDT | manual   | 100009407 | pixmanualamount    | USDT    | 10     | PIX-ByBit-manual-V2-DESC-n   | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
            | QR  | Brasil      | USDT | embebido | 100009407 | pix                | USDT    | 10     | PIX-ByBit-embebido-V2-DESC-n | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |

    @Smoke @BybitPixkeyb
    Scenario Outline: Ejecutar sintético de pago "<pay>" "<accion>" contra "<coin>" hacia PixKey en descubierto para usuario "<nacionality>" vía ByBit endpoints
        Given Contar con la api-key "F4EZSEW-AMC4Z24-G5CNFS4-880BSHJ"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "<paymentDestination>" a la variable "paymentDestination"
        And Asignar el valor "<against>" a la variable "against"
        And Asignar el valor "<amount>" a la variable "amount"
        And Ejecutar el método Post al endpoint "/v2/payment-locks"
        Then Se obtiene una respuesta 201

        When Asignar el valor "<sessionId>" a la variable "sessionId"
        And Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "pixCode" a la variable "pixCode"
        And Ejecutar el método Post al endpoint "/v2/synthetics/qr-payment"
        Then Se obtiene una respuesta 201

        When Esperar procesamiento de la "orden PIX" por 5 segundos
        And Ejecutar el método Get al endpoint "/v1/synthetics/{syntheticId}"
        Then Se obtiene una respuesta 200 y status COMPLETED

        # User ARG no funciona todavia
        Examples:
            | pay | nacionality | coin | accion   | userAnyId | paymentDestination                   | against | amount | sessionId                       | to                                         | ticker |
            | PIX | Argentina   | USDT | manual   | 100009406 | martin@gmail.com                     |         | 10     | PixKey-ByBit-manual-V2-DESC-n   | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
            | PIX | Argentina   | USDT | embebido | 100009406 | renancamargo19@gmail.com             |         | 10     | PixKey-ByBit-embebido-V2-DESC-n | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
            | PIX | Argentina   | USDT | manual   | 100009406 | +5511949227612                       |         | 10     | PixKey-ByBit-manual-V2-DESC-n   | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
            | PIX | Argentina   | USDT | embebido | 100009406 | 08449ae2-8a26-47a5-992d-2689f135bc11 |         | 10     | PixKey-ByBit-embebido-V2-DESC-n | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
            | QR  | Brasil      | USDT | manual   | 100009407 | martin@gmail.com                     |         | 10     | PixKey-ByBit-manual-V2-DESC-n   | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
            | QR  | Brasil      | USDT | embebido | 100009407 | renancamargo19@gmail.com             |         | 10     | PixKey-ByBit-embebido-V2-DESC-n | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
            | QR  | Brasil      | USDT | manual   | 100009407 | +5511949227612                       |         | 10     | PixKey-ByBit-manual-V2-DESC-n   | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
            | QR  | Brasil      | USDT | embebido | 100009407 | 08449ae2-8a26-47a5-992d-2689f135bc11 |         | 10     | PixKey-ByBit-embebido-V2-DESC-n | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |

    @Smoke1 @Refunds @RefundsDs
    Scenario Outline: Validar refund para usuario operando en descubierto
        Given Contar con la api-key "F4EZSEW-AMC4Z24-G5CNFS4-880BSHJ"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "<paymentDestination>" a la variable "paymentDestination"
        And Asignar el valor "<against>" a la variable "against"
        And Asignar el valor "<amount>" a la variable "amount"
        And Asignar el valor "<sessionId>" a la variable "sessionId"
        Then Ejecutar sintetico refund "descubierto"
        And Se obtiene una respuesta 200 y status "CANCELLED"

        Examples:
            | userAnyId | paymentDestination | against | amount | sessionId     |
            | 100009408 | qr3manualamount    | USDT    | 1000   | refund-DESC-n |
            | 100009408 | +5511949227612     | USDT    | 10     | refund-DESC-n |
    # Cuando marto incluya +5511949227612 como siempre falla para reverse, borrar qr3manualamount
    # Falta caso en against ARS en el que se toma deuda en ARS pero no hay order reversal

    @Smoke1 @Refunds @RefundsNDt
    Scenario Outline: Validar refund para usuario operando en no descubierto contra <against>
        Given Contar con la api-key "95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6"
        And Contar con la api-secret "1RpvdT7Vc7ukKeGKdU"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "<userAnyId>" a la variable "userAnyId"
        And Asignar el valor "<paymentDestination>" a la variable "paymentDestination"
        And Asignar el valor "<against>" a la variable "against"
        And Asignar el valor "<amount>" a la variable "amount"
        And Asignar el valor "<sessionId>" a la variable "sessionId"
        And Asignar el valor "<apiKeyDeposit>" a la variable "apiKeyDeposit"
        Then Ejecutar sintetico refund "no descubierto"
        And Se obtiene una respuesta 200 y status "CANCELLED"

        Examples:
            | userAnyId | paymentDestination | against | amount | sessionId        | apiKeyDeposit                   |
            | 100009417 | qr3manualamount    | ARS     | 1000   | refund-NO-DESC-n | C10XB2Z-AG243CS-G42KB2M-4085WTF |
            | 100009417 | qr3manualamount    | USDT    | 1000   | refund-NO-DESC-n | C10XB2Z-AG243CS-G42KB2M-4085WTF |
