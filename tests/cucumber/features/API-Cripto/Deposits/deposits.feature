@Deposit
Feature: Depositos

    @Crypto
    Scenario: Generar deposito Crypto
        Given The API key is available "C10XB2Z-AG243CS-G42KB2M-4085WTF"
        And The API secret is available "mZJ5r9KCdRjnWCdPJg"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<hash>" to the variable "hash"
        And Assign the value "<from>" to the variable "from"
        And Assign the value "<to>" to the variable "to"
        And Assign the value "<wei>" to the variable "wei"
        And Assign the value "<human>" to the variable "human"
        And Assign the value "<ticker>" to the variable "ticker"
        And Assign the value <chain> to the variable "chain"
        And Execute the POST method on the endpoint "/v1/transaction/deposit"
        Then Obtain a response 201

        Examples:
            | hash | from                                       | to                                         | wei                  | human | ticker | chain |
            | hash | 0x9bD31d82B6212dd60a9328CCe7277161e5975fB5 | 0xb3ee60DA935e0B627614D8FA05cD87c1542d2fdd | 10000000000000000000 | 10    | USDC   | 8     |

    @CryptoAdmin
    Scenario: Generar deposito Crypto
        Given login user admin "<credential>"
        When Assign the value "<hash>" to the variable "hash"
        And Assign the value "<from>" to the variable "from"
        And Assign the value "<to>" to the variable "to"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<ticker>" to the variable "ticker"
        And Assign the value "<chain>" to the variable "chain"
        And Execute crypto admin deposit
        Then Obtain a response 201

        Examples:
            | credential                | hash | from                                       | to                                         | amount | ticker | chain |
            | andresperalta@manteca.dev | hash | 0x9bD31d82B6212dd60a9328CCe7277161e5975fB5 | 0xA6A291F7Dd6770277CfDcd7D332BfDC8E706F71f | 10     | USDT   | 0     |

    @Tron
    Scenario: Generar deposito Crypto by Tron chain
        Given The API key is available "C10XB2Z-AG243CS-G42KB2M-4085WTF"
        And The API secret is available "mZJ5r9KCdRjnWCdPJg"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<hash>" to the variable "hash"
        And Assign the value "<from>" to the variable "from"
        And Assign the value "<to>" to the variable "to"
        And Assign the value "<wei>" to the variable "wei"
        And Assign the value "<human>" to the variable "human"
        And Assign the value "<ticker>" to the variable "ticker"
        And Assign the value <chain> to the variable "chain"
        And Execute the POST method on the endpoint "/v1/transaction/deposit"
        Then Obtain a response 201

        @TRX
        Examples:
            | hash | from                               | to                                 | wei                  | human | ticker | chain |
            | hash | TB32aawPahWHakN9YPCnshYXP5WXnByCPm | TBm3cipnHc7HifuBJdh8JM3nwG3LQJ9UQv | 10000000000000000000 | 10    | TRX    | 9     |

        @USDT
        Examples:
            | hash | from                               | to                                 | wei                  | human | ticker | chain |
            | hash | TB32aawPahWHakN9YPCnshYXP5WXnByCPm | TBm3cipnHc7HifuBJdh8JM3nwG3LQJ9UQv | 10000000000000000000 | 10    | USDT   | 9     |