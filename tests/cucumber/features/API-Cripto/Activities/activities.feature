@Activities
Feature: Activities entries

    Scenario Outline: validadr activities
        Given Get credentials for company "<companyId>"
        # And The API secret is available "tNYgnM4sZR2ypkEDnU"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        # Request de lock payment
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<qrCode>" to the variable "qrCode"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<against>" to the variable "against"
        And Execute the POST method on the endpoint "/v2/payment-locks"
        Then Obtain a response 201 for lock payment
        # Execute synthetic payment
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "pixCode" to the variable "pixCode"
        And Execute the POST method on the endpoint "/v2/synthetics/qr-payment"
        Then Obtain a response 201
        And Execute the GET method on the endpoint "/v2/stats/balance-activities?userAnyId=<userAnyId>"
        And Validate entries for activity "<activity>"

        Examples:
            | companyId                | userAnyId | qrCode          | amount | sessionId    | to                                         | against | activity                |
            | 6849d02e906eb70b50893536 | 100013904 | qr3manualamount | 1000   | activities-n | 0x7921319332714EBea5c1219439c34309e600DF54 | ARS     | direct currency payment |
            | 6849d02e906eb70b50893536 | 100013905 | pixmanualamount | 10     | activities-n | 0x7921319332714EBea5c1219439c34309e600DF54 | ARS     | direct currency payment |
