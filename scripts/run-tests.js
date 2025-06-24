const { exec } = require("child_process");

const tagArgs = process.argv.slice(2);
const tag = tagArgs.length > 0 ? tagArgs.join(" ") : "@pix";

const command = `npx cucumber-js --tags "${tag}" --format json:cucumber-report.json`;

exec(command, (error, stdout, stderr) => {
  console.log(stdout);
  console.error(stderr);

  // Siempre generar el reporte, incluso si hubo error
  require("../reporter.js");
});
