import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crud_flutter/screens/login.dart';

class SignupScreen extends StatefulWidget {
  @override
  SignupScreenState createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  Future<http.Response> signup(
      String email, String password, String username) async {
    if (_formKey.currentState.validate()) {
      final response =
          await http.post('http://192.168.1.85:4000/addUser', body: {
        'email': _emailController.text,
        'password': _passwordController.text,
        'username': _usernameController.text,
      });
      print(response.body);
      _usernameController.text = '';
      _emailController.text = '';
      _passwordController.text = '';

      Navigator.of(context).pushNamed("/login");
      return response;
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            autovalidate: true,
            onWillPop: () async {
              return false;
            },
            onChanged: () {},
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  autofocus: true,
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: "username",
                    icon: Icon(
                      Icons.person,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  validator: (String v) {
                    return v.trim().isNotEmpty ? null : "Can not be empty";
                  },
                ),
                TextFormField(
                  autofocus: true,
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "email",
                    icon: Icon(
                      Icons.email,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  validator: (String v) {
                    return v.trim().isNotEmpty ? null : "Can not be empty";
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: "password",
                    icon: Icon(
                      Icons.lock,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  obscureText: true,
                  validator: (String v) {
                    return v.trim().isNotEmpty ? null : "Can not be empty";
                  },
                ),
                RaisedButton(
                  onPressed: () {
                    signup(_emailController.text, _passwordController.text,
                        _usernameController.text);
                  },
                  child: Text('Signup'),
                ),
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}
