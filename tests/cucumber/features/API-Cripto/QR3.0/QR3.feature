@QR @Regression
Feature: Sintético QR 3.0

    # **** SUITE ****
    # ! NO TOCAR DATOS
    # ------ NO DESCUBIERTOS -------
    # ------ QR V1 ------

    @QRV1NoDesc @Automated
    Scenario Outline: Ejecutar sintético de pago QR PIX <type> contra <ticker> no descubierto vía V1 endpoints desde User Account
        Given Get credentials for company "<companyId>"
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
            | companyId                | userAnyId | type    | qrCode                               | amount | sessionId      | to                                         | ticker |
            | 684b2f25dcca16d5557fd8b2 | 100009352 | PIX-KEY | 08449ae2-8a26-47a5-992d-2689f135bc11 | 10     | QR-NoDesc-V1-n | 0x7921319332714EBea5c1219439c34309e600DF54 | USDT   |

    @QRV1NoDesc @Automated
    Scenario Outline: Ejecutar sintético de pago QR PIX <type> contra <against> en no descubierto vía V1 endpoints
        Given Get credentials for company "<companyId>"
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
            | companyId                | userAnyId | type     | qrCode                               | against | amount | sessionId      | to                                         |
            | 684b2f25dcca16d5557fd8b2 | 100011660 | embebido | 08449ae2-8a26-47a5-992d-2689f135bc11 | BRL     | 10     | QR-NoDesc-V1-n | 0x7921319332714EBea5c1219439c34309e600DF54 |

    @QRV1NoDesc @Automated
    Scenario Outline: Validar Clean Code al ejecutar lock de QR estático sin enviar amount vía V1 endpoints
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<qrCode>" to the variable "qrCode"
        And Assign the value "<amount>" to the variable "amount"
        And Execute the POST method on the endpoint "/v2/pix-locks"
        Then Obtain a response 206

        Examples:
            | companyId                | accion | userAnyId | qrCode          | amount | sessionId    | to                                         | ticker |
            | 684b2f25dcca16d5557fd8b2 | manual | 100009502 | pixmanualamount |        | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |

    # ------ QR V2 ------

    @QRV2NoDesc @Automated
    Scenario Outline: Ejecutar sintético de pago QR ARS <accion> contra <ticker> en no descubierto vía V2 endpoints against default
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
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
            | companyId                | credential                | accion   | userAnyId | qrCode             | amount | sessionId    | to                                         | ticker |
            | 684b2f25dcca16d5557fd8b2 | andresperalta@manteca.dev | dinamico | 100009502 | qr3                |        | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |
            | 684b2f25dcca16d5557fd8b2 | andresperalta@manteca.dev | estatico | 100009502 | qr3manualamount    | 1500   | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |
            | 684b2f25dcca16d5557fd8b2 | andresperalta@manteca.dev | estatico | 100013787 | qr3BOBmanualamount | 1000   | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |

    @QRV2NoDesc @Automated
    Scenario Outline: Ejecutar sintético de pago QR ARS <accion> contra <ticker> en no descubierto vía V2 endpoints
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
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
            | companyId                | credential                | accion   | userAnyId | qrCode          | amount | sessionId    | to                                         | ticker |
            | 684b2f25dcca16d5557fd8b2 | andresperalta@manteca.dev | estatico | 100009502 | qr3manualamount | 1500   | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |
            | 684b2f25dcca16d5557fd8b2 | andresperalta@manteca.dev | embebido | 100009502 | qr3             | 1500   | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |

        @Smoke @WLD
        Examples:
            | companyId | credential | accion | userAnyId | qrCode | amount | sessionId | to | ticker |
    # | 684b2f25dcca16d5557fd8b2 | andresperalta@manteca.dev | estatico | 100009502 | qr3manualamount | 1500   | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | WLD    | Ticket: C-0007
    # | 684b2f25dcca16d5557fd8b2 | andresperalta@manteca.dev | embebido | 100009502 | qr3             | 1500   | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | WLD    | Ticket: C-0007


    @Smoke @QRV2NoDesc @Automated
    Scenario Outline: Validar Clean Code al ejecutar lock de QR estático sin enviar amount vía V2 endpoints
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<qrCode>" to the variable "qrCode"
        And Assign the value "<amount>" to the variable "amount"
        And Execute the POST method on the endpoint "/v2/payment-locks"
        Then Obtain a response 206

        Examples:
            | companyId                | accion | userAnyId | qrCode          | amount | sessionId    | to                                         | ticker |
            | 684b2f25dcca16d5557fd8b2 | manual | 100009502 | qr3manualamount |        | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |

    # ------ PIX V1 ------

    @Smoke @PixV1NoDesc @Automated
    Scenario Outline:  Ejecutar sintético de pago PIX "<accion>" contra USDT en no descubierto vía V1 endpoints
        Given Get credentials for company "<companyId>"
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
        #     | manual   | 100011660 | pixmanualamount | 10     | PIX-manual-V1-NO-DESC-n   | 0xC19b0041b0D6261FD98BFe753d76D58Ae65e44aD | USDT   |
        #     | embebido | 100011660 | pix             | 10     | PIX-embebido-V1-NO-DESC-n | 0xC19b0041b0D6261FD98BFe753d76D58Ae65e44aD | USDT   |

        #When transfero pix failed
        Examples:
            | companyId                | accion | userAnyId | qrCode                               | amount | sessionId               | to                                         | ticker |
            | 684b2f25dcca16d5557fd8b2 | manual | 100011660 | 08449ae2-8a26-47a5-992d-2689f135bc11 | 5      | PIX-manual-V1-NO-DESC-n | 0xC19b0041b0D6261FD98BFe753d76D58Ae65e44aD | USDT   |

    @Smoke @PixV1NoDesc @Automated
    Scenario Outline:  Ejecutar sintético de pago PIX "<accion>" contra ARS en no descubierto vía V1 endpoints
        Given Get credentials for company "<companyId>"
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
        #     | embebido | 100011660 | pix             | ARS     | 10     | PIX-embebido-V1-DESC-n | 0xC19b0041b0D6261FD98BFe753d76D58Ae65e44aD | USDT   |
        #     | manual   | 100011660 | pixmanualamount | ARS     | 10     | PIX-manual-V1-DESC-n   | 0xC19b0041b0D6261FD98BFe753d76D58Ae65e44aD | USDT   |

        #When transfero pix failed
        Examples:
            | companyId                | accion   | userAnyId | qrCode                               | against | amount | sessionId              | to                                         | ticker |
            | 684b2f25dcca16d5557fd8b2 | embebido | 100011660 | 08449ae2-8a26-47a5-992d-2689f135bc11 | BRL     | 5      | PIX-embebido-V1-DESC-n | 0xC19b0041b0D6261FD98BFe753d76D58Ae65e44aD | USDT   |

    @Smoke @PixV1NoDesc @Automated
    Scenario Outline: Validar Clean Code al ejecutar lock de QR PIX estático sin enviar amount vía V2 endpoints
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<qrCode>" to the variable "qrCode"
        And Assign the value "<amount>" to the variable "amount"
        And Execute the POST method on the endpoint "/v2/payment-locks"
        Then Obtain a response 206

        Examples:
            | companyId                | accion | userAnyId | qrCode          | amount | sessionId    | to                                         | ticker |
            | 684b2f25dcca16d5557fd8b2 | manual | 100011660 | pixmanualamount |        | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |

    # ------ PIX V2 ------

    @Smoke @PixV2NoDesc @Automated
    Scenario Outline: Ejecutar sintético de pago PIX "<accion>" contra USDT en no descubierto vía V2 endpoints
        Given Get credentials for company "<companyId>"
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
        #     | manual   | 100011660 | pixmanualamount | 10     | PIX-manual-V2-NO-DESC-n   | 0x8aD91F66950d65C7a27a123c28fd4f861717bF08 | USDT   |
        #     | embebido | 100011660 | pix             |        | PIX-embebido-V2-NO-DESC-n | 0x8aD91F66950d65C7a27a123c28fd4f861717bF08 | USDT   |

        #When transfero pix failed
        Examples:
            | companyId                | accion | userAnyId | qrCode                               | amount | sessionId               | to                                         | ticker |
            | 684b2f25dcca16d5557fd8b2 | manual | 100011660 | 08449ae2-8a26-47a5-992d-2689f135bc11 | 5      | PIX-manual-V2-NO-DESC-n | 0x8aD91F66950d65C7a27a123c28fd4f861717bF08 | USDT   |

    @PixV2NoDesc @Automated
    Scenario Outline: Ejecutar sintético de pago PIX "<accion>" contra ARS en no descubierto vía V2 endpoints
        Given Get credentials for company "<companyId>"
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
        #     | estatico | 100013787 | qr3BOBmanualamount | BOB     | 1000   | QR-V2-DESC-n              | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   | Ticket: C-0006

        #When transfero pix failed
        @Smoke
        Examples:
            | companyId                | accion   | userAnyId | qrCode                               | against | amount | sessionId                 | to                                         | ticker |
            # | manual   | 100011660 | 08449ae2-8a26-47a5-992d-2689f135bc11 | BRL     | 5      | PIX-manual-V2-NO-DESC-n   | 0xF26A2ECa66d87Dd16225c8507ABbBf3CD14Cfcd2 | USDT   |
            | 684b2f25dcca16d5557fd8b2 | embebido | 100011660 | 08449ae2-8a26-47a5-992d-2689f135bc11 | BRL     | 5      | PIX-embebido-V2-NO-DESC-n | 0xF26A2ECa66d87Dd16225c8507ABbBf3CD14Cfcd2 | USDT   |

    # @Smoke
    # Examples:
    #     | accion | userAnyId | qrCode                               | against | amount | sessionId               | to                                         | ticker |
    #     | manual | 100011660 | 08449ae2-8a26-47a5-992d-2689f135bc11 | ARS     | 5      | PIX-manual-V2-NO-DESC-n | 0xF26A2ECa66d87Dd16225c8507ABbBf3CD14Cfcd2 | USDT   |

    @Smoke @Peru @NoDesc @Ignore
    Scenario Outline: Ejecutar sintético de pago "<pay>" "<accion>" contra "<coin>" en no descubierto para usuario "<nacionality>" sobre el Balance User
        Given Get credentials for company "<companyId>"
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
            | companyId                | pay | nacionality | coin | accion   | userAnyId | paymentDestination                                                                                                                                                                                                                                                                                                     | against | amount | sessionId | to                                         | ticker |
            | 687fdad5160b638a204ca1bf | QR  | Argentina   | PEN  | dinámico | 100010488 | 00020101021102164096230055528616041553015000555286109166499890055528615123900111000000040610740923902707005552861826800011FACILITADOR0161IZIPAYVIR;1771899483420;5552861;989931923;348518349303003;;;252045999530360454030.05802PE5922IZI*FAST STORE PREMIUM6008TRUJILLO6103PER82270009FECHAVCTO01102036-02-2463048443 | PEN     | 1.5    | QR-Peru-n | 0x862Acf26956DCEf54F4726CF88709bFE9128e500 |        |
            # | QR  | Argentina   | PEN  | estático | 100010488 | 000201010211263700028001039030220250424092119905530665204482953036045802PE5917CESAR TACURI INGA6004Lima80550003ID10144suGASdIEsZFzlFh4eZ/UMQRNdpSojGNBwPiV0Punz2o=6304FA5B                                                                                                                  | PEN     | 100    | QR-Peru-n | 0x862Acf26956DCEf54F4726CF88709bFE9128e500 |        |
            # | QR  | Peru        | PEN  | dinámico | 100010538 | 00020101021226370002800103903022025072409211954330527520448295303604540415005802PE5917CESAR TACURI INGA6004Lima80550003ID10144suGASdIEsZFzlFh4eZ/UMQRNdpSojGNBwPiV0Punz2o=90490005GLOSA0136Happy Path Generación de QR Dinamico91230007FECVCTO01082025123192210005QUOTA01089999999963041AAA | PEN     |        | QR-Peru-n | 0x862Acf26956DCEf54F4726CF88709bFE9128e500 |        |
            | 687fdad5160b638a204ca1bf | QR  | Peru        | PEN  | estático | 100010538 | 00020101021102164096230055528616041553015000555286109166499890055528615123900111000000040610740923902707005552861826800011FACILITADOR0161IZIPAYVIR;1771899483420;5552861;989931923;348518349303003;;;252045999530360454030.05802PE5922IZI*FAST STORE PREMIUM6008TRUJILLO6103PER82270009FECHAVCTO01102036-02-2463048443 | PEN     | 1.5    | QR-Peru-n | 0x862Acf26956DCEf54F4726CF88709bFE9128e500 |        |

    @Smoke @Peru @NoDesc @Ignore
    Scenario Outline: Ejecutar sintético de pago "<pay>" "<accion>" contra "<coin>" en no descubierto para usuario "<nacionality>"
        Given Get credentials for company "<companyId>"
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
            | companyId                | pay | nacionality | coin | accion   | userAnyId | paymentDestination                                                                                                                                                                                                                                                                          | against | amount | sessionId | to                                         | ticker |
            # | 687fdad5160b638a204ca1bf | QR  | Argentina   | USDT | dinámico | 100010488 | 00020101021226370002800103903022025072409211954330527520448295303604540415005802PE5917CESAR TACURI INGA6004Lima80550003ID10144suGASdIEsZFzlFh4eZ/UMQRNdpSojGNBwPiV0Punz2o=90490005GLOSA0136Happy Path Generación de QR Dinamico91230007FECVCTO01082025123192210005QUOTA01089999999963041AAA | USDT    |        | QR-Peru-n | 0x862Acf26956DCEf54F4726CF88709bFE9128e500 | USDT   |
            | 687fdad5160b638a204ca1bf | QR  | Argentina   | USDT | estático | 100010488 | 000201010211263700028001039030220250424092119905530665204482953036045802PE5917CESAR TACURI INGA6004Lima80550003ID10144suGASdIEsZFzlFh4eZ/UMQRNdpSojGNBwPiV0Punz2o=6304FA5B                                                                                                                  | USDT    | 100    | QR-Peru-n | 0x862Acf26956DCEf54F4726CF88709bFE9128e500 | USDT   |
            | 687fdad5160b638a204ca1bf | QR  | Peru        | USDT | dinámico | 100010538 | 00020101021226370002800103903022025072409211954330527520448295303604540415005802PE5917CESAR TACURI INGA6004Lima80550003ID10144suGASdIEsZFzlFh4eZ/UMQRNdpSojGNBwPiV0Punz2o=90490005GLOSA0136Happy Path Generación de QR Dinamico91230007FECVCTO01082025123192210005QUOTA01089999999963041AAA | USDT    |        | QR-Peru-n | 0x862Acf26956DCEf54F4726CF88709bFE9128e500 | USDT   |
    # | 687fdad5160b638a204ca1bf | QR  | Peru        | USDT | estático | 100010538 | 000201010211263700028001039030220250424092119905530665204482953036045802PE5917CESAR TACURI INGA6004Lima80550003ID10144suGASdIEsZFzlFh4eZ/UMQRNdpSojGNBwPiV0Punz2o=6304FA5B                                                                                                                  | USDT    | 100    | QR-Peru-n | 0x862Acf26956DCEf54F4726CF88709bFE9128e500 | USDT   |

    @Peru @Smoke @Ignore
    Scenario Outline: Ejecutar sintético de pago "<pay>" "<accion>" contra "<against>" en descubierto para usuario "<nacionality>" sobre el Balance User
        Given Get credentials for company "<companyId>"
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
            | companyId                | pay | nacionality | coin | accion                  | userAnyId | paymentDestination | against | amount | sessionId      | to                                         | ticker |
            | 687fdad5160b638a204ca1bf | QR  | Argentina   | USDT | pago a teléfono celular | 100010488 | +51987365083       | PEN     | 1000   | QR-PeruPhone-n | 0x862Acf26956DCEf54F4726CF88709bFE9128e500 | USDT   |
            | 687fdad5160b638a204ca1bf | QR  | Peru        | USDT | pago a teléfono celular | 100010538 | +51987365083       | PEN     | 1000   | QR-PeruPhone-n | 0x862Acf26956DCEf54F4726CF88709bFE9128e500 | USDT   |

    @Peru @Smoke @ToBeAutomated
    Scenario Outline: Ejecutar sintético de pago "<pay>" "<accion>" contra "<against>" no descubierto para usuario "<nacionality>"
        Given Get credentials for company "<companyId>"
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
            | companyId                | pay | nacionality | coin | accion                  | userAnyId | paymentDestination | against | amount | sessionId      | to                                         | ticker |
            | 687fdad5160b638a204ca1bf | QR  | Peru        | USDT | pago a teléfono celular | 100010538 | +51987365083       | USDT    | 1000   | QR-PeruPhone-n | 0x862Acf26956DCEf54F4726CF88709bFE9128e500 | USDT   |

    #*************************************
    # !------ USERBALANCES -------
    # ------ QR V1 ------

    @Smoke @UserBalance @QRV1NUserBalance @Automated
    Scenario Outline: Ejecutar sintético de pago QR PIX <type> contra <ticker> operando desde el user balance vía V1 endpoints
        Given Get credentials for company "<companyId>"
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
            | companyId                | userAnyId | type     | qrCode                               | amount | sessionId           | ticker |
            | 68a50570fbdff4f9d45884b0 | 100056383 | estático | 08449ae2-8a26-47a5-992d-2689f135bc11 | 10     | QR-UserBalance-V1-n | USDT   |
            | 68a50570fbdff4f9d45884b0 | 100056383 | estático | 08449ae2-8a26-47a5-992d-2689f135bc11 | 10     | QR-UserBalance-V1-n | BRL    |

    # ------ QR V2 ------

    @UserBalance @QRV2UserBalance @Automated
    Scenario Outline: Ejecutar sintético de pago QR ARS <accion> contra <ticker> operando desde el user balance vía V2 endpoints
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
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
            | companyId                | credential                | accion   | userAnyId | qrCode          | amount | sessionId           | ticker |
            | 68a50570fbdff4f9d45884b0 | andresperalta@manteca.dev | estatico | 100015038 | qr3manualamount | 1500   | QR-UserBalance-V2-n | USDT   |
            | 68a50570fbdff4f9d45884b0 | andresperalta@manteca.dev | estatico | 100015038 | qr3manualamount | 1500   | QR-UserBalance-V2-n | ARS    |

    # ------ PIX V1 ------

    @UserBalance @PixV1UserBalance @Automated
    Scenario Outline:  Ejecutar sintético de pago PIX "<accion>" contra USDT operando desde el user balance vía V1 endpoints
        Given Get credentials for company "<companyId>"
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
            | companyId                | accion   | userAnyId | qrCode                               | amount | sessionId            | ticker |
            | 68a50570fbdff4f9d45884b0 | estático | 100056383 | 08449ae2-8a26-47a5-992d-2689f135bc11 | 10     | PIX-UserBalance-V1-n | USDT   |
            | 68a50570fbdff4f9d45884b0 | estático | 100056383 | 08449ae2-8a26-47a5-992d-2689f135bc11 | 10     | PIX-UserBalance-V1-n | ARS    |

    # ------ PIX V2 ------

    @UserBalance @PixV2UserBalance @Automated
    Scenario Outline: Ejecutar sintético de pago PIX "<accion>" contra USDT operando desde el user balance vía V2 endpoints
        Given Get credentials for company "<companyId>"
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
            | companyId                | accion   | userAnyId | qrCode                               | amount | sessionId            | ticker |
            | 68a50570fbdff4f9d45884b0 | estático | 100056383 | 08449ae2-8a26-47a5-992d-2689f135bc11 | 10     | PIX-UserBalance-V2-n | USDT   |
            | 68a50570fbdff4f9d45884b0 | estático | 100056383 | 08449ae2-8a26-47a5-992d-2689f135bc11 | 10     | PIX-UserBalance-V2-n | ARS    |

    @Smoke @Peru @UserBalance @Peru @Sender @Automated
    Scenario Outline: Ejecutar sintético de pago <pay> contra <against> enviando sender info desde Principal Account <accountExc>
        Given Get credentials for company "<companyId>"
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
            | companyId                | pay | exchange  | legalId     | name          | surname  | userAnyId | paymentDestination                                                                                                                           | against | amount | sessionId                          | accountExc |
            | 6961c8e3be02a1dde6bcffcb | QR  | BRAZIL    | 40842073817 | DARIO AUGUSTO | DA SILVA | 100037733 | 00020101021140200010com.yacare02022350150011336972350495204739953030325802AR5910HAVANNA SA6012BUENOS AIRES81220010com.yacare0204Y2156304E401 | USDT    | 1000   | PrincipalAccount-payment-V2-DESC-n | ARGENTINA  |
            | 6961c8e3be02a1dde6bcffcb | QR  | ARGENTINA | 20293755311 | CESAR ANTONIO | MANRIQUE | 100037733 | 00020101021140200010com.yacare02022350150011336972350495204739953030325802AR5910HAVANNA SA6012BUENOS AIRES81220010com.yacare0204Y2156304E401 | ARS     | 1000   | PrincipalAccount-payment-V2-DESC-n | ARGENTINA  |

        @BRA
        Examples:
            | companyId                | pay | exchange  | legalId     | name          | surname  | userAnyId | paymentDestination | against | amount | sessionId                          | accountExc |
            | 6961c8e3be02a1dde6bcffcb | PIX | BRAZIL    | 40842073817 | DARIO AUGUSTO | DA SILVA | 100037715 | +5511949227612     | BRL     | 10     | PrincipalAccount-payment-V2-DESC-n | BRAZIL     |
            | 6961c8e3be02a1dde6bcffcb | PIX | ARGENTINA | 27414298732 | BETO LUIS     | SOLARI   | 100037715 | +5511949227612     | USDT    | 10     | PrincipalAccount-payment-V2-DESC-n | BRAZIL     |

    # @BOB
    # Examples:
    #     | companyId                | pay | exchange  | legalId     | name          | surname  | userAnyId | paymentDestination | against | amount | sessionId                          | accountExc |
    #   | 6961c8e3be02a1dde6bcffcb | PIX | BRAZIL    | 40842073817 | DARIO AUGUSTO | DA SILVA | 100037707 | qr3BOBmanualamount | BOB     | 10     | PrincipalAccount-payment-V2-DESC-n | BRAZIL     |
    #   | 6961c8e3be02a1dde6bcffcb | PIX | ARGENTINA | 27414298732 | BETO LUIS     | SOLARI   | 100037707 | qr3BOBmanualamount | BOB     | 10     | PrincipalAccount-payment-V2-DESC-n | BRAZIL     |


    @Smoke @UserBalance @Sender @Peru @Automated
    Scenario Outline: Ejecutar sintético de pago <pay> contra <against> enviando sender completo info desde Principal Account <accountExc>
        Given Get credentials for company "<companyId>"
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
            | companyId                | pay           | exchange | legalId  | name          | surname  | work     | email              | phoneNumber  | gender | userAnyId | paymentDestination                                                                                                                                                                                                                                                                                                     | against | amount | sessionId                      | accountExc |
            | 6961c8e3be02a1dde6bcffcb | QR_PERU       | PERU     | 46326357 | DARIO AUGUSTO | DA SILVA | EMPLEADO | polanque@gmail.com | +51953605263 | MALE   | 100037706 | 00020101021102164096230055528616041553015000555286109166499890055528615123900111000000040610740923902707005552861826800011FACILITADOR0161IZIPAYVIR;1771899483420;5552861;989931923;348518349303003;;;252045999530360454030.05802PE5922IZI*FAST STORE PREMIUM6008TRUJILLO6103PER82270009FECHAVCTO01102036-02-2463048443 | PEN     | 1.5    | PixKey-Sender-manual-V2-DESC-n | PERU       |
            | 6961c8e3be02a1dde6bcffcb | QR_PERU_PHONE | PERU     | 46326357 | DARIO AUGUSTO | DA SILVA | EMPLEADO | polanque@gmail.com | +51953605263 | MALE   | 100037706 | +51986667537                                                                                                                                                                                                                                                                                                           | PEN     | 1.5    | PixKey-Sender-manual-V2-DESC-n | PERU       |


    #*************************************
    # !------ DESCUBIERTOS -------
    # ------ QR V1 ------

    @Desc @V1Desc @Deprecated
    Scenario Outline: Ejecutar sintético de pago QR "<accion>" contra USDT en descubierto vía V1 endpoints
        Given Get credentials for company "<companyId>"
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
            | companyId                | accion   | userAnyId | qrCode                               | amount | sessionId    | to                                         | ticker |
            | 684b9446017d29431c2cac6a | embebido | 100009358 | 08449ae2-8a26-47a5-992d-2689f135bc11 | 10     | QR-V1-DESC-n | 0x0FE0845Da176E24d9F6Bcf86d19948e592909C8D | USDT   |


    @Desc @V1Desc @Deprecated
    Scenario Outline: Ejecutar sintético de pago QR "<accion>" contra ARS en descubierto vía V1 endpoints
        Given Get credentials for company "<companyId>"
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
            | companyId                | accion   | userAnyId | qrCode                               | amount | against | sessionId    | to                                         | ticker |
            | 684b9446017d29431c2cac6a | embebido | 100009358 | 08449ae2-8a26-47a5-992d-2689f135bc11 | 10     | ARS     | QR-V1-DESC-n | 0x0FE0845Da176E24d9F6Bcf86d19948e592909C8D | USDT   |


    # ------ QR V2 ------

    @Desc @QRV2Desc @Automated
    Scenario Outline: Ejecutar sintético de pago QR "<accion>" contra USDT en descubierto vía V2 endpoints con against default
        Given Get credentials for company "<companyId>"
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
            | companyId                | accion   | userAnyId | qrCode             | amount | sessionId    | to                                         | ticker |
            | 684b9446017d29431c2cac6a | manual   | 100009359 | qr3manualamount    | 2000   | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |
            | 684b9446017d29431c2cac6a | embebido | 100009359 | qr3                | 1000   | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |
            | 684b9446017d29431c2cac6a | embebido | 100013788 | qr3BOBmanualamount | 1000   | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |

    @Desc @QRV2Desc @Automated
    Scenario Outline: Ejecutar sintético de pago QR "<accion>" contra USDT en descubierto vía V2 endpoints
        Given Get credentials for company "<companyId>"
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
            | companyId                | accion   | userAnyId | qrCode          | amount | sessionId    | to                                         | ticker |
            | 684b9446017d29431c2cac6a | manual   | 100009359 | qr3manualamount | 2000   | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |
            | 684b9446017d29431c2cac6a | embebido | 100009359 | qr3             | 1000   | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |

        @WLD
        Examples:
            | companyId                | accion   | userAnyId | qrCode          | amount | sessionId    | to                                         | ticker |
            | 684b9446017d29431c2cac6a | estatico | 100009359 | qr3manualamount | 1500   | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | WLD    |
            | 684b9446017d29431c2cac6a | embebido | 100009359 | qr3             | 1500   | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | WLD    |

    @NoSupportYet
    Scenario Outline: Ejecutar sintético de pago QR "<accion>" contra ARS en descubierto vía V2 endpoints
        Given Get credentials for company "<companyId>"
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
            | companyId                | accion   | userAnyId | qrCode          | against | amount | sessionId    | to                                         | ticker |
            | 684b9446017d29431c2cac6a | manual   | 100009359 | qr3manualamount | ARS     | 100000 | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |
            | 684b9446017d29431c2cac6a | embebido | 100009359 | qr3             | ARS     | 1000   | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |

    @NoSupportYet
    Scenario Outline: Ejecutar sintético de pago QR "<accion>" contra ARS en descubierto con valores mínimos vía V2 endpoints
        Given Get credentials for company "<companyId>"
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
            | companyId                | accion | userAnyId | qrCode          | against | amount | sessionId    | to                                         | ticker |
            | 684b9446017d29431c2cac6a | manual | 100009359 | qr3manualamount | ARS     | 101    | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |

    @NoSupportYet
    Scenario Outline: Validar error al ejecutar sintético de pago QR "<accion>" contra ARS en descubierto con monto inferior al mínimo vía V2 endpoints
        Given Get credentials for company "<companyId>"
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
            | companyId                | accion | userAnyId | qrCode          | against | amount | sessionId    | to                                         | ticker |
            | 684b9446017d29431c2cac6a | manual | 100009359 | qr3manualamount | ARS     | 9      | QR-V2-DESC-n | 0xff26ffee34fD1BDd8A4aDeD1A8bb961e07926802 | USDT   |

    # ------ PIX V1 ------

    @Desc @PixV1Desc @Automated
    Scenario Outline:  Ejecutar sintético de pago PIX "<accion>" contra USDT en descubierto vía V1 endpoints
        Given Get credentials for company "<companyId>"
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
            | companyId                | accion   | userAnyId | qrCode                               | amount | sessionId              | to                                         | ticker |
            | 684b9446017d29431c2cac6a | embebido | 100037525 | 08449ae2-8a26-47a5-992d-2689f135bc11 | 10     | PIX-embebido-V1-DESC-n | 0x966af97f8D14FbAa77d3fdfe214a638b5587BCBA | USDT   |
            | 684b9446017d29431c2cac6a | manual   | 100037525 | 08449ae2-8a26-47a5-992d-2689f135bc11 | 10     | PIX-manual-V1-DESC-n   | 0x966af97f8D14FbAa77d3fdfe214a638b5587BCBA | USDT   |

    @Desc @PixV1Desc @Automated
    Scenario Outline:  Ejecutar sintético de pago PIX "<accion>" contra ARS en descubierto vía V1 endpoints
        Given Get credentials for company "<companyId>"
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
            | companyId                | accion   | userAnyId | qrCode                               | against | amount | sessionId              | to                                         | ticker |
            | 684b9446017d29431c2cac6a | embebido | 100037525 | 08449ae2-8a26-47a5-992d-2689f135bc11 | ARS     | 10     | PIX-embebido-V1-DESC-n | 0x966af97f8D14FbAa77d3fdfe214a638b5587BCBA | USDT   |
            | 684b9446017d29431c2cac6a | manual   | 100037525 | 08449ae2-8a26-47a5-992d-2689f135bc11 | ARS     | 10     | PIX-manual-V1-DESC-n   | 0x966af97f8D14FbAa77d3fdfe214a638b5587BCBA | USDT   |

    # ------ PIX V2 ------

    @Desc @PixV2Desc @Automated
    Scenario Outline: Ejecutar sintético de pago PIX "<accion>" contra USDT en descubierto vía V2 endpoints
        Given Get credentials for company "<companyId>"
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
            | companyId                | accion   | userAnyId | qrCode                               | amount | sessionId              | to                                         | ticker |
            | 684b9446017d29431c2cac6a | manual   | 100037525 | 08449ae2-8a26-47a5-992d-2689f135bc11 | 10     | PIX-manual-V2-DESC-n   | 0xF26A2ECa66d87Dd16225c8507ABbBf3CD14Cfcd2 | USDT   |
            | 684b9446017d29431c2cac6a | embebido | 100037525 | 08449ae2-8a26-47a5-992d-2689f135bc11 | 10     | PIX-embebido-V2-DESC-n | 0xF26A2ECa66d87Dd16225c8507ABbBf3CD14Cfcd2 | USDT   |

    @Desc @PixV2Desc @Deprecated
    Scenario Outline: Ejecutar sintético de pago PIX "<accion>" contra ARS en descubierto vía V2 endpoints
        Given Get credentials for company "<companyId>"
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
            | companyId                | accion   | userAnyId | qrCode                               | against | amount | sessionId              | to                                         | ticker |
            | 684b9446017d29431c2cac6a | manual   | 100037525 | 08449ae2-8a26-47a5-992d-2689f135bc11 | ARS     | 10     | PIX-manual-V2-DESC-n   | 0xF26A2ECa66d87Dd16225c8507ABbBf3CD14Cfcd2 | USDT   |
            | 684b9446017d29431c2cac6a | embebido | 100037525 | 08449ae2-8a26-47a5-992d-2689f135bc11 | ARS     | 10     | PIX-embebido-V2-DESC-n | 0xF26A2ECa66d87Dd16225c8507ABbBf3CD14Cfcd2 | USDT   |

    # ------ PaymentDestinarion ------

    @Desc @Bybit @Automated
    Scenario Outline: Ejecutar sintético de pago "<pay>" "<accion>" contra "<coin>" en descubierto para usuario "<nacionality>" vía ByBit endpoints
        Given Get credentials for company "<companyId>"
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
            | companyId                | pay | nacionality | coin | accion   | userAnyId | paymentDestination                   | against | amount | sessionId                    | to                                         | ticker |
            | 684b9446017d29431c2cac6a | PIX | Argentina   | USDT | manual   | 100037525 | 08449ae2-8a26-47a5-992d-2689f135bc11 |         | 10     | PIX-ByBit-manual-V2-DESC-n   | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
            | 684b9446017d29431c2cac6a | QR  | Argentina   | USDT | manual   | 100009406 | qr3manualamount                      |         | 1000   | PIX-ByBit-manual-V2-DESC-n   | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
            | 684b9446017d29431c2cac6a | QR  | Argentina   | USDT | embebido | 100009406 | qr3                                  |         | 1000   | PIX-ByBit-embebido-V2-DESC-n | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
            | 684b9446017d29431c2cac6a | QR  | Brasil      | USDT | manual   | 100009407 | 08449ae2-8a26-47a5-992d-2689f135bc11 | USDT    | 10     | PIX-ByBit-manual-V2-DESC-n   | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
    # Ver routing de ppal accounts
    # | QR  | Brasil      | USDT | manual   | 100009407 | qr3manualamount                      |         | 1000   | PIX-ByBit-manual-V2-DESC-n   | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
    # | QR  | Brasil      | USDT | embebido | 100009407 | qr3                                  |         | 1000   | PIX-ByBit-embebido-V2-DESC-n | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |

    @Desc @BybitPixkeyb @Automated
    Scenario Outline: Ejecutar sintético de pago "<pay>" "<accion>" contra "<coin>" hacia PixKey en descubierto para usuario "<nacionality>" vía ByBit endpoints
        Given Get credentials for company "<companyId>"
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
            | companyId                | pay | nacionality | coin | accion   | userAnyId | paymentDestination                   | against | amount | sessionId                       | to                                         | ticker |
            | 684b9446017d29431c2cac6a | QR  | Brasil      | USDT | manual   | 100009407 | martin@gmail.com                     |         | 10     | PixKey-ByBit-manual-V2-DESC-n   | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
            | 684b9446017d29431c2cac6a | QR  | Brasil      | USDT | embebido | 100009407 | renancamargo19@gmail.com             |         | 10     | PixKey-ByBit-embebido-V2-DESC-n | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
            | 684b9446017d29431c2cac6a | QR  | Brasil      | USDT | manual   | 100009407 | +5511949227612                       |         | 10     | PixKey-ByBit-manual-V2-DESC-n   | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |
            | 684b9446017d29431c2cac6a | QR  | Brasil      | USDT | embebido | 100009407 | 08449ae2-8a26-47a5-992d-2689f135bc11 |         | 10     | PixKey-ByBit-embebido-V2-DESC-n | 0x460e4C83dB07d8c3217Dc0fE96d99a829dA687d8 | USDT   |

    # Sender ----------------------------------------------------------------------------------------

    @Smoke @Desc @Sender @Automated
    Scenario Outline: Ejecutar sintético de pago <pay> contra <against> enviando sender info desde Principal Account <accountExc>
        Given Get credentials for company "<companyId>"
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
            | companyId                | pay | exchange  | legalId     | name          | surname  | userAnyId | paymentDestination                                                                                                                           | against | amount | sessionId                          | accountExc |
            | 6981ff2f4af353838a534bc4 | PIX | BRAZIL    | 40842073817 | DARIO AUGUSTO | DA SILVA | 100038486 | +5511949227612                                                                                                                               | USDT    | 10     | PrincipalAccount-payment-V2-DESC-n | ARGENTINA  |
            | 6981ff2f4af353838a534bc4 | PIX | ARGENTINA | 27414298732 | BETO LUIS     | SOLARI   | 100038486 | +5511949227612                                                                                                                               | USDT    | 10     | PrincipalAccount-payment-V2-DESC-n | ARGENTINA  |
            | 6981ff2f4af353838a534bc4 | QR  | BRAZIL    | 40842073817 | DARIO AUGUSTO | DA SILVA | 100038486 | 00020101021140200010com.yacare02022350150011336972350495204739953030325802AR5910HAVANNA SA6012BUENOS AIRES81220010com.yacare0204Y2156304E401 | USDT    | 1000   | PrincipalAccount-payment-V2-DESC-n | ARGENTINA  |
            | 6981ff2f4af353838a534bc4 | QR  | ARGENTINA | 27414298732 | BETO LUIS     | SOLARI   | 100038486 | 00020101021140200010com.yacare02022350150011336972350495204739953030325802AR5910HAVANNA SA6012BUENOS AIRES81220010com.yacare0204Y2156304E401 | USDT    | 1000   | PrincipalAccount-payment-V2-DESC-n | ARGENTINA  |
            | 6981ff2f4af353838a534bc4 | QR  | BRAZIL    | 40842073817 | DARIO AUGUSTO | DA SILVA | 100038486 | 00020101021140200010com.yacare02022350150011336972350495204739953030325802AR5910HAVANNA SA6012BUENOS AIRES81220010com.yacare0204Y2156304E401 | WLD     | 1000   | PrincipalAccount-payment-V2-DESC-n | ARGENTINA  |
            | 6981ff2f4af353838a534bc4 | QR  | ARGENTINA | 27414298732 | BETO LUIS     | SOLARI   | 100038486 | 00020101021140200010com.yacare02022350150011336972350495204739953030325802AR5910HAVANNA SA6012BUENOS AIRES81220010com.yacare0204Y2156304E401 | WLD     | 1000   | PrincipalAccount-payment-V2-DESC-n | ARGENTINA  |

        @BRA
        Examples:
            | companyId                | pay | exchange  | legalId     | name          | surname  | userAnyId | paymentDestination                                                                                                                                                          | against | amount | sessionId                          | accountExc |
            | 6981ff2f4af353838a534bc4 | PIX | BRAZIL    | 40842073817 | DARIO AUGUSTO | DA SILVA | 100038487 | 00020126480014BR.GOV.BCB.PIX0126leandro.ribeiro@meujota.ai520400005303986540550.005802BR5925LEANDRO DE OLIVEIRA NOEL 6009SAO PAULO622905255b9f00c0931f47dd89e207276630474E8 | USDT    | 10     | PrincipalAccount-payment-V2-DESC-n | BRAZIL     |
            | 6981ff2f4af353838a534bc4 | PIX | ARGENTINA | 27414298732 | BETO LUIS     | SOLARI   | 100038487 | 00020126480014BR.GOV.BCB.PIX0126leandro.ribeiro@meujota.ai520400005303986540550.005802BR5925LEANDRO DE OLIVEIRA NOEL 6009SAO PAULO622905255b9f00c0931f47dd89e207276630474E8 | USDT    | 10     | PrincipalAccount-payment-V2-DESC-n | BRAZIL     |

        @COP
        Examples:
            | companyId                | pay | exchange  | legalId     | name          | surname  | userAnyId | paymentDestination            | against | amount | sessionId                          | accountExc |
            | 6981ff2f4af353838a534bc4 | QR  | BRAZIL    | 40842073817 | DARIO AUGUSTO | DA SILVA | 100038489 | manteca-breb-qa               | USDT    |        | PrincipalAccount-payment-V2-DESC-n | COLOMBIA   |
            | 6981ff2f4af353838a534bc4 | QR  | COLOMBIA  | 2994445     | ROLANDO       | OVIEDO   | 100038489 | manteca-breb-qa-manual-amount | USDT    | 500    | PrincipalAccount-payment-V2-DESC-n | COLOMBIA   |
            | 6981ff2f4af353838a534bc4 | QR  | ARGENTINA | 27283436719 | LAURA         | ACOSTA   | 100038489 | manteca-breb-qa-manual-amount | USDT    | 500    | PrincipalAccount-payment-V2-DESC-n | COLOMBIA   |


    @Smoke @Desc @Sender @Peru @Automated
    Scenario Outline: Ejecutar sintético de pago <pay> contra <against> enviando sender completo info desde Principal Account <accountExc> por PLUS_PAGOS
        Given Get credentials for company "<companyId>"
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
            | companyId                | pay           | exchange | legalId  | name          | surname  | work     | email              | phoneNumber  | gender | userAnyId | paymentDestination                                                                                                                                                                                                                                                                                                     | against | amount | sessionId                      | accountExc |
            | 6913d6f4db01142cde3fb7e0 | QR_PERU       | PERU     | 46326357 | DARIO AUGUSTO | DA SILVA | EMPLEADO | polanque@gmail.com | +51953605263 | MALE   | 100014302 | 00020101021102164096230055528616041553015000555286109166499890055528615123900111000000040610740923902707005552861826800011FACILITADOR0161IZIPAYVIR;1771899483420;5552861;989931923;348518349303003;;;252045999530360454030.05802PE5922IZI*FAST STORE PREMIUM6008TRUJILLO6103PER82270009FECHAVCTO01102036-02-2463048443 | USDT    | 1.5    | PixKey-Sender-manual-V2-DESC-n | PERU       |
            | 6913d6f4db01142cde3fb7e0 | QR_PERU_PHONE | PERU     | 46326357 | DARIO AUGUSTO | DA SILVA | EMPLEADO | polanque@gmail.com | +51953605263 | MALE   | 100014302 | +51986667537                                                                                                                                                                                                                                                                                                           | USDT    | 1.5    | PixKey-Sender-manual-V2-DESC-n | PERU       |

    @Smoke @Desc @Sender @Peru @Foreigns @Deprecated
    Scenario Outline: Principal Account <country>: Ejecutar pago enviando sender extranjero descubierto
        Given Get credentials for company "<companyId>"
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
            | companyId                | pay     | exchange  | legalId       | name         | surname | work     | email                | phoneNumber    | gender | birthDate  | street               | userAnyId | paymentDestination                                                                                                                                                                                                                                                                                                     | against | amount | sessionId                      | country |
            | 6913d6f4db01142cde3fb7e0 | QR_PERU | ARGENTINA | 27-32244493-7 | PEDRO        | PEREZ   | EMPLEADO | peperez@gmail.com    | +5491153605263 | MALE   | 1960-05-06 | Av. Corrientes       | 100014302 | 00020101021102164096230055528616041553015000555286109166499890055528615123900111000000040610740923902707005552861826800011FACILITADOR0161IZIPAYVIR;1771899483420;5552861;989931923;348518349303003;;;252045999530360454030.05802PE5922IZI*FAST STORE PREMIUM6008TRUJILLO6103PER82270009FECHAVCTO01102036-02-2463048443 | USDT    | 1.5    | PixKey-Sender-manual-V2-DESC-n | PERU    |
            | 6913d6f4db01142cde3fb7e0 | QR_PERU | BRAZIL    | 22373020149   | YAMIL        | SOUZA   | EMPLEADO | jsouza@gmail.com     | +5291153605263 | MALE   | 1960-05-06 | Av. Paulista         | 100014302 | 00020101021102164096230055528616041553015000555286109166499890055528615123900111000000040610740923902707005552861826800011FACILITADOR0161IZIPAYVIR;1771899483420;5552861;989931923;348518349303003;;;252045999530360454030.05802PE5922IZI*FAST STORE PREMIUM6008TRUJILLO6103PER82270009FECHAVCTO01102036-02-2463048443 | USDT    | 1.5    | PixKey-Sender-manual-V2-DESC-n | PERU    |
            | 6913d6f4db01142cde3fb7e0 | QR_PERU | ANDORRA   | 22373020149   | SANTIAGO     | MARCO   | EMPLEADO | smarco@gmail.com     | +5291153605263 | MALE   | 1960-05-06 | Av. Andorra          | 100014302 | 00020101021102164096230055528616041553015000555286109166499890055528615123900111000000040610740923902707005552861826800011FACILITADOR0161IZIPAYVIR;1771899483420;5552861;989931923;348518349303003;;;252045999530360454030.05802PE5922IZI*FAST STORE PREMIUM6008TRUJILLO6103PER82270009FECHAVCTO01102036-02-2463048443 | USDT    | 1.5    | PixKey-Sender-manual-V2-DESC-n | PERU    |
            | 6913d6f4db01142cde3fb7e0 | QR_PERU | MEXICO    | ROCS720312186 | JOSE SALOMON | ROMERO  | EMPLEADO | joseromero@gmail.com | +5291153605263 | MALE   | 1960-05-06 | Av. Distrito Federal | 100014302 | 00020101021102164096230055528616041553015000555286109166499890055528615123900111000000040610740923902707005552861826800011FACILITADOR0161IZIPAYVIR;1771899483420;5552861;989931923;348518349303003;;;252045999530360454030.05802PE5922IZI*FAST STORE PREMIUM6008TRUJILLO6103PER82270009FECHAVCTO01102036-02-2463048443 | USDT    | 1.5    | PixKey-Sender-manual-V2-DESC-n | PERU    |
            | 6913d6f4db01142cde3fb7e0 | QR_PERU | CHILE     | 17720072-7    | MACARENA     | VAZQUEZ | EMPLEADO | vama@gmail.com       | +5291153605263 | MALE   | 1960-05-06 | Av. Santiago         | 100014302 | 00020101021102164096230055528616041553015000555286109166499890055528615123900111000000040610740923902707005552861826800011FACILITADOR0161IZIPAYVIR;1771899483420;5552861;989931923;348518349303003;;;252045999530360454030.05802PE5922IZI*FAST STORE PREMIUM6008TRUJILLO6103PER82270009FECHAVCTO01102036-02-2463048443 | USDT    | 1.5    | PixKey-Sender-manual-V2-DESC-n | PERU    |


    # Sender ----------------------------------------------------------------------------------------

    #*************************************
    # !------ USER ACCOUNTS -------

    @Smoke @UserAccount @Desc @Automated
    Scenario Outline: Ejecutar sintético de pago <payment> contra <against> tomando deuda
        Given Get credentials for company "<companyId>"
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
            | companyId                | payment   | userAnyId | paymentDestination                                                                                                                                                          | against | amount | sessionId             |
            # | 696d44e622cceda591c025cd | QR BOB    | 100037877 | qr3BOBmanualamount                                                                                                                                                          | USDT    | 10     | useraccount-payment-n | Ticket: C-0006
            # | 696d44e622cceda591c025cd | QR PERU    | 100037878 | 0002010102122637000280010390302202511060921196434575252044829530360454031505802PE5917CESAR TACURI INGA6004Lima80550003ID10144suGASdIEsZFzlFh4eZ/UMQRNdpSojGNBwPiV0Punz2o=90490005GLOSA0136Happy Path Generación de QR Dinamico91230007FECVCTO01082025123192210005QUOTA0108999999996304C993 | USDT    | 10     | useraccount-payment-n |
            # | 696d44e622cceda591c025cd | PERU PHONE | 100037878 | +51986667537                                                                                                                                                                | USDT    | 10     | useraccount-payment-n |
            | 696d44e622cceda591c025cd | QR BRAZIL | 100037879 | 00020126480014BR.GOV.BCB.PIX0126leandro.ribeiro@meujota.ai520400005303986540550.005802BR5925LEANDRO DE OLIVEIRA NOEL 6009SAO PAULO622905255b9f00c0931f47dd89e207276630474E8 | USDT    | 10     | useraccount-payment-n |
            | 696d44e622cceda591c025cd | PIX KEY   | 100037879 | 08449ae2-8a26-47a5-992d-2689f135bc11                                                                                                                                        | USDT    | 10     | useraccount-payment-n |
            | 696d44e622cceda591c025cd | QR ARG    | 100037880 | 00020101021140200010com.yacare02022350150011336972350495204739953030325802AR5910HAVANNA SA6012BUENOS AIRES81220010com.yacare0204Y2156304E401                                | USDT    | 10     | useraccount-payment-n |
            # | 696d44e622cceda591c025cd | PAGO PIX  | 100037880 | 08449ae2-8a26-47a5-992d-2689f135bc11                                                                                                                                        | USDT    | 10     | useraccount-payment-n |
            | 696d44e622cceda591c025cd | QR COP    | 100037935 | manteca-breb-qa-manual-amount                                                                                                                                               | USDT    | 500    | useraccount-payment-n |



    @Smoke @UserAccount @Desc @Automated
    Scenario Outline: Ejecutar sintético de pago <payment> contra <against> desde el user balance
        Given Get credentials for company "<companyId>"
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
            | companyId                | payment   | userAnyId | paymentDestination                                                                                                                                                          | against | amount | sessionId             |
            # | 696d44e622cceda591c025cd | QR BOB    | 100037877 | qr3BOBmanualamount                                                                                                                                                          | BOB     | 1000   | useraccount-payment-n | Ticket: C-0006
            # | 696d44e622cceda591c025cd | QR PERU   | 100037878 | 00020101021102164096230055528616041553015000555286109166499890055528615123900111000000040610740923902707005552861826800011FACILITADOR0161IZIPAYVIR;1771899483420;5552861;989931923;348518349303003;;;252045999530360454030.05802PE5922IZI*FAST STORE PREMIUM6008TRUJILLO6103PER82270009FECHAVCTO01102036-02-2463048443 | PEN     | 1000   | useraccount-payment-n |
            #             | 696d44e622cceda591c025cd | QR PERU   | 100037878 | +51986667537                                                                                                                                                                                                                                                                                                           | PEN     | 1000   | useraccount-payment-n |
            | 696d44e622cceda591c025cd | QR BRAZIL | 100037879 | 00020126480014BR.GOV.BCB.PIX0126leandro.ribeiro@meujota.ai520400005303986540550.005802BR5925LEANDRO DE OLIVEIRA NOEL 6009SAO PAULO622905255b9f00c0931f47dd89e207276630474E8 | BRL     | 10     | useraccount-payment-n |
            | 696d44e622cceda591c025cd | QR BRAZIL | 100037879 | 08449ae2-8a26-47a5-992d-2689f135bc11                                                                                                                                        | BRL     | 10     | useraccount-payment-n |
            | 696d44e622cceda591c025cd | QR ARG    | 100037880 | 00020101021140200010com.yacare02022350150011336972350495204739953030325802AR5910HAVANNA SA6012BUENOS AIRES81220010com.yacare0204Y2156304E401                                | ARS     | 1000   | useraccount-payment-n |
            # | 696d44e622cceda591c025cd | PAGO PIX  | 100037880 | 08449ae2-8a26-47a5-992d-2689f135bc11                                                                                                                                                                                                                                                                                   | ARS     | 10     | useraccount-payment-n |
            | 696d44e622cceda591c025cd | QR COP    | 100037935 | manteca-breb-qa-manual-amount                                                                                                                                               | COP     | 500    | useraccount-payment-n |


    #*************************************
    # !------ ROUTING -------

    @Smoke @Routing @Desc @Automated
    Scenario Outline: Ejecutar sintético de pago <payment> contra <against> tomando deuda
        Given Get credentials for company "<companyId>"
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
            | companyId                | payment   | userAnyId | principalAccount | paymentDestination                                                                                                                                                                                                                                                                                                     | against | amount | sessionId             |
            # | 6981ff2f4af353838a534bc4 | QR BOB    | 100038494 | 100038490        | qr3BOBmanualamount                                                                                                                                                                                                                                                                                                     | USDT    | 10     | useraccount-payment-n | Ticket: C-0006
            | 696e44372190b0a1c211a430 | QR BRAZIL | 100038086 | 100038082        | 00020126480014BR.GOV.BCB.PIX0126leandro.ribeiro@meujota.ai520400005303986540550.005802BR5925LEANDRO DE OLIVEIRA NOEL 6009SAO PAULO622905255b9f00c0931f47dd89e207276630474E8                                                                                                                                            | USDT    | 10     | useraccount-payment-n |
            | 696e44372190b0a1c211a430 | QR PERU   | 100038086 | 100038083        | 00020101021102164096230055528616041553015000555286109166499890055528615123900111000000040610740923902707005552861826800011FACILITADOR0161IZIPAYVIR;1771899483420;5552861;989931923;348518349303003;;;252045999530360454030.05802PE5922IZI*FAST STORE PREMIUM6008TRUJILLO6103PER82270009FECHAVCTO01102036-02-2463048443 | USDT    | 1.5    | useraccount-payment-n |
            | 6981ff2f4af353838a534bc4 | QR ARG    | 100038493 | 100038486        | 00020101021140200010com.yacare02022350150011336972350495204739953030325802AR5910HAVANNA SA6012BUENOS AIRES81220010com.yacare0204Y2156304E401manualamount                                                                                                                                                               | USDT    | 1000   | useraccount-payment-n |
            | 6981ff2f4af353838a534bc4 | QR BREB   | 100038493 | 100038489        | manteca-breb-qa-manual-amount                                                                                                                                                                                                                                                                                          | USDT    | 1000   | useraccount-payment-n |




