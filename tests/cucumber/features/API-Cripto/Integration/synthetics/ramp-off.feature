@Sintetico @RampOff @Integrations
Feature: Sintéticos Integrations

    Background:
        Given The urlBase is available "https://sandbox.manteca.dev/crypto"

    @HappyPath @Automated
    Scenario Outline: Validate success ramp off response <case>
        Given Get credentials for company "<companyId>"
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<externalId>" to the variable "externalId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Assign the value "<withdrawAddress>" to the variable "withdrawAddress"
        And Assign the value "<withdrawNetwork>" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v2/synthetics/ramp-off"
        Then Obtain a response 201
        And Validate ramp off "<type>" for "<exchange>" user response attributes

        Examples:
            | companyId                | userAnyId | exchange | type    | externalId                   | sessionId           | asset | against | assetAmount | withdrawAddress        | withdrawNetwork |
            | 69b83acb59880505eeaa3e52 | 100062342 | ARG      | deposit | external-integrations-rampon | integrations-rampon | USDC  | ARS     | 10          | 4530000800015017168564 | BANK_TRANSFER   |
            | 69b83acb59880505eeaa3e52 | 100062342 | ARG      | deposit | external-integrations-rampon | integrations-rampon | USDT  | ARS     | 10          | 4530000800015017168564 | BANK_TRANSFER   |
            | 69b83acb59880505eeaa3e52 | 100062342 | ARG      | deposit | external-integrations-rampon | integrations-rampon | WLD   | ARS     | 10          | 4530000800015017168564 | BANK_TRANSFER   |
            | 684b9446017d29431c2cac6a | 100009457 | ARG      | deposit | external-integrations-rampon | integrations-rampon | USDC  | ARS     | 10          | 4530000800015017168564 | BANK_TRANSFER   |

    @ErrorPath @Automated
    Scenario Outline: Validate success ramp off response <case>
        Given Get credentials for company "<companyId>"
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<externalId>" to the variable "externalId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<against>" to the variable "against"
        And Assign the value "<assetAmount>" to the variable "assetAmount"
        And Assign the value "<withdrawAddress>" to the variable "withdrawAddress"
        And Assign the value "<withdrawNetwork>" to the variable "withdrawNetwork"
        And Execute the POST method on the endpoint "/v2/synthetics/ramp-off"
        Then Obtain a response <statusCode>
        And Validate response attributes with internalStatus: "<internalStatus>" and message: "<message>" and error: "<errors>"

        Examples:
            | companyId                | userAnyId | exchange | type    | externalId       | sessionId           | asset | against | assetAmount | withdrawAddress        | withdrawNetwork | statusCode | internalStatus   | message                                  | errors                                                                                                                                                                                                                 |
            | 69b83acb59880505eeaa3e52 | 100062342 | ARG      | deposit | externalIdRepeat | integrations-rampon | USDC  | ARS     | 10          | 4530000800015017168564 | BANK_TRANSFER   | 409        | SYNTHETIC_EXISTS | Synthetic with given ids already exists. |                                                                                                                                                                                                                        |
            | 69b83acb59880505eeaa3e52 |           | ARG      | deposit | externalId       | integrations-rampon | USDC  | ARS     | 10          | 4530000800015017168564 | BANK_TRANSFER   | 400        | BAD_REQUEST      | Bad request.                             | userAnyId is missing.                                                                                                                                                                                                  |
            | 69b83acb59880505eeaa3e52 | 100062342 | ARG      | deposit | externalId       | integrations-rampon |       | ARS     | 10          | 4530000800015017168564 | BANK_TRANSFER   | 400        | BAD_REQUEST      | Bad request.                             | asset has wrong value . Possible values are DAI,USDT,BUSD,USDC,USDCB,ETH,BNB,ARB,POL,TRX,XLM,SOL,UST,AUST,BTC,LUNA,LUNA2,MATIC,NUARS,WLD,USDL,SDAI,AXS,MANA,ENJ,...and 13 more.                                        |
            | 69b83acb59880505eeaa3e52 | 100062342 | ARG      | deposit | externalId       | integrations-rampon | USDC  | ARS     |             | 4530000800015017168564 | BANK_TRANSFER   | 400        | BAD_REQUEST      | Bad request.                             | One of these fields needs to be provided [assetAmount, againstAmount].                                                                                                                                                 |
            | 69b83acb59880505eeaa3e52 | 100062342 | ARG      | deposit | externalId       | integrations-rampon | USDC  | ARS     | -10         | 4530000800015017168564 | BANK_TRANSFER   | 400        | BAD_REQUEST      | Bad request.                             | assetAmount has wrong value -10. Value should be valid number string using dot (.) as decimal separator and without trailing dot. So 100 or 100.0 but not 100. Adding - at the beginning like -100.10 is not allowed.. |
            | 69b83acb59880505eeaa3e52 | 100062342 | ARG      | deposit | externalId       | integrations-rampon | USDC  | ARS     | 10          |                        | BANK_TRANSFER   | 400        | BAD_REQUEST      | Bad request.                             | destination.address has wrong value . Value should be a 22-digit number with correct validation digits and not starting with 000..                                                                                     |
