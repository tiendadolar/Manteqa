@DepositInfo @Fiat @Integrations @Regression
Feature: Lock Price Integrations

    Background:
        Given The urlBase is available "https://sandbox.manteca.dev/crypto"

    @HappyPath @Smoke @Automated
    Scenario Outline: Validate success deposit info query response for <coin>
        Given The API key is available "<apiKEY>"
        When Assign the value "<coin>" to the variable "coin"
        And Execute the GET method on the endpoint "/v2/info/deposit-info/<coin>"
        Then Obtain a response 200
        And Validate deposit info fiat response attributes

        Examples:
            | apiKEY                          | coin |
            | C10XB2Z-AG243CS-G42KB2M-4085WTF | ARS  |
            | C10XB2Z-AG243CS-G42KB2M-4085WTF | CLP  |
            | C10XB2Z-AG243CS-G42KB2M-4085WTF | BRL  |
            | C10XB2Z-AG243CS-G42KB2M-4085WTF | BOB  |
            | C10XB2Z-AG243CS-G42KB2M-4085WTF | GTQ  |
            | C10XB2Z-AG243CS-G42KB2M-4085WTF | MXN  |
            | C10XB2Z-AG243CS-G42KB2M-4085WTF | USD  |
            | C10XB2Z-AG243CS-G42KB2M-4085WTF | COP  |
