var express = require('express');
var app = express();

app.get('/health', function (req, res) {
   res.end('Healthy :)');
})

app.get('/', function (req, res) {
   res.end('Hello World!');
})

var server = app.listen(8080, function () {
  var host = server.address().address
  var port = server.address().port
  console.log("Listening http://%s:%s", host, port)
})
