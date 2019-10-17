var userModel = require('../models/user');
let controller = {};

controller.addUser = function(req,res){
	console.log(req.body);
	var user = new userModel(req.body);
	user.save(function(err,savedUser){
		//console.log(err,user);
		res.status(200).send(savedUser);
		console.log("body",savedUser);
	})

}
controller.login = function(req,res){
	userModel.findOne({ email: req.body.email,password:req.body.password}, function(err, user) {
		
		console.log(err);
		if(err) 
			return res.status(500).send();
		if(!user)
			return res.status(404).send();
		console.log("login", user);
		res.send(user);	

})

}

module.exports = controller;