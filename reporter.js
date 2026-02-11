const cucumber = require('cucumber-html-reporter');
const puppeteer = require('puppeteer');
const path = require('path');
const fs = require('fs');

// // Nuevo import para el segundo reporte
// const multipleCucumberHtmlReporter = require("multiple-cucumber-html-reporter");

// const jsonFile = path.join(__dirname, "cucumber-report.json");
const reportsDir = path.join(__dirname, 'reports', 'pdf');
const htmlFile = path.join(__dirname, 'cucumber-report.html');
const pdfFile = path.join(__dirname, 'cucumber-report.pdf');

fs.mkdirSync(reportsDir, { recursive: true });

const options = {
  theme: 'bootstrap', // Estilo del informe
  jsonFile: 'cucumber-report.json', // Ruta al archivo JSON generado por Cucumber
  output: 'cucumber-report.html', // Ruta del archivo HTML de salida
  reportSuiteAsScenarios: true,
  scenarioTimestamp: true,
  launchReport: true, // Abrir el informe automáticamente en el navegador
  metadata: {
    'App Version': '1.0.0',
    'Test Environment': 'STAGING',
    'Test Type': 'API',
    Platform: 'Node.js',
    Parallel: 'Scenarios',
    Executed: 'CI/CD'
  }
};

cucumber.generate(options);
console.log(`✅ HTML report generated at ${htmlFile}`);

// // 🟢 Reporte claro en tabla con multiple-cucumber-html-reporter
// multipleCucumberHtmlReporter.generate({
//   jsonDir: ".", // directorio donde está el json
//   reportPath: "./reports/multiple-cucumber-html-report",
//   metadata: {
//     browser: {
//       name: "chrome",
//       version: "114",
//     },
//     device: "GitHub Actions CI",
//     platform: {
//       name: "ubuntu",
//       version: "20.04",
//     },
//   },
// });
// console.log(
//   `✅ Multiple Cucumber HTML report generated in ./reports/multiple-cucumber-html-report`
// );

// Función async para convertir HTML a PDF
(async () => {
  // Leer el contenido HTML y servirlo en el page
  const htmlContent = require('fs').readFileSync(htmlFile, 'utf8');

  const browser = await puppeteer.launch({
    headless: true,
    args: ['--no-sandbox', '--disable-setuid-sandbox']
  });
  const page = await browser.newPage();

  // Emular media 'screen' para aplicar estilos correctamente
  await page.emulateMediaType('screen');

  // Cargar el HTML directamente en la página
  await page.setContent(htmlContent, { waitUntil: 'networkidle0' });

  // Esperar un momento extra para que todos los estilos JS se apliquen
  await new Promise((resolve) => setTimeout(resolve, 1000));

  // Forzar expansión de todos los paneles colapsables
  await page.evaluate(() => {
    // Para Cucumber HTML Reporter (bootstrap), normalmente los detalles están en .panel-collapse.collapse
    document.querySelectorAll('.panel-collapse.collapse').forEach((el) => {
      el.classList.add('in'); // activa la sección
      el.style.height = 'auto'; // se asegura de que crezca al contenido
    });

    // Expande errores colapsados individuales (ej: "Show Error +" enlaces)
    document.querySelectorAll('div.collapse').forEach((el) => {
      el.classList.add('in');
      el.style.display = 'block';
    });

    // Asegura que los toggles cambien el texto a "Show Error -" si es necesario
    document.querySelectorAll('a.toggle').forEach((a) => {
      a.classList.add('open');
      a.setAttribute('aria-expanded', 'true');
      a.textContent = a.textContent.replace('Show Error +', 'Show Error -');
    });
  });

  // Hacer scroll hasta el final para cargar contenido dinámico
  await page.evaluate(() => window.scrollTo(0, document.body.scrollHeight));
  await new Promise((resolve) => setTimeout(resolve, 500));

  await page.pdf({
    path: pdfFile,
    format: 'A4',
    printBackground: true,
    margin: { top: '20mm', bottom: '20mm', left: '10mm', right: '10mm' },
    preferCSSPageSize: true
  });

  await browser.close();
  console.log(`✅ PDF report generated at ${pdfFile}`);
})();
