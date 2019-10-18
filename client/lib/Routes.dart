import 'package:flutter/material.dart';
import 'package:crud_flutter/screens/login.dart';
import 'package:crud_flutter/screens/signup.dart';
import 'package:crud_flutter/screens/display.dart';

class Routes {

  var routes = <String, WidgetBuilder>{
    "/login": (BuildContext context) => new LoginScreen(),
    "/signup":(BuildContext context) => new SignupScreen(),
    "/display":(BuildContext context) => new DisplayScreen(),
   
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