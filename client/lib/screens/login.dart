import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  Future<http.Response> login(String email, String password) async {
    if(_emailController.text != '' && _passwordController.text != ''){
    // if (_formKey.currentState.validate()) {
      final response = await http.post('http://192.168.1.85:4000/login', body: {
        'email': _emailController.text,
        'password': _passwordController.text,
      });
      print(response.body);
      _emailController.text = '';
      _passwordController.text = '';
        Navigator.of(context).pushNamed("/display");
      return response;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
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
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "email",
                    icon: Icon(
                      Icons.email,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                 
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
                 
                ),
                RaisedButton(
                  onPressed: () {
                    login(_emailController.text, _passwordController.text);
                  },
                  child: Text('Login'),
                ),
                 GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed("/signup");
                  },
                  child: const Text(
                    'New Here? Create Account',
                    style: TextStyle(color: Colors.black, fontSize: 18.0),
                  ),
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
