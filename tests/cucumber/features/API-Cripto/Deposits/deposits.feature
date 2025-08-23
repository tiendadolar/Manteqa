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
            | hash | 0x9bD31d82B6212dd60a9328CCe7277161e5975fB5 | 0x450f1DC0C7Bfcf3bA321B7d6cb57cEC2D73a22eC | 10000000000000000000 | 10    | USDT   | 0     |

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
            | hash | TB32aawPahWHakN9YPCnshYXP5WXnByCPm | TK87U6EA5Fyq1zLZc9Q6NEeasHtTTRMaLu | 10000000000000000000 | 10    | TRX    | 9     |

        @USDT
        Examples:
            | hash | from                               | to                                 | wei                  | human | ticker | chain |
            | hash | TB32aawPahWHakN9YPCnshYXP5WXnByCPm | TK87U6EA5Fyq1zLZc9Q6NEeasHtTTRMaLu | 10000000000000000000 | 10    | USDT   | 9     |