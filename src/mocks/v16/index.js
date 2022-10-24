const common = require('./common.json');
const login = require('./login.json');

// утилита по мержу
module.exports = {
  login: { ...common, ...login }
}
