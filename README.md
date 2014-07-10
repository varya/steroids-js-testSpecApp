Steorids.js automated tests
===========================

Automated tests for [Steroids.js](https://github.com/AppGyver/steroids-js).

##Running the tests

This project is meant to be used as a Git submodule of the [Steroids.js](https://github.com/AppGyver/steroids-js) repo. The file at `www/javascripts/steroids.js`, used by the tests, is symlinked to the `dist/steroids.js` folder of this repo's parent directory. Thus, to run the tests, you would:

1. Clone the [Steroids.js](https://github.com/AppGyver/steroids-js) repo.
2. Follow the setup instructions in the Steroids.js README.md file.
3. Run `$ git submodule init` and `$ git submodule update` to initialize this repo as a submodule
4. Run `$ grunt` in the Steroids.js directory to create the `dist/steroids.js` file
5. Run `$ npm install` in the `steroids-js-testSpecApp` folder to install dependencies for the automated tests project.
6. Run `$ steroids connect` in `steroids-js-testSpecApp` folder to start the Steroids server.
7. Scan the app with AppGyver Scanner.
