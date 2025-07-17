@Deposit
Feature: Depositos

    @Crypto
    Scenario: Generar deposito Crypto
        Given Contar con la api-key "C10XB2Z-AG243CS-G42KB2M-4085WTF"
        And Contar con la api-secret "rcrgtDnGxjY2AYC5qs"
        And Contar con la urlBase "https://sandbox.manteca.dev/crypto"
        When Asignar el valor "<hash>" a la variable "hash"
        And Asignar el valor "<from>" a la variable "from"
        And Asignar el valor "<to>" a la variable "to"
        And Asignar el valor "<wei>" a la variable "wei"
        And Asignar el valor "<human>" a la variable "human"
        And Asignar el valor "<ticker>" a la variable "ticker"
        And Asignar el valor <chain> a la variable "chain"
        And Ejecutar el método Post al endpoint "/v1/transaction/deposit"
        Then Se obtiene una respuesta 201

        Examples:
            | hash | from                                       | to                                         | wei                  | human | ticker | chain |
            | hash | 0x9bD31d82B6212dd60a9328CCe7277161e5975fB5 | 0x449aC40afE7C69e67Ac0321970d72d3107153F30 | 10000000000000000000 | 10    | WLD    | 6     |