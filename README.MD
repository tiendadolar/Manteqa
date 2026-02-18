# Manteqa - E2E Test Suite

Suite de tests end-to-end para la plataforma Manteca. Valida los flujos completos de API-Crypto y API-Cambio contra el entorno sandbox.

## Pre-requisitos

- Node.js 18+
- Acceso a AWS CodeArtifact (para paquetes `@md/*`)

## Instalacion

```bash
git clone <URL_DEL_REPOSITORIO>
npm run login   # Auth con CodeArtifact
npm install
```

## Ejecucion

```bash
# Todos los tests
npm test

# Por tags (con reporte)
npm run test:tag '@Smoke and @Automated'

# Por tags (sin reporte)
npx cucumber-js --tags '@OnboardingV2 and @Smoke and @Automated'
```

Los reportes se generan en `cucumber-report.html` y `cucumber-report.pdf`.

---

## Estructura del proyecto

```
Manteqa/
  tests/
    cucumber/
      features/           # Archivos .feature (Gherkin)
        API-Cripto/        # Tests de la API Crypto
        API-Cambio/        # Tests de la API Cambio
      step-definitions/    # Implementacion de los steps
        API-Cripto/
        API-Cambio/
    hooks/                 # Before/After de cada scenario
    support/
      constants/           # Constantes (assets, endpoints)
      data/                # Datos de test (credentials, accounts, networks)
      factory/             # EndpointHandlerFactory
      handlers/            # Handlers por API (apiCrypto, apiCambio)
      helpers/             # Funciones de apoyo (auth, request, deposit, etc.)
      interfaces/          # TypeScript interfaces de responses
      validators/          # Validaciones de responses por dominio
      utils/               # Logger, utilidades generales
      world.ts             # CustomWorld - estado compartido entre steps
    artillery/             # Tests de carga (Artillery)
  scripts/
    run-tests.js           # Runner por tags con reporte
  reporter.js              # Generador de reportes HTML/PDF
  cucumber.js              # Config de Cucumber
```

---

## Tipos de test

### Smoke (`@Smoke and @Automated`)

Tests rapidos que validan que los flujos criticos funcionan. Son los que corren en CI en cada push y post-deploy. Cubren el happy path de cada funcionalidad principal.

**Cuando usarlos:** Validacion rapida de que nada se rompio. Post-deploy, en PRs.

### Regression (`@Regression and @Automated`)

Tests mas exhaustivos que cubren edge cases, error paths, y combinaciones de datos. Incluyen validaciones de campos, tipos de datos, y mensajes de error.

**Cuando usarlos:** Antes de releases, en schedules nocturnos.

### Integration (`@Integrations and @Regression and @Automated`)

Tests que validan flujos completos multi-step (ej: onboarding + order + withdraw). Verifican que los servicios interactuan correctamente entre si.

**Cuando usarlos:** Antes de releases, despues de cambios que afectan multiples servicios.

### E2E (`@E2E`)

Flujos de punta a punta que simulan un usuario completo (onboarding, carga de documentos, banking, etc.).

### Load (Artillery)

Tests de carga en `tests/artillery/`. Se ejecutan con Artillery directamente:

```bash
npx artillery run tests/artillery/qr-fallback.yml
```

---

## Sistema de tags

Los tags controlan que tests se ejecutan. Se combinan con `and`/`or`/`not`.

### Tags de tipo

| Tag | Descripcion |
|-----|-------------|
| `@Smoke` | Happy path rapido |
| `@Regression` | Cobertura exhaustiva |
| `@Integrations` | Flujos multi-step |
| `@E2E` | Flujos completos de usuario |
| `@Automated` | Listo para ejecucion automatica |
| `@Manual` | Requiere intervencion manual |

### Tags de funcionalidad

