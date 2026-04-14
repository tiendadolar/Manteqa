@Sintetico @RampOn @Integrations
Feature: Sintéticos Integrations

    Background:
        Given The urlBase is available "https://sandbox.manteca.dev/crypto"

    @HappyPath @Automated
    Scenario Outline: Validate success ramp on response
        Given Get credentials for company "<companyId>"
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<externalId>" to the variable "externalId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Assign the value "<withdrawAddress>" to the variable "withdrawAddress"
        And Assign the value "<withdrawNetwork>" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v2/synthetics/ramp-on"
        Then Obtain a response 201
        And Validate ramp on "<type>" for "<exchange>" user response attributes

        Examples:
            | companyId                | userAnyId | exchange | type     | sessionId           | asset | against | assetAmount | withdrawAddress                                          | withdrawNetwork |
            | 69b83acb59880505eeaa3e52 | 100062342 | ARG      | deposit  | integrations-rampon | USDC  | ARS     | 10          | GDUARKVEGQYUS32AC3W4WLYBZUTXUAODZEPMXIJ3D2PKOMT6624TL7SK | STELLAR         |
            # | 69b83acb59880505eeaa3e52 | 100062342 | ARG      | deposit  | integrations-rampon | XML   | ARS     | 10          | GDUARKVEGQYUS32AC3W4WLYBZUTXUAODZEPMXIJ3D2PKOMT6624TL7SK | STELLAR         |
            | 69b83acb59880505eeaa3e52 | 100062342 | ARG      | deposit  | integrations-rampon | USDC  | ARS     | 10          | E7kG9CFGGBdoGWticHtoM81t38RuZt2ziMnXeSsLgfbw             | SOLANA          |
            | 69b83acb59880505eeaa3e52 | 100062342 | ARG      | deposit  | integrations-rampon | USDT  | ARS     | 10          | TRaHQ7KfnkQHCM8zFyX7HrNmMkr54A9oyM                       | TRON            |
            | 69b83acb59880505eeaa3e52 | 100062342 | ARG      | deposit  | integrations-rampon | TRX   | ARS     | 10          | TRaHQ7KfnkQHCM8zFyX7HrNmMkr54A9oyM                       | TRON            |
            | 69b83acb59880505eeaa3e52 | 100062342 | ARG      | deposit  | integrations-rampon | USDT  | ARS     | 10          | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2               | ETHEREUM        |
            | 69b83acb59880505eeaa3e52 | 100062342 | ARG      | deposit  | integrations-rampon | USDC  | ARS     | 10          | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2               | BASE            |
            | 69b83acb59880505eeaa3e52 | 100062342 | ARG      | deposit  | integrations-rampon | USDT  | ARS     | 10          | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2               | POLYGON         |
            | 69b83acb59880505eeaa3e52 | 100062342 | ARG      | deposit  | integrations-rampon | USDC  | ARS     | 10          | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2               | ARBITRUM        |
            | 69b83acb59880505eeaa3e52 | 100062342 | ARG      | deposit  | integrations-rampon | USDT  | ARS     | 10          | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2               | BINANCE         |
            | 69b83acb59880505eeaa3e52 | 100062342 | ARG      | deposit  | integrations-rampon | USDC  | ARS     | 10          | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2               | OPTIMISM        |
            | 684b9446017d29431c2cac6a | 100009457 | ARG      | overdraw | integrations-rampon | USDC  | ARS     | 10          | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2               | BASE            |

    @ErrorPath @Automated
    Scenario Outline: Validate error reponse ramp on sending <case>
        Given Get credentials for company "<companyId>"
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<externalId>" to the variable "externalId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Assign the value "<withdrawAddress>" to the variable "withdrawAddress"
        And Assign the value "<withdrawNetwork>" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v2/synthetics/ramp-on"
        Then Obtain a response <statusCode>
        And Validate response attributes with internalStatus: "<internalStatus>" and message: "<message>" and error: "<errors>"

        Examples:
            | case                 | companyId                | userAnyId | exchange | type    | externalId          | sessionId        | asset | against | assetAmount | withdrawAddress                                          | withdrawNetwork | statusCode | internalStatus   | message                                  | errors                                                                                                                                                                                                                 |
            | exist externalId     | 69b83acb59880505eeaa3e52 | 100062342 | ARG      | deposit | externalIdRepeat    | externalIdRepeat | USDC  | ARS     | 10          | GDUARKVEGQYUS32AC3W4WLYBZUTXUAODZEPMXIJ3D2PKOMT6624TL7SK | STELLAR         | 409        | SYNTHETIC_EXISTS | Synthetic with given ids already exists. |                                                                                                                                                                                                                        |
            | empty userAnyId      | 69b83acb59880505eeaa3e52 |           | ARG      | deposit | integrations-rampon | externalIdRepeat | USDC  | ARS     | 10          | GDUARKVEGQYUS32AC3W4WLYBZUTXUAODZEPMXIJ3D2PKOMT6624TL7SK | STELLAR         | 400        | BAD_REQUEST      | Bad request.                             | userAnyId is missing.                                                                                                                                                                                                  |
            | invalid asset        | 69b83acb59880505eeaa3e52 | 100062342 | ARG      | deposit | integrations-rampon | externalIdRepeat | COIN  | ARS     | 10          | GDUARKVEGQYUS32AC3W4WLYBZUTXUAODZEPMXIJ3D2PKOMT6624TL7SK | STELLAR         | 400        | BAD_REQUEST      | Bad request.                             | asset has wrong value COIN. Possible values are DAI,USDT,BUSD,USDC,USDCB,ETH,BNB,ARB,POL,TRX,XLM,SOL,UST,AUST,BTC,LUNA,LUNA2,MATIC,NUARS,WLD,USDL,SDAI,AXS,MANA,ENJ,...and 13 more.                                    |
            | empty against        | 69b83acb59880505eeaa3e52 | 100062342 | ARG      | deposit | integrations-rampon | externalIdRepeat | USDC  |         | 10          | GDUARKVEGQYUS32AC3W4WLYBZUTXUAODZEPMXIJ3D2PKOMT6624TL7SK | STELLAR         | 400        | BAD_REQUEST      | Bad request.                             | against has wrong value . Possible values are ARS,USD,CLP,COP,BRL,GTQ,CRC,PUSD,MXN,PHP,PEN,PYG,BOB,EUR,USDCCL.                                                                                                         |
            | empty assetAmount    | 69b83acb59880505eeaa3e52 | 100062342 | ARG      | deposit | integrations-rampon | externalIdRepeat | USDC  | ARS     |             | GDUARKVEGQYUS32AC3W4WLYBZUTXUAODZEPMXIJ3D2PKOMT6624TL7SK | STELLAR         | 400        | BAD_REQUEST      | Bad request.                             | One of these fields needs to be provided [assetAmount, againstAmount].                                                                                                                                                 |
            | negative assetAmount | 69b83acb59880505eeaa3e52 | 100062342 | ARG      | deposit | integrations-rampon | externalIdRepeat | USDC  | ARS     | -10         | GDUARKVEGQYUS32AC3W4WLYBZUTXUAODZEPMXIJ3D2PKOMT6624TL7SK | STELLAR         | 400        | BAD_REQUEST      | Bad request.                             | assetAmount has wrong value -10. Value should be valid number string using dot (.) as decimal separator and without trailing dot. So 100 or 100.0 but not 100. Adding - at the beginning like -100.10 is not allowed.. |
            | empty address        | 69b83acb59880505eeaa3e52 | 100062342 | ARG      | deposit | integrations-rampon | externalIdRepeat | USDC  | ARS     | 10          |                                                          | STELLAR         | 400        | BAD_REQUEST      | Bad request.                             | destination is missing.                                                                                                                                                                                                |
            | empty network        | 69b83acb59880505eeaa3e52 | 100062342 | ARG      | deposit | integrations-rampon | externalIdRepeat | USDC  | ARS     | 10          | GDUARKVEGQYUS32AC3W4WLYBZUTXUAODZEPMXIJ3D2PKOMT6624TL7SK |                 | 400        | BAD_REQUEST      | Bad request.                             | withdrawNetwork has wrong value UNKNOWN. Possible values are ETHEREUM,BINANCE,POLYGON,OPTIMISM,WORLDCHAIN,BASE,ARBITRUM,TRON,TEMPO,STELLAR,SOLANA.                                                                     |
