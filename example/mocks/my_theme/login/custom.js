const common = require('keycloak-ftl/mocks/v16').common;

const custom = {
  "name": "Ann"
}

// мерж объектов
module.exports = {
  ...common,
  ...custom,
}