| Tag | Dominio |
|-----|---------|
| `@OnboardingV2` | Alta de usuarios V2 |
| `@Onboarding` | Alta de usuarios V1 |
| `@Orders` | Ordenes de compra/venta |
| `@QR` | Pagos QR 3.0 |
| `@Withdraw` | Retiros (fiat y crypto) |
| `@Billing` | Facturacion |
| `@Topup` | Top ups |
| `@Provider` | Providers externos |
| `@Refunds` | Reembolsos |
| `@Sintetico` | Sinteticos de rampa |
| `@Pix` | Pagos PIX (Brasil) |
| `@Deposit` | Depositos |
| `@Prices` | Precios V2 |
| `@LockPrice` | Lock de precios |
| `@Activities` | Historial de actividades |

### Tags de version/filtro

| Tag | Filtro |
|-----|--------|
| `@V1` | Endpoints V1 |
| `@V2` | Endpoints V2 |
| `@Fiat` | Operaciones fiat |
| `@Crypto` | Operaciones crypto |
| `@USDT` | Par USDT |
| `@USDC` | Par USDC |
| `@Remesas` | Retiros tipo remesa |
| `@BuyByCountry` | Compras por pais |
| `@SellByCountry` | Ventas por pais |

### Combinaciones comunes

```bash
# Smoke completo
npm run test:tag '@Smoke and @Automated'

# Orders V2 smoke
npm run test:tag '@Orders and @Smoke and @V2 and @Automated'

# Withdraw fiat V2
npm run test:tag '@Withdraw and @Smoke and @Fiat and @V2 and @Automated'

# Integraciones de onboarding
npm run test:tag '@Integrations and @OnboardingV2 and @Regression and @Automated'

# Solo QR, sin refunds
npm run test:tag '@QR and @Smoke and @Automated and not @Refunds'
```

---

## Como agregar un test nuevo

### 1. Crear o editar el .feature

Los features van en `tests/cucumber/features/` organizados por API y dominio:

```
features/
  API-Cripto/
    Orders/orders.feature
    Withdraws/withdrawFiat.feature
    NuevoDominio/nuevoDominio.feature    # <-- nuevo
  API-Cambio/
    ...
```

Estructura de un feature:

```gherkin
@NuevoDominio
Feature: Descripcion del dominio

    @Smoke @Automated
    Scenario Outline: Descripcion del caso <variable>
        Given The API key is available "<apiKEY>"
        And The urlBase is available "https://sandbox.manteca.dev/crypto"
        When Assign the value "<campo1>" to the variable "campo1"
        And Assign the value "<campo2>" to the variable "campo2"
        And Execute the POST method on the endpoint "/v2/mi-endpoint"
        Then Obtain a response 201

        Examples:
            | apiKEY                          | campo1 | campo2 |
            | B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV | valor1 | valor2 |
```

**Reglas:**
- Siempre poner al menos `@Automated` si el test corre sin intervencion manual
- Poner `@Smoke` si es happy path critico, `@Regression` si cubre edge cases
- El tag de feature (ej `@NuevoDominio`) va en la primera linea del archivo
- Usar `Scenario Outline` + `Examples` cuando hay multiples combinaciones de datos

### 2. Steps existentes (reutilizables)

Estos steps ya existen y cubren la mayoria de los casos:

```gherkin
# Setup
Given The API key is available "<key>"
Given The urlBase is available "<url>"
Given The API secret is available "<secret>"
Given The token is available "<token>"

# Asignar datos al payload
When Assign the value "<valor>" to the variable "<campo>"
When Assign the value <numero> to the variable "<campo>"   # para enviar como number

# Ejecutar requests
When Execute the POST method on the endpoint "<path>"
When Execute the GET method on the endpoint "<path>"

# Validar respuesta
Then Obtain a response <statusCode>
Then Obtain a response <statusCode> y status "<status>"
```

### 3. Agregar steps custom (si necesitas validaciones nuevas)

Crear un archivo en `tests/cucumber/step-definitions/API-Cripto/NuevoDominio/`:

```typescript
// nuevoDominio.steps.ts
const { Then } = require('@cucumber/cucumber');
import { expect } from 'chai';
import { CustomWorld } from '../../../../support/world';

Then('Validate nuevo dominio response', function (this: CustomWorld) {
  const res = this.response;
  expect(res.body).to.have.property('id').that.is.a('string');
  // ... mas validaciones
});
```

