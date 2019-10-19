import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class UpdateScreen extends StatefulWidget {
  final id;
  UpdateScreen({Key key, @required this.id}) : super(key: key);

  @override
  UpdateScreenState createState() => UpdateScreenState();
}

class UpdateScreenState extends State<UpdateScreen> {
  TextEditingController _usernamecontroller;
  TextEditingController _emailcontroller;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List userData;
  @override
  void initState() {
    super.initState();
    fetchPost();
  }

  Future fetchPost() async {
    var id = this.widget.id;
    http.Response response =
        await http.get('http://192.168.1.85:4000/getUserById/$id');

    setState(() {
      userData = json.decode(response.body);
    });
    print('userData=====${userData[0]["username"]}');
    _usernamecontroller =
        new TextEditingController(text: '${userData[0]["username"]}');
    _emailcontroller =
        new TextEditingController(text: '${userData[0]["email"]}');
  }

  Future<http.Response> update(String email, String username) async {
    print(email);
    print(username);
    var id = this.widget.id;
    final response =
        await http.put('http://192.168.1.85:4000/updateData/$id', body: {
      'email': _emailcontroller.text,
      'username': _usernamecontroller.text,
    });
    print(response.body);

    Navigator.of(context).pushNamed("/display");
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id),
      ),
      body: ListView.builder(
          itemCount: userData == null ? 0 : userData.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
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
                        controller: _usernamecontroller,
                        decoration: InputDecoration(
                          labelText: "username",
                          icon: Icon(
                            Icons.person,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      TextFormField(
                        autofocus: true,
                        controller: _emailcontroller,
                        decoration: InputDecoration(
                          labelText: "email",
                          icon: Icon(
                            Icons.email,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {
                          update(
                              _emailcontroller.text, _usernamecontroller.text);
                        },
                        child: Text('Update'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
