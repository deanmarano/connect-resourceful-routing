// Generated by CoffeeScript 1.3.3
(function() {
  var app, connect;

  connect = require('connect');

  app = connect().use(connect.logger('dev').use(connect["static"]('public').use(function(req, res) {
    return res.end('hello world\n');
  }))).listen(3000);

}).call(this);
