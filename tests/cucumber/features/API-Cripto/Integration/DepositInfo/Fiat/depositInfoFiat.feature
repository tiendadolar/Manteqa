@DepositInfo @Fiat @Integrations @Regression
Feature: Lock Price Integrations

    Background:
        Given The urlBase is available "https://sandbox.manteca.dev/crypto"

    @HappyPath @Smoke @Automated
    Scenario Outline: Validate success deposit info fiat query response for <coin>
        Given Get credentials for company "<companyId>"
        When Assign the value "<coin>" to the variable "coin"
        And Execute the GET method on the endpoint "/v2/info/deposit-info/<coin>"
        Then Obtain a response 200
        And Validate deposit info fiat response attributes

        Examples:
            | companyId                | coin |
            | 6127ac5e8e7d68001294d6bb | ARS  |
            | 6127ac5e8e7d68001294d6bb | CLP  |
            | 6127ac5e8e7d68001294d6bb | BRL  |
            | 6127ac5e8e7d68001294d6bb | BOB  |
            | 6127ac5e8e7d68001294d6bb | GTQ  |
            | 6127ac5e8e7d68001294d6bb | MXN  |
            | 6127ac5e8e7d68001294d6bb | USD  |
            | 6127ac5e8e7d68001294d6bb | COP  |
