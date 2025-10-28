@Refunds
Feature: Synthetic Refunds

    Background:
        Given The API key is available "F4EZSEW-AMC4Z24-G5CNFS4-880BSHJ"

    #Companies partiallyManaged take company debt instead take funds for user balances
    #Companies looselyManaged take funds for user balances instead take company debt. If user has no funds, take from company debt.

    # User exchange ARG opereted a QR3.0 against ARS
    @Manual @Automated
    Scenario Outline: Refund manual de sintetico de pago QR3.0 contra ARS (Sobre User Argentino Balance)
        Given The urlBase is available "https://sandbox.manteca.dev/crypto"
        And login user admin "<credential>"
        And Obtain "<against>" balance for "<userAnyId>" user over "<charge>"
        And Execute overdrawn "<type>" synthetic lock against "<against>" for user "<userAnyId>"
        And Execute overdrawn synthetic payment
        When Assign the value "<amount>" to the variable "amount"
        And Assign the value "<refundReason>" to the variable "refundReason"
        And Assign the value "<refundAsset>" to the variable "refundAsset"
        And Execute the POST method on the endpoint "/v1/admin/synthetics/{syntheticId}/refund"
        Then Obtain a response 204
        And Validate refund stages
        And Obtain "<against>" balance for "<userAnyId>" user over "<charge>"

        Examples:
            | credential                | amount  | refundReason  | refundAsset | type | against | userAnyId | charge  |
            | andresperalta@manteca.dev | dynamic | Manual refund | ARS         | QR   | ARS     | 100009359 | balance |

    # User exchange ARG opereted a QR3.0 against USDT
    @Manual @Automated
    Scenario Outline: Refund manual de sintetico de pago QR3.0 contra USDT (Sobre Company User Argentino)
        Given The urlBase is available "https://sandbox.manteca.dev/crypto"
        And login user admin "<credential>"
        And Obtain "<against>" debt balance "company"
        And Obtain "<against>" credit balance "company"
        And Execute overdrawn "<type>" synthetic lock against "<against>" for user "<userAnyId>"
        And Execute overdrawn synthetic payment
        When Assign the value "<amount>" to the variable "amount"
        And Assign the value "<refundReason>" to the variable "refundReason"
        And Assign the value "<refundAsset>" to the variable "refundAsset"
        And Execute the POST method on the endpoint "/v1/admin/synthetics/{syntheticId}/refund"
        Then Obtain a response 204
        And Validate refund stages
        And Obtain "<against>" debt balance "company"
        And Obtain "<against>" credit balance "company"

        Examples:
            | credential                | amount  | refundReason  | refundAsset | type | against | userAnyId | charge  |
            | andresperalta@manteca.dev | dynamic | Manual refund | ARS         | QR   | USDT    | 100009359 | company |

    # User exchange ARG opereted a PIX against ARS
    @Manual @Automated
    Scenario Outline: Refund manual de sintetico de pago PIX contra ARS (Sobre User Balance Argentino)
        Given The urlBase is available "https://sandbox.manteca.dev/crypto"
        And login user admin "<credential>"
        And Obtain "<balance>" balance for "<userAnyId>" user over "<charge>"
        And Execute overdrawn "<type>" synthetic lock against "<against>" for user "<userAnyId>"
        And Execute overdrawn synthetic payment
        When Assign the value "<amount>" to the variable "amount"
        And Assign the value "<refundReason>" to the variable "refundReason"
        And Assign the value "<refundAsset>" to the variable "refundAsset"
        And Execute the POST method on the endpoint "/v1/admin/synthetics/{syntheticId}/refund"
        Then Obtain a response 204
        And Validate refund stages
        And Obtain "<balance>" balance for "<userAnyId>" user over "<charge>"

        Examples:
            | credential                | amount  | refundReason  | refundAsset | type | against | userAnyId | charge  | balance |
            | andresperalta@manteca.dev | dynamic | Manual refund | BRL         | PIX  | ARS_BRL | 100009359 | balance | ARS     |

    # User exchange ARG opereted a PIX against USDT
    @Manual @Automated
    Scenario Outline: Refund manual de sintetico de pago PIX contra ARS (Sobre User Balance Argentino)
        Given The urlBase is available "https://sandbox.manteca.dev/crypto"
        And login user admin "<credential>"
        And Obtain "<balance>" debt balance "company"
        And Obtain "<balance>" credit balance "company"
        And Execute overdrawn "<type>" synthetic lock against "<against>" for user "<userAnyId>"
        And Execute overdrawn synthetic payment
        When Assign the value "<amount>" to the variable "amount"
        And Assign the value "<refundReason>" to the variable "refundReason"
        And Assign the value "<refundAsset>" to the variable "refundAsset"
        And Execute the POST method on the endpoint "/v1/admin/synthetics/{syntheticId}/refund"
        Then Obtain a response 204
        And Validate refund stages
        And Obtain "<balance>" debt balance "company"
        And Obtain "<balance>" credit balance "company"

        Examples:
            | credential                | amount  | refundReason  | refundAsset | type | against  | userAnyId | charge  | balance |
            | andresperalta@manteca.dev | dynamic | Manual refund | BRL         | PIX  | USDT_BRL | 100009359 | company | USDT    |

    # User exchange ARG opereted a PIX against BRL
    @Manual @Automated
    Scenario Outline: Refund manual de sintetico de pago PIX contra ARS (Sobre User Balance Argentino)
        Given The urlBase is available "https://sandbox.manteca.dev/crypto"
        And login user admin "<credential>"
        And Obtain "<balance>" balance for "<userAnyId>" user over "<charge>"
        And Execute overdrawn "<type>" synthetic lock against "<against>" for user "<userAnyId>"
        And Execute overdrawn synthetic payment
        When Assign the value "<amount>" to the variable "amount"
        And Assign the value "<refundReason>" to the variable "refundReason"
        And Assign the value "<refundAsset>" to the variable "refundAsset"
        And Execute the POST method on the endpoint "/v1/admin/synthetics/{syntheticId}/refund"
        Then Obtain a response 204
        And Validate refund stages
        And Obtain "<balance>" balance for "<userAnyId>" user over "<charge>"

        Examples:
            | credential                | amount  | refundReason  | refundAsset | type | against | userAnyId | charge  | balance |
            | andresperalta@manteca.dev | dynamic | Manual refund | BRL         | PIX  | BRL_BRL | 100009359 | balance | BRL     |


    # User exchange BRL opereted a PIX against BRL
    @Manual @Automated
    Scenario Outline: Refund manual de sintetico de pago PIX contra ARS (Sobre User Balance Argentino)
        Given The urlBase is available "https://sandbox.manteca.dev/crypto"
        And login user admin "<credential>"
        And Obtain "<balance>" balance for "<userAnyId>" user over "<charge>"
        And Execute overdrawn "<type>" synthetic lock against "<against>" for user "<userAnyId>"
        And Execute overdrawn synthetic payment
        When Assign the value "<amount>" to the variable "amount"
        And Assign the value "<refundReason>" to the variable "refundReason"
        And Assign the value "<refundAsset>" to the variable "refundAsset"
        And Execute the POST method on the endpoint "/v1/admin/synthetics/{syntheticId}/refund"
        Then Obtain a response 204
        And Validate refund stages
        And Obtain "<balance>" balance for "<userAnyId>" user over "<charge>"

        Examples:
            | credential                | amount  | refundReason  | refundAsset | type | against | userAnyId | charge  | balance |
            | andresperalta@manteca.dev | dynamic | Manual refund | BRL         | PIX  | BRL_BRL | 100011657 | balance | BRL     |

    # User exchange BRL opereted a PIX against USDT
    @Manual @Automated
    Scenario Outline: Refund manual de sintetico de pago PIX contra ARS (Sobre User Balance Argentino)
        Given The urlBase is available "https://sandbox.manteca.dev/crypto"
        And login user admin "<credential>"
        And Obtain "<balance>" debt balance "company"
        And Obtain "<balance>" credit balance "company"
        And Execute overdrawn "<type>" synthetic lock against "<against>" for user "<userAnyId>"
        And Execute overdrawn synthetic payment
        When Assign the value "<amount>" to the variable "amount"
        And Assign the value "<refundReason>" to the variable "refundReason"
        And Assign the value "<refundAsset>" to the variable "refundAsset"
        And Execute the POST method on the endpoint "/v1/admin/synthetics/{syntheticId}/refund"
        Then Obtain a response 204
        And Validate refund stages
        And Obtain "<balance>" debt balance "company"
        And Obtain "<balance>" credit balance "company"

        Examples:
            | credential                | amount  | refundReason  | refundAsset | type | against  | userAnyId | charge  | balance |
            | andresperalta@manteca.dev | dynamic | Manual refund | BRL         | PIX  | USDT_BRL | 100011657 | company | USDT    |

    # User exchange BRL opereted a QR3.0 against BRL
    @Manual @Automated
    Scenario Outline: Refund manual de sintetico de pago PIX contra ARS (Sobre User Balance Argentino)
        Given The urlBase is available "https://sandbox.manteca.dev/crypto"
        And login user admin "<credential>"
        And Obtain "<balance>" balance for "<userAnyId>" user over "<charge>"
        And Execute overdrawn "<type>" synthetic lock against "<against>" for user "<userAnyId>"
        And Execute overdrawn synthetic payment
        When Assign the value "<amount>" to the variable "amount"
        And Assign the value "<refundReason>" to the variable "refundReason"
        And Assign the value "<refundAsset>" to the variable "refundAsset"
        And Execute the POST method on the endpoint "/v1/admin/synthetics/{syntheticId}/refund"
        Then Obtain a response 204
        And Validate refund stages
        And Obtain "<balance>" balance for "<userAnyId>" user over "<charge>"

        Examples:
            | credential                | amount  | refundReason  | refundAsset | type | against | userAnyId | charge  | balance |
            | andresperalta@manteca.dev | dynamic | Manual refund | ARS         | QR   | BRL     | 100011657 | balance | BRL     |

    # User exchange BRL opereted a QR3.0 against USDT
    @Manual1 @Automated
    Scenario Outline: Refund manual de sintetico de pago PIX contra ARS (Sobre User Balance Argentino)
        Given The urlBase is available "https://sandbox.manteca.dev/crypto"
        And login user admin "<credential>"
        And Obtain "<balance>" debt balance "company"
        And Obtain "<balance>" credit balance "company"
        And Execute overdrawn "<type>" synthetic lock against "<against>" for user "<userAnyId>"
        And Execute overdrawn synthetic payment
        When Assign the value "<amount>" to the variable "amount"
        And Assign the value "<refundReason>" to the variable "refundReason"
        And Assign the value "<refundAsset>" to the variable "refundAsset"
        And Execute the POST method on the endpoint "/v1/admin/synthetics/{syntheticId}/refund"
        Then Obtain a response 204
        And Validate refund stages
        And Obtain "<balance>" debt balance "company"
        And Obtain "<balance>" credit balance "company"

        Examples:
            | credential                | amount  | refundReason  | refundAsset | type | against | userAnyId | charge  | balance |
            | andresperalta@manteca.dev | dynamic | Manual refund | ARS         | QR   | USDT    | 100011657 | company | USDT    |

#FALTA CONTRA PIXKEY