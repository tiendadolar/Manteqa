@Auth
Feature: Autorización API-Cambio

    Scenario: Iniciar sesión exitosamente en Admin Panel de TiendaDolar
        Given The urlBase is available "https://api-qa.tiendadolar.com.ar"
        When Assign the value "<email>" to the variable "email"
        And  Assign the value "<password>" to the variable "password"
        And Execute the POST method on the endpoint "/v3/admin/auth/login"
        Then Obtain a response 428

        Examples:
            | email                | password  |
            | andy@tiendadolar.com | !12345678 |

    Scenario: Ingresar token de acceso
        Given The urlBase is available "https://api-qa.tiendadolar.com.ar"
        When Assign the value "<accessToken>" to the variable "token"
        And Execute the POST method on the endpoint "/v3/admin/auth/verifyLogin/{twoFaCode}"
        Then Obtain a response 200

        Examples:
            | accessToken |
            | 911242      |