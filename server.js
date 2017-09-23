var express = require('express');
var app = express();
app.use(express.static('public'))
var port = 5000;


app.get("/", function(req, res) {
  res.sendfile('index.html');
});

app.listen(port, function() {
  console.log('listening on port ', port);
});