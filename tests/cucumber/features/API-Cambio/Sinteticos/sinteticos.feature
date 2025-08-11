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


    Scenario Outline: Ejecutar sintetico ramp-on api-cambio no descubierto
        Given The API key is available "bd69-f82c-c372-5bb6-3248-45e9-99f5-5035-7581106d"
        And The urlBase is available "https://sandbox.manteca.dev/cambio"
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "automation-test-n" to the variable "sessionId"
        And Assign the value "<type>" to the variable "type"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Assign the value "<withdrawAddress>" to the variable "withdrawAddress"
        And Execute the POST method on the endpoint "/v3/synthetics/ramp-on"
        Then Obtain a response 201

        Given The token is available "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjowLCJjb21wYW55SWQiOiI2NjEwNDVjNzVhZTUwZjE5YzUzOTIxZmQiLCJpZCI6IjY4MDJhMGVmMTJhNWI4MzY4ODk1ZThiMyIsImVtYWlsIjoiYW5keUB0aWVuZGFkb2xhci5jb20iLCJpYXQiOjE3NTQ0MTg0NDgsImV4cCI6MTc1NDQ0MDA0OCwiaXNzIjoiVGllbmRhRG9sYXIifQ.A_jIOvQWA4aV5KmEEC6BOd_gly9rr3XkfGcoSj8bPhDZqjD7Rpfud1F-ExyNarCZIz8voSn3hyIa3IxCQmOShTpPaDSvJblvOqnAC-h6nXkZ5pdwrLDyk3Ei3WL5yEHevk5Ftg-XkbbKdP2pl2yxdHmftsHJ5_4Q0XH_KpSa66IuEnormem3Kt2brU2jxmtBPK_V3wgmKNLOaljGtFW3bD8zoTiLr4xdVv9lnEfVEGsqLFlkGis7j0wwFv8LphhXyYf7zwiTgmCsiYkJMyeH821ddqoG0a1qPSWzPnLCPa7nX1nrlF6U9krvMmZo-Ldk2kVm_gZw8FqZuza0K8Sg_AhXM0pm12oe_HBiMDNnBLvRcFLqR-0iZIONIJBxitgiB9pd8nCcYwaubtXPt0-u1h_HY3PNb78B0alVVnkNAAHf0jN342IzuClZRjLfJsnGf3eVBwwvFJsPYM124eLLGjBofBrgVDBLPjiNRoUvUgbmOK-GGNoREm0scZIKtBayYaTmZKmPoXNyM7KgQypNRj45OoG_Swj9nChwn8KYZZBA5mhJeSRppO3xMOoEoQY0FI_yl-mk-_RxJKzutTOO7h6WvmTGWtsi_UVkV1h_u9iK7jGd9-BdZ1k7B7ZQq1vcfMeUwefPU4907QBS88i5Lhxh2sBpnzCi4JB7Sp2drJo"
        And The urlBase is available "https://sandbox.manteca.dev/cambio"
        When Assign the value "681e3eef53061c3925f3556c" to the variable "companyId"
        And Assign the value "123" to the variable "networkId"
        And Assign the value "<userAnyId>" to the variable "userId"
        And Assign the value "<source>" to the variable "source"
        And Assign the value "<legalId>" to the variable "legalId"
        And Assign the value "<coin>" to the variable "coin"
        And Assign the value "<amount>" to the variable "amount"
        And Execute the POST method on the endpoint "/v3/admin/banking/deposit"
        Then Obtain a response 201

        Given The API key is available "bd69-f82c-c372-5bb6-3248-45e9-99f5-5035-7581106d"
        And The urlBase is available "https://sandbox.manteca.dev/cambio"
        When Wait for the processing of the "orden" por 5 seconds
        And Execute the GET method on the endpoint "/v3/synthetics/{syntheticId}"
        Then Obtain a response 200 y status COMPLETED

        Examples:
            | userAnyId                | type   | asset | against | assetAmount | withdrawAddress | source        | legalId     | coin | amount |
            | 6823694a6ebe42f301e4dad1 | DIRECT | USD   | ARS     | 10          | lean.gara.usd   | lean.gara.ars | 27265941236 | ARS  | 1      |
            | 6823694a6ebe42f301e4dad1 | DIRECT | USD   | ARS     | 1.5         | lean.gara.usd   | lean.gara.ars | 27265941236 | ARS  | 1      |
            | 6823694a6ebe42f301e4dad1 | DIRECT | USD   | ARS     | 100.12      | lean.gara.usd   | lean.gara.ars | 27265941236 | ARS  | 1      |
            | 6823694a6ebe42f301e4dad1 | DIRECT | USD   | ARS     | 51.795      | lean.gara.usd   | lean.gara.ars | 27265941236 | ARS  | 1      |

    @E2E
    Scenario Outline: Ejecutar sintetico ramp-off api-cambio no descubierto
        Given The API key is available "bd69-f82c-c372-5bb6-3248-45e9-99f5-5035-7581106d"
        And The urlBase is available "https://sandbox.manteca.dev/cambio"
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "automation-test-n" to the variable "sessionId"
        And Assign the value "<type>" to the variable "type"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Assign the value "<withdrawAddress>" to the variable "withdrawAddress"
        And Execute the POST method on the endpoint "/v3/synthetics/ramp-off"
        Then Obtain a response 201

        Given The token is available "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjowLCJjb21wYW55SWQiOiI2NjEwNDVjNzVhZTUwZjE5YzUzOTIxZmQiLCJpZCI6IjY4MDJhMGVmMTJhNWI4MzY4ODk1ZThiMyIsImVtYWlsIjoiYW5keUB0aWVuZGFkb2xhci5jb20iLCJpYXQiOjE3NTQ0MTg0NDgsImV4cCI6MTc1NDQ0MDA0OCwiaXNzIjoiVGllbmRhRG9sYXIifQ.A_jIOvQWA4aV5KmEEC6BOd_gly9rr3XkfGcoSj8bPhDZqjD7Rpfud1F-ExyNarCZIz8voSn3hyIa3IxCQmOShTpPaDSvJblvOqnAC-h6nXkZ5pdwrLDyk3Ei3WL5yEHevk5Ftg-XkbbKdP2pl2yxdHmftsHJ5_4Q0XH_KpSa66IuEnormem3Kt2brU2jxmtBPK_V3wgmKNLOaljGtFW3bD8zoTiLr4xdVv9lnEfVEGsqLFlkGis7j0wwFv8LphhXyYf7zwiTgmCsiYkJMyeH821ddqoG0a1qPSWzPnLCPa7nX1nrlF6U9krvMmZo-Ldk2kVm_gZw8FqZuza0K8Sg_AhXM0pm12oe_HBiMDNnBLvRcFLqR-0iZIONIJBxitgiB9pd8nCcYwaubtXPt0-u1h_HY3PNb78B0alVVnkNAAHf0jN342IzuClZRjLfJsnGf3eVBwwvFJsPYM124eLLGjBofBrgVDBLPjiNRoUvUgbmOK-GGNoREm0scZIKtBayYaTmZKmPoXNyM7KgQypNRj45OoG_Swj9nChwn8KYZZBA5mhJeSRppO3xMOoEoQY0FI_yl-mk-_RxJKzutTOO7h6WvmTGWtsi_UVkV1h_u9iK7jGd9-BdZ1k7B7ZQq1vcfMeUwefPU4907QBS88i5Lhxh2sBpnzCi4JB7Sp2drJo"
        And The urlBase is available "https://sandbox.manteca.dev/cambio"
        When Assign the value "681e3eef53061c3925f3556c" to the variable "companyId"
        And Assign the value "123" to the variable "networkId"
        And Assign the value "<userAnyId>" to the variable "userId"
        And Assign the value "<source>" to the variable "source"
        And Assign the value "<legalId>" to the variable "legalId"
        And Assign the value "<coin>" to the variable "coin"
        And Assign the value "<amount>" to the variable "amount"
        And Execute the POST method on the endpoint "/v3/admin/banking/deposit"
        Then Obtain a response 201

        Given The API key is available "bd69-f82c-c372-5bb6-3248-45e9-99f5-5035-7581106d"
        And The urlBase is available "https://sandbox.manteca.dev/cambio"
        When Wait for the processing of the "orden" por 5 seconds
        And Execute the GET method on the endpoint "/v3/synthetics/{syntheticId}"
        Then Obtain a response 200 y status COMPLETED

        Examples:
            | userAnyId                | type   | asset | against | assetAmount | withdrawAddress | source        | legalId     | coin | amount |
            | 6823694a6ebe42f301e4dad1 | DIRECT | USD   | ARS     | 10          | lean.gara.ars   | lean.gara.usd | 27265941236 | USD  | 1      |



# #Datos utilizados
# | company               | apikey                                           | companyId                | userAnyId                | opera          |
# | Company Orders (Desc) | 66ce-7686-b472-6cac-4430-13db-9654-009a-6b88bc83 | 6812e5c9da0292039eb0fc71 | 681df60f8dffa19a1c05d4ab | DESCUBIERTO    |
# | Company Orders NoDesc | bc0f-6187-d2c1-67e7-5f88-5504-075a-caa8-66c24e68 | 681e3eef53061c3925f3556c | 681e3fedad113b8233600f1d | NO DESCUBIERTO |



