@Sintetico @Regression
Feature: Sintéticos

    # ----- Descubierto -----
    # ----- LooselyManagedAssets -----
    @RampOnDesc @Automated
    Scenario Outline: Flujo E2E Ramp-On descubierto loosely managed generando deuda a la company "<asset>" contra "<against>"

        # Parte 1: Creación de sintético
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        # And Obtain a company debt "<against>" balance

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
        # And Obtain a company debt "<against>" balance

        Examples:
            | companyId                | userAnyId | sessionId                | asset | against | assetAmount | withdrawAddress                            | withdrawNetwork |
            | 6849d02e906eb70b50893536 | 100009780 | smoke-rampOn-DESC-test-n | WLD   | ARS     | 3           | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | WORLDCHAIN      |
            | 6849d02e906eb70b50893536 | 100009780 | smoke-rampOn-DESC-test-n | USDT  | ARS     | 5           | 0xd673e64ea7b8689920c957414d01c488B5a4fab5 | ETHEREUM        |
            #|6849d02e906eb70b50893536 | 100009780 | smoke-rampOn-DESC-test-n | DAI   | ARS     | 5           | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | ETHEREUM        |
            #|6849d02e906eb70b50893536 | 100009780 | smoke-rampOn-DESC-test-n | USDC  | ARS     | 15          | 0xd673e64ea7b8689920c957414d01c488B5a4fab5 | BINANCE         |
            #|6849d02e906eb70b50893536 | 100009780 | smoke-rampOn-DESC-test-n | USDC  | ARS     | 15          | 0xd673e64ea7b8689920c957414d01c488B5a4fab5 | POLYGON         |
            | 6849d02e906eb70b50893536 | 100009780 | smoke-rampOn-DESC-test-n | USDC  | ARS     | 15          | 0xd673e64ea7b8689920c957414d01c488B5a4fab5 | OPTIMISM        |
            #|6849d02e906eb70b50893536 | 100009780 | smoke-rampOn-DESC-test-n | USDC  | ARS     | 15          | 0xd673e64ea7b8689920c957414d01c488B5a4fab5 | ARBITRUM        |
            | 6849d02e906eb70b50893536 | 100009780 | smoke-rampOn-DESC-test-n | USDC  | ARS     | 15          | 0xd673e64ea7b8689920c957414d01c488B5a4fab5 | BASE            |

        @Smoke
        Examples:
            | userAnyId | sessionId                | asset | against | assetAmount | withdrawAddress                            | withdrawNetwork |
            | 100009780 | smoke-rampOn-DESC-test-n | WLD   | ARS     | 3           | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | WORLDCHAIN      |

    @RampOnDesc @Automated
    Scenario Outline: Flujo E2E Ramp-On descubierto loosely managed con deposito "<asset>" contra "<against>"
        # Parte 1: Creación de sintético
        Given Get credentials for company "<companyId>"
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

        @Smoke
        Examples:
            | companyId                | userAnyId | sessionId                | asset | against | assetAmount | disallowDebt | withdrawAddress                            | withdrawNetwork |
            | 6849d02e906eb70b50893536 | 100009780 | smoke-rampOn-DESC-test-n | WLD   | ARS     | 3           | true         | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | WORLDCHAIN      |

    @RampOnDesc @Automated
    Scenario Outline: Flujo E2E Ramp-On descubierto loosely managed operando desde userBalance "<asset>" contra "<against>"
        # Parte 1: Creación de sintético
        Given Get credentials for company "<companyId>"
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

        @Smoke
        Examples:
            | companyId                | userAnyId | sessionId                | asset | against | assetAmount | disallowDebt | withdrawAddress                            | withdrawNetwork |
            | 6849d02e906eb70b50893536 | 100009788 | smoke-rampOn-DESC-test-n | WLD   | ARS     | 3           | true         | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | WORLDCHAIN      |

    @RampOnDesc @Tron @Automated
    Scenario Outline: Flujo E2E Ramp-On descubierto loosely managed generando deuda a la company "<asset>" contra "<against>"

        # Parte 1: Creación de sintético
        Given Get credentials for company "<companyId>"
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

        @Smoke
        Examples:
            | companyId                | userAnyId | sessionId                | asset | against | assetAmount | withdrawAddress                    | withdrawNetwork |
            | 6849d02e906eb70b50893536 | 100009780 | smoke-rampOn-DESC-test-n | TRX   | ARS     | 3           | TRaHQ7KfnkQHCM8zFyX7HrNmMkr54A9oyM | TRON            |
            | 6849d02e906eb70b50893536 | 100009780 | smoke-rampOn-DESC-test-n | USDT  | ARS     | 10          | TRaHQ7KfnkQHCM8zFyX7HrNmMkr54A9oyM | TRON            |

    # Se ejecuta solo el stage de orden
    @PartialRampOnDesc @Automated
    Scenario Outline: Flujo E2E Partial-Ramp-On descubierto loosely managed generando deuda a la company "<asset>" contra "<against>"
        # Parte 1: Creación de sintético
        Given Get credentials for company "<companyId>"
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
            | companyId                | userAnyId | sessionId                       | asset | against | assetAmount | withdrawAddress                            | withdrawNetwork |
            | 6849d02e906eb70b50893536 | 100009781 | smoke-partialRampOn-DESC-test-n | WLD   | ARS     | 3           | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | WORLDCHAIN      |
            | 6849d02e906eb70b50893536 | 100009781 | smoke-partialRampOn-DESC-test-n | USDT  | ARS     | 7           | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | ETHEREUM        |
            | 6849d02e906eb70b50893536 | 100009781 | smoke-partialRampOn-DESC-test-n | USDC  | ARS     | 5           | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | OPTIMISM        |

        @Smoke
        Examples:
            | companyId                | userAnyId | sessionId                       | asset | against | assetAmount | withdrawAddress                            | withdrawNetwork |
            | 6849d02e906eb70b50893536 | 100009781 | smoke-partialRampOn-DESC-test-n | WLD   | ARS     | 3           | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | WORLDCHAIN      |

    # ----- PartiallyManagedAssets -----
    @RampOnDesc @Automated
    Scenario Outline: Flujo E2E Ramp-On descubierto partially managed generando deuda a la company "<asset>" contra "<against>"

        # Parte 1: Creación de sintético
        Given Get credentials for company "<companyId>"
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

        @Smoke
        Examples:
            | companyId                | userAnyId | sessionId                | asset | against | assetAmount | withdrawAddress                            | withdrawNetwork |
            | 689e03af7919769c293d70bf | 100011129 | smoke-rampOn-DESC-test-n | USDT  | ARS     | 7           | 0xd673e64ea7b8689920c957414d01c488B5a4fab5 | ETHEREUM        |


    @RampOnDesc @Deprecated
    Scenario Outline: Flujo E2E Ramp-On descubierto partially managed deposit stage "<asset>" contra "<against>"

        # Parte 1: Creación de sintético
        Given Get credentials for company "<companyId>"
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
            | companyId                | userAnyId | sessionId                | asset | against | assetAmount | disallowDebt | withdrawAddress                            | withdrawNetwork |
            | 689e03af7919769c293d70bf | 100011129 | smoke-rampOn-DESC-test-n | WLD   | ARS     | 3           | true         | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | WORLDCHAIN      |
            | 689e03af7919769c293d70bf | 100011129 | smoke-rampOn-DESC-test-n | USDT  | ARS     | 10          | true         | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | ETHEREUM        |
            | 689e03af7919769c293d70bf | 100011129 | smoke-rampOn-DESC-test-n | USDC  | ARS     | 3           | true         | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | BASE            |



    # ----- No Descubierto -----

    @RampOn @Automated
    Scenario Outline: Flujo E2E Ramp-On no descubierto "<asset>" constra "<against>"
        # Parte 1: Creación de sintético
        Given Get credentials for company "<companyId>"
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
            | companyId                | userAnyId | sessionId    | asset | against | assetAmount | withdrawAddress                            | withdrawNetwork |
            | 6830d459db3fdce1729dd147 | 100008214 | smoke-test-n | WLD   | ARS     | 3           | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | WORLDCHAIN      |
            | 6830d459db3fdce1729dd147 | 100008214 | smoke-test-n | USDT  | ARS     | 10          | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | ETHEREUM        |
            # | 6830d459db3fdce1729dd147 | 100008214 | smoke-test-n | DAI   | ARS     | 10          | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | ETHEREUM        |
            | 6830d459db3fdce1729dd147 | 100008214 | smoke-test-n | USDC  | ARS     | 10          | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | OPTIMISM        |


        Examples:
            | companyId                | userAnyId | sessionId    | asset | against | assetAmount | withdrawAddress                            | withdrawNetwork |
            | 6830d459db3fdce1729dd147 | 100008214 | smoke-test-n | WLD   | ARS     | 3           | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | WORLDCHAIN      |

    @RampOn @Tron @Automated
    Scenario Outline: Flujo E2E Ramp-On no descubierto "<asset>" contra "<against>"
        # Parte 1: Creación de sintético
        Given Get credentials for company "<companyId>"
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

        @Smoke
        Examples:
            | companyId                | userAnyId | sessionId    | asset | against | assetAmount | withdrawAddress                    | withdrawNetwork |
            | 683cce15397feba125068c9b | 100011193 | smoke-test-n | TRX   | ARS     | 5           | TRaHQ7KfnkQHCM8zFyX7HrNmMkr54A9oyM | TRON            |
            | 683cce15397feba125068c9b | 100011193 | smoke-test-n | USDT  | ARS     | 10          | TRaHQ7KfnkQHCM8zFyX7HrNmMkr54A9oyM | TRON            |

    @RampOn @Automated
    Scenario Outline: Flujo E2E Ramp-On no descubierto operando desde el user balance "<asset>" contra "<against>"
        # Parte 1: Creación de sintético
        Given Get credentials for company "<companyId>"
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

        @Smoke
        Examples:
            | companyId                | userAnyId | sessionId    | asset | against | assetAmount | skipDeposit | withdrawAddress                            | withdrawNetwork |
            | 6830d459db3fdce1729dd147 | 100008214 | smoke-test-n | WLD   | ARS     | 3           | true        | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | WORLDCHAIN      |

    @RampOff @NoDesc @Automated @Run
    Scenario Outline: Flujo E2E Ramp-Off no descubierto "<asset>" constra "<against>"
        # Parte 1: Creación de sintético
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"

        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Assign the value "<withdrawAddress>" to the variable "withdrawAddress"
        And Assign the value "<withdrawNetwork>" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v2/synthetics/ramp-off"
        Then Obtain a response 201
        # Parte 2: Generar depósito
        And Execute crypto deposit
        # Parte 2: Validar ejeccución del sintético
        Then Obtain a response 200 and status "COMPLETED" for "ramp" synthetic


        Examples:
            | companyId                | userAnyId | sessionId    | asset | against | assetAmount | withdrawAddress        | withdrawNetwork | to                                         | ticker | chain |
            | 6830d459db3fdce1729dd147 | 100009688 | smoke-test-n | WLD   | ARS     | 10          | 4530000800015017168564 | WORLDCHAIN      | 0xFFb66dD89211C43Dd76cF7fbE287172bDF35A187 | WLD    | 6     |
    # |6830d459db3fdce1729dd147| 100009688 | smoke-test-n | USDT  | ARS     | 7           | 4530000800015017168564 | ETHEREUM        | 0xFFb66dD89211C43Dd76cF7fbE287172bDF35A187 | USDT   | 0     |
    # |6830d459db3fdce1729dd147| 100009688 | smoke-test-n | DAI   | ARS     | 5           | 4530000800015017168564 | ETHEREUM        | 0xFFb66dD89211C43Dd76cF7fbE287172bDF35A187 | DAI    | 0     |
    # |6830d459db3fdce1729dd147| 100009688 | smoke-test-n | USDC  | ARS     | 3           | 4530000800015017168564 | OPTIMISM        | 0xFFb66dD89211C43Dd76cF7fbE287172bDF35A187 | USDC   | 5     |

    @RampOff @Tron @Automated
    Scenario Outline: Flujo E2E Ramp-Off no descubierto "<asset>" constra "<against>"
        # Parte 1: Creación de sintético
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"

        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Assign the value "<withdrawAddress>" to the variable "withdrawAddress"
        And Assign the value "<withdrawNetwork>" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v2/synthetics/ramp-off"
        Then Obtain a response 201
        # Parte 2: Generar depósito
        And Execute crypto deposit
        # Parte 2: Validar ejeccución del sintético
        Then Obtain a response 200 and status "COMPLETED" for "tron ramp" synthetic

        @Smoke
        Examples:
            | companyId                | userAnyId | sessionId    | asset | against | assetAmount | withdrawAddress        | withdrawNetwork | to                                 | ticker | chain |
            | 683cce15397feba125068c9b | 100011193 | smoke-test-n | TRX   | ARS     | 3           | 4530000800015017168564 | TRON            | TBm3cipnHc7HifuBJdh8JM3nwG3LQJ9UQv | TRX    | 9     |
            | 683cce15397feba125068c9b | 100011193 | smoke-test-n | USDT  | ARS     | 10          | 4530000800015017168564 | TRON            | TBm3cipnHc7HifuBJdh8JM3nwG3LQJ9UQv | USDT   | 9     |

    @PartialRampOn @Automated
    Scenario Outline: Flujo E2E Partial-Ramp-On no descubierto
        # Parte 1: Creación de sintético
        Given Get credentials for company "<companyId>"
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
            | companyId                | userAnyId | sessionId                  | asset | against | assetAmount | withdrawAddress                            | withdrawNetwork |
            | 6830d459db3fdce1729dd147 | 100009719 | smoke-partialRampOn-test-n | WLD   | ARS     | 3           | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | WORLDCHAIN      |
            | 6830d459db3fdce1729dd147 | 100009719 | smoke-partialRampOn-test-n | USDT  | ARS     | 7           | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | ETHEREUM        |
            | 6830d459db3fdce1729dd147 | 100009719 | smoke-partialRampOn-test-n | USDC  | ARS     | 4           | 0x63c91C1F898389bF7b09cD275d4BAD1194f1b77e | OPTIMISM        |

    @PartialRampOff @Automated
    Scenario Outline: Flujo E2E Partial-Ramp-Off no descubierto
        # Parte 1: Creación de sintético
        Given Get credentials for company "<companyId>"
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
            | companyId                | userAnyId | sessionId                   | asset | against | assetAmount | withdrawAddress        | withdrawNetwork | to                                         | ticker | chain |
            | 6830d459db3fdce1729dd147 | 100009774 | smoke-partialRampOff-test-n | WLD   | ARS     | 10          | 4530000800015017168564 | WORLDCHAIN      | 0x367b5Aa470049B722ce815b8f9EB66064D0415d4 | WLD    | 6     |
            | 6830d459db3fdce1729dd147 | 100009774 | smoke-partialRampOff-test-n | USDT  | ARS     | 10          | 4530000800015017168564 | ETHEREUM        | 0x367b5Aa470049B722ce815b8f9EB66064D0415d4 | USDT   | 0     |
    #| 6830d459db3fdce1729dd147| 100009774 | smoke-partialRampOff-test-n | USDC  | ARS     | 10          | 4530000800015017168564 | OPTIMISM        | 0x367b5Aa470049B722ce815b8f9EB66064D0415d4 | USDC   | 5     |

    @Smoke @RampOfft @Exchange @Automated
    Scenario Outline: Flujo E2E Ramp-Off no descubierto para usuario exchange <against>
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        # And Obtain "<against>" balance for "<userAnyId>" user

        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Assign the value "<withdrawAddress>" to the variable "withdrawAddress"
        And Execute the POST method on the endpoint "/v2/synthetics/ramp-off"
        Then Obtain a response 201
        # Parte 2: Generar depósito
        And Execute crypto deposit
        # Parte 2: Validar ejeccución del sintético
        Then Obtain a response 200 and status "COMPLETED" for "ramp" synthetic
        # And Obtain "<against>" balance for "<userAnyId>" user

        Examples:
            | companyId                | userAnyId | sessionId       | asset | against | assetAmount | withdrawAddress        | withdrawNetwork |
            | 684b2f25dcca16d5557fd8b2 | 100011660 | smoke-rampoff-n | USDT  | BRL     | 3           | 53724491875            | ETHEREUM        |
            | 684b2f25dcca16d5557fd8b2 | 100012259 | smoke-rampoff-n | USDT  | CLP     | 3           | 16778957               | ETHEREUM        |
            | 684b2f25dcca16d5557fd8b2 | 100012269 | smoke-rampoff-n | USDT  | GTQ     | 3           | 1234567                | ETHEREUM        |
            | 684b2f25dcca16d5557fd8b2 | 100012270 | smoke-rampoff-n | USDT  | CRC     | 3           | CR88010404046620113218 | ETHEREUM        |
            | 684b2f25dcca16d5557fd8b2 | 100012271 | smoke-rampoff-n | USDT  | MXN     | 3           | 156356784125789654     | ETHEREUM        |
            | 684b2f25dcca16d5557fd8b2 | 100012272 | smoke-rampoff-n | USDT  | PHP     | 3           | 09300164750            | ETHEREUM        |
            | 684b2f25dcca16d5557fd8b2 | 100013985 | smoke-rampoff-n | USDT  | COP     | 3           | 3511234567             | ETHEREUM        |
            | 684b2f25dcca16d5557fd8b2 | 100012268 | smoke-rampoff-n | USDT  | PUSD    | 3           | 0472018417951          | ETHEREUM        |

    @Smoke @RampOn @Exchange @Automated @test
    Scenario Outline: Flujo E2E Ramp-On no descubierto para usuario exchange <against>
        Given Get credentials for company "<companyId>"
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
            | companyId                | userAnyId | sessionId       | asset | against | assetAmount | withdrawAddress                            | withdrawNetwork |
            | 684b2f25dcca16d5557fd8b2 | 100011660 | smoke-rampoff-n | USDC  | BRL     | 10          | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | BASE            |
            | 684b2f25dcca16d5557fd8b2 | 100012259 | smoke-rampoff-n | USDC  | CLP     | 10          | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | BASE            |
            | 684b2f25dcca16d5557fd8b2 | 100012269 | smoke-rampoff-n | USDC  | GTQ     | 10          | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | BASE            |
            | 684b2f25dcca16d5557fd8b2 | 100012270 | smoke-rampoff-n | USDC  | CRC     | 10          | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | BASE            |
            | 684b2f25dcca16d5557fd8b2 | 100012271 | smoke-rampoff-n | USDC  | MXN     | 10          | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | BASE            |
            | 684b2f25dcca16d5557fd8b2 | 100012272 | smoke-rampoff-n | USDC  | PHP     | 10          | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | BASE            |
            | 684b2f25dcca16d5557fd8b2 | 100013985 | smoke-rampoff-n | USDC  | COP     | 10          | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | BASE            |
            | 684b2f25dcca16d5557fd8b2 | 100012268 | smoke-rampoff-n | USDC  | PUSD    | 10          | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | BASE            |
