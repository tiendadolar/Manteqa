@WithdrawV2 @Integrations @Regression
Feature: Lock Price Integrations

    Background:
        Given The urlBase is available "https://sandbox.manteca.dev/crypto"

    @HappyPath @Automated
    Scenario Outline: Validate success withdraw cripto V2 response <case>
        Given The API key is available "<apiKEY>"
        And login user admin "<credential>"
        When Assign the value "<externalId>" to the variable "externalId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<address>" to the variable "address"
        And Assign the value "<network>" to the variable "network"
        And Execute the POST method on the endpoint "/v2/withdraws"
        Then Obtain a response 201
        And Validate withdraw cripto V2 response attributes

        Examples:
            | case               | credential                | apiKEY                          | externalId | sessionId          | userAnyId | asset | amount | address                                    | network |
            | sending all fields | andresperalta@manteca.dev | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | ext-n      | withdraw-session-n | 100009873 | USDC  | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | BASE    |

    @HappyPath @Automated
    Scenario Outline: Validate success withdraw cripto V2 response <case>
        Given The API key is available "<apiKEY>"
        And login user admin "<credential>"
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<address>" to the variable "address"
        And Assign the value "<network>" to the variable "network"
        And Execute the POST method on the endpoint "/v2/withdraws"
        Then Obtain a response 201
        And Validate withdraw cripto V2 response attributes

        Examples:
            | case                           | credential                | apiKEY                          | userAnyId | asset | amount | address                                    | network    |
            | required fields                | andresperalta@manteca.dev | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | 100009873 | USDC  | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | BASE       |
            | required fields for Ethereum   | andresperalta@manteca.dev | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | 100009873 | USDT  | 10     | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | ETHEREUM   |
            | required fields for Binance    | andresperalta@manteca.dev | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | 100009873 | USDT  | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | BINANCE    |
            | required fields for Polygon    | andresperalta@manteca.dev | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | 100009873 | USDT  | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | POLYGON    |
            | required fields for Optimism   | andresperalta@manteca.dev | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | 100009873 | USDC  | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | OPTIMISM   |
            | required fields for Worldchain | andresperalta@manteca.dev | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | 100009873 | WLD   | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | WORLDCHAIN |
            | required fields for Arbitrum   | andresperalta@manteca.dev | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | 100009873 | WLD   | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | ARBITRUM   |
            | required fields for Tron       | andresperalta@manteca.dev | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | 100009873 | USDT  | 5      | TRaHQ7KfnkQHCM8zFyX7HrNmMkr54A9oyM         | TRON       |

    @ErrorPath @Automated
    Scenario Outline: Validate error withdraw cripto V2 response <case>
        Given The API key is available "<apiKEY>"
        And login user admin "<credential>"
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<address>" to the variable "address"
        And Assign the value "<network>" to the variable "network"
        And Execute the POST method on the endpoint "/v2/withdraws"
        Then Obtain a response <statusCode>
        And Validate response attributes with internalStatus: "<internalStatus>" and message: "<message>" and error: "<errors>"

        Examples:
            | case                             | credential                | apiKEY                          | userAnyId | asset | amount | address                                    | network | statusCode | internalStatus | message                                                                                                 | errors                                                                                                                                                                                                             |
            | sending invalid api-KEY          | andresperalta@manteca.dev | PRAJCG-71RM2H7-HSQK3BN-0NDD7MY  | 100009873 | USDC  | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | BASE    | 403        | FORBIDDEN      | You do not have enough permissions to access the resource with the provided authentication credentials. |                                                                                                                                                                                                                    |
            | sending empty api-KEY            | andresperalta@manteca.dev |                                 | 100009873 | USDC  | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | BASE    | 400        | INVALID_PARAMS | Invalid parameters.                                                                                     |                                                                                                                                                                                                                    |
            | sending invalid userAnyId        | andresperalta@manteca.dev | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | 100009871 | USDC  | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | BASE    | 404        | USER_NF        | User not found                                                                                          |                                                                                                                                                                                                                    |
            | sending invalid amount           | andresperalta@manteca.dev | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | 100009873 | USDC  | -5     | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | BASE    | 400        | BAD_REQUEST    | Bad request.                                                                                            | amount has wrong value -100. Value should be valid number string using dot (.) as decimal separator and without trailing dot. So 100 or 100.0 but not 100. Adding - at the beginning like -100.10 is not allowed.. |
            | sending invalid address          | andresperalta@manteca.dev | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | 100009873 | USDC  | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f  | BASE    | 400        | BAD_REQUEST    | Bad request.                                                                                            | destination.address has wrong value 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f. Value should be a valid ethers address or ICAP address.                                                                             |
            | sending invalid network          | andresperalta@manteca.dev | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | 100009873 | USDC  | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | BASE    | 400        | BAD_REQUEST    | Bad request.                                                                                            | destination.network has wrong value BSE. Possible values are ETHEREUM,BINANCE,POLYGON,OPTIMISM,WORLDCHAIN,BASE,ARBITRUM,TRON,TEMPO,INTERNAL.                                                                       |
            | sending invalid Tron network     | andresperalta@manteca.dev | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | 100009873 | USDC  | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | TRON    | 400        | BAD_REQUEST    | Bad request.                                                                                            | destination.address has wrong value 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2. Value should be a valid tron address with correct checksum.                                                                        |
            | sending invalid Tron network     | andresperalta@manteca.dev | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | 100009873 | USDC  | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | TRON    | 400        | BAD_REQUEST    | Bad request.                                                                                            | destination.address has wrong value 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2. Value should be a valid tron address with correct checksum.                                                                        |
            | sending invalid EVM network      | andresperalta@manteca.dev | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | 100009873 | USDC  | 5      | TRaHQ7KfnkQHCM8zFyX7HrNmMkr54A9oyM         | BASE    | 400        | BAD_REQUEST    | Bad request.                                                                                            | destination.address has wrong value TRaHQ7KfnkQHCM8zFyX7HrNmMkr54A9oyM. Value should be a valid ethers address or ICAP address.                                                                                    |
            | sending invalid coin for network | andresperalta@manteca.dev | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | 100009873 | USDT  | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | BASE    | 403        | FORBIDDEN      | Forbidden.                                                                                              |                                                                                                                                                                                                                    |
            | sending empty userAnyId          | andresperalta@manteca.dev | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY |           | USDC  | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | BASE    | 400        | BAD_REQUEST    | Bad request.                                                                                            | userAnyId is missing.                                                                                                                                                                                              |
            | sending empty asset              | andresperalta@manteca.dev | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | 100009873 |       | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | BASE    | 400        | BAD_REQUEST    | Bad request.                                                                                            | asset is missing.                                                                                                                                                                                                  |
            | sending empty amount             | andresperalta@manteca.dev | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | 100009873 | USDC  |        | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | BASE    | 400        | BAD_REQUEST    | Bad request.                                                                                            | amount is missing.                                                                                                                                                                                                 |
            | sending empty address            | andresperalta@manteca.dev | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | 100009873 | USDC  | 5      |                                            | BASE    | 400        | BAD_REQUEST    | Bad request.                                                                                            | destination.address is missing.                                                                                                                                                                                    |
            | sending empty network            | andresperalta@manteca.dev | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | 100009873 | USDC  | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 |         | 400        | BAD_REQUEST    | Bad request.                                                                                            | destination.network is missing.                                                                                                                                                                                    |

    @ErrorPath @Automated
    Scenario Outline: Validate error withdraw cripto V2 response <case>
        Given The API key is available "<apiKEY>"
        And login user admin "<credential>"
        When Assign the value "<externalId>" to the variable "externalId"
        And Assign the value "<sessionId>" to the variable "sessionId"
        And Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<amount>" to the variable "amount"
        And Assign the value "<address>" to the variable "address"
        And Assign the value "<network>" to the variable "network"
        And Execute the POST method on the endpoint "/v2/withdraws"
        Then Obtain a response <statusCode>
        And Validate response attributes with internalStatus: "<internalStatus>" and message: "<message>" and error: "<errors>"

        #Error en response
        Examples:
            | case                      | credential                | apiKEY                          | externalId       | sessionId          | userAnyId | asset | amount | address                                    | network | statusCode | internalStatus | message      | errors                          |
            | sending repeat externalId | andresperalta@manteca.dev | PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY | externalIdRepeat | withdraw-session-n | 100009873 | USDC  | 5      | 0x4cD0820ca71Bda1A6cEfe1A6D5a2F6E50D4370f2 | BASE    | 400        | BAD_REQUEST    | Bad request. | destination.network is missing. |
