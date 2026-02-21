@DepositInfo @Cripto @Integrations @Regression
Feature: Lock Price Integrations

    Background:
        Given The urlBase is available "https://sandbox.manteca.dev/crypto"

    @HappyPath @Smoke @Automated
    Scenario Outline: Validate success deposit info cripto query response for <coin>
        Given The API key is available "<apiKEY>"
        When Assign the value "<coin>" to the variable "coin"
        And Execute the GET method on the endpoint "/v2/info/deposit-info/<coin>?userAnyId=<userAnyId>"
        Then Obtain a response 200
        And Validate deposit info cripto response attributes

        Examples:
            | apiKEY                          | coin | userAnyId |
            | C10XB2Z-AG243CS-G42KB2M-4085WTF | WLD  | 100038447 |
            | C10XB2Z-AG243CS-G42KB2M-4085WTF | USDT | 100038447 |
            | C10XB2Z-AG243CS-G42KB2M-4085WTF | USDC | 100038447 |
