@SyntheticApiCambio
Feature: Sintéticos API-Cambio

    @Syn @RampOnDesc
    Scenario: Creación de sintético Ramp-On API-Cambio en descubierto
        Given The API key is available "66ce-7686-b472-6cac-4430-13db-9654-009a-6b88bc83"
        And The urlBase is available "https://sandbox.manteca.dev/cambio"
        When Assign the value "681df60f8dffa19a1c05d4ab" to the variable "userAnyId"
        And Assign the value "automation-test-n" to the variable "sessionId"
        And Assign the value "DIRECT" to the variable "type"
        And Assign the value "USD" to the variable "asset"
        And Assign the value "ARS" to the variable "against"
        And Assign the value "7" to the variable "assetAmount"
        And Assign the value "0000003100075086465852" to the variable "withdrawAddress"
        And Execute the POST method on the endpoint "/v3/synthetics/ramp-on"
        Then Obtain a response 201

    @Syn @RampOffDesc
    Scenario: Creación de sintético Ramp-Off API-Cambio en descubierto
        Given The API key is available "66ce-7686-b472-6cac-4430-13db-9654-009a-6b88bc83"
        And The urlBase is available "https://sandbox.manteca.dev/cambio"
        When Assign the value "681df60f8dffa19a1c05d4ab" to the variable "userAnyId"
        And Assign the value "automation-test-n" to the variable "sessionId"
        And Assign the value "DIRECT" to the variable "type"
        And Assign the value "USD" to the variable "asset"
        And Assign the value "ARS" to the variable "against"
        And Assign the value "7" to the variable "assetAmount"
        And Assign the value "0000003100000341514293" to the variable "withdrawAddress"
        And Execute the POST method on the endpoint "/v3/synthetics/ramp-off"
        Then Obtain a response 201

    @Syn @RampOn
    Scenario: Creación de sintético Ramp-On API-Cambio no descubierto
        Given The API key is available "bc0f-6187-d2c1-67e7-5f88-5504-075a-caa8-66c24e68"
        And The urlBase is available "https://sandbox.manteca.dev/cambio"
        When Assign the value "681e3fedad113b8233600f1d" to the variable "userAnyId"
        And Assign the value "automation-test-n" to the variable "sessionId"
        And Assign the value "DIRECT" to the variable "type"
        And Assign the value "USD" to the variable "asset"
        And Assign the value "ARS" to the variable "against"
        And Assign the value "7" to the variable "assetAmount"
        And Assign the value "0000003100075086465852" to the variable "withdrawAddress"
        And Execute the POST method on the endpoint "/v3/synthetics/ramp-on"
        Then Obtain a response 201

    @Syn @RampOn @Deposit
    Scenario: Realizar deposito fiat ARS
        Given The token is available "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjowLCJjb21wYW55SWQiOiI2NjEwNDVjNzVhZTUwZjE5YzUzOTIxZmQiLCJpZCI6IjY4MDJhMGVmMTJhNWI4MzY4ODk1ZThiMyIsImVtYWlsIjoiYW5keUB0aWVuZGFkb2xhci5jb20iLCJpYXQiOjE3NDY5OTk3NjksImV4cCI6MTc0NzAyMTM2OSwiaXNzIjoiVGllbmRhRG9sYXIifQ.QTwvwpMyyo-rRJuf9VOrOSE0hTZZEN7BP1FzlzTe3JUSfYebglMQBYs-idX0eBCPHCZAZAYq3UcJXes8Y1WS7eXDp8dHuCMCDeSkYaTqO66m5nsNAoYHwxgcx9ksj4wIEZCJeDQetCOXl5OpTdNyxug5t2XqhetWiegO6He0dDv0jXdLPO6Tyt_Q-jWl1m0cEVSAigGVaLyw4ZW9APmtNTBP8mpMrZI3WN-1DaK0zO3w0oOFrNE1PaWWDY5s28vTM6VeiP5yp0szBFqDuLwWYyRWfyMEyn1VDWK4E0ZLqPx9TngTc_ZYerXPa9GRtZrjMmYoJRedHSHlPiCr1RHQWAtltNM3Y-72HwvKODCiWE0ql1EFqeH_yhoCRSGqVVauN5fSEDKm8LD0YDhYNaysBgVfK7lTNoJVmIj-PtBfqYvCGbNro-1Y6JbBgfnAdxKmcICIOMAMW3X1M6JYrpTHaW9hiPD7oNRoY19Qe-zZYdaiT0CpTlD14DSSMLeoJiwOvdtiKtTQ0rkkYuLOhEsJdB0eYHKOGhu8ATERjV5GHOLDrl2pAWpwH-I71E2Uzz3yJEgCyLnehomX_o7WjB86q866P0wacRGqbRUrpNp7974FKRJWu6LYurJXWR3NIGOIWLGda6pwadnUzOdbTGSLF0IoOMFVsr7twoLESRrLlbo"
        And The urlBase is available "https://sandbox.manteca.dev/cambio"
        When Assign the value "681e3eef53061c3925f3556c" to the variable "companyId"
        And Assign the value "123" to the variable "networkId"
        And Assign the value "681e3fedad113b8233600f1d" to the variable "userId"
        And Assign the value "0000003100075086465852" to the variable "source"
        And Assign the value "27367026788" to the variable "legalId"
        And Assign the value "coin" to the variable "coin"
        And Assign the value "amount" to the variable "amount"
        And Execute the POST method on the endpoint "/v3/admin/banking/deposit"
        Then Obtain a response 201

    @Syn @RampOff
    Scenario: Creación de sintético Ramp-Off API-Cambio no descubierto
        Given The API key is available "bc0f-6187-d2c1-67e7-5f88-5504-075a-caa8-66c24e68"
        And The urlBase is available "https://sandbox.manteca.dev/cambio"
        When Assign the value "681e3fedad113b8233600f1d" to the variable "userAnyId"
        And Assign the value "automation-test-n" to the variable "sessionId"
        And Assign the value "DIRECT" to the variable "type"
        And Assign the value "USD" to the variable "asset"
        And Assign the value "ARS" to the variable "against"
        And Assign the value "7" to the variable "assetAmount"
        And Assign the value "0000003100000341514293" to the variable "withdrawAddress"
        And Execute the POST method on the endpoint "/v3/synthetics/ramp-off"
        Then Obtain a response 201

    @Syn @RampOff @Deposit
    Scenario: Realizar deposito fiat USD
        Given The token is available "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjowLCJjb21wYW55SWQiOiI2NjEwNDVjNzVhZTUwZjE5YzUzOTIxZmQiLCJpZCI6IjY4MDJhMGVmMTJhNWI4MzY4ODk1ZThiMyIsImVtYWlsIjoiYW5keUB0aWVuZGFkb2xhci5jb20iLCJpYXQiOjE3NDY5OTk3NjksImV4cCI6MTc0NzAyMTM2OSwiaXNzIjoiVGllbmRhRG9sYXIifQ.QTwvwpMyyo-rRJuf9VOrOSE0hTZZEN7BP1FzlzTe3JUSfYebglMQBYs-idX0eBCPHCZAZAYq3UcJXes8Y1WS7eXDp8dHuCMCDeSkYaTqO66m5nsNAoYHwxgcx9ksj4wIEZCJeDQetCOXl5OpTdNyxug5t2XqhetWiegO6He0dDv0jXdLPO6Tyt_Q-jWl1m0cEVSAigGVaLyw4ZW9APmtNTBP8mpMrZI3WN-1DaK0zO3w0oOFrNE1PaWWDY5s28vTM6VeiP5yp0szBFqDuLwWYyRWfyMEyn1VDWK4E0ZLqPx9TngTc_ZYerXPa9GRtZrjMmYoJRedHSHlPiCr1RHQWAtltNM3Y-72HwvKODCiWE0ql1EFqeH_yhoCRSGqVVauN5fSEDKm8LD0YDhYNaysBgVfK7lTNoJVmIj-PtBfqYvCGbNro-1Y6JbBgfnAdxKmcICIOMAMW3X1M6JYrpTHaW9hiPD7oNRoY19Qe-zZYdaiT0CpTlD14DSSMLeoJiwOvdtiKtTQ0rkkYuLOhEsJdB0eYHKOGhu8ATERjV5GHOLDrl2pAWpwH-I71E2Uzz3yJEgCyLnehomX_o7WjB86q866P0wacRGqbRUrpNp7974FKRJWu6LYurJXWR3NIGOIWLGda6pwadnUzOdbTGSLF0IoOMFVsr7twoLESRrLlbo"
        And The urlBase is available "https://sandbox.manteca.dev/cambio"
        When Assign the value "0000003100000341514293" to the variable "companyId" 
        And Assign the value "123" to the variable "networkId"
        And Assign the value "681e3fedad113b8233600f1d" to the variable "userId"
        And Assign the value "0000003100075086465852" to the variable "source"
        And Assign the value "27367026788" to the variable "legalId"
        And Assign the value "coin" to the variable "coin"
        And Assign the value "amount" to the variable "amount"
        And Execute the POST method on the endpoint "/v3/admin/banking/deposit"
        Then Obtain a response 201

# #Datos utilizados
# | company               | apikey                                           | companyId                | userAnyId                | opera          |
# | Company Orders (Desc) | 66ce-7686-b472-6cac-4430-13db-9654-009a-6b88bc83 | 6812e5c9da0292039eb0fc71 | 681df60f8dffa19a1c05d4ab | DESCUBIERTO    |
# | Company Orders NoDesc | bc0f-6187-d2c1-67e7-5f88-5504-075a-caa8-66c24e68 | 681e3eef53061c3925f3556c | 681e3fedad113b8233600f1d | NO DESCUBIERTO |



