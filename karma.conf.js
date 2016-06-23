// Karma configuration
// Generated on Thu Jun 23 2016 09:13:29 GMT+0300 (MSK)

module.exports = function(config) {
  config.set({

    // base path that will be used to resolve all patterns (eg. files, exclude)
    basePath: '',


    // frameworks to use
    // available frameworks: https://npmjs.org/browse/keyword/karma-adapter
    frameworks: ['jasmine'],


    // list of files / patterns to load in the browser
    files: [
      'vendor/assets/components/angular/angular.js',
      'vendor/assets/components/angular-cookie/angular-cookie.js',
      'vendor/assets/components/angular-mocks/angular-mocks.js',
      'vendor/assets/components/angular-resource/angular-resource.js',
      'vendor/assets/components/angular-route/angular-route.js',
      'vendor/assets/components/angular-ui-router/release/angular-ui-router.js',
      'vendor/assets/components/ng-token-auth/dist/ng-token-auth.js',
      'app/assets/javascripts/templates/*.html',
      'app/assets/javascripts/templates/**/*.html',
      'app/assets/javascripts/app.js',
      'app/assets/javascripts/router.js',
      'app/assets/javascripts/controllers/*.js',
      'app/assets/javascripts/directives/*.js',
      'app/assets/javascripts/specs/*.js'
    ],


    // list of files to exclude
    exclude: [
    ],


    // preprocess matching files before serving them to the browser
    // available preprocessors: https://npmjs.org/browse/keyword/karma-preprocessor
    preprocessors: {
      '**/*.html': ['ng-html2js']
    },


    ngHtml2JsPreprocessor: {
      // we want all templates to be loaded in the same module called 'templates'
      moduleName: 'templates'
    },

    // test results reporter to use
    // possible values: 'dots', 'progress'
    // available reporters: https://npmjs.org/browse/keyword/karma-reporter
    reporters: ['progress'],


    // web server port
    port: 9876,


    // enable / disable colors in the output (reporters and logs)
    colors: true,


    // level of logging
    // possible values: config.LOG_DISABLE || config.LOG_ERROR || config.LOG_WARN || config.LOG_INFO || config.LOG_DEBUG
    logLevel: config.LOG_INFO,


    // enable / disable watching file and executing tests whenever any file changes
    autoWatch: true,


    // start these browsers
    // available browser launchers: https://npmjs.org/browse/keyword/karma-launcher
    browsers: ['Chrome'],


    // Continuous Integration mode
    // if true, Karma captures browsers, runs the tests and exits
    singleRun: false,

    // Concurrency level
    // how many browser should be started simultaneous
    concurrency: Infinity
  })
}
