@QR @Regression
Feature: Sintéticos de Pago Principal Accounts

    @PpalAccount @UserBalance @ToBeAutomated
    Scenario Outline: Principal Account <country>: Ejecutar pago desde balance contra <against>
        Given The API key is available "<apiKEY>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        # Validate initial balance before execute qr payment
        And Obtain "<against>" balance for "<userAnyId>" user
        # Request de lock payment
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<paymentDestination>" to the variable "paymentDestination"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<exchange>" to the variable "exchange"
        And Assign the value "<legalId>" to the variable "legalId"
        And Assign the value "<name>" to the variable "name"
        And Assign the value "<surname>" to the variable "surname"
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
            | apiKEY                          | country   | userAnyId | paymentDestination            | amount    | sessionId           | against | exchange  | legalId       | name    | surname |
            | ZM6WZ67-8X64Z7Q-Q107HW1-0SFG9KK | Argentina | 100056098 | qr3manualamount               | 1000      | QR-UserBalance-V1-n | USDT    | BRAZIL    | 731.443.71149 | MIGUEL  | ACOSTA  |
            | ZM6WZ67-8X64Z7Q-Q107HW1-0SFG9KK | Brasil    | 100056099 | +5511949227612                | 10        | QR-UserBalance-V1-n | USDT    | BRAZIL    | 731.443.71149 | MIGUEL  | ACOSTA  |
            | ZM6WZ67-8X64Z7Q-Q107HW1-0SFG9KK | Colombia  | 100056101 | manteca-breb-qa-manual-amount | 500       | QR-UserBalance-V1-n | USDT    | BRAZIL    | 731.443.71149 | MIGUEL  | ACOSTA  |
            | ZM6WZ67-8X64Z7Q-Q107HW1-0SFG9KK | Bolivia   | 100056102 | qr3BOBmanualamount            | 61.980000 | QR-UserBalance-V1-n | USDT    | BRAZIL    | 731.443.71149 | MIGUEL  | ACOSTA  |
            | ZM6WZ67-8X64Z7Q-Q107HW1-0SFG9KK | Argentina | 100056098 | qr3manualamount               | 1000      | QR-UserBalance-V1-n | ARS     | ARGENTINA | 20167417435   | MARIO   | ABBADI  |
            | ZM6WZ67-8X64Z7Q-Q107HW1-0SFG9KK | Brasil    | 100056099 | +5511949227612                | 10        | QR-UserBalance-V1-n | BRL     | BRAZIL    | 731.443.71149 | MIGUEL  | ACOSTA  |
            | ZM6WZ67-8X64Z7Q-Q107HW1-0SFG9KK | Colombia  | 100056101 | manteca-breb-qa-manual-amount | 500       | QR-UserBalance-V1-n | COP     | COLOMBIA  | 1.977.392     | ROGER   | SANCHEZ |
            | ZM6WZ67-8X64Z7Q-Q107HW1-0SFG9KK | Bolivia   | 100056102 | qr3BOBmanualamount            | 61.980000 | QR-UserBalance-V1-n | BOB     | BOLIVIA   | 4563732       | ABRAHAM | GARCIA  |


    @PpalAccount @UserBalance @ToBeAutomated
    Scenario Outline: Principal Account <country>: Ejecutar pago desde balance contra <against>
        Given The API key is available "<apiKEY>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        # Validate initial balance before execute qr payment
        And Obtain "<against>" balance for "<userAnyId>" user
        # Request de lock payment
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<paymentDestination>" to the variable "paymentDestination"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<exchange>" to the variable "exchange"
        And Assign the value "<legalId>" to the variable "legalId"
        And Assign the value "<name>" to the variable "name"
        And Assign the value "<surname>" to the variable "surname"
        And Assign the value "<work>" to the variable "work"
        And Assign the value "<email>" to the variable "email"
        And Assign the value "<phoneNumber>" to the variable "phoneNumber"
        And Assign the value "<gender>" to the variable "gender"
        And Assign the value "<birthDate>" to the variable "birthDate"
        And Assign the value "<street>" to the variable "street"
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
            | apiKEY                          | country | userAnyId | paymentDestination | amount | sessionId           | against | exchange | legalId       | name   | surname | work     | email              | phoneNumber  | gender | street         | birthDate  |
            | ZM6WZ67-8X64Z7Q-Q107HW1-0SFG9KK | Peru    | 100056100 | +51986667537       | 100    | QR-UserBalance-V1-n | USDT    | BRAZIL   | 731.443.71149 | MIGUEL | ACOSTA  | EMPLEADO | polanque@gmail.com | +51953605263 | MALE   | Av. Corrientes | 1960-05-06 |
            | ZM6WZ67-8X64Z7Q-Q107HW1-0SFG9KK | Peru    | 100056100 | +51986667537       | 100    | QR-UserBalance-V1-n | PEN     | PERU     | 74162704      | ALICIA | ALCARAZ | EMPLEADO | polanque@gmail.com | +51953605263 | MALE   | Av. Corrientes | 1960-05-06 |


    @PpalAccount @Deposit @ToBeAutomated
    Scenario Outline: Principal Account <country>: Ejecutar pago mediante deposito cripto contra <against>
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
        And Assign the value "<exchange>" to the variable "exchange"
        And Assign the value "<legalId>" to the variable "legalId"
        And Assign the value "<name>" to the variable "name"
        And Assign the value "<surname>" to the variable "surname"
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
            | apiKEY                          | country   | userAnyId | paymentDestination            | amount | sessionId    | against | exchange | legalId       | name   | surname |
            | 7997ZG9-97042HS-P821399-SGEBCFH | Argentina | 100055871 | qr3manualamount               | 1000   | QR-V2-DESC-n | USDT    | BRAZIL   | 731.443.71149 | MIGUEL | ACOSTA  |
            | 7997ZG9-97042HS-P821399-SGEBCFH | Brasil    | 100055872 | +5511949227612                | 10     | QR-V2-DESC-n | USDT    | BRAZIL   | 731.443.71149 | MIGUEL | ACOSTA  |
            | 7997ZG9-97042HS-P821399-SGEBCFH | Colombia  | 100055874 | manteca-breb-qa-manual-amount | 500    | QR-V2-DESC-n | USDT    | BRAZIL   | 731.443.71149 | MIGUEL | ACOSTA  |
            | 7997ZG9-97042HS-P821399-SGEBCFH | Bolivia   | 100055875 | qr3BOBmanualamount            | 61.98  | QR-V2-DESC-n | USDT    | BRAZIL   | 731.443.71149 | MIGUEL | ACOSTA  |

    @PpalAccount @Deposit @ToBeAutomated
    Scenario Outline: Principal Account <country>: Ejecutar pago mediante deposito cripto contra <against>
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
        And Assign the value "<exchange>" to the variable "exchange"
        And Assign the value "<legalId>" to the variable "legalId"
        And Assign the value "<name>" to the variable "name"
        And Assign the value "<surname>" to the variable "surname"
        And Assign the value "<work>" to the variable "work"
        And Assign the value "<email>" to the variable "email"
        And Assign the value "<phoneNumber>" to the variable "phoneNumber"
        And Assign the value "<gender>" to the variable "gender"
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
            | apiKEY                          | country | userAnyId | paymentDestination | amount | sessionId    | against | exchange | legalId  | name   | surname | work     | email              | phoneNumber  | gender |
            | 7997ZG9-97042HS-P821399-SGEBCFH | Peru    | 100055873 | +51986667537       | 500    | QR-V2-DESC-n | USDT    | PERU     | 74162704 | ALICIA | ALCARAZ | EMPLEADO | polanque@gmail.com | +51953605263 | MALE   |