@LockWithdrawCost @Integrations
Feature: Lock Withdraw Cost Integrations

    Background:
        Given The urlBase is available "https://sandbox.manteca.dev/crypto"

    @HappyPath
    Scenario Outline: Validate success lock withdraw cost response
        Given The API key is available "<apiKEY>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<address>" to the variable "address"
        And Assign the value "<network>" to the variable "network"
        And Execute the POST method on the endpoint "/v2/withdraw-locks"
        Then Obtain a response <statusCode>
        And Validate lock withdraw cost response attributes

        Examples:
            | case | apiKEY                          | userAnyId | asset | network  | address                                    | statusCode |
            |      | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 | 100009352 | USDT  | ETHEREUM | 0x7921319332714EBea5c1219439c34309e600DF54 | 201        |
