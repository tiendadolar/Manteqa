@QR
Feature: Sintético QR 3.0

    @INTest
    Scenario: Ejecución del lock de pago QR 3.0 vía qr endpoint
        Given The API key is available "99QM9HQ-9JWM288-NHEZ6RB-2NBDZP3"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "100007956" to the variable "userAnyId"
        And Assign the value "00020101021140200010com.yacare02022350150011336972350495204858553030325802AR5910HAVANNA SA6012BUENOS AIRES81220010com.yacare0204Y2156304E401" to the variable "qrCode"
        And Assign the value "2200" to the variable "amount"
        And Execute the POST method on the endpoint "/v2/payment-locks"
        Then Obtain a response 201
        And The price LockPix is created

    @INTest
    Scenario: Creación del síntetico de pago QR 3.0 vía qr endpoint
        Given The API key is available "99QM9HQ-9JWM288-NHEZ6RB-2NBDZP3"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "automation-test-n" to the variable "sessionId"
        And Assign the value "100007956" to the variable "userAnyId"
        And Assign the value "pixCode" to the variable "pixCode"
        And Execute the POST method on the endpoint "/v2/synthetics/qr-payment"
        Then Obtain a response 201
        And The payment synthetic is created

    @INTestd
    Scenario: Generar deposito Crypto
        Given The API key is available "C10XB2Z-AG243CS-G42KB2M-4085WTF"
        And The API secret is available "rcrgtDnGxjY2AYC5qs"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "0of00s808a0s0a0d0000129tfd00000f00f0c0cz00fi00efb0000t00000i1g0f" to the variable "hash"
        And Assign the value "0x9bD31d82B6212dd60a9328CCe7277161e5975fB5" to the variable "from"
        And Assign the value "0x449aC40afE7C69e67Ac0321970d72d3107153F30" to the variable "to"
        And Assign the value "10000000000000000000" to the variable "wei"
        And Assign the value "10" to the variable "human"
        And Assign the value "WLD" to the variable "ticker"
        And Assign the value 6 to the variable "chain"
        And Execute the POST method on the endpoint "/v1/transaction/deposit"
        Then Obtain a response 201

    # **** SUITE ****
    # ! NO TOCAR DATOS
    # ------ NO DESCUBIERTOS -------
    # ------ QR V1 ------

    @Smoke @QRV1NoDesc @Automated @ct
    Scenario Outline: Ejecutar sintético de pago QR embebido contra USDT en no descubierto vía V1 endpoints
        Given The API key is available "95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6"
        And The API secret is available "1RpvdT7Vc7ukKeGKdU"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        # Validate initial balance before execute qr payment
        And Obtain "<ticker>" balance for "<userAnyId>" user
        # Request de lock payment
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<qrCode>" to the variable "qrCode"
        And Assign the value "<amount>" to the variable "amount"
        And Execute the POST method on the endpoint "/v2/pix-locks"
        Then Obtain a response 201 for lock payment
        # Execute synthetic payment
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "pixCode" to the variable "pixCode"
        And Execute the POST method on the endpoint "/v2/synthetics/pix-payment"
        Then Obtain a response 201
        # Execute deposit
        And Execute crypto deposit
        # Get status synthetic payment
        And Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic
        # Validate balance after execute qr payment
        And Obtain "<ticker>" balance for "<userAnyId>" user

        # First QR is implemented to skip microoperations blocked
        Examples:
            | userAnyId | qrCode                                                                                                                                                                                                     | amount | sessionId      | to                                         | ticker |
            | 100009352 | pixmanualamount                                                                                                                                                                                            | 10     | QR-NoDesc-V1-n | 0x7921319332714EBea5c1219439c34309e600DF54 | USDT   |
            | 100009352 | 00020101021226990014br.gov.bcb.pix2577pix-h.bancogenial.com/qrs1/v2/014oS98KbQ7LEFcTdc8P69XEVBEqJRsBDDJtTCs6Kv3DScU52040000530398654042.105802BR5917Transafero Brasil6014Rio de Janeiro62070503***6304211D | 10     | QR-NoDesc-V1-n | 0x7921319332714EBea5c1219439c34309e600DF54 | USDT   |

    @Smoke @QRV1NoDesc @Automated
    Scenario Outline: Ejecutar sintético de pago QR embebido contra ARS en no descubierto vía V1 endpoints
        Given The API key is available "95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6"
        And The API secret is available "1RpvdT7Vc7ukKeGKdU"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        # Validate initial balance before execute qr payment
        And Obtain "<against>" balance for "<userAnyId>" user
        # Request de lock payment
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<qrCode>" to the variable "qrCode"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<amount>" to the variable "amount"
        And Execute the POST method on the endpoint "/v2/pix-locks"
        Then Obtain a response 201 for lock payment
        # Execute synthetic payment
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "pixCode" to the variable "pixCode"
        And Execute the POST method on the endpoint "/v2/synthetics/pix-payment"
        Then Obtain a response 201
        # Execute deposit
        And Execute fiat deposit
        # Get status synthetic payment
        And Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic
        # Validate balance after execute qr payment
        And Obtain "<against>" balance for "<userAnyId>" user

        Examples:
            | userAnyId | qrCode                                                                                                                                                                                                     | against | amount | sessionId      | to                                         | ticker |
            | 100009352 | 00020101021226990014br.gov.bcb.pix2577pix-h.bancogenial.com/qrs1/v2/014oS98KbQ7LEFcTdc8P69XEVBEqJRsBDDJtTCs6Kv3DScU52040000530398654042.105802BR5917Transafero Brasil6014Rio de Janeiro62070503***6304211D | ARS     | 10     | QR-NoDesc-V1-n | 0x7921319332714EBea5c1219439c34309e600DF54 | USDT   |

    @Smoke @QRV1NoDesc @Automated
    Scenario Outline: Validar Clean Code al ejecutar lock de QR estático sin enviar amount vía V1 endpoints
        Given The API key is available "95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<qrCode>" to the variable "qrCode"
        And Assign the value "<amount>" to the variable "amount"
        And Execute the POST method on the endpoint "/v2/pix-locks"
        Then Obtain a response 206

        Examples:
            | accion | userAnyId | qrCode          | amount | sessionId    | to                                         | ticker |
            | manual | 100009502 | pixmanualamount |        | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |

    # ------ QR V2 ------

    @Smoke @QRV2NoDesc @Automated
    Scenario Outline: Ejecutar sintético de pago QR "<accion>" contra USDT en no descubierto vía V2 endpoints
        Given The API key is available "95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        And The API secret is available "1RpvdT7Vc7ukKeGKdU"
        # Validate initial balance before execute qr payment
        And Obtain "<ticker>" balance for "<userAnyId>" user
        # Request de lock payment
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<qrCode>" to the variable "qrCode"
        And Assign the value "<amount>" to the variable "amount"
        And Execute the POST method on the endpoint "/v2/payment-locks"
        Then Obtain a response 201 for lock payment
        # Execute synthetic payment
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "pixCode" to the variable "pixCode"
        And Execute the POST method on the endpoint "/v2/synthetics/qr-payment"
        Then Obtain a response 201
        And The attributes of the QR USDT synthetic are validated
        # Execute deposit
        And Execute crypto deposit
        # Get status synthetic payment
        And Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic
        # Validate balance after execute qr payment
        And Obtain "<ticker>" balance for "<userAnyId>" user

        Examples:
            | credential                | accion | userAnyId | qrCode          | amount | sessionId    | to                                         | ticker |
            | andresperalta@manteca.dev | manual | 100009502 | qr3manualamount | 1500   | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |
    # | embebido | 100009502 | qr3             | 1000   | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |

    @Smoke @QRV2NoDesc @Automated
    Scenario Outline: Validar Clean Code al ejecutar lock de QR estático sin enviar amount vía V2 endpoints
        Given The API key is available "95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<qrCode>" to the variable "qrCode"
        And Assign the value "<amount>" to the variable "amount"
        And Execute the POST method on the endpoint "/v2/payment-locks"
        Then Obtain a response 206

        Examples:
            | accion | userAnyId | qrCode          | amount | sessionId    | to                                         | ticker |
            | manual | 100009502 | qr3manualamount |        | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |

    # ------ PIX V1 ------

    @Smoke @PixV1NoDesc @Automated
    Scenario Outline:  Ejecutar sintético de pago PIX "<accion>" contra USDT en no descubierto vía V1 endpoints
        Given The API key is available "95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6"
        And The API secret is available "1RpvdT7Vc7ukKeGKdU"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        # Validate initial balance before execute qr payment
        And Obtain "<ticker>" balance for "<userAnyId>" user
        # Request de lock payment
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<qrCode>" to the variable "qrCode"
        And Assign the value "<amount>" to the variable "amount"
        And Execute the POST method on the endpoint "/v2/pix-locks"
        Then Obtain a response 201 for lock payment
        # Execute synthetic payment
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "pixCode" to the variable "pixCode"
        And Execute the POST method on the endpoint "/v2/synthetics/pix-payment"
        Then Obtain a response 201
        # Execute deposit
        And Execute crypto deposit
        # Get status synthetic payment
        And Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic
        # Validate balance after execute qr payment
        And Obtain "<ticker>" balance for "<userAnyId>" user

        Examples:
            | accion   | userAnyId | qrCode          | amount | sessionId                 | to                                         | ticker |
            | manual   | 100009624 | pixmanualamount | 10     | PIX-manual-V1-NO-DESC-n   | 0xC19b0041b0D6261FD98BFe753d76D58Ae65e44aD | USDT   |
            | embebido | 100009624 | pix             | 10     | PIX-embebido-V1-NO-DESC-n | 0xC19b0041b0D6261FD98BFe753d76D58Ae65e44aD | USDT   |

    @Smoke @PixV1NoDesc @Automated
    Scenario Outline:  Ejecutar sintético de pago PIX "<accion>" contra ARS en no descubierto vía V1 endpoints
        Given The API key is available "95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6"
        And The API secret is available "1RpvdT7Vc7ukKeGKdU"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        # Validate initial balance before execute qr payment
        And Obtain "<against>" balance for "<userAnyId>" user
        # Request de lock payment
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<qrCode>" to the variable "qrCode"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<amount>" to the variable "amount"
        And Execute the POST method on the endpoint "/v2/pix-locks"
        Then Obtain a response 201 for lock payment
        # Execute synthetic payment
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "pixCode" to the variable "pixCode"
        And Execute the POST method on the endpoint "/v2/synthetics/pix-payment"
        Then Obtain a response 201
        # Execute deposit
        And Execute fiat deposit
        # Get status synthetic payment
        And Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic
        # Validate balance after execute qr payment
        And Obtain "<against>" balance for "<userAnyId>" user

        Examples:
            | accion   | userAnyId | qrCode          | against | amount | sessionId              | to                                         | ticker |
            | embebido | 100009624 | pix             | ARS     | 10     | PIX-embebido-V1-DESC-n | 0xC19b0041b0D6261FD98BFe753d76D58Ae65e44aD | USDT   |
            | manual   | 100009624 | pixmanualamount | ARS     | 10     | PIX-manual-V1-DESC-n   | 0xC19b0041b0D6261FD98BFe753d76D58Ae65e44aD | USDT   |

    @Smoke @PixV1NoDesc @Automated
    Scenario Outline: Validar Clean Code al ejecutar lock de QR PIX estático sin enviar amount vía V2 endpoints
        Given The API key is available "95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<qrCode>" to the variable "qrCode"
        And Assign the value "<amount>" to the variable "amount"
        And Execute the POST method on the endpoint "/v2/payment-locks"
        Then Obtain a response 206

        Examples:
            | accion | userAnyId | qrCode          | amount | sessionId    | to                                         | ticker |
            | manual | 100009502 | pixmanualamount |        | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |

    # ------ PIX V2 ------

    @Smoke @PixV2NoDesc @Automated
    Scenario Outline: Ejecutar sintético de pago PIX "<accion>" contra USDT en no descubierto vía V2 endpoints
        Given The API key is available "95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6"
        And The API secret is available "1RpvdT7Vc7ukKeGKdU"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        # Validate initial balance before execute qr payment
        When Obtain "<ticker>" balance for "<userAnyId>" user
        # Request de lock payment
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<qrCode>" to the variable "qrCode"
        And Assign the value "<amount>" to the variable "amount"
        And Execute the POST method on the endpoint "/v2/payment-locks"
        Then Obtain a response 201 for lock payment
        # Execute synthetic payment
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "pixCode" to the variable "pixCode"
        And Execute the POST method on the endpoint "/v2/synthetics/qr-payment"
        Then Obtain a response 201
        # Execute deposit
        And Execute crypto deposit
        # Get status synthetic payment
        And Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic
        # Validate balance after execute qr payment
        And Obtain "<ticker>" balance for "<userAnyId>" user

        Examples:
            | accion   | userAnyId | qrCode          | amount | sessionId                 | to                                         | ticker |
            | manual   | 100009628 | pixmanualamount | 10     | PIX-manual-V2-NO-DESC-n   | 0x8aD91F66950d65C7a27a123c28fd4f861717bF08 | USDT   |
            | embebido | 100009628 | pix             |        | PIX-embebido-V2-NO-DESC-n | 0x8aD91F66950d65C7a27a123c28fd4f861717bF08 | USDT   |

    @Smoke @PixV2NoDesc @Automated
    Scenario Outline: Ejecutar sintético de pago PIX "<accion>" contra ARS en no descubierto vía V2 endpoints
        Given The API key is available "95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6"
        And The API secret is available "1RpvdT7Vc7ukKeGKdU"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        # Validate initial balance before execute qr payment
        And Obtain "<against>" balance for "<userAnyId>" user
        # Request de lock payment
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<qrCode>" to the variable "qrCode"
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
        # Execute deposit
        And Execute fiat deposit
        # Get status synthetic payment
        And Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic
        # Validate balance after execute qr payment
        And Obtain "<against>" balance for "<userAnyId>" user

        Examples:
            | accion   | userAnyId | qrCode          | against | amount | sessionId                 | to                                         | ticker |
            | manual   | 100009628 | pixmanualamount | ARS     | 10     | PIX-manual-V2-NO-DESC-n   | 0xF26A2ECa66d87Dd16225c8507ABbBf3CD14Cfcd2 | USDT   |
            | embebido | 100009628 | pix             | ARS     | 10     | PIX-embebido-V2-NO-DESC-n | 0xF26A2ECa66d87Dd16225c8507ABbBf3CD14Cfcd2 | USDT   |

    @Peru @NoDesc @ToBeAutomated
    Scenario Outline: Ejecutar sintético de pago "<pay>" "<accion>" contra "<coin>" en no descubierto para usuario "<nacionality>" sobre el Balance User
        Given The API key is available "MBA68YQ-RXW46ZS-P4K4BAZ-D2KX43F"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        # Get user balance before execute qr payment
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
        And Obtain a response 200 and status "COMPLETED" for "pix payment" synthetic
        # Get user balance after execute qr payment
        And Obtain "<against>" balance for "<userAnyId>" user

        Examples:
            | pay | nacionality | coin | accion   | userAnyId | paymentDestination                                                                                                                                                                                                                                                                         | against | amount | sessionId | to                                         | ticker |
            | QR  | Argentina   | PEN  | dinámico | 100010488 | 0002010102122637000280010390302202508100921195431272952044829530360454031505802PE5917CESAR TACURI INGA6004Lima80550003ID10144suGASdIEsZFzlFh4eZ/UMQRNdpSojGNBwPiV0Punz2o=90490005GLOSA0136Happy Path Generación de QR Dinamico91230007FECVCTO01082025123192210005QUOTA0108999999996304B3D4 | PEN     |        | QR-Peru-n | 0x862Acf26956DCEf54F4726CF88709bFE9128e500 |        |
    # | QR  | Argentina   | PEN  | estático | 100010488 | 000201010211263700028001039030220250424092119905530665204482953036045802PE5917CESAR TACURI INGA6004Lima80550003ID10144suGASdIEsZFzlFh4eZ/UMQRNdpSojGNBwPiV0Punz2o=6304FA5B                                                                                                                  | PEN     | 100    | QR-Peru-n | 0x862Acf26956DCEf54F4726CF88709bFE9128e500 |        |
    # | QR  | Peru        | PEN  | dinámico | 100010538 | 00020101021226370002800103903022025072409211954330527520448295303604540415005802PE5917CESAR TACURI INGA6004Lima80550003ID10144suGASdIEsZFzlFh4eZ/UMQRNdpSojGNBwPiV0Punz2o=90490005GLOSA0136Happy Path Generación de QR Dinamico91230007FECVCTO01082025123192210005QUOTA01089999999963041AAA | PEN     |        | QR-Peru-n | 0x862Acf26956DCEf54F4726CF88709bFE9128e500 |        |
    # | QR  | Peru        | PEN  | estático | 100010538 | 000201010211263700028001039030220250424092119905530665204482953036045802PE5917CESAR TACURI INGA6004Lima80550003ID10144suGASdIEsZFzlFh4eZ/UMQRNdpSojGNBwPiV0Punz2o=6304FA5B                                                                                                                  | PEN     | 100    | QR-Peru-n | 0x862Acf26956DCEf54F4726CF88709bFE9128e500 |        |

    @Peru @ToBeAutomated
    Scenario Outline: Ejecutar sintético de pago "<pay>" "<accion>" contra "<coin>" en no descubierto para usuario "<nacionality>"
        Given The API key is available "MBA68YQ-RXW46ZS-P4K4BAZ-D2KX43F"
        And The API secret is available "vH2W199pE1re5ZR4Z7"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        # Get user balance before execute qr payment
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
        # Execute deposit
        And Execute crypto deposit
        # Get status synthetic payment
        And Obtain a response 200 and status "COMPLETED" for "pix payment" synthetic
        # Get user balance after execute qr payment
        And Obtain "<against>" balance for "<userAnyId>" user

        Examples:
            | pay | nacionality | coin | accion   | userAnyId | paymentDestination                                                                                                                                                                                                                                                                          | against | amount | sessionId | to                                         | ticker |
            | QR  | Argentina   | USDT | dinámico | 100010488 | 00020101021226370002800103903022025072409211954330527520448295303604540415005802PE5917CESAR TACURI INGA6004Lima80550003ID10144suGASdIEsZFzlFh4eZ/UMQRNdpSojGNBwPiV0Punz2o=90490005GLOSA0136Happy Path Generación de QR Dinamico91230007FECVCTO01082025123192210005QUOTA01089999999963041AAA | USDT    |        | QR-Peru-n | 0x862Acf26956DCEf54F4726CF88709bFE9128e500 | USDT   |
            | QR  | Argentina   | USDT | estático | 100010488 | 000201010211263700028001039030220250424092119905530665204482953036045802PE5917CESAR TACURI INGA6004Lima80550003ID10144suGASdIEsZFzlFh4eZ/UMQRNdpSojGNBwPiV0Punz2o=6304FA5B                                                                                                                  | USDT    | 100    | QR-Peru-n | 0x862Acf26956DCEf54F4726CF88709bFE9128e500 | USDT   |
            | QR  | Peru        | USDT | dinámico | 100010538 | 00020101021226370002800103903022025072409211954330527520448295303604540415005802PE5917CESAR TACURI INGA6004Lima80550003ID10144suGASdIEsZFzlFh4eZ/UMQRNdpSojGNBwPiV0Punz2o=90490005GLOSA0136Happy Path Generación de QR Dinamico91230007FECVCTO01082025123192210005QUOTA01089999999963041AAA | USDT    |        | QR-Peru-n | 0x862Acf26956DCEf54F4726CF88709bFE9128e500 | USDT   |
            | QR  | Peru        | USDT | estático | 100010538 | 000201010211263700028001039030220250424092119905530665204482953036045802PE5917CESAR TACURI INGA6004Lima80550003ID10144suGASdIEsZFzlFh4eZ/UMQRNdpSojGNBwPiV0Punz2o=6304FA5B                                                                                                                  | USDT    | 100    | QR-Peru-n | 0x862Acf26956DCEf54F4726CF88709bFE9128e500 | USDT   |

    @Smoke @Automated
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

    @Smoke @Automated
    Scenario Outline: Ejecutar sintético de pago "<pay>" "<accion>" contra "<against>" no descubierto para usuario "<nacionality>"
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

        Given Execute crypto deposit

        # Get status synthetic payment
        When Wait for the processing of the "orden PIX" por 45 seconds
        And Execute the GET method on the endpoint "/v1/synthetics/{syntheticId}"
        Then Obtain a response 200 y status "COMPLETED" for payment synthetics
        And Obtain "<against>" balance for "<userAnyId>" user

        Examples:
            | pay | nacionality | coin | accion                  | userAnyId | paymentDestination | against | amount | sessionId      | to                                         | ticker |
            | QR  | Argentina   | USDT | pago a teléfono celular | 100010488 | +51987365083       | USDT    | 1000   | QR-PeruPhone-n | 0x862Acf26956DCEf54F4726CF88709bFE9128e500 | USDT   |
            | QR  | Peru        | USDT | pago a teléfono celular | 100010538 | +51987365083       | USDT    | 1000   | QR-PeruPhone-n | 0x862Acf26956DCEf54F4726CF88709bFE9128e500 | USDT   |

    #*************************************
    # !------ DESCUBIERTOS -------
    # ------ QR V1 ------

    @Smoke @Desc @V1Desc @Automated
    Scenario Outline: Ejecutar sintético de pago QR "<accion>" contra USDT en descubierto vía V1 endpoints
        Given The API key is available "F4EZSEW-AMC4Z24-G5CNFS4-880BSHJ"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        # Get company balance before execute qr payment
        And Obtain a company debt "<ticker>" balance
        # Request de lock payment
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<qrCode>" to the variable "qrCode"
        And Assign the value "<amount>" to the variable "amount"
        And Execute the POST method on the endpoint "/v2/pix-locks"
        Then Obtain a response 201 for lock payment
        # Execute synthetic payment
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "pixCode" to the variable "pixCode"
        And Execute the POST method on the endpoint "/v2/synthetics/pix-payment"
        Then Obtain a response 201
        And The attributes of the QR USDT synthetic are validated
        # Get status synthetic payment
        And Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic
        # Get company balance after execute qr payment
        And Obtain a company debt "<ticker>" balance

        Examples:
            | accion   | userAnyId | qrCode                                                                                                                                                                                                     | amount | sessionId    | to                                         | ticker |
            | embebido | 100009358 | 00020101021226990014br.gov.bcb.pix2577pix-h.bancogenial.com/qrs1/v2/014oS98KbQ7LEFcTdc8P69XEVBEqJRsBDDJtTCs6Kv3DScU52040000530398654042.105802BR5917Transafero Brasil6014Rio de Janeiro62070503***6304211D | 10     | QR-V1-DESC-n | 0x0FE0845Da176E24d9F6Bcf86d19948e592909C8D | USDT   |

    @Smoke @Desc @V1Desc @Automated
    Scenario Outline: Ejecutar sintético de pago QR "<accion>" contra ARS en descubierto vía V1 endpoints
        Given The API key is available "F4EZSEW-AMC4Z24-G5CNFS4-880BSHJ"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        # Get company balance before execute qr payment
        And Obtain a company debt "<against>" balance
        # Request de lock payment
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<qrCode>" to the variable "qrCode"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<amount>" to the variable "amount"
        And Execute the POST method on the endpoint "/v2/pix-locks"
        Then Obtain a response 201 for lock payment
        # Execute synthetic payment
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "pixCode" to the variable "pixCode"
        And Execute the POST method on the endpoint "/v2/synthetics/pix-payment"
        Then Obtain a response 201
        And The attributes of the QR ARS synthetic are validated
        # Get status synthetic payment
        And Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic
        # Get company balance after execute qr payment
        And Obtain a company debt "<against>" balance

        Examples:
            | accion   | userAnyId | qrCode                                                                                                                                                                                                     | amount | against | sessionId    | to                                         | ticker |
            | embebido | 100009358 | 00020101021226990014br.gov.bcb.pix2577pix-h.bancogenial.com/qrs1/v2/014oS98KbQ7LEFcTdc8P69XEVBEqJRsBDDJtTCs6Kv3DScU52040000530398654042.105802BR5917Transafero Brasil6014Rio de Janeiro62070503***6304211D | 10     | ARS     | QR-V1-DESC-n | 0x0FE0845Da176E24d9F6Bcf86d19948e592909C8D | USDT   |

    # ------ QR V2 ------

    @Smoke @Desc @QRV2Desc @Automated
    Scenario Outline: Ejecutar sintético de pago QR "<accion>" contra USDT en descubierto vía V2 endpoints
        Given The API key is available "F4EZSEW-AMC4Z24-G5CNFS4-880BSHJ"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        # Get company balance before execute qr payment
        And Obtain a company debt "<ticker>" balance
        # Request de lock payment
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<qrCode>" to the variable "qrCode"
        And Assign the value "<amount>" to the variable "amount"
        And Execute the POST method on the endpoint "/v2/payment-locks"
        Then Obtain a response 201 for lock payment
        # Execute synthetic payment
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "pixCode" to the variable "pixCode"
        And Execute the POST method on the endpoint "/v2/synthetics/qr-payment"
        Then Obtain a response 201
        And The attributes of the QR USDT synthetic are validated
        # Get status synthetic payment
        And Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic
        # Get company balance after execute qr payment
        And Obtain a company debt "<ticker>" balance

        Examples:
            | accion   | userAnyId | qrCode          | amount | sessionId    | to                                         | ticker |
            | manual   | 100009359 | qr3manualamount | 2000   | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |
            | embebido | 100009359 | qr3             | 1000   | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |

    @NoSupportYet
    Scenario Outline: Ejecutar sintético de pago QR "<accion>" contra ARS en descubierto vía V2 endpoints
        Given The API key is available "F4EZSEW-AMC4Z24-G5CNFS4-880BSHJ"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<qrCode>" to the variable "qrCode"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<amount>" to the variable "amount"
        And Execute the POST method on the endpoint "/v2/payment-locks"
        Then Obtain a response 201

        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "pixCode" to the variable "pixCode"
        And Execute the POST method on the endpoint "/v2/synthetics/qr-payment"
        Then Obtain a response 201
        And The attributes of the QR ARS synthetic are validated

        When Wait for the processing of the "orden QR" por 5 seconds
        And Execute the GET method on the endpoint "/v1/synthetics/{syntheticId}"
        Then Obtain a response 200 y status "COMPLETED" for payment synthetics

        Examples:
            | accion   | userAnyId | qrCode          | against | amount | sessionId    | to                                         | ticker |
            | manual   | 100009359 | qr3manualamount | ARS     | 100000 | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |
            | embebido | 100009359 | qr3             | ARS     | 1000   | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |

    @NoSupportYet
    Scenario Outline: Ejecutar sintético de pago QR "<accion>" contra ARS en descubierto con valores mínimos vía V2 endpoints
        Given The API key is available "F4EZSEW-AMC4Z24-G5CNFS4-880BSHJ"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<qrCode>" to the variable "qrCode"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<amount>" to the variable "amount"
        And Execute the POST method on the endpoint "/v2/payment-locks"
        Then Obtain a response 201

        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "pixCode" to the variable "pixCode"
        And Execute the POST method on the endpoint "/v2/synthetics/qr-payment"
        Then Obtain a response 201
        And The attributes of the QR ARS synthetic are validated

        When Wait for the processing of the "orden QR" por 5 seconds
        And Execute the GET method on the endpoint "/v1/synthetics/{syntheticId}"
        Then Obtain a response 200 y status "COMPLETED" for payment synthetics

        Examples:
            | accion | userAnyId | qrCode          | against | amount | sessionId    | to                                         | ticker |
            | manual | 100009359 | qr3manualamount | ARS     | 101    | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |

    @NoSupportYet
    Scenario Outline: Validar error al ejecutar sintético de pago QR "<accion>" contra ARS en descubierto con monto inferior al mínimo vía V2 endpoints
        Given The API key is available "F4EZSEW-AMC4Z24-G5CNFS4-880BSHJ"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<qrCode>" to the variable "qrCode"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<amount>" to the variable "amount"
        And Execute the POST method on the endpoint "/v2/payment-locks"
        Then Obtain a response 201

        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "pixCode" to the variable "pixCode"
        And Execute the POST method on the endpoint "/v2/synthetics/qr-payment"
        Then Obtain a response 400

        Examples:
            | accion | userAnyId | qrCode          | against | amount | sessionId    | to                                         | ticker |
            | manual | 100009359 | qr3manualamount | ARS     | 9      | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |

    # ------ PIX V1 ------

    @Smoke @Desc @PixV1Desc @Automated
    Scenario Outline:  Ejecutar sintético de pago PIX "<accion>" contra USDT en descubierto vía V1 endpoints
        Given The API key is available "F4EZSEW-AMC4Z24-G5CNFS4-880BSHJ"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        # Get company balance before execute qr payment
        And Obtain a company debt "<ticker>" balance
        # Request de lock payment
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<qrCode>" to the variable "qrCode"
        And Assign the value "<amount>" to the variable "amount"
        And Execute the POST method on the endpoint "/v2/pix-locks"
        Then Obtain a response 201 for lock payment
        # Execute synthetic payment
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "pixCode" to the variable "pixCode"
        And Execute the POST method on the endpoint "/v2/synthetics/pix-payment"
        Then Obtain a response 201
        # Get status synthetic payment
        And Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic
        # Get company balance after execute qr payment
        And Obtain a company debt "<ticker>" balance

        Examples:
            | accion   | userAnyId | qrCode          | amount | sessionId              | to                                         | ticker |
            | embebido | 100009360 | pix             | 10     | PIX-embebido-V1-DESC-n | 0x966af97f8D14FbAa77d3fdfe214a638b5587BCBA | USDT   |
            | manual   | 100009360 | pixmanualamount | 10     | PIX-manual-V1-DESC-n   | 0x966af97f8D14FbAa77d3fdfe214a638b5587BCBA | USDT   |

    @Smoke @Desc @PixV1Desc @Automated
    Scenario Outline:  Ejecutar sintético de pago PIX "<accion>" contra ARS en descubierto vía V1 endpoints
        Given The API key is available "F4EZSEW-AMC4Z24-G5CNFS4-880BSHJ"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        # Get company balance before execute qr payment
        And Obtain a company debt "<against>" balance
        # Request de lock payment
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<qrCode>" to the variable "qrCode"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<amount>" to the variable "amount"
        And Execute the POST method on the endpoint "/v2/pix-locks"
        Then Obtain a response 201 for lock payment
        # Execute synthetic payment
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "pixCode" to the variable "pixCode"
        And Execute the POST method on the endpoint "/v2/synthetics/pix-payment"
        Then Obtain a response 201
        # Get status synthetic payment
        And Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic
        # Get company balance after execute qr payment
        And Obtain a company debt "<against>" balance

        #Usuario argentino realizando pago qr a brasil
        Examples:
            | accion   | userAnyId | qrCode          | against | amount | sessionId              | to                                         | ticker |
            | embebido | 100009360 | pix             | ARS     | 10     | PIX-embebido-V1-DESC-n | 0x966af97f8D14FbAa77d3fdfe214a638b5587BCBA | USDT   |
            | manual   | 100009360 | pixmanualamount | ARS     | 10     | PIX-manual-V1-DESC-n   | 0x966af97f8D14FbAa77d3fdfe214a638b5587BCBA | USDT   |

    # ------ PIX V2 ------

    @Smoke @Desc @PixV2Desc @Automated
    Scenario Outline: Ejecutar sintético de pago PIX "<accion>" contra USDT en descubierto vía V2 endpoints
        Given The API key is available "F4EZSEW-AMC4Z24-G5CNFS4-880BSHJ"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        # Get company balance before execute qr payment
        And Obtain a company debt "<ticker>" balance
        # Request de lock payment
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<qrCode>" to the variable "qrCode"
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
        And Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic
        # Get company balance after execute qr payment
        And Obtain a company debt "<ticker>" balance

        Examples:
            | accion   | userAnyId | qrCode          | amount | sessionId              | to                                         | ticker |
            | manual   | 100009361 | pixmanualamount | 10     | PIX-manual-V2-DESC-n   | 0xF26A2ECa66d87Dd16225c8507ABbBf3CD14Cfcd2 | USDT   |
            | embebido | 100009361 | pix             | 10     | PIX-embebido-V2-DESC-n | 0xF26A2ECa66d87Dd16225c8507ABbBf3CD14Cfcd2 | USDT   |

    @Smoke @Desc @PixV2Desc @Automated
    Scenario Outline: Ejecutar sintético de pago PIX "<accion>" contra ARS en descubierto vía V2 endpoints
        Given The API key is available "F4EZSEW-AMC4Z24-G5CNFS4-880BSHJ"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        # Get company balance before execute qr payment
        And Obtain a company debt "<against>" balance
        # Request de lock payment
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<qrCode>" to the variable "qrCode"
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
        And Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic
        # Get company balance after execute qr payment
        And Obtain a company debt "<against>" balance

        Examples:
            | accion   | userAnyId | qrCode          | against | amount | sessionId              | to                                         | ticker |
            | manual   | 100009361 | pixmanualamount | ARS     | 10     | PIX-manual-V2-DESC-n   | 0xF26A2ECa66d87Dd16225c8507ABbBf3CD14Cfcd2 | USDT   |
            | embebido | 100009361 | pix             | ARS     | 10     | PIX-embebido-V2-DESC-n | 0xF26A2ECa66d87Dd16225c8507ABbBf3CD14Cfcd2 | USDT   |

    # ------ PaymentDestinarion ------

    @Smoke @Desc @Bybit @Automated
    Scenario Outline: Ejecutar sintético de pago "<pay>" "<accion>" contra "<coin>" en descubierto para usuario "<nacionality>" vía ByBit endpoints
        Given The API key is available "F4EZSEW-AMC4Z24-G5CNFS4-880BSHJ"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        # Get company balance before execute qr payment
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
        And Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic
        # Get company balance after execute qr payment
        And Obtain a company debt "<coin>" balance

        Examples:
            | pay | nacionality | coin | accion   | userAnyId | paymentDestination | against | amount | sessionId                    | to                                         | ticker |
            | PIX | Argentina   | USDT | manual   | 100009406 | pixmanualamount    |         | 10     | PIX-ByBit-manual-V2-DESC-n   | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
            | PIX | Argentina   | USDT | embebido | 100009406 | pix                |         | 10     | PIX-ByBit-embebido-V2-DESC-n | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
            | QR  | Argentina   | USDT | manual   | 100009406 | qr3manualamount    |         | 1000   | PIX-ByBit-manual-V2-DESC-n   | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
            | QR  | Argentina   | USDT | embebido | 100009406 | qr3                |         | 1000   | PIX-ByBit-embebido-V2-DESC-n | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
            | QR  | Brasil      | USDT | manual   | 100009407 | pixmanualamount    | USDT    | 10     | PIX-ByBit-manual-V2-DESC-n   | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
            | QR  | Brasil      | USDT | manual   | 100009407 | qr3manualamount    |         | 1000   | PIX-ByBit-manual-V2-DESC-n   | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
            | QR  | Brasil      | USDT | embebido | 100009407 | qr3                |         | 1000   | PIX-ByBit-embebido-V2-DESC-n | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
            | QR  | Brasil      | USDT | embebido | 100009407 | pix                | USDT    | 10     | PIX-ByBit-embebido-V2-DESC-n | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |

    @Smoke @Desc @BybitPixkeyb @Automated
    Scenario Outline: Ejecutar sintético de pago "<pay>" "<accion>" contra "<coin>" hacia PixKey en descubierto para usuario "<nacionality>" vía ByBit endpoints
        Given The API key is available "F4EZSEW-AMC4Z24-G5CNFS4-880BSHJ"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        # Get company balance before execute qr payment
        When Obtain a company debt "<coin>" balance
        # Request de lock payment
        And Assign the value "<userAnyId>" to the variable "userAnyId"
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
        And Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic
        # Get company balance after execute qr payment
        And Obtain a company debt "<coin>" balance

        # User ARG no funciona todavia por eso se comentó
        Examples:
            | pay | nacionality | coin | accion   | userAnyId | paymentDestination                   | against | amount | sessionId                       | to                                         | ticker |
            # | PIX | Argentina   | USDT | manual   | 100009406 | martin@gmail.com                     |         | 10     | PixKey-ByBit-manual-V2-DESC-n   | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
            # | PIX | Argentina   | USDT | embebido | 100009406 | renancamargo19@gmail.com             |         | 10     | PixKey-ByBit-embebido-V2-DESC-n | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
            # | PIX | Argentina   | USDT | manual   | 100009406 | +5511949227612                       |         | 10     | PixKey-ByBit-manual-V2-DESC-n   | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
            # | PIX | Argentina   | USDT | embebido | 100009406 | 08449ae2-8a26-47a5-992d-2689f135bc11 |         | 10     | PixKey-ByBit-embebido-V2-DESC-n | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
            | QR  | Brasil      | USDT | manual   | 100009407 | martin@gmail.com                     |         | 10     | PixKey-ByBit-manual-V2-DESC-n   | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
            | QR  | Brasil      | USDT | embebido | 100009407 | renancamargo19@gmail.com             |         | 10     | PixKey-ByBit-embebido-V2-DESC-n | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
            | QR  | Brasil      | USDT | manual   | 100009407 | +5511949227612                       |         | 10     | PixKey-ByBit-manual-V2-DESC-n   | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
            | QR  | Brasil      | USDT | embebido | 100009407 | 08449ae2-8a26-47a5-992d-2689f135bc11 |         | 10     | PixKey-ByBit-embebido-V2-DESC-n | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |

    @Smoke @Desc @Sender @Automated
    Scenario Outline: Ejecutar sintético de pago "<pay>" contra "<against>" enviando sender info
        Given The API key is available "C8P0Y2E-HQ4MTGE-JCQC1P9-9SETP69"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        # Get company balance before execute qr payment
        When Obtain a company debt "<against>" balance
        # Request de lock payment
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<paymentDestination>" to the variable "paymentDestination"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<exchange>" to the variable "exchange"
        And Assign the value "<legalId>" to the variable "legalId"
        And Assign the value "<name>" to the variable "name"
        And Assign the value "<surname>" to the variable "surname"
        And Execute the POST method on the endpoint "/v2/payment-locks"
        Then Obtain a response 201 for lock payment
        # Execute synthetic payment
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "pixCode" to the variable "pixCode"
        And Execute the POST method on the endpoint "/v2/synthetics/qr-payment"
        Then Obtain a response 201
        # Get status synthetic payment
        And Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic
        And Validate sender info
        # Get company balance after execute qr payment
        And Obtain a company debt "<against>" balance

        Examples:
            | pay | exchange  | legalId     | name          | surname  | userAnyId | paymentDestination | against | amount | sessionId                      |
            | PIX | BRAZIL    | 40842073817 | DARIO AUGUSTO | DA SILVA | 100011832 | pixmanualamount    | ARS     | 10     | PixKey-Sender-manual-V2-DESC-n |
            | PIX | ARGENTINA | 27414298732 | BETO LUIS     | SOLARI   | 100011832 | pixmanualamount    | ARS     | 10     | PixKey-Sender-manual-V2-DESC-n |


    @Peru @ToBeAutomated
    Scenario Outline: Ejecutar sintético de pago "<pay>" "<accion>" contra "<coin>" en descubierto para usuario "<nacionality>"
        Given The API key is available "HCV8JDA-P574VG5-MR5JYEG-HRZCP74"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        # Get company balance before execute qr payment
        When Obtain a company debt "<coin>" balance
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
        And Obtain a response 200 and status "COMPLETED" for "pix payment" synthetic
        # Get company balance after execute qr payment
        And Obtain a company debt "<coin>" balance

        Examples:
            | pay | nacionality | coin | accion   | userAnyId | paymentDestination                                                                                                                                                                                                                                                                                 | against | amount | sessionId | to                                         | ticker |
            | QR  | Argentina   | USDT | dinámico | 100010503 | 0002010102122637000280010390302202508210921195427978452044829530360454031505802PE5925Tupay Test Prod - S/ 1.006004Lima80550003ID10144suGASdIEsZFzlFh4eZ/UMQRNdpSojGNBwPiV0Punz2o=90490005GLOSA0136Happy Path Generación de QR Dinamico91230007FECVCTO01082025123192210005QUOTA01089999999963040C20 | USDT    |        | QR-Peru-n | 0x862Acf26956DCEf54F4726CF88709bFE9128e500 | USDT   |
            # | QR  | Argentina   | USDT | estático | 100010503 | 000201010211263700028001039030220250424092119905530665204482953036045802PE5917CESAR TACURI INGA6004Lima80550003ID10144suGASdIEsZFzlFh4eZ/UMQRNdpSojGNBwPiV0Punz2o=6304FA5B                                                                                                                         | USDT    | 100    | QR-Peru-n | 0x862Acf26956DCEf54F4726CF88709bFE9128e500 | USDT   |
            | QR  | Peru        | USDT | dinámico | 100010539 | 0002010102122637000280010390302202508210921195427976252044829530360454031105802PE5925Tupay Test Prod - S/ 1.006004Lima80550003ID10144suGASdIEsZFzlFh4eZ/UMQRNdpSojGNBwPiV0Punz2o=90490005GLOSA0136Happy Path Generación de QR Dinamico91230007FECVCTO01082025123192140005QUOTA010156304D30A        | USDT    |        | QR-Peru-n | 0x862Acf26956DCEf54F4726CF88709bFE9128e500 | USDT   |
    # | QR  | Peru        | USDT | estático | 100010539 | 000201010211263700028001039030220250424092119905530665204482953036045802PE5917CESAR TACURI INGA6004Lima80550003ID10144suGASdIEsZFzlFh4eZ/UMQRNdpSojGNBwPiV0Punz2o=6304FA5B                                                                                                                         | USDT    | 100    | QR-Peru-n | 0x862Acf26956DCEf54F4726CF88709bFE9128e500 | USDT   |

    @Smoke @Desc @PeruPhone @Automated
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

    @Refunds @RefundsDs
    Scenario Outline: Validar refund para usuario operando en descubierto
        Given The API key is available "F4EZSEW-AMC4Z24-G5CNFS4-880BSHJ"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"

        When Obtain a company debt "<against>" balance

        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<paymentDestination>" to the variable "paymentDestination"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<sessionId>" to the variable "sessionId"
        Then Execute the refund synthetic "descubierto"
        And Obtain a response 200 y status "CANCELLED"

        And Obtain a company debt "<against>" balance

        Examples:
            | userAnyId | paymentDestination      | against | amount | sessionId     |
            | 100009408 | failuremartin@gmail.com | USDT    | 1000   | refund-DESC-n |
    # Cuando marto incluya +5511949227612 como siempre falla para reverse, borrar qr3manualamount
    # Falta caso en against ARS en el que se toma deuda en ARS pero no hay order reversal

    @Refunds @RefundsNDt
    Scenario Outline: Validar refund para usuario operando en no descubierto contra <against>
        Given The API key is available "95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6"
        And The API secret is available "1RpvdT7Vc7ukKeGKdU"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"

        When Execute the GET method on the endpoint "/v2/user-balances/<userAnyId>"
        Then Obtain a response 200
        And Obtain a user in "<against>" balance

        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<paymentDestination>" to the variable "paymentDestination"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<apiKeyDeposit>" to the variable "apiKeyDeposit"
        Then Execute the refund synthetic "no descubierto"
        And Obtain a response 200 y status "CANCELLED"

        When Execute the GET method on the endpoint "/v2/user-balances/<userAnyId>"
        Then Obtain a response 200
        And Obtain refund on user in "<against>" balance

        Examples:
            | userAnyId | paymentDestination      | against | amount | sessionId        | apiKeyDeposit                   |
            | 100009417 | failuremartin@gmail.com | ARS     | 1000   | refund-NO-DESC-n | C10XB2Z-AG243CS-G42KB2M-4085WTF |

    @Refunds @manualRefund
    Scenario Outline: Validar refund manual desde admin para usuario operando en no descubierto contra <against>
        Given The API key is available "95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6"
        And The API secret is available "1RpvdT7Vc7ukKeGKdU"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        And login user admin "<credential>"
        # Validate initial balance before execute qr payment
        And Obtain "<against>" balance for "<userAnyId>" user
        # Request de lock payment
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<qrCode>" to the variable "qrCode"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<against>" to the variable "against"
        And Execute the POST method on the endpoint "/v2/payment-locks"
        Then Obtain a response 201 for lock payment
        # Execute synthetic payment
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "pixCode" to the variable "pixCode"
        And Execute the POST method on the endpoint "/v2/synthetics/qr-payment"
        Then Obtain a response 201
        # And The attributes of the QR USDT synthetic are validated
        # Get status synthetic payment
        And Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic
        # Validate balance after execute qr payment
        And Obtain "<against>" balance for "<userAnyId>" user
        And Execute admin refund

        Examples:
            | credential                | userAnyId | qrCode          | against | amount | sessionId        | apiKeyDeposit                   |
            | andresperalta@manteca.dev | 100009417 | qr3manualamount | ARS     | 1000   | refund-NO-DESC-n | C10XB2Z-AG243CS-G42KB2M-4085WTF |

#SENDER. Se aloja en la db solo minimal info, el resto es solo para BIND