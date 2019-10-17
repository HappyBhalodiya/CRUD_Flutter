var express  = require('express');
var mongoose = require('mongoose');
var app      = express();
var controller = require('./controller/controller');
var cors = require('cors');

var bodyParser = require('body-parser');         

app.use(bodyParser.urlencoded({'extended':'true'}));           
app.use(bodyParser.json());        
app.use(cors());                            

var User = require('./models/user');

mongoose.connect("mongodb://localhost:27017/demo");
console.log("connected");

app.post('/addUser',controller.addUser);
app.post('/login',controller.login);

module.exports = app;


app.listen(3000);
console.log("App listening");