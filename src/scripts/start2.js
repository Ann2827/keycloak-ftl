const WebpackDevServer = require('webpack-dev-server');
const serverConfig = require('../utils/webpackDevServer.config');
const chalk = require('chalk');
const openBrowser = require('../utils/openBrowser');
// const { createCompiler } = require('react-dev-utils/WebpackDevServerUtils');
//
// const compiler = createCompiler({
//   appName,
//   config,
//   urls,
//   useYarn,
//   useTypeScript,
//   webpack,
// });

const devServer = new WebpackDevServer(
  serverConfig(),
  // compiler
);

// Launch WebpackDevServer.
devServer.startCallback(() => {
  // if (isInteractive) {
  //   clearConsole();
  // }

  // if (env.raw.FAST_REFRESH && semver.lt(react.version, '16.10.0')) {
  //   console.log(
  //     chalk.yellow(
  //       `Fast Refresh requires React 16.10 or higher. You are using React ${react.version}.`
  //     )
  //   );
  // }

  console.log(chalk.cyan('Starting the development server...\n'));
  openBrowser('https://localhost:3000/');
});

['SIGINT', 'SIGTERM'].forEach(function (sig) {
  process.on(sig, function () {
    devServer.close();
    process.exit();
  });
});

if (process.env.CI !== 'true') {
  // Gracefully exit when stdin ends
  process.stdin.on('end', function () {
    devServer.close();
    process.exit();
  });
}
