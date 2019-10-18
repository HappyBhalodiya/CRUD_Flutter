import 'package:flutter/material.dart';
import 'package:crud_flutter/login.dart';


class Routes {

  var routes = <String, WidgetBuilder>{
    "/login": (BuildContext context) => new LoginScreen(),
   
  };

  Routes() {
    runApp(new MaterialApp(
      title: "Flutter Flat App",
      home: new LoginScreen(),
     theme: ThemeData(         
        primaryColor: Colors.deepPurple,
      ), 
      routes: routes,
    ));
  }
}