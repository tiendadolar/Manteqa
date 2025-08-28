@Auth
Feature: Autorización API-Cambio

    Scenario: Iniciar sesión exitosamente en Admin Panel de TiendaDolar
        Given The urlBase is available "https://api-qa.tiendadolar.com.ar"
        When Assign the value "<email>" to the variable "email"
        And  Assign the value "<password>" to the variable "password"
        And Execute the POST method on the endpoint "/v3/admin/auth/login"
        Then Obtain a response 428 and twoFaCode url
        And Send 2FA code

        # When Execute the POST method on the endpoint "/v3/{twoFaCode}"
        # Then Obtain a response 200

        Examples:
            | email                | password  |
            | andy@tiendadolar.com | !12345678 |

    @Cambio
    Scenario: Auth
        Given login user admin "<credential>"

        Examples:
            | credential           |
            | andy@tiendadolar.com |

