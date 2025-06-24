@Auth
Feature: Autorización API-Cambio

    Scenario: Iniciar sesión exitosamente en Admin Panel de TiendaDolar
        Given Contar con la urlBase "https://api-qa.tiendadolar.com.ar"
        When Asignar el valor "<email>" a la variable "email"
        And  Asignar el valor "<password>" a la variable "password"
        And Ejecutar el método Post al endpoint "/v3/admin/auth/login"
        Then Se obtiene una respuesta 428

        Examples:
            | email                | password  |
            | andy@tiendadolar.com | !12345678 |

    Scenario: Ingresar token de acceso
        Given Contar con la urlBase "https://api-qa.tiendadolar.com.ar"
        When Asignar el valor "<accessToken>" a la variable "token"
        And Ejecutar el método Post al endpoint "/v3/admin/auth/verifyLogin/{twoFaCode}"
        Then Se obtiene una respuesta 200

        Examples:
            | accessToken |
            | 911242      |