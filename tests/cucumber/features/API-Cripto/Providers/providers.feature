@Provider
Feature: Providers

    @Smoke @Automated
    Scenario Outline: Validar providers de pagos <type> para user exchange <exchange>
        Given The API key is available "<apiKEY>"
        And The urlBase is available "https://api-qa.tiendacrypto.com"
        And login user admin "<credential>"
        And Execute overdrawn "<type>" synthetic lock against "<against>" for user "<userAnyId>"
        And Execute overdrawn synthetic payment
        When Execute the GET method on the endpoint "/v1/admin/user/<userAnyId>/doug"
        And Validate withdraw provider for "<type>" payment

        Examples:
            | apiKEY                          | credential                | type | against | userAnyId | exchange |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | andresperalta@manteca.dev | QR   | ARS     | 100009359 | ARG      |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | andresperalta@manteca.dev | PIX  | ARS_BRL | 100009359 | ARG      |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | andresperalta@manteca.dev | QR   | BRL     | 100011657 | BRA      |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | andresperalta@manteca.dev | PIX  | BRL_BRL | 100011657 | BRA      |