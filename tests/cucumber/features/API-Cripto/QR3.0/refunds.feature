@Refunds
Feature: Synthetic Refunds

    Background:
        Given Get credentials for company "684b9446017d29431c2cac6a"

    #Companies partiallyManaged take company debt instead take funds for user balances
    #Companies looselyManaged take funds for user balances instead take company debt. If user has no funds, take from company debt.

    # User exchange ARG opereted a QR3.0 against ARS
    @Manual @Deprecated
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


    @Manual @TotalRefund @Automated
    Scenario Outline: Refund total de sintetico de pago <type> contra <against> (Sobre User Balance)
        Given The urlBase is available "https://sandbox.manteca.dev/crypto"
        And Get credentials for company "69b83acb59880505eeaa3e52"
        And login user admin "<credential>"
        And Get "<against>" initial user balance for "<userAnyId>"
        And Execute overdrawn "<type>" synthetic lock against "<against>" for user "<userAnyId>"
        And Execute balance synthetic payment
        When Assign the value "<amount>" to the variable "amount"
        And Assign the value "<refundReason>" to the variable "refundReason"
        And Assign the value "<refundAsset>" to the variable "refundAsset"
        And Execute the POST method on the endpoint "/v1/admin/synthetics/{syntheticId}/refund"
        Then Obtain a response 204
        And Validate total refund stages
        And Validate "<status>" status
        And Get "<against>" final user balance for "<userAnyId>"
        And Compare user balance for "<operation>"

        Examples:
            | credential                | amount  | refundReason  | refundAsset | type | against | userAnyId | charge  | status    | operation   |
            | andresperalta@manteca.dev | dynamic | Manual refund | ARS         | QR   | ARS     | 100061862 | balance | CANCELLED | TOTALREFUND |
            | andresperalta@manteca.dev | dynamic | Manual refund | ARS         | QR   | USDT    | 100061862 | balance | CANCELLED | TOTALREFUND |
            | andresperalta@manteca.dev | dynamic | Manual refund | ARS         | QR   | USDC    | 100061862 | balance | CANCELLED | TOTALREFUND |

    @Manual @TotalRefund @Automated
    Scenario Outline: Refund total de sintetico de pago <type> contra <against> (Sobre User Balance) desde principal account
        Given The urlBase is available "https://sandbox.manteca.dev/crypto"
        And Get credentials for company "69b83acb59880505eeaa3e52"
        And login user admin "<credential>"
        And Get "<against>" initial user balance for "<userAnyId>"
        And Execute overdrawn "<type>" synthetic lock against "<against>" for user "<userAnyId>"
        And Execute balance synthetic payment
        When Assign the value "<amount>" to the variable "amount"
        And Assign the value "<refundReason>" to the variable "refundReason"
        And Assign the value "<refundAsset>" to the variable "refundAsset"
        And Execute the POST method on the endpoint "/v1/admin/synthetics/{syntheticId}/refund"
        Then Obtain a response 204
        And Validate total refund stages
        And Validate "<status>" status
        And Get "<against>" final user balance for "<userAnyId>"
        And Compare user balance for "<operation>"

        Examples:
            | credential                | amount  | refundReason  | refundAsset | type | against         | userAnyId | status    | operation   |
            | andresperalta@manteca.dev | dynamic | Manual refund | BRL         | PIX  | USDT_BRL_SENDER | 100061862 | CANCELLED | TOTALREFUND |
    # | andresperalta@manteca.dev | dynamic | Manual refund | USDT        | PIX  | USDT_BRL_SENDER | 100061862 | balance | CANCELLED | TOTALREFUND |

    @Manual @PartialRefund @Automated
    Scenario Outline: Refund parcial de sintetico de pago QR3.0 contra <against> (Sobre User Balance)
        Given The urlBase is available "https://sandbox.manteca.dev/crypto"
        And Get credentials for company "69b83acb59880505eeaa3e52"
        And login user admin "<credential>"
        And Get "<against>" initial user balance for "<userAnyId>"
        And Execute overdrawn "<type>" synthetic lock against "<against>" for user "<userAnyId>"
        And Execute balance synthetic payment
        When Assign the value "<amount>" to the variable "amount"
        And Assign the value "<refundReason>" to the variable "refundReason"
        And Assign the value "<refundAsset>" to the variable "refundAsset"
        And Execute the POST method on the endpoint "/v1/admin/synthetics/{syntheticId}/refund"
        Then Obtain a response 204
        And Validate partial refund stages
        And Validate "<status>" status
        And Get "<against>" final user balance for "<userAnyId>"
        And Compare balance for "<operation>"

        Examples:
            | credential                | amount | refundReason  | refundAsset | type | against         | userAnyId | status    | operation     |
            | andresperalta@manteca.dev | 500    | Manual refund | ARS         | QR   | ARS             | 100061862 | CANCELLED | PARTIALREFUND |
            | andresperalta@manteca.dev | 500    | Manual refund | ARS         | QR   | USDT            | 100061862 | COMPLETED | PARTIALREFUND |
            | andresperalta@manteca.dev | 500    | Manual refund | ARS         | QR   | USDC            | 100061862 | COMPLETED | PARTIALREFUND |
            | andresperalta@manteca.dev | 5      | Manual refund | BRL         | PIX  | USDT_BRL_SENDER | 100061862 | COMPLETED | PARTIALREFUND |

    @Manual @TotalRefund @Automated
    Scenario Outline: Refund total de sintetico de pago QR3.0 contra <against> (Sobre Company Partially)
        Given The urlBase is available "https://sandbox.manteca.dev/crypto"
        And Get credentials for company "69bf5afc19c429831287d1bf"
        And login user admin "<credential>"
        And Get "<against>" initial debt company balance
        And Get "<against>" initial credit company balance
        And Execute overdrawn "<type>" synthetic lock against "<against>" for user "<userAnyId>"
        And Execute overdrawn synthetic payment
        When Assign the value "<amount>" to the variable "amount"
        And Assign the value "<refundReason>" to the variable "refundReason"
        And Assign the value "<refundAsset>" to the variable "refundAsset"
        And Execute the POST method on the endpoint "/v1/admin/synthetics/{syntheticId}/refund"
        Then Obtain a response 204
        And Validate total refund stages
        And Validate "<status>" status
        And Get "<against>" final debt company balance
        And Get "<against>" final credit company balance
        And Compare accounting company balance for "<operation>"

        Examples:
            | credential                | amount  | refundReason  | refundAsset | type | against | userAnyId | status    | operation   |
            | andresperalta@manteca.dev | dynamic | Manual refund | ARS         | QR   | USDT    | 100062353 | CANCELLED | TOTALREFUND |
    # | andresperalta@manteca.dev | dynamic | Manual refund | ARS         | QR   | ARS     | 100062353 | balance |

    @Manual @PartialRefund @Automated
    Scenario Outline: Refund parcial de sintetico de pago QR3.0 contra <against> (Sobre Company Partially)
        Given The urlBase is available "https://sandbox.manteca.dev/crypto"
        And Get credentials for company "69bf5afc19c429831287d1bf"
        And login user admin "<credential>"
        And Get "<against>" initial debt company balance
        And Get "<against>" initial credit company balance
        And Execute overdrawn "<type>" synthetic lock against "<against>" for user "<userAnyId>"
        And Execute overdrawn synthetic payment
        When Assign the value "<amount>" to the variable "amount"
        And Assign the value "<refundReason>" to the variable "refundReason"
        And Assign the value "<refundAsset>" to the variable "refundAsset"
        And Execute the POST method on the endpoint "/v1/admin/synthetics/{syntheticId}/refund"
        Then Obtain a response 204
        And Validate partial refund stages
        And Validate "<status>" status
        And Get "<against>" final debt company balance
        And Get "<against>" final credit company balance
        And Compare accounting company balance for "<operation>"

        Examples:
            | credential                | amount | refundReason  | refundAsset | type | against | userAnyId | status    | operation     |
            | andresperalta@manteca.dev | 500    | Manual refund | ARS         | QR   | USDT    | 100062353 | COMPLETED | PARTIALREFUND |

    @Manual @TotalRefund @Automated
    Scenario Outline: Refund total de sintetico de pago QR3.0 contra <against> (Sobre Company Partially) desde principal account
        Given The urlBase is available "https://sandbox.manteca.dev/crypto"
        And Get credentials for company "69bf5afc19c429831287d1bf"
        And login user admin "<credential>"
        And Get "<against>" initial debt company balance
        And Get "<against>" initial credit company balance
        And Execute overdrawn "<type>" synthetic lock against "<against>" for user "<userAnyId>"
        And Execute overdrawn synthetic payment
        When Assign the value "<amount>" to the variable "amount"
        And Assign the value "<refundReason>" to the variable "refundReason"
        And Assign the value "<refundAsset>" to the variable "refundAsset"
        And Execute the POST method on the endpoint "/v1/admin/synthetics/{syntheticId}/refund"
        Then Obtain a response 204
        And Validate "<status>" status
        And Get "<against>" final debt company balance
        And Get "<against>" final credit company balance
        And Compare accounting company balance for "<operation>"

        Examples:
            | credential                | amount  | refundReason  | refundAsset | type | against         | userAnyId | status    | operation   |
            | andresperalta@manteca.dev | dynamic | Manual refund | BRL         | PIX  | USDT_BRL_SENDER | 100064936 | CANCELLED | TOTALREFUND |

    @Manual @Automated
    Scenario Outline: Refund sintetico de pago QR3.0 contra <against> (Sobre Company Looselly)
        Given The urlBase is available "https://sandbox.manteca.dev/crypto"
        And Get credentials for company "69c02e4719c4298312882d1e"
        And login user admin "<credential>"
        And Get "<against>" initial debt company balance
        And Get "<against>" initial credit company balance
        And Get "<against>" initial user balance for "<userAnyId>"
        And Execute overdrawn "<type>" synthetic lock against "<against>" for user "<userAnyId>"
        And Execute overdrawn synthetic payment
        When Assign the value "<amount>" to the variable "amount"
        And Assign the value "<refundReason>" to the variable "refundReason"
        And Assign the value "<refundAsset>" to the variable "refundAsset"
        And Execute the POST method on the endpoint "/v1/admin/synthetics/{syntheticId}/refund"
        Then Obtain a response 204
        And Validate partial refund stages
        And Validate "<status>" status
        And Get "<against>" final debt company balance
        And Get "<against>" final credit company balance
        And Get "<against>" final user balance for "<userAnyId>"
        And Compare equal accounting company balance
        And Compare user balance for "<operation>"

        Examples:
            | credential                | amount  | refundReason  | refundAsset | type | against | userAnyId | status    | operation     |
            | andresperalta@manteca.dev | 500     | Manual refund | ARS         | QR   | USDT    | 100062358 | COMPLETED | PARTIALREFUND |
            | andresperalta@manteca.dev | dynamic | Manual refund | ARS         | QR   | USDT    | 100062358 | CANCELLED | TOTALREFUND   |
            | andresperalta@manteca.dev | dynamic | Manual refund | ARS         | QR   | ARS     | 100062358 | CANCELLED | TOTALREFUND   |
            | andresperalta@manteca.dev | 500     | Manual refund | ARS         | QR   | ARS     | 100062358 | CANCELLED | PARTIALREFUND |

    # User exchange ARG opereted a QR3.0 against USDT
    @Manual @Deprecated
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
    @Manual @Deprecated
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
    @Manual @Deprecated
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
    @Manual @Deprecated
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
    @Manual @Deprecated
    Scenario Outline: Refund manual de sintetico de pago PIX contra BRL (Sobre User Balance Brasilero)
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
    @Manual @Deprecated
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
    @Manual @Deprecated
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
    @Manual @Deprecated
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


    # User exchange BRL opereted a PIXKEY against BRL
    @Manual @Deprecated
    Scenario Outline: Refund manual de sintetico de pago PIXKey contra BRL (Sobre User Balance Brazil)
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
            | credential                | amount  | refundReason  | refundAsset | type   | against | userAnyId | charge  | balance |
            | andresperalta@manteca.dev | dynamic | Manual refund | BRL         | PIXKEY | BRL     | 100011657 | balance | BRL     |

    # User exchange BRL opereted a PIXKEY against USDT
    @Manual @Deprecated
    Scenario Outline: Refund manual de sintetico de pago PIXKey contra USDT (Sobre Company Balance Brazil)
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
            | credential                | amount  | refundReason  | refundAsset | type   | against  | userAnyId | charge  | balance |
            | andresperalta@manteca.dev | dynamic | Manual refund | BRL         | PIXKEY | USDT_BRL | 100011657 | company | USDT    |


    # --------------- FAILURE

    # User exchange ARG opereted a QR3.0 against ARS
    @Failure @Automated
    Scenario Outline: Refund automatico de sintetico de pago QR3.0 contra ARS por fallo de network (Sobre User Argentino Balance)
        Given The urlBase is available "https://sandbox.manteca.dev/crypto"
        And login user admin "<credential>"
        And Obtain "<against>" balance for "<userAnyId>" user over "<charge>"
        And Execute overdrawn "<type>" synthetic lock against "<against>" for user "<userAnyId>"
        And Execute overdrawn synthetic payment
        And Validate refund stages
        And Obtain "<against>" balance for "<userAnyId>" user over "<charge>"

        Examples:
            | credential                | amount  | refundReason  | refundAsset | type    | against | userAnyId | charge  |
            | andresperalta@manteca.dev | dynamic | Manual refund | ARS         | FAILURE | ARS     | 100009359 | balance |

    # --------------- REFUND AUTOMATICO

    # User exchange ARG opereted a QR3.0 against ARS
    @Refund @Automated
    Scenario Outline: Refund automatico de sintetico de pago QR3.0 contra ARS por fallo de network (Sobre User Argentino Balance)
        Given The urlBase is available "https://sandbox.manteca.dev/crypto"
        And login user admin "<credential>"
        And Obtain "<against>" balance for "<userAnyId>" user over "<charge>"
        And Execute overdrawn "<type>" synthetic lock against "<against>" for user "<userAnyId>"
        And Execute overdrawn synthetic payment
        And Validate refund stages
        And Obtain "<against>" balance for "<userAnyId>" user over "<charge>"

        Examples:
            | credential                | amount  | refundReason  | refundAsset | type   | against | userAnyId | charge  |
            | andresperalta@manteca.dev | dynamic | Manual refund | ARS         | REFUND | ARS     | 100009359 | balance |