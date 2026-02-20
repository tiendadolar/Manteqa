@QR @Regression
Feature: Sintético QR 3.0

    # **** SUITE ****
    # ! NO TOCAR DATOS
    # ------ NO DESCUBIERTOS -------
    # ------ QR V1 ------

    @QRV1NoDesc @Automated
    Scenario Outline: Ejecutar sintético de pago QR PIX <type> contra <ticker> no descubierto vía V1 endpoints desde User Account
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

        # # First QR is implemented to skip microoperations blocked 08449ae2-8a26-47a5-992d-2689f135bc11
        # Examples:
        #     | userAnyId | type     | qrCode                                                                                                                                                                                                     | amount | sessionId      | to                                         | ticker |
        #     | 100009352 | estático | pixmanualamount                                                                                                                                                                                            | 10     | QR-NoDesc-V1-n | 0x7921319332714EBea5c1219439c34309e600DF54 | USDT   |
        #     | 100009352 | embebido | 00020101021226990014br.gov.bcb.pix2577pix-h.bancogenial.com/qrs1/v2/014oS98KbQ7LEFcTdc8P69XEVBEqJRsBDDJtTCs6Kv3DScU52040000530398654042.105802BR5917Transafero Brasil6014Rio de Janeiro62070503***6304211D | 10     | QR-NoDesc-V1-n | 0x7921319332714EBea5c1219439c34309e600DF54 | USDT   |

        #When transfero pix failed
        Examples:
            | userAnyId | type    | qrCode                               | amount | sessionId      | to                                         | ticker |
            | 100009352 | PIX-KEY | 08449ae2-8a26-47a5-992d-2689f135bc11 | 10     | QR-NoDesc-V1-n | 0x7921319332714EBea5c1219439c34309e600DF54 | USDT   |

    @QRV1NoDesc @Automated
    Scenario Outline: Ejecutar sintético de pago QR PIX <type> contra <against> en no descubierto vía V1 endpoints
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

        # Examples:
        #     | userAnyId | type     | qrCode                                                                                                                                                                                                     | against | amount | sessionId      | to                                         |
        #     | 100009352 | embebido | 00020101021226990014br.gov.bcb.pix2577pix-h.bancogenial.com/qrs1/v2/014oS98KbQ7LEFcTdc8P69XEVBEqJRsBDDJtTCs6Kv3DScU52040000530398654042.105802BR5917Transafero Brasil6014Rio de Janeiro62070503***6304211D | ARS     | 10     | QR-NoDesc-V1-n | 0x7921319332714EBea5c1219439c34309e600DF54 |
        #     | 100009352 | estático | pixmanualamount

        #When transfero pix failed
        Examples:
            | userAnyId | type     | qrCode                               | against | amount | sessionId      | to                                         |
            | 100009352 | embebido | 08449ae2-8a26-47a5-992d-2689f135bc11 | ARS     | 10     | QR-NoDesc-V1-n | 0x7921319332714EBea5c1219439c34309e600DF54 |

    @QRV1NoDesc @Automated
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

    @QRV2NoDesc @Automated
    Scenario Outline: Ejecutar sintético de pago QR ARS <accion> contra <ticker> en no descubierto vía V2 endpoints against default
        Given The API key is available "apiKEY"
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
        And The attributes of the QR "<ticker>" synthetic are validated
        # Execute deposit
        And Execute crypto deposit
        # Get status synthetic payment
        And Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic
        # Validate balance after execute qr payment
        And Obtain "<ticker>" balance for "<userAnyId>" user

        #QR BOB monto nuy bajo, falla contra USDT
        Examples:
            | apiKEY                          | credential                | accion   | userAnyId | qrCode             | amount | sessionId    | to                                         | ticker |
            | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 | andresperalta@manteca.dev | dinamico | 100009502 | qr3                |        | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |
            | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 | andresperalta@manteca.dev | estatico | 100009502 | qr3manualamount    | 1500   | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |
            | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 | andresperalta@manteca.dev | estatico | 100013787 | qr3BOBmanualamount | 1000   | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |

    @QRV2NoDesc @Automated
    Scenario Outline: Ejecutar sintético de pago QR ARS <accion> contra <ticker> en no descubierto vía V2 endpoints
        Given The API key is available "95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        And The API secret is available "1RpvdT7Vc7ukKeGKdU"
        # Validate initial balance before execute qr payment
        And Obtain "<ticker>" balance for "<userAnyId>" user
        # Request de lock payment
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<qrCode>" to the variable "qrCode"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<ticker>" to the variable "against"
        And Execute the POST method on the endpoint "/v2/payment-locks"
        Then Obtain a response 201 for lock payment
        # Execute synthetic payment
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "pixCode" to the variable "pixCode"
        And Execute the POST method on the endpoint "/v2/synthetics/qr-payment"
        Then Obtain a response 201
        And The attributes of the QR "<ticker>" synthetic are validated
        # Execute deposit
        And Execute crypto deposit
        # Get status synthetic payment
        And Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic
        # Validate balance after execute qr payment
        And Obtain "<ticker>" balance for "<userAnyId>" user

        @Smoke
        Examples:
            | credential                | accion   | userAnyId | qrCode          | amount | sessionId    | to                                         | ticker |
            | andresperalta@manteca.dev | estatico | 100009502 | qr3manualamount | 1500   | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |
            | andresperalta@manteca.dev | embebido | 100009502 | qr3             | 1500   | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |

        @Smoke @WLD
        Examples:
            | credential                | accion   | userAnyId | qrCode          | amount | sessionId    | to                                         | ticker |
            | andresperalta@manteca.dev | estatico | 100009502 | qr3manualamount | 1500   | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | WLD    |
            | andresperalta@manteca.dev | embebido | 100009502 | qr3             | 1500   | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | WLD    |


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

        # Examples:
        #     | accion   | userAnyId | qrCode          | amount | sessionId                 | to                                         | ticker |
        #     | manual   | 100009624 | pixmanualamount | 10     | PIX-manual-V1-NO-DESC-n   | 0xC19b0041b0D6261FD98BFe753d76D58Ae65e44aD | USDT   |
        #     | embebido | 100009624 | pix             | 10     | PIX-embebido-V1-NO-DESC-n | 0xC19b0041b0D6261FD98BFe753d76D58Ae65e44aD | USDT   |

        #When transfero pix failed
        Examples:
            | accion | userAnyId | qrCode                               | amount | sessionId               | to                                         | ticker |
            | manual | 100009624 | 08449ae2-8a26-47a5-992d-2689f135bc11 | 10     | PIX-manual-V1-NO-DESC-n | 0xC19b0041b0D6261FD98BFe753d76D58Ae65e44aD | USDT   |

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

        # Examples:
        #     | accion   | userAnyId | qrCode          | against | amount | sessionId              | to                                         | ticker |
        #     | embebido | 100009624 | pix             | ARS     | 10     | PIX-embebido-V1-DESC-n | 0xC19b0041b0D6261FD98BFe753d76D58Ae65e44aD | USDT   |
        #     | manual   | 100009624 | pixmanualamount | ARS     | 10     | PIX-manual-V1-DESC-n   | 0xC19b0041b0D6261FD98BFe753d76D58Ae65e44aD | USDT   |

        #When transfero pix failed
        Examples:
            | accion   | userAnyId | qrCode                               | against | amount | sessionId              | to                                         | ticker |
            | embebido | 100009624 | 08449ae2-8a26-47a5-992d-2689f135bc11 | ARS     | 10     | PIX-embebido-V1-DESC-n | 0xC19b0041b0D6261FD98BFe753d76D58Ae65e44aD | USDT   |

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

        # Examples:
        #     | accion   | userAnyId | qrCode          | amount | sessionId                 | to                                         | ticker |
        #     | manual   | 100009628 | pixmanualamount | 10     | PIX-manual-V2-NO-DESC-n   | 0x8aD91F66950d65C7a27a123c28fd4f861717bF08 | USDT   |
        #     | embebido | 100009628 | pix             |        | PIX-embebido-V2-NO-DESC-n | 0x8aD91F66950d65C7a27a123c28fd4f861717bF08 | USDT   |

        #When transfero pix failed
        Examples:
            | accion | userAnyId | qrCode                               | amount | sessionId               | to                                         | ticker |
            | manual | 100009628 | 08449ae2-8a26-47a5-992d-2689f135bc11 | 10     | PIX-manual-V2-NO-DESC-n | 0x8aD91F66950d65C7a27a123c28fd4f861717bF08 | USDT   |

    @PixV2NoDesc @Automated
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

        # Examples:
        #     | accion   | userAnyId | qrCode             | against | amount | sessionId                 | to                                         | ticker |
        #     | manual   | 100009628 | pixmanualamount    | ARS     | 10     | PIX-manual-V2-NO-DESC-n   | 0xF26A2ECa66d87Dd16225c8507ABbBf3CD14Cfcd2 | USDT   |
        #     | embebido | 100009628 | pix                | ARS     | 10     | PIX-embebido-V2-NO-DESC-n | 0xF26A2ECa66d87Dd16225c8507ABbBf3CD14Cfcd2 | USDT   |
        #     | estatico | 100013787 | qr3BOBmanualamount | BOB     | 1000   | QR-V2-DESC-n              | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |

        #When transfero pix failed
        @Smoke
        Examples:
            | accion   | userAnyId | qrCode                               | against | amount | sessionId                 | to                                         | ticker |
            | manual   | 100009628 | 08449ae2-8a26-47a5-992d-2689f135bc11 | ARS     | 10     | PIX-manual-V2-NO-DESC-n   | 0xF26A2ECa66d87Dd16225c8507ABbBf3CD14Cfcd2 | USDT   |
            | embebido | 100009628 | 08449ae2-8a26-47a5-992d-2689f135bc11 | ARS     | 10     | PIX-embebido-V2-NO-DESC-n | 0xF26A2ECa66d87Dd16225c8507ABbBf3CD14Cfcd2 | USDT   |
            | estatico | 100013787 | qr3BOBmanualamount                   | BOB     | 1000   | QR-V2-DESC-n              | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |

        @Smoke
        Examples:
            | accion | userAnyId | qrCode                               | against | amount | sessionId               | to                                         | ticker |
            | manual | 100009628 | 08449ae2-8a26-47a5-992d-2689f135bc11 | ARS     | 10     | PIX-manual-V2-NO-DESC-n | 0xF26A2ECa66d87Dd16225c8507ABbBf3CD14Cfcd2 | USDT   |

    @Smoke @Peru @NoDesc @Automated
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
            | QR  | Peru        | PEN  | estático | 100010538 | 000201010211263700028001039030220250424092119905530665204482953036045802PE5917CESAR TACURI INGA6004Lima80550003ID10144suGASdIEsZFzlFh4eZ/UMQRNdpSojGNBwPiV0Punz2o=6304FA5B                                                                                                                 | PEN     | 100    | QR-Peru-n | 0x862Acf26956DCEf54F4726CF88709bFE9128e500 |        |

    @Smoke @Peru @NoDesc @Automated
    Scenario Outline: Ejecutar sintético de pago "<pay>" "<accion>" contra "<coin>" en no descubierto para usuario "<nacionality>"
        Given The API key is available "<apiKEY>"
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
            | apiKEY                          | pay | nacionality | coin | accion   | userAnyId | paymentDestination                                                                                                                                                                                                                                                                          | against | amount | sessionId | to                                         | ticker |
            # | MBA68YQ-RXW46ZS-P4K4BAZ-D2KX43F | QR  | Argentina   | USDT | dinámico | 100010488 | 00020101021226370002800103903022025072409211954330527520448295303604540415005802PE5917CESAR TACURI INGA6004Lima80550003ID10144suGASdIEsZFzlFh4eZ/UMQRNdpSojGNBwPiV0Punz2o=90490005GLOSA0136Happy Path Generación de QR Dinamico91230007FECVCTO01082025123192210005QUOTA01089999999963041AAA | USDT    |        | QR-Peru-n | 0x862Acf26956DCEf54F4726CF88709bFE9128e500 | USDT   |
            | MBA68YQ-RXW46ZS-P4K4BAZ-D2KX43F | QR  | Argentina   | USDT | estático | 100010488 | 000201010211263700028001039030220250424092119905530665204482953036045802PE5917CESAR TACURI INGA6004Lima80550003ID10144suGASdIEsZFzlFh4eZ/UMQRNdpSojGNBwPiV0Punz2o=6304FA5B                                                                                                                  | USDT    | 100    | QR-Peru-n | 0x862Acf26956DCEf54F4726CF88709bFE9128e500 | USDT   |
            | MBA68YQ-RXW46ZS-P4K4BAZ-D2KX43F | QR  | Peru        | USDT | dinámico | 100010538 | 00020101021226370002800103903022025072409211954330527520448295303604540415005802PE5917CESAR TACURI INGA6004Lima80550003ID10144suGASdIEsZFzlFh4eZ/UMQRNdpSojGNBwPiV0Punz2o=90490005GLOSA0136Happy Path Generación de QR Dinamico91230007FECVCTO01082025123192210005QUOTA01089999999963041AAA | USDT    |        | QR-Peru-n | 0x862Acf26956DCEf54F4726CF88709bFE9128e500 | USDT   |
    # | MBA68YQ-RXW46ZS-P4K4BAZ-D2KX43F | QR  | Peru        | USDT | estático | 100010538 | 000201010211263700028001039030220250424092119905530665204482953036045802PE5917CESAR TACURI INGA6004Lima80550003ID10144suGASdIEsZFzlFh4eZ/UMQRNdpSojGNBwPiV0Punz2o=6304FA5B                                                                                                                  | USDT    | 100    | QR-Peru-n | 0x862Acf26956DCEf54F4726CF88709bFE9128e500 | USDT   |

    @Peru @Smoke @Ignore
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

    @Peru @Smoke @ToBeAutomated
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
        And Execute crypto deposit
        # Get status synthetic payment
        Then Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic

        Examples:
            | pay | nacionality | coin | accion                  | userAnyId | paymentDestination | against | amount | sessionId      | to                                         | ticker |
            | QR  | Peru        | USDT | pago a teléfono celular | 100010538 | +51987365083       | USDT    | 1000   | QR-PeruPhone-n | 0x862Acf26956DCEf54F4726CF88709bFE9128e500 | USDT   |

    #*************************************
    # !------ USERBALANCES -------
    # ------ QR V1 ------

    @Smoke @UserBalance @QRV1NUserBalance @Automated
    Scenario Outline: Ejecutar sintético de pago QR PIX <type> contra <ticker> operando desde el user balance vía V1 endpoints
        Given The API key is available "0DBQKAS-Q4R456C-HCYXX4W-AYBYC6P"
        And The API secret is available "9MrwHA3SZP33Z7gUmb"
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
        And Assign the value "true" to the variable "skipDeposit"
        And Assign the value "pixCode" to the variable "pixCode"
        And Execute the POST method on the endpoint "/v2/synthetics/pix-payment"
        Then Obtain a response 201
        And Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic
        # Validate balance after execute qr payment
        And Obtain "<ticker>" balance for "<userAnyId>" user

        # First QR is implemented to skip microoperations blocked
        # Examples:
        #     | userAnyId | type     | qrCode          | amount | sessionId           | ticker |
        #     | 100015037 | estático | pixmanualamount | 10     | QR-UserBalance-V1-n | USDT   |
        #     | 100015037 | estático | pixmanualamount | 10     | QR-UserBalance-V1-n | ARS    |

        #When transfero pix failed
        Examples:
            | userAnyId | type     | qrCode                               | amount | sessionId           | ticker |
            | 100015037 | estático | 08449ae2-8a26-47a5-992d-2689f135bc11 | 10     | QR-UserBalance-V1-n | USDT   |
            | 100015037 | estático | 08449ae2-8a26-47a5-992d-2689f135bc11 | 10     | QR-UserBalance-V1-n | ARS    |

    # ------ QR V2 ------

    @UserBalance @QRV2UserBalance @Automated
    Scenario Outline: Ejecutar sintético de pago QR ARS <accion> contra <ticker> operando desde el user balance vía V2 endpoints
        Given The API key is available "0DBQKAS-Q4R456C-HCYXX4W-AYBYC6P"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        And The API secret is available "9MrwHA3SZP33Z7gUmb"
        # Validate initial balance before execute qr payment
        And Obtain "<ticker>" balance for "<userAnyId>" user
        # Request de lock payment
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<qrCode>" to the variable "qrCode"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<ticker>" to the variable "against"
        And Execute the POST method on the endpoint "/v2/payment-locks"
        Then Obtain a response 201 for lock payment
        # Execute synthetic payment
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "true" to the variable "skipDeposit"
        And Assign the value "pixCode" to the variable "pixCode"
        And Execute the POST method on the endpoint "/v2/synthetics/qr-payment"
        Then Obtain a response 201
        And The attributes of the QR "<ticker>" synthetic are validated
        # Get status synthetic payment
        And Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic
        # Validate balance after execute qr payment
        And Obtain "<ticker>" balance for "<userAnyId>" user

        @bob
        Examples:
            | credential                | accion   | userAnyId | qrCode          | amount | sessionId           | ticker |
            | andresperalta@manteca.dev | estatico | 100015038 | qr3manualamount | 1500   | QR-UserBalance-V2-n | USDT   |
            | andresperalta@manteca.dev | estatico | 100015038 | qr3manualamount | 1500   | QR-UserBalance-V2-n | ARS    |

    # ------ PIX V1 ------

    @UserBalance @PixV1UserBalance @Automated
    Scenario Outline:  Ejecutar sintético de pago PIX "<accion>" contra USDT operando desde el user balance vía V1 endpoints
        Given The API key is available "0DBQKAS-Q4R456C-HCYXX4W-AYBYC6P"
        And The API secret is available "9MrwHA3SZP33Z7gUmb"
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
        And Assign the value "true" to the variable "skipDeposit"
        And Assign the value "pixCode" to the variable "pixCode"
        And Execute the POST method on the endpoint "/v2/synthetics/pix-payment"
        Then Obtain a response 201
        # Get status synthetic payment
        And Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic
        # Validate balance after execute qr payment
        And Obtain "<ticker>" balance for "<userAnyId>" user

        # Examples:
        #     | accion   | userAnyId | qrCode          | amount | sessionId            | ticker |
        #     | estático | 100015039 | pixmanualamount | 10     | PIX-UserBalance-V1-n | USDT   |
        #     | estático | 100015039 | pixmanualamount | 10     | PIX-UserBalance-V1-n | ARS    |

        #When transfero pix
        Examples:
            | accion   | userAnyId | qrCode                               | amount | sessionId            | ticker |
            | estático | 100015039 | 08449ae2-8a26-47a5-992d-2689f135bc11 | 10     | PIX-UserBalance-V1-n | USDT   |
            | estático | 100015039 | 08449ae2-8a26-47a5-992d-2689f135bc11 | 10     | PIX-UserBalance-V1-n | ARS    |

    # ------ PIX V2 ------

    @UserBalance @PixV2UserBalance @Automated
    Scenario Outline: Ejecutar sintético de pago PIX "<accion>" contra USDT operando desde el user balance vía V2 endpoints
        Given The API key is available "0DBQKAS-Q4R456C-HCYXX4W-AYBYC6P"
        And The API secret is available "9MrwHA3SZP33Z7gUmb"
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
        And Assign the value "true" to the variable "skipDeposit"
        And Assign the value "pixCode" to the variable "pixCode"
        And Execute the POST method on the endpoint "/v2/synthetics/qr-payment"
        Then Obtain a response 201
        # Get status synthetic payment
        And Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic
        # Validate balance after execute qr payment
        And Obtain "<ticker>" balance for "<userAnyId>" user

        # Examples:
        #     | accion   | userAnyId | qrCode          | amount | sessionId            | ticker |
        #     | estático | 100015040 | pixmanualamount | 10     | PIX-UserBalance-V2-n | USDT   |
        #     | estático | 100015040 | pixmanualamount | 10     | PIX-UserBalance-V2-n | ARS    |

        #When transfero pix failed
        Examples:
            | accion   | userAnyId | qrCode                               | amount | sessionId            | ticker |
            | estático | 100015040 | 08449ae2-8a26-47a5-992d-2689f135bc11 | 10     | PIX-UserBalance-V2-n | USDT   |
            | estático | 100015040 | 08449ae2-8a26-47a5-992d-2689f135bc11 | 10     | PIX-UserBalance-V2-n | ARS    |

    @Smoke @Peru @UserBalance @Peru @Sender @Automated
    Scenario Outline: Ejecutar sintético de pago <pay> contra <against> enviando sender info desde Principal Account <accountExc>
        Given The API key is available "<apiKEY>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        # Get company balance before execute qr payment
        When Obtain "<against>" balance for "<userAnyId>" user
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
        And Assign the value "true" to the variable "skipDeposit"
        And Assign the value "pixCode" to the variable "pixCode"
        And Execute the POST method on the endpoint "/v2/synthetics/qr-payment"
        Then Obtain a response 201
        # Get status synthetic payment
        And Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic
        And Validate sender info
        # Get company balance after execute qr payment
        And Obtain "<against>" balance for "<userAnyId>" user

        #No admitido yet pagos desde principal accounts NO PERU. Por el momento solo desde ppal acc PERU
        @ARG
        Examples:
            | apiKEY                          | pay | exchange | legalId     | name          | surname  | userAnyId | paymentDestination                                                                                                                           | against | amount | sessionId                          | accountExc |
            | MCGKK4Q-4RA4MSN-HMT8FFQ-0BXW028 | PIX | BRAZIL   | 40842073817 | DARIO AUGUSTO | DA SILVA | 100037733 | +5511949227612                                                                                                                               | ARS     | 10     | PrincipalAccount-payment-V2-DESC-n | ARGENTINA  |
            | MCGKK4Q-4RA4MSN-HMT8FFQ-0BXW028 | QR  | BRAZIL   | 40842073817 | DARIO AUGUSTO | DA SILVA | 100037733 | 00020101021140200010com.yacare02022350150011336972350495204739953030325802AR5910HAVANNA SA6012BUENOS AIRES81220010com.yacare0204Y2156304E401 | ARS     | 1000   | PrincipalAccount-payment-V2-DESC-n | ARGENTINA  |

        @BRA
        Examples:
            | apiKEY                          | pay | exchange  | legalId     | name          | surname  | userAnyId | paymentDestination | against | amount | sessionId                          | accountExc |
            | MCGKK4Q-4RA4MSN-HMT8FFQ-0BXW028 | PIX | BRAZIL    | 40842073817 | DARIO AUGUSTO | DA SILVA | 100037715 | +5511949227612     | BRL     | 10     | PrincipalAccount-payment-V2-DESC-n | BRAZIL     |
            | MCGKK4Q-4RA4MSN-HMT8FFQ-0BXW028 | PIX | ARGENTINA | 27414298732 | BETO LUIS     | SOLARI   | 100037715 | +5511949227612     | BRL     | 10     | PrincipalAccount-payment-V2-DESC-n | BRAZIL     |

    # @BOB
    # Examples:
    #     | apiKEY                          | pay | exchange  | legalId     | name          | surname  | userAnyId | paymentDestination | against | amount | sessionId                          | accountExc |
    #     | MCGKK4Q-4RA4MSN-HMT8FFQ-0BXW028 | PIX | BRAZIL    | 40842073817 | DARIO AUGUSTO | DA SILVA | 100037707 | qr3BOBmanualamount | BOB     | 10     | PrincipalAccount-payment-V2-DESC-n | BRAZIL     |
    #     | MCGKK4Q-4RA4MSN-HMT8FFQ-0BXW028 | PIX | ARGENTINA | 27414298732 | BETO LUIS     | SOLARI   | 100037707 | qr3BOBmanualamount | BOB     | 10     | PrincipalAccount-payment-V2-DESC-n | BRAZIL     |


    @Smoke @UserBalance @Sender @Peru @Automated
    Scenario Outline: Ejecutar sintético de pago <pay> contra <against> enviando sender completo info desde Principal Account <accountExc> por PLUS_PAGOS
        Given The API key is available "<apiKEY>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        # Get company balance before execute qr payment
        When Obtain "<against>" balance for "<userAnyId>" user
        # Request de lock payment
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<paymentDestination>" to the variable "paymentDestination"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<exchange>" to the variable "exchange"
        And Assign the value "<legalId>" to the variable "legalId"
        And Assign the value "<name>" to the variable "name"
        And Assign the value "<surname>" to the variable "surname"
        And Assign the value "<work>" to the variable "work"
        And Assign the value "<email>" to the variable "email"
        And Assign the value "<phoneNumber>" to the variable "phoneNumber"
        And Assign the value "<gender>" to the variable "gender"
        And Execute the POST method on the endpoint "/v2/payment-locks"
        Then Obtain a response 201 for lock payment
        # Execute synthetic payment
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "true" to the variable "skipDeposit"
        And Assign the value "pixCode" to the variable "pixCode"
        And Execute the POST method on the endpoint "/v2/synthetics/qr-payment"
        Then Obtain a response 201
        # Get status synthetic payment
        And Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic
        And Validate sender info
        # Get company balance after execute qr payment
        And Obtain "<against>" balance for "<userAnyId>" user

        Examples:
            | apiKEY                          | pay           | exchange | legalId  | name          | surname  | work     | email              | phoneNumber  | gender | userAnyId | paymentDestination                                                                                                                                                                                                                                                                         | against | amount | sessionId                      | accountExc |
            | MCGKK4Q-4RA4MSN-HMT8FFQ-0BXW028 | QR_PERU       | PERU     | 46326357 | DARIO AUGUSTO | DA SILVA | EMPLEADO | polanque@gmail.com | +51953605263 | MALE   | 100037706 | 0002010102122637000280010390302202511060921196434575252044829530360454031505802PE5917CESAR TACURI INGA6004Lima80550003ID10144suGASdIEsZFzlFh4eZ/UMQRNdpSojGNBwPiV0Punz2o=90490005GLOSA0136Happy Path Generación de QR Dinamico91230007FECVCTO01082025123192210005QUOTA0108999999996304C993 | PEN     | 1000   | PixKey-Sender-manual-V2-DESC-n | PERU       |
            | MCGKK4Q-4RA4MSN-HMT8FFQ-0BXW028 | QR_PERU_PHONE | PERU     | 46326357 | DARIO AUGUSTO | DA SILVA | EMPLEADO | polanque@gmail.com | +51953605263 | MALE   | 100037706 | +51919468262                                                                                                                                                                                                                                                                               | PEN     | 1000   | PixKey-Sender-manual-V2-DESC-n | PERU       |


    #*************************************
    # !------ DESCUBIERTOS -------
    # ------ QR V1 ------

    @Desc @V1Desc @Automated
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
        And The attributes of the QR "<ticker>" synthetic are validated
        # Get status synthetic payment
        And Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic
        # Get company balance after execute qr payment
        And Obtain a company debt "<ticker>" balance

        # Examples:
        #     | accion   | userAnyId | qrCode                                                                                                                                                                                                     | amount | sessionId    | to                                         | ticker |
        #     | embebido | 100009358 | 00020101021226990014br.gov.bcb.pix2577pix-h.bancogenial.com/qrs1/v2/014oS98KbQ7LEFcTdc8P69XEVBEqJRsBDDJtTCs6Kv3DScU52040000530398654042.105802BR5917Transafero Brasil6014Rio de Janeiro62070503***6304211D | 10     | QR-V1-DESC-n | 0x0FE0845Da176E24d9F6Bcf86d19948e592909C8D | USDT   |

        #When transfero pix failed
        Examples:
            | accion   | userAnyId | qrCode                               | amount | sessionId    | to                                         | ticker |
            | embebido | 100009358 | 08449ae2-8a26-47a5-992d-2689f135bc11 | 10     | QR-V1-DESC-n | 0x0FE0845Da176E24d9F6Bcf86d19948e592909C8D | USDT   |


    @Desc @V1Desc @Automated
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
        And The attributes of the QR "<against>" synthetic are validated
        # Get status synthetic payment
        And Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic
        # Get company balance after execute qr payment
        And Obtain a company debt "<against>" balance

        # Examples:
        #     | accion   | userAnyId | qrCode                                                                                                                                                                                                     | amount | against | sessionId    | to                                         | ticker |
        #     | embebido | 100009358 | 00020101021226990014br.gov.bcb.pix2577pix-h.bancogenial.com/qrs1/v2/014oS98KbQ7LEFcTdc8P69XEVBEqJRsBDDJtTCs6Kv3DScU52040000530398654042.105802BR5917Transafero Brasil6014Rio de Janeiro62070503***6304211D | 10     | ARS     | QR-V1-DESC-n | 0x0FE0845Da176E24d9F6Bcf86d19948e592909C8D | USDT   |

        #When transfero pix failed
        Examples:
            | accion   | userAnyId | qrCode                               | amount | against | sessionId    | to                                         | ticker |
            | embebido | 100009358 | 08449ae2-8a26-47a5-992d-2689f135bc11 | 10     | ARS     | QR-V1-DESC-n | 0x0FE0845Da176E24d9F6Bcf86d19948e592909C8D | USDT   |


    # ------ QR V2 ------

    @Desc @QRV2Desc @Automated
    Scenario Outline: Ejecutar sintético de pago QR "<accion>" contra USDT en descubierto vía V2 endpoints con against default
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
        And The attributes of the QR "<ticker>" synthetic are validated
        # Get status synthetic payment
        And Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic
        # Get company balance after execute qr payment
        And Obtain a company debt "<ticker>" balance

        # QR BOB monto muy bajo, falla contra USDT
        Examples:
            | accion   | userAnyId | qrCode             | amount | sessionId    | to                                         | ticker |
            | manual   | 100009359 | qr3manualamount    | 2000   | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |
            | embebido | 100009359 | qr3                | 1000   | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |
            | embebido | 100013788 | qr3BOBmanualamount | 1000   | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |

    @Desc @QRV2Desc @Automated
    Scenario Outline: Ejecutar sintético de pago QR "<accion>" contra USDT en descubierto vía V2 endpoints
        Given The API key is available "F4EZSEW-AMC4Z24-G5CNFS4-880BSHJ"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        # Get company balance before execute qr payment
        # And Obtain a company debt "<ticker>" balance
        # Request de lock payment
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<qrCode>" to the variable "qrCode"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<ticker>" to the variable "against"
        And Execute the POST method on the endpoint "/v2/payment-locks"
        Then Obtain a response 201 for lock payment
        # Execute synthetic payment
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "pixCode" to the variable "pixCode"
        And Execute the POST method on the endpoint "/v2/synthetics/qr-payment"
        Then Obtain a response 201
        And The attributes of the QR "<ticker>" synthetic are validated
        # Get status synthetic payment
        And Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic
        # Get company balance after execute qr payment
        # And Obtain a company debt "<ticker>" balance

        Examples:
            | accion   | userAnyId | qrCode          | amount | sessionId    | to                                         | ticker |
            | manual   | 100009359 | qr3manualamount | 2000   | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |
            | embebido | 100009359 | qr3             | 1000   | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |

        @WLD
        Examples:
            | accion   | userAnyId | qrCode          | amount | sessionId    | to                                         | ticker |
            | estatico | 100009359 | qr3manualamount | 1500   | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | WLD    |
            | embebido | 100009359 | qr3             | 1500   | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | WLD    |

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
        And The attributes of the QR "<against>" synthetic are validated

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
        And The attributes of the QR "<against>" synthetic are validated

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

    @Desc @PixV1Desc @Automated
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

        # Examples:
        #     | accion   | userAnyId | qrCode          | amount | sessionId              | to                                         | ticker |
        #     | embebido | 100009360 | pix             | 10     | PIX-embebido-V1-DESC-n | 0x966af97f8D14FbAa77d3fdfe214a638b5587BCBA | USDT   |
        #     | manual   | 100009360 | pixmanualamount | 10     | PIX-manual-V1-DESC-n   | 0x966af97f8D14FbAa77d3fdfe214a638b5587BCBA | USDT   |

        #When transfero pix failed
        Examples:
            | accion   | userAnyId | qrCode                               | amount | sessionId              | to                                         | ticker |
            | embebido | 100009360 | 08449ae2-8a26-47a5-992d-2689f135bc11 | 10     | PIX-embebido-V1-DESC-n | 0x966af97f8D14FbAa77d3fdfe214a638b5587BCBA | USDT   |
            | manual   | 100009360 | 08449ae2-8a26-47a5-992d-2689f135bc11 | 10     | PIX-manual-V1-DESC-n   | 0x966af97f8D14FbAa77d3fdfe214a638b5587BCBA | USDT   |

    @Desc @PixV1Desc @Automated
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
        # Examples:
        #     | accion   | userAnyId | qrCode          | against | amount | sessionId              | to                                         | ticker |
        #     | embebido | 100009360 | pix             | ARS     | 10     | PIX-embebido-V1-DESC-n | 0x966af97f8D14FbAa77d3fdfe214a638b5587BCBA | USDT   |
        #     | manual   | 100009360 | pixmanualamount | ARS     | 10     | PIX-manual-V1-DESC-n   | 0x966af97f8D14FbAa77d3fdfe214a638b5587BCBA | USDT   |

        #When transfero pix failed
        Examples:
            | accion   | userAnyId | qrCode                               | against | amount | sessionId              | to                                         | ticker |
            | embebido | 100009360 | 08449ae2-8a26-47a5-992d-2689f135bc11 | ARS     | 10     | PIX-embebido-V1-DESC-n | 0x966af97f8D14FbAa77d3fdfe214a638b5587BCBA | USDT   |
            | manual   | 100009360 | 08449ae2-8a26-47a5-992d-2689f135bc11 | ARS     | 10     | PIX-manual-V1-DESC-n   | 0x966af97f8D14FbAa77d3fdfe214a638b5587BCBA | USDT   |

    # ------ PIX V2 ------

    @Desc @PixV2Desc @Automated
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

        # Examples:
        #     | accion   | userAnyId | qrCode          | amount | sessionId              | to                                         | ticker |
        #     | manual   | 100009361 | pixmanualamount | 10     | PIX-manual-V2-DESC-n   | 0xF26A2ECa66d87Dd16225c8507ABbBf3CD14Cfcd2 | USDT   |
        #     | embebido | 100009361 | pix             | 10     | PIX-embebido-V2-DESC-n | 0xF26A2ECa66d87Dd16225c8507ABbBf3CD14Cfcd2 | USDT   |

        #When transfero pix failed
        Examples:
            | accion   | userAnyId | qrCode                               | amount | sessionId              | to                                         | ticker |
            | manual   | 100009361 | 08449ae2-8a26-47a5-992d-2689f135bc11 | 10     | PIX-manual-V2-DESC-n   | 0xF26A2ECa66d87Dd16225c8507ABbBf3CD14Cfcd2 | USDT   |
            | embebido | 100009361 | 08449ae2-8a26-47a5-992d-2689f135bc11 | 10     | PIX-embebido-V2-DESC-n | 0xF26A2ECa66d87Dd16225c8507ABbBf3CD14Cfcd2 | USDT   |

    @Desc @PixV2Desc @Automated
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

        # Examples:
        #     | accion   | userAnyId | qrCode          | against | amount | sessionId              | to                                         | ticker |
        #     | manual   | 100009361 | pixmanualamount | ARS     | 10     | PIX-manual-V2-DESC-n   | 0xF26A2ECa66d87Dd16225c8507ABbBf3CD14Cfcd2 | USDT   |
        #     | embebido | 100009361 | pix             | ARS     | 10     | PIX-embebido-V2-DESC-n | 0xF26A2ECa66d87Dd16225c8507ABbBf3CD14Cfcd2 | USDT   |

        #When transfero pix failed
        Examples:
            | accion   | userAnyId | qrCode                               | against | amount | sessionId              | to                                         | ticker |
            | manual   | 100009361 | 08449ae2-8a26-47a5-992d-2689f135bc11 | ARS     | 10     | PIX-manual-V2-DESC-n   | 0xF26A2ECa66d87Dd16225c8507ABbBf3CD14Cfcd2 | USDT   |
            | embebido | 100009361 | 08449ae2-8a26-47a5-992d-2689f135bc11 | ARS     | 10     | PIX-embebido-V2-DESC-n | 0xF26A2ECa66d87Dd16225c8507ABbBf3CD14Cfcd2 | USDT   |

    # ------ PaymentDestinarion ------

    @Desc @Bybit @Automated
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

        # Examples:
        #     | pay | nacionality | coin | accion   | userAnyId | paymentDestination | against | amount | sessionId                    | to                                         | ticker |
        #     | PIX | Argentina   | USDT | manual   | 100009406 | pixmanualamount    |         | 10     | PIX-ByBit-manual-V2-DESC-n   | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
        #     | PIX | Argentina   | USDT | embebido | 100009406 | pix                |         | 10     | PIX-ByBit-embebido-V2-DESC-n | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
        #     | QR  | Argentina   | USDT | manual   | 100009406 | qr3manualamount    |         | 1000   | PIX-ByBit-manual-V2-DESC-n   | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
        #     | QR  | Argentina   | USDT | embebido | 100009406 | qr3                |         | 1000   | PIX-ByBit-embebido-V2-DESC-n | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
        #     | QR  | Brasil      | USDT | manual   | 100009407 | pixmanualamount    | USDT    | 10     | PIX-ByBit-manual-V2-DESC-n   | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
        #     | QR  | Brasil      | USDT | manual   | 100009407 | qr3manualamount    |         | 1000   | PIX-ByBit-manual-V2-DESC-n   | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
        #     | QR  | Brasil      | USDT | embebido | 100009407 | qr3                |         | 1000   | PIX-ByBit-embebido-V2-DESC-n | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
        #     | QR  | Brasil      | USDT | embebido | 100009407 | pix                | USDT    | 10     | PIX-ByBit-embebido-V2-DESC-n | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |

        #When transfero pix failed
        Examples:
            | pay | nacionality | coin | accion   | userAnyId | paymentDestination                   | against | amount | sessionId                    | to                                         | ticker |
            | PIX | Argentina   | USDT | manual   | 100009406 | 08449ae2-8a26-47a5-992d-2689f135bc11 |         | 10     | PIX-ByBit-manual-V2-DESC-n   | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
            | QR  | Argentina   | USDT | manual   | 100009406 | qr3manualamount                      |         | 1000   | PIX-ByBit-manual-V2-DESC-n   | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
            | QR  | Argentina   | USDT | embebido | 100009406 | qr3                                  |         | 1000   | PIX-ByBit-embebido-V2-DESC-n | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
            | QR  | Brasil      | USDT | manual   | 100009407 | 08449ae2-8a26-47a5-992d-2689f135bc11 | USDT    | 10     | PIX-ByBit-manual-V2-DESC-n   | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
    # Ver routing de ppal accounts
    # | QR  | Brasil      | USDT | manual   | 100009407 | qr3manualamount                      |         | 1000   | PIX-ByBit-manual-V2-DESC-n   | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
    # | QR  | Brasil      | USDT | embebido | 100009407 | qr3                                  |         | 1000   | PIX-ByBit-embebido-V2-DESC-n | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |

    @Desc @BybitPixkeyb @Automated
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
            | QR  | Brasil      | USDT | manual   | 100009407 | martin@gmail.com                     |         | 10     | PixKey-ByBit-manual-V2-DESC-n   | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
            | QR  | Brasil      | USDT | embebido | 100009407 | renancamargo19@gmail.com             |         | 10     | PixKey-ByBit-embebido-V2-DESC-n | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
            | QR  | Brasil      | USDT | manual   | 100009407 | +5511949227612                       |         | 10     | PixKey-ByBit-manual-V2-DESC-n   | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
            | QR  | Brasil      | USDT | embebido | 100009407 | 08449ae2-8a26-47a5-992d-2689f135bc11 |         | 10     | PixKey-ByBit-embebido-V2-DESC-n | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |

    # Sender ----------------------------------------------------------------------------------------

    @Smoke @Desc @Sender @Automated
    Scenario Outline: Ejecutar sintético de pago <pay> contra <against> enviando sender info desde Principal Account <accountExc>
        Given The API key is available "<apiKEY>"
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

        #No admitido yet pagos desde principal accounts NO PERU. Por el momento solo desde ppal acc PERU
        @ARG
        Examples:
            | apiKEY                          | pay | exchange  | legalId     | name          | surname  | userAnyId | paymentDestination                                                                                                                           | against | amount | sessionId                          | accountExc |
            | 9SE03H0-6KRMN7E-G6S75X8-VBRXM9S | PIX | BRAZIL    | 40842073817 | DARIO AUGUSTO | DA SILVA | 100038486 | +5511949227612                                                                                                                               | USDT    | 10     | PrincipalAccount-payment-V2-DESC-n | ARGENTINA  |
            | 9SE03H0-6KRMN7E-G6S75X8-VBRXM9S | PIX | ARGENTINA | 27414298732 | BETO LUIS     | SOLARI   | 100038486 | +5511949227612                                                                                                                               | USDT    | 10     | PrincipalAccount-payment-V2-DESC-n | ARGENTINA  |
            | 9SE03H0-6KRMN7E-G6S75X8-VBRXM9S | QR  | BRAZIL    | 40842073817 | DARIO AUGUSTO | DA SILVA | 100038486 | 00020101021140200010com.yacare02022350150011336972350495204739953030325802AR5910HAVANNA SA6012BUENOS AIRES81220010com.yacare0204Y2156304E401 | USDT    | 1000   | PrincipalAccount-payment-V2-DESC-n | ARGENTINA  |
            | 9SE03H0-6KRMN7E-G6S75X8-VBRXM9S | QR  | ARGENTINA | 27414298732 | BETO LUIS     | SOLARI   | 100038486 | 00020101021140200010com.yacare02022350150011336972350495204739953030325802AR5910HAVANNA SA6012BUENOS AIRES81220010com.yacare0204Y2156304E401 | USDT    | 1000   | PrincipalAccount-payment-V2-DESC-n | ARGENTINA  |
            | 9SE03H0-6KRMN7E-G6S75X8-VBRXM9S | QR  | BRAZIL    | 40842073817 | DARIO AUGUSTO | DA SILVA | 100038486 | 00020101021140200010com.yacare02022350150011336972350495204739953030325802AR5910HAVANNA SA6012BUENOS AIRES81220010com.yacare0204Y2156304E401 | WLD     | 1000   | PrincipalAccount-payment-V2-DESC-n | ARGENTINA  |
            | 9SE03H0-6KRMN7E-G6S75X8-VBRXM9S | QR  | ARGENTINA | 27414298732 | BETO LUIS     | SOLARI   | 100038486 | 00020101021140200010com.yacare02022350150011336972350495204739953030325802AR5910HAVANNA SA6012BUENOS AIRES81220010com.yacare0204Y2156304E401 | WLD     | 1000   | PrincipalAccount-payment-V2-DESC-n | ARGENTINA  |

        @BRA
        Examples:
            | apiKEY                          | pay | exchange  | legalId     | name          | surname  | userAnyId | paymentDestination                                                                                                                                                          | against | amount | sessionId                          | accountExc |
            | 9SE03H0-6KRMN7E-G6S75X8-VBRXM9S | PIX | BRAZIL    | 40842073817 | DARIO AUGUSTO | DA SILVA | 100038487 | 00020126480014BR.GOV.BCB.PIX0126leandro.ribeiro@meujota.ai520400005303986540550.005802BR5925LEANDRO DE OLIVEIRA NOEL 6009SAO PAULO622905255b9f00c0931f47dd89e207276630474E8 | USDT    | 10     | PrincipalAccount-payment-V2-DESC-n | BRAZIL     |
            | 9SE03H0-6KRMN7E-G6S75X8-VBRXM9S | PIX | ARGENTINA | 27414298732 | BETO LUIS     | SOLARI   | 100038487 | 00020126480014BR.GOV.BCB.PIX0126leandro.ribeiro@meujota.ai520400005303986540550.005802BR5925LEANDRO DE OLIVEIRA NOEL 6009SAO PAULO622905255b9f00c0931f47dd89e207276630474E8 | USDT    | 10     | PrincipalAccount-payment-V2-DESC-n | BRAZIL     |

        @COP
        Examples:
            | apiKEY                          | pay | exchange  | legalId     | name          | surname  | userAnyId | paymentDestination            | against | amount | sessionId                          | accountExc |
            | 9SE03H0-6KRMN7E-G6S75X8-VBRXM9S | QR  | BRAZIL    | 40842073817 | DARIO AUGUSTO | DA SILVA | 100038489 | manteca-breb-qa               | USDT    |        | PrincipalAccount-payment-V2-DESC-n | COLOMBIA   |
            | 9SE03H0-6KRMN7E-G6S75X8-VBRXM9S | QR  | COLOMBIA  | 2994445     | ROLANDO       | OVIEDO   | 100038489 | manteca-breb-qa-manual-amount | USDT    | 500    | PrincipalAccount-payment-V2-DESC-n | COLOMBIA   |
            | 9SE03H0-6KRMN7E-G6S75X8-VBRXM9S | QR  | ARGENTINA | 27283436719 | LAURA         | ACOSTA   | 100038489 | manteca-breb-qa-manual-amount | USDT    | 500    | PrincipalAccount-payment-V2-DESC-n | COLOMBIA   |


    @Smoke @Desc @Sender @Peru @Automated
    Scenario Outline: Ejecutar sintético de pago <pay> contra <against> enviando sender completo info desde Principal Account <accountExc> por PLUS_PAGOS
        Given The API key is available "<apiKEY>"
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
        And Assign the value "<work>" to the variable "work"
        And Assign the value "<email>" to the variable "email"
        And Assign the value "<phoneNumber>" to the variable "phoneNumber"
        And Assign the value "<gender>" to the variable "gender"
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
            | apiKEY                          | pay           | exchange | legalId  | name          | surname  | work     | email              | phoneNumber  | gender | userAnyId | paymentDestination                                                                                                                                                                                                                                                                         | against | amount | sessionId                      | accountExc |
            | SG0EPCX-9XW4G7Y-NQDMP1Q-52X6MB9 | QR_PERU       | PERU     | 46326357 | DARIO AUGUSTO | DA SILVA | EMPLEADO | polanque@gmail.com | +51953605263 | MALE   | 100014302 | 0002010102122637000280010390302202511060921196434575252044829530360454031505802PE5917CESAR TACURI INGA6004Lima80550003ID10144suGASdIEsZFzlFh4eZ/UMQRNdpSojGNBwPiV0Punz2o=90490005GLOSA0136Happy Path Generación de QR Dinamico91230007FECVCTO01082025123192210005QUOTA0108999999996304C993 | USDT    | 1000   | PixKey-Sender-manual-V2-DESC-n | PERU       |
            | SG0EPCX-9XW4G7Y-NQDMP1Q-52X6MB9 | QR_PERU_PHONE | PERU     | 46326357 | DARIO AUGUSTO | DA SILVA | EMPLEADO | polanque@gmail.com | +51953605263 | MALE   | 100014302 | +51919468262                                                                                                                                                                                                                                                                               | USDT    | 1000   | PixKey-Sender-manual-V2-DESC-n | PERU       |

    @Smoke @Desc @Sender @Peru @Foreigns @Automated
    Scenario Outline: Ejecutar sintético de pago <pay> contra <against> enviando sender completo info para FOREINGS desde Principal Account <accountExc> por PLUS_PAGOS
        Given The API key is available "<apiKEY>"
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
        And Assign the value "<work>" to the variable "work"
        And Assign the value "<email>" to the variable "email"
        And Assign the value "<phoneNumber>" to the variable "phoneNumber"
        And Assign the value "<gender>" to the variable "gender"
        And Assign the value "<birthDate>" to the variable "birthDate"
        And Assign the value "<street>" to the variable "street"
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
            | apiKEY                          | pay     | exchange  | legalId       | name         | surname | work     | email                | phoneNumber    | gender | birthDate  | street               | userAnyId | paymentDestination                                                                                                                                                                                                                                                                         | against | amount | sessionId                      | accountExc |
            | SG0EPCX-9XW4G7Y-NQDMP1Q-52X6MB9 | QR_PERU | ARGENTINA | 27-32244493-7 | PEDRO        | PEREZ   | EMPLEADO | peperez@gmail.com    | +5491153605263 | MALE   | 1960-05-06 | Av. Corrientes       | 100014302 | 0002010102122637000280010390302202511060921196434575252044829530360454031505802PE5917CESAR TACURI INGA6004Lima80550003ID10144suGASdIEsZFzlFh4eZ/UMQRNdpSojGNBwPiV0Punz2o=90490005GLOSA0136Happy Path Generación de QR Dinamico91230007FECVCTO01082025123192210005QUOTA0108999999996304C993 | USDT    | 1000   | PixKey-Sender-manual-V2-DESC-n | PERU       |
            | SG0EPCX-9XW4G7Y-NQDMP1Q-52X6MB9 | QR_PERU | BRAZIL    | 22373020149   | YAMIL        | SOUZA   | EMPLEADO | jsouza@gmail.com     | +5291153605263 | MALE   | 1960-05-06 | Av. Paulista         | 100014302 | 0002010102122637000280010390302202511060921196434575252044829530360454031505802PE5917CESAR TACURI INGA6004Lima80550003ID10144suGASdIEsZFzlFh4eZ/UMQRNdpSojGNBwPiV0Punz2o=90490005GLOSA0136Happy Path Generación de QR Dinamico91230007FECVCTO01082025123192210005QUOTA0108999999996304C993 | USDT    | 1000   | PixKey-Sender-manual-V2-DESC-n | PERU       |
            | SG0EPCX-9XW4G7Y-NQDMP1Q-52X6MB9 | QR_PERU | ANDORRA   | 22373020149   | SANTIAGO     | MARCO   | EMPLEADO | smarco@gmail.com     | +5291153605263 | MALE   | 1960-05-06 | Av. Andorra          | 100014302 | 0002010102122637000280010390302202511060921196434575252044829530360454031505802PE5917CESAR TACURI INGA6004Lima80550003ID10144suGASdIEsZFzlFh4eZ/UMQRNdpSojGNBwPiV0Punz2o=90490005GLOSA0136Happy Path Generación de QR Dinamico91230007FECVCTO01082025123192210005QUOTA0108999999996304C993 | USDT    | 1000   | PixKey-Sender-manual-V2-DESC-n | PERU       |
            | SG0EPCX-9XW4G7Y-NQDMP1Q-52X6MB9 | QR_PERU | MEXICO    | ROCS720312186 | JOSE SALOMON | ROMERO  | EMPLEADO | joseromero@gmail.com | +5291153605263 | MALE   | 1960-05-06 | Av. Distrito Federal | 100014302 | 0002010102122637000280010390302202511060921196434575252044829530360454031505802PE5917CESAR TACURI INGA6004Lima80550003ID10144suGASdIEsZFzlFh4eZ/UMQRNdpSojGNBwPiV0Punz2o=90490005GLOSA0136Happy Path Generación de QR Dinamico91230007FECVCTO01082025123192210005QUOTA0108999999996304C993 | USDT    | 1000   | PixKey-Sender-manual-V2-DESC-n | PERU       |
            | SG0EPCX-9XW4G7Y-NQDMP1Q-52X6MB9 | QR_PERU | CHILE     | 17720072-7    | MACARENA     | VAZQUEZ | EMPLEADO | vama@gmail.com       | +5291153605263 | MALE   | 1960-05-06 | Av. Santiago         | 100014302 | 0002010102122637000280010390302202511060921196434575252044829530360454031505802PE5917CESAR TACURI INGA6004Lima80550003ID10144suGASdIEsZFzlFh4eZ/UMQRNdpSojGNBwPiV0Punz2o=90490005GLOSA0136Happy Path Generación de QR Dinamico91230007FECVCTO01082025123192210005QUOTA0108999999996304C993 | USDT    | 1000   | PixKey-Sender-manual-V2-DESC-n | PERU       |


    # Sender ----------------------------------------------------------------------------------------

    #*************************************
    # !------ USER ACCOUNTS -------

    @Smoke @UserAccount @Desc @Automated
    Scenario Outline: Ejecutar sintético de pago <payment> contra <against> tomando deuda
        Given The API key is available "<apiKEY>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        # Get company balance before execute qr payment
        And Obtain a company debt "<against>" balance
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
        And Assign the value "pixCode" to the variable "qrCode"
        And Execute the POST method on the endpoint "/v2/synthetics/qr-payment"
        Then Obtain a response 201
        # Get status synthetic payment
        And Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic
        # Get company balance after execute qr payment
        And Obtain a company debt "<against>" balance

        Examples:
            | apiKEY                          | payment    | userAnyId | paymentDestination                                                                                                                                                                                                                                                                         | against | amount | sessionId             |
            | NZ3GF31-QWS4JHS-JGJ5XH8-XAKCFWR | QR BOB     | 100037877 | qr3BOBmanualamount                                                                                                                                                                                                                                                                         | USDT    | 10     | useraccount-payment-n |
            | NZ3GF31-QWS4JHS-JGJ5XH8-XAKCFWR | QR PERU    | 100037878 | 0002010102122637000280010390302202511060921196434575252044829530360454031505802PE5917CESAR TACURI INGA6004Lima80550003ID10144suGASdIEsZFzlFh4eZ/UMQRNdpSojGNBwPiV0Punz2o=90490005GLOSA0136Happy Path Generación de QR Dinamico91230007FECVCTO01082025123192210005QUOTA0108999999996304C993 | USDT    | 10     | useraccount-payment-n |
            | NZ3GF31-QWS4JHS-JGJ5XH8-XAKCFWR | PERU PHONE | 100037878 | +51986667537                                                                                                                                                                                                                                                                               | USDT    | 10     | useraccount-payment-n |
            | NZ3GF31-QWS4JHS-JGJ5XH8-XAKCFWR | QR BRAZIL  | 100037879 | 00020126480014BR.GOV.BCB.PIX0126leandro.ribeiro@meujota.ai520400005303986540550.005802BR5925LEANDRO DE OLIVEIRA NOEL 6009SAO PAULO622905255b9f00c0931f47dd89e207276630474E8                                                                                                                | USDT    | 10     | useraccount-payment-n |
            | NZ3GF31-QWS4JHS-JGJ5XH8-XAKCFWR | PIX KEY    | 100037879 | 08449ae2-8a26-47a5-992d-2689f135bc11                                                                                                                                                                                                                                                       | USDT    | 10     | useraccount-payment-n |
            | NZ3GF31-QWS4JHS-JGJ5XH8-XAKCFWR | QR ARG     | 100037880 | 00020101021140200010com.yacare02022350150011336972350495204739953030325802AR5910HAVANNA SA6012BUENOS AIRES81220010com.yacare0204Y2156304E401                                                                                                                                               | USDT    | 10     | useraccount-payment-n |
            | NZ3GF31-QWS4JHS-JGJ5XH8-XAKCFWR | PAGO PIX   | 100037880 | 08449ae2-8a26-47a5-992d-2689f135bc11                                                                                                                                                                                                                                                       | USDT    | 10     | useraccount-payment-n |
            | NZ3GF31-QWS4JHS-JGJ5XH8-XAKCFWR | QR COP     | 100037935 | manteca-breb-qa-manual-amount                                                                                                                                                                                                                                                              | USDT    | 500    | useraccount-payment-n |



    @Smoke @UserAccount @Desc @Automated
    Scenario Outline: Ejecutar sintético de pago <payment> contra <against> desde el user balance
        Given The API key is available "<apiKEY>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        # Validate initial balance before execute qr payment
        And Obtain "<against>" balance for "<userAnyId>" user
        # Request de lock payment
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<paymentDestination>" to the variable "paymentDestination"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<against>" to the variable "against"
        And Execute the POST method on the endpoint "/v2/payment-locks"
        Then Obtain a response 201 for lock payment
        # Execute synthetic payment
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "true" to the variable "skipDeposit"
        And Assign the value "pixCode" to the variable "pixCode"
        And Execute the POST method on the endpoint "/v2/synthetics/qr-payment"
        Then Obtain a response 201
        And The attributes of the QR "<against>" synthetic are validated
        # Get status synthetic payment
        And Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic
        # Validate balance after execute qr payment
        And Obtain "<against>" balance for "<userAnyId>" user

        @bob
        Examples:
            | apiKEY                          | payment   | userAnyId | paymentDestination                                                                                                                                                                                                                                                                         | against | amount | sessionId             |
            | NZ3GF31-QWS4JHS-JGJ5XH8-XAKCFWR | QR BOB    | 100037877 | qr3BOBmanualamount                                                                                                                                                                                                                                                                         | BOB     | 1000   | useraccount-payment-n |
            | NZ3GF31-QWS4JHS-JGJ5XH8-XAKCFWR | QR PERU   | 100037878 | 0002010102122637000280010390302202511060921196434575252044829530360454031505802PE5917CESAR TACURI INGA6004Lima80550003ID10144suGASdIEsZFzlFh4eZ/UMQRNdpSojGNBwPiV0Punz2o=90490005GLOSA0136Happy Path Generación de QR Dinamico91230007FECVCTO01082025123192210005QUOTA0108999999996304C993 | PEN     | 1000   | useraccount-payment-n |
            | NZ3GF31-QWS4JHS-JGJ5XH8-XAKCFWR | QR PERU   | 100037878 | +51986667537                                                                                                                                                                                                                                                                               | PEN     | 1000   | useraccount-payment-n |
            | NZ3GF31-QWS4JHS-JGJ5XH8-XAKCFWR | QR BRAZIL | 100037879 | 00020126480014BR.GOV.BCB.PIX0126leandro.ribeiro@meujota.ai520400005303986540550.005802BR5925LEANDRO DE OLIVEIRA NOEL 6009SAO PAULO622905255b9f00c0931f47dd89e207276630474E8                                                                                                                | BRL     | 10     | useraccount-payment-n |
            | NZ3GF31-QWS4JHS-JGJ5XH8-XAKCFWR | QR BRAZIL | 100037879 | 08449ae2-8a26-47a5-992d-2689f135bc11                                                                                                                                                                                                                                                       | BRL     | 10     | useraccount-payment-n |
            | NZ3GF31-QWS4JHS-JGJ5XH8-XAKCFWR | QR ARG    | 100037880 | 00020101021140200010com.yacare02022350150011336972350495204739953030325802AR5910HAVANNA SA6012BUENOS AIRES81220010com.yacare0204Y2156304E401                                                                                                                                               | ARS     | 1000   | useraccount-payment-n |
            | NZ3GF31-QWS4JHS-JGJ5XH8-XAKCFWR | PAGO PIX  | 100037880 | 08449ae2-8a26-47a5-992d-2689f135bc11                                                                                                                                                                                                                                                       | ARS     | 10     | useraccount-payment-n |
            | NZ3GF31-QWS4JHS-JGJ5XH8-XAKCFWR | QR COP    | 100037935 | manteca-breb-qa-manual-amount                                                                                                                                                                                                                                                              | COP     | 500    | useraccount-payment-n |


    #*************************************
    # !------ ROUTING -------

    @Smoke @Routing @Desc @Automated
    Scenario Outline: Ejecutar sintético de pago <payment> contra <against> desde la principal account balance
        Given The API key is available "<apiKEY>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        # Get company balance before execute qr payment
        And Obtain "<against>" balance for "<principalAccount>" user
        # Request de lock payment
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<paymentDestination>" to the variable "paymentDestination"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<amount>" to the variable "amount"
        And Execute the POST method on the endpoint "/v2/payment-locks"
        Then Obtain a response 201 for lock payment
        # Execute synthetic payment
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<principalAccount>" to the variable "userAnyId"
        And Assign the value "true" to the variable "skipDeposit"
        And Assign the value "pixCode" to the variable "qrCode"
        And Execute the POST method on the endpoint "/v2/synthetics/qr-payment"
        Then Obtain a response 201
        # Get status synthetic payment
        And Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic
        # Get company balance after execute qr payment
        And Obtain "<against>" balance for "<principalAccount>" user

        Examples:
            | apiKEY                          | payment   | userAnyId | principalAccount | paymentDestination                                                                                                                                                                     | against | amount | sessionId             |
            | 9SE03H0-6KRMN7E-G6S75X8-VBRXM9S | QR BOB    | 100038492 | 100038490        | qr3BOBmanualamount                                                                                                                                                                     | BOB     | 10     | useraccount-payment-n |
            | FF4CEBS-1404S0J-M3YQ6Q0-8ZR4GTT | QR BRAZIL | 100038086 | 100038082        | 00020126480014BR.GOV.BCB.PIX0126leandro.ribeiro@meujota.ai520400005303986540550.005802BR5925LEANDRO DE OLIVEIRA NOEL 6009SAO PAULO622905255b9f00c0931f47dd89e207276630474E8            | BRL     | 10     | useraccount-payment-n |
            | FF4CEBS-1404S0J-M3YQ6Q0-8ZR4GTT | QR PERU   | 100038086 | 100038083        | 000201010211263700028001039030220250424092119905530665204482953036045802PE5917CESAR TACURI INGA6004Lima80550003ID10144suGASdIEsZFzlFh4eZ/UMQRNdpSojGNBwPiV0Punz2o=6304FA5Bmanualamount | PEN     | 10     | useraccount-payment-n |
            | 9SE03H0-6KRMN7E-G6S75X8-VBRXM9S | QR ARG    | 100038493 | 100038486        | 00020101021140200010com.yacare02022350150011336972350495204739953030325802AR5910HAVANNA SA6012BUENOS AIRES81220010com.yacare0204Y2156304E401manualamount                               | ARS     | 1000   | useraccount-payment-n |
            | 9SE03H0-6KRMN7E-G6S75X8-VBRXM9S | QR BREB   | 100038493 | 100038489        | manteca-breb-qa-manual-amount                                                                                                                                                          | COP     | 1000   | useraccount-payment-n |

    @Smoke @Routing @Desc @Automated
    Scenario Outline: Ejecutar sintético de pago <payment> contra <against> tomando deuda
        Given The API key is available "<apiKEY>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        # Get company balance before execute qr payment
        And Obtain a company debt "<against>" balance
        # Request de lock payment
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<paymentDestination>" to the variable "paymentDestination"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<amount>" to the variable "amount"
        And Execute the POST method on the endpoint "/v2/payment-locks"
        Then Obtain a response 201 for lock payment
        # Execute synthetic payment
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<principalAccount>" to the variable "userAnyId"
        And Assign the value "pixCode" to the variable "qrCode"
        And Execute the POST method on the endpoint "/v2/synthetics/qr-payment"
        Then Obtain a response 201
        # Get status synthetic payment
        And Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic
        # Get company balance after execute qr payment
        And Obtain a company debt "<against>" balance

        Examples:
            | apiKEY                          | payment   | userAnyId | principalAccount | paymentDestination                                                                                                                                                                     | against | amount | sessionId             |
            | 9SE03H0-6KRMN7E-G6S75X8-VBRXM9S | QR BOB    | 100038494 | 100038490        | qr3BOBmanualamount                                                                                                                                                                     | USDT    | 10     | useraccount-payment-n |
            | FF4CEBS-1404S0J-M3YQ6Q0-8ZR4GTT | QR BRAZIL | 100038086 | 100038082        | 00020126480014BR.GOV.BCB.PIX0126leandro.ribeiro@meujota.ai520400005303986540550.005802BR5925LEANDRO DE OLIVEIRA NOEL 6009SAO PAULO622905255b9f00c0931f47dd89e207276630474E8            | USDT    | 10     | useraccount-payment-n |
            | FF4CEBS-1404S0J-M3YQ6Q0-8ZR4GTT | QR PERU   | 100038086 | 100038083        | 000201010211263700028001039030220250424092119905530665204482953036045802PE5917CESAR TACURI INGA6004Lima80550003ID10144suGASdIEsZFzlFh4eZ/UMQRNdpSojGNBwPiV0Punz2o=6304FA5Bmanualamount | USDT    | 10     | useraccount-payment-n |
            | 9SE03H0-6KRMN7E-G6S75X8-VBRXM9S | QR ARG    | 100038493 | 100038486        | 00020101021140200010com.yacare02022350150011336972350495204739953030325802AR5910HAVANNA SA6012BUENOS AIRES81220010com.yacare0204Y2156304E401manualamount                               | USDT    | 1000   | useraccount-payment-n |
            | 9SE03H0-6KRMN7E-G6S75X8-VBRXM9S | QR BREB   | 100038493 | 100038489        | manteca-breb-qa-manual-amount                                                                                                                                                          | USDT    | 1000   | useraccount-payment-n |


    @Refunds @RefundsDs @Automated
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

    @Refunds @RefundsNDt @Automated
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

    @Refunds @manualRefund @Automated
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

