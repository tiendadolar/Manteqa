module.exports = {
  default: {
    paths: ['tests/**/*.feature'],
    requireModule: ['ts-node/register'],
    require: ['tests/cucumber/step-definitions/**/*.ts', 'tests/hooks/*.ts'],
    format: ['json:cucumber-report.json', 'progress'],
    // publishQuiet: true,
    strict: true,
    timeout: 30000
  }
};
