@LockWithdrawCost @Integrations
Feature: Lock Withdraw Cost Integrations

    Background:
        Given The urlBase is available "https://sandbox.manteca.dev/crypto"

    @HappyPath
    Scenario Outline: Validate success lock withdraw cost response
        Given The API key is available "<apiKEY>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<address>" to the variable "address"
        And Assign the value "<network>" to the variable "network"
        And Execute the POST method on the endpoint "/v2/withdraw-locks"
        Then Obtain a response <statusCode>
        And Validate lock withdraw cost response attributes

        Examples:
            | case | apiKEY                          | userAnyId | asset | network    | address                                    | statusCode |
            |      | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 | 100009352 | USDT  | ETHEREUM   | 0x7921319332714EBea5c1219439c34309e600DF54 | 201        |
            |      | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 | 100009352 | USDT  | BINANCE    | 0x7921319332714EBea5c1219439c34309e600DF54 | 201        |
            |      | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 | 100009352 | USDT  | POLYGON    | 0x7921319332714EBea5c1219439c34309e600DF54 | 201        |
            |      | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 | 100009352 | USDT  | OPTIMISM   | 0x7921319332714EBea5c1219439c34309e600DF54 | 201        |
            |      | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 | 100009352 | WLD   | WORLDCHAIN | 0x7921319332714EBea5c1219439c34309e600DF54 | 201        |
            |      | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 | 100009352 | USDC  | BASE       | 0x7921319332714EBea5c1219439c34309e600DF54 | 201        |
            |      | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 | 100009352 | USDT  | ARBITRUM   | 0x7921319332714EBea5c1219439c34309e600DF54 | 201        |
            |      | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 | 100013787 | USDT  | TRON       | TKejKJ4Zeo1SED1ygVCJtbHZfwMUf5PMj9         | 201        |

    @ErrorPath
    Scenario Outline: Validate error lock withdraw cost response <case>
        Given The API key is available "<apiKEY>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<userAnyId>" to the variable "userAnyId"
        And Assign the value "<asset>" to the variable "asset"
        And Assign the value "<address>" to the variable "address"
        And Assign the value "<network>" to the variable "network"
        And Execute the POST method on the endpoint "/v2/withdraw-locks"
        Then Obtain a response <statusCode>
        And Validate response attributes with internalStatus: "<internalStatus>" and message: "<message>" and error: "<errors>"

        Examples:
            | case                         | apiKEY                          | userAnyId | asset | network  | address                                    | statusCode | internalStatus | message      | errors                                                                                                                                                                          |
            | sending empty userAnyId      | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 |           | USDT  | ETHEREUM | 0x7921319332714EBea5c1219439c34309e600DF54 | 400        | BAD_REQUEST    | Bad request. | userAnyId is missing.                                                                                                                                                           |
            | sending wrong asset          | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 | 100009352 |       | ETHEREUM | 0x7921319332714EBea5c1219439c34309e600DF54 | 400        | BAD_REQUEST    | Bad request. | asset has wrong value . Possible values are DAI,USDT,BUSD,USDC,USDCB,ETH,BNB,ARB,POL,TRX,UST,AUST,BTC,LUNA,LUNA2,SOL,MATIC,NUARS,WLD,USDL,SDAI,AXS,MANA,ENJ,SAND,...and 8 more. |
            | sending wrong address EVM    | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 | 100009352 | USDT  | ETHEREUM |                                            | 400        | BAD_REQUEST    | Bad request. | destination.address has wrong value . Value should be a valid ethers address or ICAP address.                                                                                   |
            | sending wrong network        | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 | 100009352 | USDT  |          | 0x7921319332714EBea5c1219439c34309e600DF54 | 400        | BAD_REQUEST    | Bad request. | destination.network has wrong value . Possible values are ETHEREUM,BINANCE,POLYGON,OPTIMISM,WORLDCHAIN,BASE,ARBITRUM,TRON,TEMPO,INTERNAL.                                       |
            | sending wrong address   TRON | 95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6 | 100009352 | USDT  | TRON     |                                            | 400        | BAD_REQUEST    | Bad request. | destination.address has wrong value . Value should be a valid tron address with correct checksum.                                                                               |
