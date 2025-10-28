const fs = require('fs');
const path = require('path');

function beforeScenario(context, ee, next) {
  const lockPath = path.resolve(__dirname, '../artillery/payloads/lock.json');
  const fileContent = fs.readFileSync(lockPath, 'utf-8'); // 👈 leer contenido
  const data = JSON.parse(fileContent);
  context.vars = context.vars || {};
  context.vars.lockCode = data.lockCode;
  return next();
}

function metricsByEndpoint_beforeRequest(req, context, ee, next) {
  const timestamp = new Date().toISOString();
  console.log(`[${timestamp}] 📤 Request #${context.vars.$uuid} - lockCode: ${context.vars.lockCode}`);
  return next();
}

function metricsByEndpoint_afterResponse(req, res, context, ee, next) {
  const timestamp = new Date().toISOString();
  console.log(`[${timestamp}] 📥 Response #${context.vars.$uuid} - Status: ${res.statusCode}`);
  return next();
}

module.exports = {
  beforeScenario,
  metricsByEndpoint_beforeRequest
};
