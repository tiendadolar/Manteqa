@Prices
Feature: Prices V2

    @Smoke @Automated
    Scenario Outline: Obtener par prices <par_prices>
        Given The API key is available "<apiKEY>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        And Execute the GET method on the endpoint "/v2/prices/direct/<par_price>"
        Then Obtain a response 200
        And Obtain correct price network

        @ARS
        Examples:
            | apiKEY                          | par_price |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | USDT_ARS  |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | WLD_ARS   |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | USDC_ARS  |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | USDCB_ARS |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | ETH_ARS   |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | BTC_ARS   |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | BNB_ARS   |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | DAI_ARS   |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | TRX_ARS   |

        @USD
        Examples:
            | apiKEY                          | par_price |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | USDT_USD  |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | WLD_USD   |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | USDC_USD  |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | USDCB_USD |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | ETH_USD   |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | BTC_USD   |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | BNB_USD   |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | DAI_USD   |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | TRX_USD   |

        @CLP
        Examples:
            | apiKEY                          | par_price |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | USDT_CLP  |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | WLD_CLP   |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | USDC_CLP  |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | USDCB_CLP |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | TRX_CLP   |

        @BRL
        Examples:
            | apiKEY                          | par_price |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | USDT_BRL  |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | WLD_BRL   |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | USDC_BRL  |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | USDCB_BRL |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | TRX_BRL   |

        @COP
        Examples:
            | apiKEY                          | par_price |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | USDT_COP  |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | WLD_COP   |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | USDC_COP  |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | USDCB_COP |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | TRX_COP   |

        @CRC
        Examples:
            | apiKEY                          | par_price |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | USDT_CRC  |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | WLD_CRC   |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | USDC_CRC  |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | USDCB_CRC |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | TRX_CRC   |

        @MXN
        Examples:
            | apiKEY                          | par_price |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | USDT_MXN  |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | WLD_MXN   |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | USDC_MXN  |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | USDCB_MXN |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | TRX_MXN   |

        @PUSD
        Examples:
            | apiKEY                          | par_price  |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | USDT_PUSD  |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | WLD_PUSD   |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | USDC_PUSD  |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | USDCB_PUSD |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | TRX_PUSD   |

        @PHP
        Examples:
            | apiKEY                          | par_price |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | USDT_PHP  |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | WLD_PHP   |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | USDC_PHP  |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | USDCB_PHP |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | PHP       |

        @PEN
        Examples:
            | apiKEY                          | par_price |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | USDT_PEN  |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | WLD_PEN   |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | USDC_PEN  |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | USDCB_PEN |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | TRX_PEN   |

        @BOB
        Examples:
            | apiKEY                          | par_price |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | USDT_BOB  |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | WLD_BOB   |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | USDC_BOB  |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | USDCB_BOB |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | TRX_BOB   |