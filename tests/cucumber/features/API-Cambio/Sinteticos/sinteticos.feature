@SyntheticApiCambio
Feature: Sintéticos API-Cambio

    @Syn @RampOnDesc
    Scenario: Creación de sintético Ramp-On API-Cambio en descubierto
        Given Contar con la api-key "66ce-7686-b472-6cac-4430-13db-9654-009a-6b88bc83"
        And Contar con la urlBase "https://sandbox.manteca.dev/cambio"
        When Asignar el valor "681df60f8dffa19a1c05d4ab" a la variable "userAnyId"
        And Asignar el valor "automation-test-n" a la variable "sessionId"
        And Asignar el valor "DIRECT" a la variable "type"
        And Asignar el valor "USD" a la variable "asset"
        And Asignar el valor "ARS" a la variable "against"
        And Asignar el valor "7" a la variable "assetAmount"
        And Asignar el valor "0000003100075086465852" a la variable "withdrawAddress"
        And Ejecutar el método Post al endpoint "/v3/synthetics/ramp-on"
        Then Se obtiene una respuesta 201

    @Syn @RampOffDesc
    Scenario: Creación de sintético Ramp-Off API-Cambio en descubierto
        Given Contar con la api-key "66ce-7686-b472-6cac-4430-13db-9654-009a-6b88bc83"
        And Contar con la urlBase "https://sandbox.manteca.dev/cambio"
        When Asignar el valor "681df60f8dffa19a1c05d4ab" a la variable "userAnyId"
        And Asignar el valor "automation-test-n" a la variable "sessionId"
        And Asignar el valor "DIRECT" a la variable "type"
        And Asignar el valor "USD" a la variable "asset"
        And Asignar el valor "ARS" a la variable "against"
        And Asignar el valor "7" a la variable "assetAmount"
        And Asignar el valor "0000003100000341514293" a la variable "withdrawAddress"
        And Ejecutar el método Post al endpoint "/v3/synthetics/ramp-off"
        Then Se obtiene una respuesta 201

    @Syn @RampOn
    Scenario: Creación de sintético Ramp-On API-Cambio no descubierto
        Given Contar con la api-key "bc0f-6187-d2c1-67e7-5f88-5504-075a-caa8-66c24e68"
        And Contar con la urlBase "https://sandbox.manteca.dev/cambio"
        When Asignar el valor "681e3fedad113b8233600f1d" a la variable "userAnyId"
        And Asignar el valor "automation-test-n" a la variable "sessionId"
        And Asignar el valor "DIRECT" a la variable "type"
        And Asignar el valor "USD" a la variable "asset"
        And Asignar el valor "ARS" a la variable "against"
        And Asignar el valor "7" a la variable "assetAmount"
        And Asignar el valor "0000003100075086465852" a la variable "withdrawAddress"
        And Ejecutar el método Post al endpoint "/v3/synthetics/ramp-on"
        Then Se obtiene una respuesta 201

    @Syn @RampOn @Deposit
    Scenario: Realizar deposito fiat ARS
        Given Contar con el token "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjowLCJjb21wYW55SWQiOiI2NjEwNDVjNzVhZTUwZjE5YzUzOTIxZmQiLCJpZCI6IjY4MDJhMGVmMTJhNWI4MzY4ODk1ZThiMyIsImVtYWlsIjoiYW5keUB0aWVuZGFkb2xhci5jb20iLCJpYXQiOjE3NDY5OTk3NjksImV4cCI6MTc0NzAyMTM2OSwiaXNzIjoiVGllbmRhRG9sYXIifQ.QTwvwpMyyo-rRJuf9VOrOSE0hTZZEN7BP1FzlzTe3JUSfYebglMQBYs-idX0eBCPHCZAZAYq3UcJXes8Y1WS7eXDp8dHuCMCDeSkYaTqO66m5nsNAoYHwxgcx9ksj4wIEZCJeDQetCOXl5OpTdNyxug5t2XqhetWiegO6He0dDv0jXdLPO6Tyt_Q-jWl1m0cEVSAigGVaLyw4ZW9APmtNTBP8mpMrZI3WN-1DaK0zO3w0oOFrNE1PaWWDY5s28vTM6VeiP5yp0szBFqDuLwWYyRWfyMEyn1VDWK4E0ZLqPx9TngTc_ZYerXPa9GRtZrjMmYoJRedHSHlPiCr1RHQWAtltNM3Y-72HwvKODCiWE0ql1EFqeH_yhoCRSGqVVauN5fSEDKm8LD0YDhYNaysBgVfK7lTNoJVmIj-PtBfqYvCGbNro-1Y6JbBgfnAdxKmcICIOMAMW3X1M6JYrpTHaW9hiPD7oNRoY19Qe-zZYdaiT0CpTlD14DSSMLeoJiwOvdtiKtTQ0rkkYuLOhEsJdB0eYHKOGhu8ATERjV5GHOLDrl2pAWpwH-I71E2Uzz3yJEgCyLnehomX_o7WjB86q866P0wacRGqbRUrpNp7974FKRJWu6LYurJXWR3NIGOIWLGda6pwadnUzOdbTGSLF0IoOMFVsr7twoLESRrLlbo"
        And Contar con la urlBase "https://sandbox.manteca.dev/cambio"
        When Asignar el valor "681e3eef53061c3925f3556c" a la variable "companyId"
        And Asignar el valor "123" a la variable "networkId"
        And Asignar el valor "681e3fedad113b8233600f1d" a la variable "userId"
        And Asignar el valor "0000003100075086465852" a la variable "source"
        And Asignar el valor "27367026788" a la variable "legalId"
        And Asignar el valor "coin" a la variable "coin"
        And Asignar el valor "amount" a la variable "amount"
        And Ejecutar el método Post al endpoint "/v3/admin/banking/deposit"
        Then Se obtiene una respuesta 201

    @Syn @RampOff
    Scenario: Creación de sintético Ramp-Off API-Cambio no descubierto
        Given Contar con la api-key "bc0f-6187-d2c1-67e7-5f88-5504-075a-caa8-66c24e68"
        And Contar con la urlBase "https://sandbox.manteca.dev/cambio"
        When Asignar el valor "681e3fedad113b8233600f1d" a la variable "userAnyId"
        And Asignar el valor "automation-test-n" a la variable "sessionId"
        And Asignar el valor "DIRECT" a la variable "type"
        And Asignar el valor "USD" a la variable "asset"
        And Asignar el valor "ARS" a la variable "against"
        And Asignar el valor "7" a la variable "assetAmount"
        And Asignar el valor "0000003100000341514293" a la variable "withdrawAddress"
        And Ejecutar el método Post al endpoint "/v3/synthetics/ramp-off"
        Then Se obtiene una respuesta 201

    @Syn @RampOff @Deposit
    Scenario: Realizar deposito fiat USD
        Given Contar con el token "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjowLCJjb21wYW55SWQiOiI2NjEwNDVjNzVhZTUwZjE5YzUzOTIxZmQiLCJpZCI6IjY4MDJhMGVmMTJhNWI4MzY4ODk1ZThiMyIsImVtYWlsIjoiYW5keUB0aWVuZGFkb2xhci5jb20iLCJpYXQiOjE3NDY5OTk3NjksImV4cCI6MTc0NzAyMTM2OSwiaXNzIjoiVGllbmRhRG9sYXIifQ.QTwvwpMyyo-rRJuf9VOrOSE0hTZZEN7BP1FzlzTe3JUSfYebglMQBYs-idX0eBCPHCZAZAYq3UcJXes8Y1WS7eXDp8dHuCMCDeSkYaTqO66m5nsNAoYHwxgcx9ksj4wIEZCJeDQetCOXl5OpTdNyxug5t2XqhetWiegO6He0dDv0jXdLPO6Tyt_Q-jWl1m0cEVSAigGVaLyw4ZW9APmtNTBP8mpMrZI3WN-1DaK0zO3w0oOFrNE1PaWWDY5s28vTM6VeiP5yp0szBFqDuLwWYyRWfyMEyn1VDWK4E0ZLqPx9TngTc_ZYerXPa9GRtZrjMmYoJRedHSHlPiCr1RHQWAtltNM3Y-72HwvKODCiWE0ql1EFqeH_yhoCRSGqVVauN5fSEDKm8LD0YDhYNaysBgVfK7lTNoJVmIj-PtBfqYvCGbNro-1Y6JbBgfnAdxKmcICIOMAMW3X1M6JYrpTHaW9hiPD7oNRoY19Qe-zZYdaiT0CpTlD14DSSMLeoJiwOvdtiKtTQ0rkkYuLOhEsJdB0eYHKOGhu8ATERjV5GHOLDrl2pAWpwH-I71E2Uzz3yJEgCyLnehomX_o7WjB86q866P0wacRGqbRUrpNp7974FKRJWu6LYurJXWR3NIGOIWLGda6pwadnUzOdbTGSLF0IoOMFVsr7twoLESRrLlbo"
        And Contar con la urlBase "https://sandbox.manteca.dev/cambio"
        When Asignar el valor "0000003100000341514293" a la variable "companyId" 
        And Asignar el valor "123" a la variable "networkId"
        And Asignar el valor "681e3fedad113b8233600f1d" a la variable "userId"
        And Asignar el valor "0000003100075086465852" a la variable "source"
        And Asignar el valor "27367026788" a la variable "legalId"
        And Asignar el valor "coin" a la variable "coin"
        And Asignar el valor "amount" a la variable "amount"
        And Ejecutar el método Post al endpoint "/v3/admin/banking/deposit"
        Then Se obtiene una respuesta 201

# #Datos utilizados
# | company               | apikey                                           | companyId                | userAnyId                | opera          |
# | Company Orders (Desc) | 66ce-7686-b472-6cac-4430-13db-9654-009a-6b88bc83 | 6812e5c9da0292039eb0fc71 | 681df60f8dffa19a1c05d4ab | DESCUBIERTO    |
# | Company Orders NoDesc | bc0f-6187-d2c1-67e7-5f88-5504-075a-caa8-66c24e68 | 681e3eef53061c3925f3556c | 681e3fedad113b8233600f1d | NO DESCUBIERTO |



