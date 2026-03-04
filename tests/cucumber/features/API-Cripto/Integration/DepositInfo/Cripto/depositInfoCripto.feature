@DepositInfo @Cripto @Integrations @Regression
Feature: Lock Price Integrations

    Background:
        Given The urlBase is available "https://sandbox.manteca.dev/crypto"

    @HappyPath @Smoke @Automated
    Scenario Outline: Validate success deposit info cripto query response for <coin>
        Given Get credentials for company "<companyId>"
        When Assign the value "<coin>" to the variable "coin"
        And Execute the GET method on the endpoint "/v2/info/deposit-info/<coin>?userAnyId=<userAnyId>"
        Then Obtain a response 200
        And Validate deposit info cripto response attributes

        Examples:
            | companyId                | coin | userAnyId |
            | 6127ac5e8e7d68001294d6bb | WLD  | 100038447 |
            | 6127ac5e8e7d68001294d6bb | USDT | 100038447 |
            | 6127ac5e8e7d68001294d6bb | USDC | 100038447 |
