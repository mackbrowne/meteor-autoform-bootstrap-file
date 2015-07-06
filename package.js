Package.describe({
  name: "meteorblackbelt:autoform-bootstrap-file",
  summary: "File upload for AutoForm",
  description: "File upload for AutoForm",
  version: "0.0.2",
  git: "http://github.com/meteorblackbelt/autoform-bootstrap-file.git",
  documentation: null
});

Package.onUse(function(api) {
  api.versionsFrom('METEOR@1.0');

  api.use(
    [
    'coffeescript',
    'underscore',
    'reactive-var',
    'templating',
    'less',
    'aldeed:autoform@5.3.0'
    ],
    'client');

  api.addFiles('lib/client/autoform-bootstrap-file.html', 'client');
  api.addFiles('lib/client/autoform-bootstrap-file.less', 'client');
  api.addFiles('lib/client/autoform-bootstrap-file.coffee', 'client');
});
