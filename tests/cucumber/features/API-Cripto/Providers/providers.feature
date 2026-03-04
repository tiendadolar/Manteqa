@Provider
Feature: Providers

    @Smoke @Automated
    Scenario Outline: Validar providers de pagos <type> para user exchange <exchange>
        Given Get credentials for company "<companyId>"
        And The urlBase is available "https://api-qa.tiendacrypto.com"
        And login user admin "<credential>"
        And Execute overdrawn "<type>" synthetic lock against "<against>" for user "<userAnyId>"
        And Execute overdrawn synthetic payment
        When Execute the GET method on the endpoint "/v1/admin/user/<userAnyId>/doug"
        And Validate withdraw provider for "<type>" payment

        Examples:
            | companyId                | credential                | type | against | userAnyId | exchange |
            | 683cce15397feba125068c9b | andresperalta@manteca.dev | QR   | ARS     | 100009359 | ARG      |
            | 683cce15397feba125068c9b | andresperalta@manteca.dev | PIX  | ARS_BRL | 100009359 | ARG      |
            | 683cce15397feba125068c9b | andresperalta@manteca.dev | QR   | BRL     | 100011657 | BRA      |
            | 683cce15397feba125068c9b | andresperalta@manteca.dev | PIX  | BRL_BRL | 100011657 | BRA      |