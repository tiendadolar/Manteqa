@Sintetico
Feature: Sintéticos

    # ----- Descubierto -----
    # ----- LooselyManagedAssets -----
    @Smoke @RampOnDesc @Automated
    Scenario Outline: Flujo E2E Ramp-On descubierto loosely managed generando deuda a la company "<asset>" contra "<against>"

        # Parte 1: Creación de sintético
        Given The API key is available "RR3XN5E-R8MMCGX-PPVNJT6-GSK7BF2"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        And Obtain a company debt "<against>" balance

        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Assign the value "<withdrawAddress>" to the variable "withdrawAddress"
        And Assign the value "<withdrawNetwork>" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v2/synthetics/ramp-on"
        Then Obtain a response 201
        # Parte 2: Validar ejeccución del sintético
        Then Obtain a response 200 and status "COMPLETED" for "ramp" synthetic
        And Obtain a company debt "<against>" balance

        Examples:
            | userAnyId | sessionId                | asset | against | assetAmount | withdrawAddress                            | withdrawNetwork |
            | 100009780 | smoke-rampOn-DESC-test-n | WLD   | ARS     | 3           | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | WORLDCHAIN      |
            | 100009780 | smoke-rampOn-DESC-test-n | USDT  | ARS     | 5           | 0xd673e64ea7b8689920c957414d01c488B5a4fab5 | ETHEREUM        |
            # | 100009780 | smoke-rampOn-DESC-test-n | DAI   | ARS     | 5           | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | ETHEREUM        |
            # | 100009780 | smoke-rampOn-DESC-test-n | USDC  | ARS     | 15          | 0xd673e64ea7b8689920c957414d01c488B5a4fab5 | BINANCE         |
            # | 100009780 | smoke-rampOn-DESC-test-n | USDC  | ARS     | 15          | 0xd673e64ea7b8689920c957414d01c488B5a4fab5 | POLYGON         |
            | 100009780 | smoke-rampOn-DESC-test-n | USDC  | ARS     | 15          | 0xd673e64ea7b8689920c957414d01c488B5a4fab5 | OPTIMISM        |
            # | 100009780 | smoke-rampOn-DESC-test-n | USDC  | ARS     | 15          | 0xd673e64ea7b8689920c957414d01c488B5a4fab5 | ARBITRUM        |
            | 100009780 | smoke-rampOn-DESC-test-n | USDC  | ARS     | 15          | 0xd673e64ea7b8689920c957414d01c488B5a4fab5 | BASE            |

    @Smoke @RampOnDesc @Automated
    Scenario Outline: Flujo E2E Ramp-On descubierto loosely managed con deposito "<asset>" contra "<against>"
        # Parte 1: Creación de sintético
        Given The API key is available "RR3XN5E-R8MMCGX-PPVNJT6-GSK7BF2"
        And The API secret is available "tNYgnM4sZR2ypkEDnU"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        And Obtain a company debt "<against>" balance

        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Assign the value "<disallowDebt>" to the variable "disallowDebt"
        And Assign the value "<withdrawAddress>" to the variable "withdrawAddress"
        And Assign the value "<withdrawNetwork>" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v2/synthetics/ramp-on"
        Then Obtain a response 201
        # Parte 2: Generar depósito
        And Execute fiat deposit
        # Parte 2: Validar ejeccución del sintético
        Then Obtain a response 200 and status "COMPLETED" for "ramp" synthetic
        And Obtain a company debt "<against>" balance

        Examples:
            | userAnyId | sessionId                | asset | against | assetAmount | disallowDebt | withdrawAddress                            | withdrawNetwork |
            | 100009780 | smoke-rampOn-DESC-test-n | WLD   | ARS     | 3           | true         | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | WORLDCHAIN      |

    @Smoke @RampOnDesc @Automated
    Scenario Outline: Flujo E2E Ramp-On descubierto loosely managed operando desde userBalance "<asset>" contra "<against>"
        # Parte 1: Creación de sintético
        Given The API key is available "RR3XN5E-R8MMCGX-PPVNJT6-GSK7BF2"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        And Obtain "<against>" balance for "<userAnyId>" user

        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Assign the value "<withdrawAddress>" to the variable "withdrawAddress"
        And Assign the value "<withdrawNetwork>" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v2/synthetics/ramp-on"
        Then Obtain a response 201
        # Parte 2: Validar ejeccución del sintético
        Then Obtain a response 200 and status "COMPLETED" for "ramp" synthetic
        And Obtain "<against>" balance for "<userAnyId>" user

        Examples:
            | userAnyId | sessionId                | asset | against | assetAmount | disallowDebt | withdrawAddress                            | withdrawNetwork |
            | 100009788 | smoke-rampOn-DESC-test-n | WLD   | ARS     | 3           | true         | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | WORLDCHAIN      |

    @Smoke @RampOnDesc @Tron @Automated
    Scenario Outline: Flujo E2E Ramp-On descubierto loosely managed generando deuda a la company "<asset>" contra "<against>"

        # Parte 1: Creación de sintético
        Given The API key is available "RR3XN5E-R8MMCGX-PPVNJT6-GSK7BF2"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        And Obtain a company debt "<against>" balance

        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Assign the value "<withdrawAddress>" to the variable "withdrawAddress"
        And Assign the value "<withdrawNetwork>" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v2/synthetics/ramp-on"
        Then Obtain a response 201
        # Parte 2: Validar ejeccución del sintético
        Then Obtain a response 200 and status "COMPLETED" for "tron ramp" synthetic
        And Obtain a company debt "<against>" balance

        Examples:
            | userAnyId | sessionId                | asset | against | assetAmount | withdrawAddress                    | withdrawNetwork |
            | 100009780 | smoke-rampOn-DESC-test-n | TRX   | ARS     | 3           | TRaHQ7KfnkQHCM8zFyX7HrNmMkr54A9oyM | TRON            |
            | 100009780 | smoke-rampOn-DESC-test-n | USDT  | ARS     | 10          | TRaHQ7KfnkQHCM8zFyX7HrNmMkr54A9oyM | TRON            |

    # Se ejecuta solo el stage de orden
    @Smoke @PartialRampOnDesc @Automated
    Scenario Outline: Flujo E2E Partial-Ramp-On descubierto loosely managed generando deuda a la company "<asset>" contra "<against>"
        # Parte 1: Creación de sintético
        Given The API key is available "RR3XN5E-R8MMCGX-PPVNJT6-GSK7BF2"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        And Obtain a company debt "<against>" balance

        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Assign the value "<withdrawAddress>" to the variable "withdrawAddress"
        And Assign the value "<withdrawNetwork>" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v1/synthetics/partial-ramp-on"
        Then Obtain a response 201
        # Parte 2: Validar ejeccución del sintético
        Then Obtain a response 200 and status "COMPLETED" for "ramp" synthetic
        And Obtain a company debt "<against>" balance

        Examples:
            | userAnyId | sessionId                       | asset | against | assetAmount | withdrawAddress                            | withdrawNetwork |
            | 100009781 | smoke-partialRampOn-DESC-test-n | WLD   | ARS     | 3           | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | WORLDCHAIN      |
            | 100009781 | smoke-partialRampOn-DESC-test-n | USDT  | ARS     | 5           | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | ETHEREUM        |
            | 100009781 | smoke-partialRampOn-DESC-test-n | USDC  | ARS     | 5           | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | OPTIMISM        |

    # ----- PartiallyManagedAssets -----
    @Smoke @RampOnDesc @Automated
    Scenario Outline: Flujo E2E Ramp-On descubierto partially managed generando deuda a la company "<asset>" contra "<against>"

        # Parte 1: Creación de sintético
        Given The API key is available "XW0SRXM-TEGM71S-KS8B5MA-ZF1Z79F"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        And Obtain a company debt "<against>" balance

        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Assign the value "<withdrawAddress>" to the variable "withdrawAddress"
        And Assign the value "<withdrawNetwork>" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v2/synthetics/ramp-on"
        Then Obtain a response 201
        # Parte 2: Validar ejeccución del sintético
        Then Obtain a response 200 and status "COMPLETED" for "ramp" synthetic
        And Obtain a company debt "<against>" balance

        Examples:
            | userAnyId | sessionId                | asset | against | assetAmount | withdrawAddress                            | withdrawNetwork |
            | 100011129 | smoke-rampOn-DESC-test-n | USDT  | ARS     | 5           | 0xd673e64ea7b8689920c957414d01c488B5a4fab5 | ETHEREUM        |


    @Smoke @RampOnDesc @Automated
    Scenario Outline: Flujo E2E Ramp-On descubierto partially managed deposit stage "<asset>" contra "<against>"

        # Parte 1: Creación de sintético
        Given The API key is available "XW0SRXM-TEGM71S-KS8B5MA-ZF1Z79F"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        And Obtain "<against>" balance for "<userAnyId>" user

        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Assign the value "<disallowDebt>" to the variable "disallowDebt"
        And Assign the value "<withdrawAddress>" to the variable "withdrawAddress"
        And Assign the value "<withdrawNetwork>" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v2/synthetics/ramp-on"
        Then Obtain a response 201
        And Execute fiat deposit
        # Parte 2: Validar ejeccución del sintético
        Then Obtain a response 200 and status "COMPLETED" for "ramp" synthetic
        And Obtain "<against>" balance for "<userAnyId>" user

        Examples:
            | userAnyId | sessionId                | asset | against | assetAmount | disallowDebt | withdrawAddress                            | withdrawNetwork |
            | 100011129 | smoke-rampOn-DESC-test-n | WLD   | ARS     | 3           | true         | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | WORLDCHAIN      |
            | 100011129 | smoke-rampOn-DESC-test-n | USDT  | ARS     | 10          | true         | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | ETHEREUM        |
            | 100011129 | smoke-rampOn-DESC-test-n | USDC  | ARS     | 3           | true         | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | BASE            |



    # ----- No Descubierto -----

    @Smoke @RampOn @Automated
    Scenario Outline: Flujo E2E Ramp-On no descubierto "<asset>" constra "<against>"
        # Parte 1: Creación de sintético
        Given The API key is available "<apiKEY>"
        And The API secret is available "6RcTZScYUFb2bq9qWq"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        And Obtain "<against>" balance for "<userAnyId>" user

        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Assign the value "<withdrawAddress>" to the variable "withdrawAddress"
        And Assign the value "<withdrawNetwork>" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v1/synthetics/ramp-on"
        Then Obtain a response 201
        # Parte 2: Generar depósito
        And Execute fiat deposit
        # Parte 3: Validar ejeccución del sintético
        Then Obtain a response 200 and status "COMPLETED" for "ramp" synthetic
        And Obtain "<against>" balance for "<userAnyId>" user

        Examples:
            | apiKEY                          | userAnyId | sessionId    | asset | against | assetAmount | withdrawAddress                            | withdrawNetwork |
            | P0H3ZHM-N2EM338-PRP6BA7-S3NTRJD | 100008214 | smoke-test-n | WLD   | ARS     | 3           | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | WORLDCHAIN      |
            | P0H3ZHM-N2EM338-PRP6BA7-S3NTRJD | 100008214 | smoke-test-n | USDT  | ARS     | 10          | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | ETHEREUM        |
            # | P0H3ZHM-N2EM338-PRP6BA7-S3NTRJD | 100008214 | smoke-test-n | DAI   | ARS     | 10          | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | ETHEREUM        |
            | P0H3ZHM-N2EM338-PRP6BA7-S3NTRJD | 100008214 | smoke-test-n | USDC  | ARS     | 10          | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | OPTIMISM        |

    @Smoke @RampOn @Tron @Automated
    Scenario Outline: Flujo E2E Ramp-On no descubierto "<asset>" contra "<against>"
        # Parte 1: Creación de sintético
        Given The API key is available "<apiKEY>"
        And The API secret is available "6RcTZScYUFb2bq9qWq"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"

        And Obtain "<against>" balance for "<userAnyId>" user

        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Assign the value "<withdrawAddress>" to the variable "withdrawAddress"
        And Assign the value "<withdrawNetwork>" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v1/synthetics/ramp-on"
        Then Obtain a response 201
        # Parte 2: Generar depósito
        And Execute fiat deposit
        # Parte 2: Validar ejeccución del sintético
        Then Obtain a response 200 and status "COMPLETED" for "tron ramp" synthetic
        And Obtain "<against>" balance for "<userAnyId>" user

        Examples:
            | apiKEY                          | userAnyId | sessionId    | asset | against | assetAmount | withdrawAddress                    | withdrawNetwork |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | 100011193 | smoke-test-n | TRX   | ARS     | 5           | TRaHQ7KfnkQHCM8zFyX7HrNmMkr54A9oyM | TRON            |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | 100011193 | smoke-test-n | USDT  | ARS     | 10          | TRaHQ7KfnkQHCM8zFyX7HrNmMkr54A9oyM | TRON            |

    @Smoke @RampOn @Automated
    Scenario Outline: Flujo E2E Ramp-On no descubierto operando desde el user balance "<asset>" contra "<against>"
        # Parte 1: Creación de sintético
        Given The API key is available "<apiKEY>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"

        And Obtain "<against>" balance for "<userAnyId>" user

        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Assign the value "<skipDeposit>" to the variable "skipDeposit"
        And Assign the value "<withdrawAddress>" to the variable "withdrawAddress"
        And Assign the value "<withdrawNetwork>" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v1/synthetics/ramp-on"
        Then Obtain a response 201
        # Parte 2: Validar ejeccución del sintético
        Then Obtain a response 200 and status "COMPLETED" for "ramp" synthetic
        And Obtain "<against>" balance for "<userAnyId>" user

        Examples:
            | apiKEY                          | userAnyId | sessionId    | asset | against | assetAmount | skipDeposit | withdrawAddress                            | withdrawNetwork |
            | P0H3ZHM-N2EM338-PRP6BA7-S3NTRJD | 100008214 | smoke-test-n | WLD   | ARS     | 3           | true        | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | WORLDCHAIN      |

    @Smoke @RampOff @NoDesc @Automated
    Scenario Outline: Flujo E2E Ramp-Off no descubierto "<asset>" constra "<against>"
        # Parte 1: Creación de sintético
        Given The API key is available "P0H3ZHM-N2EM338-PRP6BA7-S3NTRJD"
        And The API secret is available "6RcTZScYUFb2bq9qWq"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"

        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Assign the value "<withdrawAddress>" to the variable "withdrawAddress"
        And Assign the value "<withdrawNetwork>" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v1/synthetics/ramp-off"
        Then Obtain a response 201
        # Parte 2: Generar depósito
        And Execute crypto deposit
        # Parte 2: Validar ejeccución del sintético
        Then Obtain a response 200 and status "COMPLETED" for "ramp" synthetic

        Examples:
            | userAnyId | sessionId    | asset | against | assetAmount | withdrawAddress        | withdrawNetwork | to                                         | ticker | chain |
            | 100009688 | smoke-test-n | WLD   | ARS     | 10          | 4530000800015017168564 | WORLDCHAIN      | 0xFFb66dD89211C43Dd76cF7fbE287172bDF35A187 | WLD    | 6     |
            | 100009688 | smoke-test-n | USDT  | ARS     | 3           | 4530000800015017168564 | ETHEREUM        | 0xFFb66dD89211C43Dd76cF7fbE287172bDF35A187 | USDT   | 0     |
            # | 100009688 | smoke-test-n | DAI   | ARS     | 5           | 4530000800015017168564 | ETHEREUM        | 0xFFb66dD89211C43Dd76cF7fbE287172bDF35A187 | DAI    | 0     |
            | 100009688 | smoke-test-n | USDC  | ARS     | 3           | 4530000800015017168564 | OPTIMISM        | 0xFFb66dD89211C43Dd76cF7fbE287172bDF35A187 | USDC   | 5     |

    @Smoke @RampOff @Tron @Automated
    Scenario Outline: Flujo E2E Ramp-Off no descubierto "<asset>" constra "<against>"
        # Parte 1: Creación de sintético
        Given The API key is available "B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV"
        And The API secret is available "mZJ5r9KCdRjnWCdPJg"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"

        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Assign the value "<withdrawAddress>" to the variable "withdrawAddress"
        And Assign the value "<withdrawNetwork>" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v1/synthetics/ramp-off"
        Then Obtain a response 201
        # Parte 2: Generar depósito
        And Execute crypto deposit
        # Parte 2: Validar ejeccución del sintético
        Then Obtain a response 200 and status "COMPLETED" for "tron ramp" synthetic

        Examples:
            | userAnyId | sessionId    | asset | against | assetAmount | withdrawAddress        | withdrawNetwork | to                                 | ticker | chain |
            | 100011193 | smoke-test-n | TRX   | ARS     | 3           | 4530000800015017168564 | TRON            | TBm3cipnHc7HifuBJdh8JM3nwG3LQJ9UQv | TRX    | 9     |
            | 100011193 | smoke-test-n | USDT  | ARS     | 10          | 4530000800015017168564 | TRON            | TBm3cipnHc7HifuBJdh8JM3nwG3LQJ9UQv | USDT   | 9     |

    @Smoke @PartialRampOn @Automated
    Scenario Outline: Flujo E2E Partial-Ramp-On no descubierto
        # Parte 1: Creación de sintético
        Given The API key is available "P0H3ZHM-N2EM338-PRP6BA7-S3NTRJD"
        And The API secret is available "6RcTZScYUFb2bq9qWq"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"

        And Obtain "<against>" balance for "<userAnyId>" user

        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Assign the value "<withdrawAddress>" to the variable "withdrawAddress"
        And Assign the value "<withdrawNetwork>" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v1/synthetics/partial-ramp-on"
        Then Obtain a response 201
        # Parte 2: Generar depósito
        And Execute fiat deposit
        # Parte 2: Validar ejeccución del sintético
        Then Obtain a response 200 and status "COMPLETED" for "ramp" synthetic
        And Obtain "<against>" balance for "<userAnyId>" user

        Examples:
            | userAnyId | sessionId                  | asset | against | assetAmount | withdrawAddress                            | withdrawNetwork |
            | 100009719 | smoke-partialRampOn-test-n | WLD   | ARS     | 3           | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | WORLDCHAIN      |
            | 100009719 | smoke-partialRampOn-test-n | USDT  | ARS     | 2           | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | ETHEREUM        |
            | 100009719 | smoke-partialRampOn-test-n | USDC  | ARS     | 4           | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | OPTIMISM        |

    @Smoke @PartialRampOff @Automated
    Scenario Outline: Flujo E2E Partial-Ramp-Off no descubierto
        # Parte 1: Creación de sintético
        Given The API key is available "P0H3ZHM-N2EM338-PRP6BA7-S3NTRJD"
        And The API secret is available "6RcTZScYUFb2bq9qWq"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"

        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Assign the value "<withdrawAddress>" to the variable "withdrawAddress"
        And Assign the value "<withdrawNetwork>" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v1/synthetics/partial-ramp-off"
        Then Obtain a response 201
        # Parte 2: Generar depósito
        And Execute crypto deposit
        # Parte 2: Validar ejeccución del sintético
        Then Obtain a response 200 and status "COMPLETED" for "ramp" synthetic

        Examples:
            | userAnyId | sessionId                   | asset | against | assetAmount | withdrawAddress        | withdrawNetwork | to                                         | ticker | chain |
            | 100009774 | smoke-partialRampOff-test-n | WLD   | ARS     | 10          | 4530000800015017168564 | WORLDCHAIN      | 0x367b5Aa470049B722ce815b8f9EB66064D0415d4 | WLD    | 6     |
            | 100009774 | smoke-partialRampOff-test-n | USDT  | ARS     | 10          | 4530000800015017168564 | ETHEREUM        | 0x367b5Aa470049B722ce815b8f9EB66064D0415d4 | USDT   | 0     |
            | 100009774 | smoke-partialRampOff-test-n | USDC  | ARS     | 10          | 4530000800015017168564 | OPTIMISM        | 0x367b5Aa470049B722ce815b8f9EB66064D0415d4 | USDC   | 5     |

    @Smoke @RampOff @Exchange @Automated
    Scenario Outline: Flujo E2E Ramp-Off no descubierto para usuario exchange <against>
        Given The API key is available "<apiKEY>"
        And The API secret is available "6RcTZScYUFb2bq9qWq"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        # And Obtain "<against>" balance for "<userAnyId>" user

        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Assign the value "<withdrawAddress>" to the variable "withdrawAddress"
        And Execute the POST method on the endpoint "/v1/synthetics/ramp-off"
        Then Obtain a response 201
        # Parte 2: Generar depósito
        And Execute crypto deposit
        # Parte 2: Validar ejeccución del sintético
        Then Obtain a response 200 and status "COMPLETED" for "ramp" synthetic
        # And Obtain "<against>" balance for "<userAnyId>" user

        Examples:
            | apiKEY                          | userAnyId | sessionId       | asset | against | assetAmount | withdrawAddress        | withdrawNetwork |
            | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 | 100011660 | smoke-rampoff-n | USDT  | BRL     | 3           | 53724491875            | ETHEREUM        |
            | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 | 100012259 | smoke-rampoff-n | USDT  | CLP     | 3           | 16778957               | ETHEREUM        |
            | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 | 100012269 | smoke-rampoff-n | USDT  | GTQ     | 3           | 1234567                | ETHEREUM        |
            | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 | 100012270 | smoke-rampoff-n | USDT  | CRC     | 3           | CR88010404046620113218 | ETHEREUM        |
            | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 | 100012271 | smoke-rampoff-n | USDT  | MXN     | 3           | 156356784125789654     | ETHEREUM        |
            | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 | 100012272 | smoke-rampoff-n | USDT  | PHP     | 3           | 09300164750            | ETHEREUM        |
            | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 | 100012389 | smoke-rampoff-n | USDT  | COP     | 3           | 3511234567             | ETHEREUM        |
            | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 | 100012268 | smoke-rampoff-n | USDT  | PUSD    | 3           | 0472018417951          | ETHEREUM        |

    @Smoke @RampOn @Exchange @Automated
    Scenario Outline: Flujo E2E Ramp-On no descubierto para usuario exchange <against>
        Given The API key is available "<apiKEY>"
        And The API secret is available "6RcTZScYUFb2bq9qWq"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        # And Obtain "<against>" balance for "<userAnyId>" user

        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Assign the value "<withdrawAddress>" to the variable "withdrawAddress"
        And Assign the value "<withdrawNetwork>" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v1/synthetics/ramp-on"
        Then Obtain a response 201
        # Parte 2: Generar depósito
        And Execute fiat deposit
        # Parte 2: Validar ejeccución del sintético
        Then Obtain a response 200 and status "COMPLETED" for "ramp" synthetic
        # And Obtain "<against>" balance for "<userAnyId>" user

        Examples:
            | apiKEY                          | userAnyId | sessionId       | asset | against | assetAmount | withdrawAddress                            | withdrawNetwork |
            | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 | 100011660 | smoke-rampoff-n | USDT  | BRL     | 3           | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | ETHEREUM        |
            | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 | 100012259 | smoke-rampoff-n | USDT  | CLP     | 10          | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | BINANCE         |
            | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 | 100012269 | smoke-rampoff-n | USDT  | GTQ     | 10          | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | BINANCE         |
            | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 | 100012270 | smoke-rampoff-n | USDT  | CRC     | 10          | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | BINANCE         |
            | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 | 100012271 | smoke-rampoff-n | USDT  | MXN     | 10          | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | BINANCE         |
            | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 | 100012272 | smoke-rampoff-n | USDT  | PHP     | 10          | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | BINANCE         |
            | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 | 100012267 | smoke-rampoff-n | USDT  | COP     | 10          | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | BINANCE         |
            | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 | 100012268 | smoke-rampoff-n | USDT  | PUSD    | 10          | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | BINANCE         |
