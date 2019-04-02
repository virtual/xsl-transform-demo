var express = require('express');
var app = express();
app.use(express.static('public'))
var port = 5000;
var path = require('path');


app.get("/", function(req, res) {
  res.sendfile('index.html');
});

app.get("/programs/", function(req, res) {
  //res.sendfile('index.html');
  res.sendFile(path.join(__dirname, 'public', 'programs/default.html'));
});
app.get("/programs/default.xml", function(req, res) {
  //res.sendfile('index.html');
  res.sendFile(path.join(__dirname, 'public', 'programs/default.xml'));
});

app.listen(port, function() {
  console.log('listening on port ', port);
});