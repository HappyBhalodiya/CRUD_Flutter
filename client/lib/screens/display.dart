import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:crud_flutter/screens/update.dart';

class DisplayScreen extends StatefulWidget {
  @override
  DisplayScreenState createState() => DisplayScreenState();
}

class DisplayScreenState extends State<DisplayScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List userData;

  @override
  void initState() {
    super.initState();
    fetchPost();
  }

  Future fetchPost() async {
    http.Response response = await http.get('http://192.168.1.85:4000/getUser');

    setState(() {
      userData = json.decode(response.body);
    });
  }

  Future<http.Response> deleteData(String _id) async {
    final response = await http.delete(
      'http://192.168.1.85:4000/deleteData/$_id',
    );

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Display'),
        ),
        body: ListView.builder(
            itemCount: userData == null ? 0 : userData.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          deleteData('${userData[index]["_id"]}');
                        },
                        child: Icon(
                          Icons.delete,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateScreen(
                                    id: '${userData[index]["_id"]}'),
                              ));
                        },
                        child: Icon(
                          Icons.create,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "${userData[index]["username"]}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }));
  }
}
