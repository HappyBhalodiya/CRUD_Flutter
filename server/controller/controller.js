var userModel = require('../models/user');
let controller = {};

controller.addUser = function (req, res) {
	console.log(req.body);
	var user = new userModel(req.body);
	user.save(function (err, savedUser) {
		//console.log(err,user);
		res.status(200).send(savedUser);
		// console.log("body", savedUser);
	})
}
controller.login = function (req, res) {
	userModel.findOne({ email: req.body.email, password: req.body.password }, function (err, user) {
		console.log(err);
		if (err)
			return res.status(500).send();
		if (!user)
			return res.status(404).send();
		// console.log("login", user);
		res.send(user);
	})
}
controller.getUser = function (req, res) {
	userModel.find({}, function (err, user) {
		console.log(err);
		if (err)
			return res.status(500).send();
		if (!user)
			return res.status(404).send();
		// console.log("get user", user);
		res.send(user);
	})
}

controller.deleteData = function (req, res) {
	const id = req.params.id;
	userModel.findOneAndRemove({ _id: id }, function (err, user) {
		console.log(err);
		if (err)
			return res.status(500).send();
		if (!user)
			return res.status(404).send();
		// console.log("delete user", user);
		res.send(user);

	})
}

controller.updateData = function (req, res) {
	const id = req.params.id;
	console.log("idd-----------", id)
	email = req.body.email;
	username = req.body.username;
	userModel.findByIdAndUpdate({ _id: id }, { $set: { email: email, username: username } }, { upsert: true, new: true }, function (err, user) {
		console.log(err);

		console.log(user);
		if (err)
			return res.status(500).send();
		if (!user)
			return res.status(404).send();
		console.log("update user", user);
		res.send(user);

	})
}
controller.getUserById = function (req, res) {
	const userArr = [];
	const id = req.params.id;
	userModel.findById({_id :id}, function (err, user) {
		console.log(err);
		if (err)
		return res.status(500).send();
		if (!user)
		return res.status(404).send();
	userArr.push(user);
		// console.log("get user", user);
		res.send(userArr);
	})
}


module.exports = controller;