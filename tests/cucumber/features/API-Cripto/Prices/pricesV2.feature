@Prices
Feature: Prices V2

    @Smoke
    Scenario Outline: Obtener par prices <par_prices>
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        And Execute the GET method on the endpoint "/v2/prices/direct/<par_price>"
        Then Obtain a response 200
        And Obtain correct price network

        @ARS
        Examples:
            | companyId                | par_price |
            | 683cce15397feba125068c9b | USDT_ARS  |
            | 683cce15397feba125068c9b | WLD_ARS   |
            | 683cce15397feba125068c9b | USDC_ARS  |
            | 683cce15397feba125068c9b | USDCB_ARS |
            | 683cce15397feba125068c9b | ETH_ARS   |
            | 683cce15397feba125068c9b | BTC_ARS   |
            | 683cce15397feba125068c9b | BNB_ARS   |
            | 683cce15397feba125068c9b | DAI_ARS   |
            | 683cce15397feba125068c9b | TRX_ARS   |

        @USD
        Examples:
            | companyId                | par_price |
            | 683cce15397feba125068c9b | USDT_USD  |
            | 683cce15397feba125068c9b | WLD_USD   |
            | 683cce15397feba125068c9b | USDC_USD  |
            | 683cce15397feba125068c9b | USDCB_USD |
            | 683cce15397feba125068c9b | ETH_USD   |
            | 683cce15397feba125068c9b | BTC_USD   |
            | 683cce15397feba125068c9b | BNB_USD   |
            | 683cce15397feba125068c9b | DAI_USD   |
            | 683cce15397feba125068c9b | TRX_USD   |

        @CLP
        Examples:
            | companyId                | par_price |
            | 683cce15397feba125068c9b | USDT_CLP  |
            | 683cce15397feba125068c9b | WLD_CLP   |
            | 683cce15397feba125068c9b | USDC_CLP  |
            | 683cce15397feba125068c9b | USDCB_CLP |
            | 683cce15397feba125068c9b | TRX_CLP   |

        @BRL
        Examples:
            | companyId                | par_price |
            | 683cce15397feba125068c9b | USDT_BRL  |
            | 683cce15397feba125068c9b | WLD_BRL   |
            | 683cce15397feba125068c9b | USDC_BRL  |
            | 683cce15397feba125068c9b | USDCB_BRL |
            | 683cce15397feba125068c9b | TRX_BRL   |

        @COP
        Examples:
            | companyId                | par_price |
            | 683cce15397feba125068c9b | USDT_COP  |
            | 683cce15397feba125068c9b | WLD_COP   |
            | 683cce15397feba125068c9b | USDC_COP  |
            | 683cce15397feba125068c9b | USDCB_COP |
            | 683cce15397feba125068c9b | TRX_COP   |

        @CRC
        Examples:
            | companyId                | par_price |
            | 683cce15397feba125068c9b | USDT_CRC  |
            | 683cce15397feba125068c9b | WLD_CRC   |
            | 683cce15397feba125068c9b | USDC_CRC  |
            | 683cce15397feba125068c9b | USDCB_CRC |
            | 683cce15397feba125068c9b | TRX_CRC   |

        @MXN
        Examples:
            | companyId                | par_price |
            | 683cce15397feba125068c9b | USDT_MXN  |
            | 683cce15397feba125068c9b | WLD_MXN   |
            | 683cce15397feba125068c9b | USDC_MXN  |
            | 683cce15397feba125068c9b | USDCB_MXN |
            | 683cce15397feba125068c9b | TRX_MXN   |

        @PUSD
        Examples:
            | companyId                | par_price  |
            | 683cce15397feba125068c9b | USDT_PUSD  |
            | 683cce15397feba125068c9b | WLD_PUSD   |
            | 683cce15397feba125068c9b | USDC_PUSD  |
            | 683cce15397feba125068c9b | USDCB_PUSD |
            | 683cce15397feba125068c9b | TRX_PUSD   |

        @PHP
        Examples:
            | companyId                | par_price |
            | 683cce15397feba125068c9b | USDT_PHP  |
            | 683cce15397feba125068c9b | WLD_PHP   |
            | 683cce15397feba125068c9b | USDC_PHP  |
            | 683cce15397feba125068c9b | USDCB_PHP |
            | 683cce15397feba125068c9b | PHP       |

        @PEN
        Examples:
            | companyId                | par_price |
            | 683cce15397feba125068c9b | USDT_PEN  |
            | 683cce15397feba125068c9b | WLD_PEN   |
            | 683cce15397feba125068c9b | USDC_PEN  |
            | 683cce15397feba125068c9b | USDCB_PEN |
            | 683cce15397feba125068c9b | TRX_PEN   |

        @BOB
        Examples:
            | companyId                | par_price |
            | 683cce15397feba125068c9b | USDT_BOB  |
            | 683cce15397feba125068c9b | WLD_BOB   |
            | 683cce15397feba125068c9b | USDC_BOB  |
            | 683cce15397feba125068c9b | USDCB_BOB |
            | 683cce15397feba125068c9b | TRX_BOB   |