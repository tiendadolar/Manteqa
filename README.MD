# 🚀 Proyecto Manteqa

Es un proyecto de automatización para "Manteca".

## ⚙️ Funcionalidades Automatizadas

- ### **API-CRYPTO:**

* **Onboarding** '@Onboarding'
* **PIX** '@Pix'
* **QR** 3.0 '@QR'
* **Orders USDT** '@USDTOrders'

- ### **API-CAMBIO:**

* **Onboarding** 'OnboardingApiCambio'
* **Orders** '@OrderApiCambio'

## 📦 Instalación

1. Clona el repositorio:
   ```bash
   git clone <URL_DEL_REPOSITORIO>
   ```
2. Instala las dependencias:
   ```bash
   npm install
   ```

## 🛠️ Tecnologías Utilizadas

Este proyecto utiliza las siguientes tecnologías:

- ![Node.js](https://img.shields.io/badge/Node.js-339933?style=for-the-badge&logo=nodedotjs&logoColor=white)
- ![Cucumber](https://img.shields.io/badge/Cucumber-23D96C?style=for-the-badge&logo=cucumber&logoColor=white)
- ![Mocha](https://img.shields.io/badge/Mocha-8D6748?style=for-the-badge&logo=mocha&logoColor=white)
- ![Chai](https://img.shields.io/badge/Chai-A30701?style=for-the-badge&logo=chai&logoColor=white)
- ![TypeScript](https://img.shields.io/badge/TypeScript-3178C6?style=for-the-badge&logo=typescript&logoColor=white)
- ![Supertest](https://img.shields.io/badge/Supertest-000000?style=for-the-badge)
- ![Express](https://img.shields.io/badge/Express-000000?style=for-the-badge&logo=express&logoColor=white)

## 🧪 Ejecución de Tests

_Para ejecutar los tests, se utilizan tags en los features_

Ejemplo de uso o ejecución del proyecto (Corre todos los tests) desde consola:

```bash
npm start
```

Corre test por tags desde consola:

```bash
npx cucumber-js --tags '@tags'
```

Correr run con reporte utilizando Tags (Ver tags) desde consola:

```bash
npm run test:tag '@tag'
```

## 🤝 Contribución

1. Realiza un fork del repositorio.
2. Crea una nueva rama (`git checkout -b feature-nueva`).
3. Realiza tus cambios y haz un commit (`git commit -m 'Agrega nueva funcionalidad'`).
4. Sube los cambios (`git push origin feature-nueva`).
5. Abre un Pull Request.

## 📄 Licencia

Este proyecto está bajo la licencia MIT. Ver el archivo `LICENSE` para más detalles.

## 📝 Recomendación final

⚠️ Este proyecto usa `package-lock.json` para garantizar versiones exactas. No eliminar ni ignorar este archivo.
