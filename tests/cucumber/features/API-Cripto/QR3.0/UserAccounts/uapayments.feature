@QR @Regression
Feature: Sintéticos de Pago User Accounts

    @UserAccount @UserBalance @ToBeAutomated
    Scenario Outline: User Account <country>: Ejecutar pago desde balance contra <against>
        Given The API key is available "<apiKEY>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        # Validate initial balance before execute qr payment
        And Obtain "<against>" balance for "<userAnyId>" user
        # Request de lock payment
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<paymentDestination>" to the variable "paymentDestination"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<against>" to the variable "against"
        And Execute the POST method on the endpoint "/v2/payment-locks"
        Then Obtain a response 201 for lock payment
        # Execute synthetic payment
        When Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "true" to the variable "skipDeposit"
        And Assign the value "pixCode" to the variable "pixCode"
        And Execute the POST method on the endpoint "/v2/synthetics/qr-payment"
        Then Obtain a response 201
        And Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic
        # Validate balance after execute qr payment
        And Obtain "<against>" balance for "<userAnyId>" user


        Examples:
            | apiKEY                          | country   | userAnyId | paymentDestination            | amount | sessionId           | against |
            | ZM6WZ67-8X64Z7Q-Q107HW1-0SFG9KK | Argentina | 100056107 | qr3manualamount               | 1000   | QR-UserBalance-V1-n | USDT    |
            | ZM6WZ67-8X64Z7Q-Q107HW1-0SFG9KK | Brasil    | 100056104 | +5511949227612                | 10     | QR-UserBalance-V1-n | USDT    |
            | ZM6WZ67-8X64Z7Q-Q107HW1-0SFG9KK | Colombia  | 100056111 | manteca-breb-qa-manual-amount | 500    | QR-UserBalance-V1-n | USDT    |
            | ZM6WZ67-8X64Z7Q-Q107HW1-0SFG9KK | Bolivia   | 100056108 | qr3BOBmanualamount            | 61.98  | QR-UserBalance-V1-n | USDT    |
            | ZM6WZ67-8X64Z7Q-Q107HW1-0SFG9KK | Peru      | 100056105 | +51986667537                  | 100    | QR-UserBalance-V1-n | USDT    |
            | ZM6WZ67-8X64Z7Q-Q107HW1-0SFG9KK | Argentina | 100056107 | qr3manualamount               | 1000   | QR-UserBalance-V1-n | ARS     |
            | ZM6WZ67-8X64Z7Q-Q107HW1-0SFG9KK | Brasil    | 100056104 | +5511949227612                | 10     | QR-UserBalance-V1-n | BRL     |
            | ZM6WZ67-8X64Z7Q-Q107HW1-0SFG9KK | Colombia  | 100056111 | manteca-breb-qa-manual-amount | 500    | QR-UserBalance-V1-n | COP     |
            | ZM6WZ67-8X64Z7Q-Q107HW1-0SFG9KK | Bolivia   | 100056108 | qr3BOBmanualamount            | 61.98  | QR-UserBalance-V1-n | BOB     |
            | ZM6WZ67-8X64Z7Q-Q107HW1-0SFG9KK | Peru      | 100056105 | +51986667537                  | 100    | QR-UserBalance-V1-n | PEN     |

    @UserAccount @Deposit @ToBeAutomated
    Scenario Outline: User Account <country>: Ejecutar pago mediante deposito cripto contra <against>
        Given The API key is available "<apiKEY>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        And The API secret is available "abc12345"
        # Validate initial balance before execute qr payment
        And Obtain "<against>" balance for "<userAnyId>" user
        # Request de lock payment
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<paymentDestination>" to the variable "paymentDestination"
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
        And The attributes of the QR "<against>" synthetic are validated
        # Execute deposit
        And Execute crypto deposit
        # Get status synthetic payment
        And Obtain a response 200 and status "COMPLETED" for "qr payment" synthetic
        # Validate balance after execute qr payment
        And Obtain "<against>" balance for "<userAnyId>" user

        #QR BOB monto nuy bajo, falla contra USDT
        Examples:
            | apiKEY                          | country   | userAnyId | paymentDestination            | amount | sessionId    | against |
            | 7997ZG9-97042HS-P821399-SGEBCFH | Argentina | 100056114 | qr3manualamount               | 1000   | QR-V2-DESC-n | USDT    |
            | 7997ZG9-97042HS-P821399-SGEBCFH | Brasil    | 100056115 | +5511949227612                | 10     | QR-V2-DESC-n | USDT    |
            | 7997ZG9-97042HS-P821399-SGEBCFH | Bolivia   | 100056117 | qr3BOBmanualamount            | 61.98  | QR-V2-DESC-n | USDT    |
            | 7997ZG9-97042HS-P821399-SGEBCFH | Colombia  | 100056118 | manteca-breb-qa-manual-amount | 500    | QR-V2-DESC-n | USDT    |
            | 7997ZG9-97042HS-P821399-SGEBCFH | Peru      | 100056116 | +51986667537                  | 500    | QR-V2-DESC-n | USDT    |