### 4. Agregar un handler (si el endpoint necesita transformar el payload)

Si tu endpoint necesita que el payload se transforme antes de enviarse (ej: mapear campos, agregar datos calculados), agrega un handler:

1. Crear handler en `tests/support/handlers/apiCrypto.handler.ts`
2. Registrarlo en `tests/support/factory/endpointHandlerFactory.ts`

### 5. Agregar un validator (si necesitas validar la response en detalle)

Crear en `tests/support/validators/`:

```typescript
// nuevoDominio.validators.ts
import { expect } from 'chai';

export const validateNuevoDominioResponse = (response: any) => {
  expect(response).to.have.property('campo1');
  // ...
};
```

---

## CI/CD (GitHub Actions)

### Triggers actuales

| Trigger | Que corre | Cuando |
|---------|-----------|--------|
| Push a cualquier rama | OnboardingV2 Smoke | Automatico en cada push |
| Manual (workflow_dispatch) | Suite seleccionada (33 opciones) | On-demand desde GitHub UI |
| Cron L-V 01:00 ARG | Smoke General | Detectar regressions del dia |
| Cron L-V 01:30 ARG | Providers | Monitorear dependencias externas |
| Cron L/Mi/V 02:00 ARG | Integrations OnboardingV2 | Flujos multi-step |
| Cron Dom 03:00 ARG | Regression | Cobertura amplia semanal |

### Suites disponibles en dispatch manual

Smoke General, Onboarding v1/v2, Orders v1/v2, Pagos, Billing, Top Up, Providers, Refunds, Sinteticos, Withdraw Fiat v1/v2, Withdraw Crypto v1/v2, Remesas, Integrations (OnboardingV2, Lock Payment, Withdraw V2), Regression.

### Notificaciones

- **Slack**: Todas las ejecuciones (resumen + link a detalles)
- **Email**: Solo cuando la tasa de fallo supera el 65%

### Reportes

Cada run genera artifacts descargables:
- `cucumber-report.html` - Reporte visual
- `cucumber-report.json` - Datos crudos
- `test-results.json` - Resumen con metricas

### Pendiente: Trigger post-deploy desde microservicios

Cuando un microservicio deploya a sandbox, deberia triggerear automaticamente los E2E relevantes. Esto todavia no esta implementado.

**Pre-requisito**: Crear un GitHub Personal Access Token con permiso `actions:write` sobre `tiendadolar/Manteqa` y agregarlo como secret `MANTEQA_TRIGGER_TOKEN` en cada repo de microservicio.

**Implementacion**: Agregar este step al final del workflow de deploy de cada servicio:

```yaml
- name: Trigger E2E tests
  if: success()
  env:
    GH_TOKEN: ${{ secrets.MANTEQA_TRIGGER_TOKEN }}
  run: |
    gh workflow run test.yml \
      --repo tiendadolar/Manteqa \
      --ref main \
      --field test_suite="${TEST_SUITE}"
```

**Mapping por servicio:**

| Repo | test_suite | Por que |
|------|-----------|---------|
| b2b-ms-exchange | `Smoke General` | Toca orders, withdrawals, deposits |
| b2b-ms-apiGateway | `Smoke General` | Todo pasa por el gateway |
| b2b-ms-prices | `Orders v2` | Afecta precios y orders |
| b2b-ms-compliance | `Onboarding v2` | Afecta flujo de alta |
| md-bank-service | `Withdraw Fiat v2` | Afecta retiros y depositos fiat |

---

## Tecnologias

- **Cucumber** - Framework BDD (Gherkin + step definitions)
- **TypeScript** - Lenguaje
- **Supertest** - HTTP client para API testing
- **Chai** - Assertions
- **Winston** - Logging
- **Artillery** - Load testing
- **Puppeteer** - Generacion de reportes PDF

---

## Notas

- Los tests corren contra `https://sandbox.manteca.dev/crypto` (sandbox)
- El `package-lock.json` garantiza versiones exactas. No eliminarlo
- Los contadores (`.sessionCounter`, `.hashCrypto`, `.externalId`) persisten entre ejecuciones locales para evitar colisiones de IDs
