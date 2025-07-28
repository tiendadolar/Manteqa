@Deposit
Feature: Depositos

    @Crypto
    Scenario: Generar deposito Crypto
        Given The API key is available "C10XB2Z-AG243CS-G42KB2M-4085WTF"
        And The API secret is available "nuuF1NYpuhCxAx7H7d"
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
            | hash | 0x9bD31d82B6212dd60a9328CCe7277161e5975fB5 | 0x8B19E15AB79c8FcfCD0A86831471d183411d95F2 | 10000000000000000000 | 10    | WLD    | 6     |