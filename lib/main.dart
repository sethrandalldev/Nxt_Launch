import 'package:flutter/material.dart';
import 'package:spacex_launches/pages/login_page.dart';
import 'package:spacex_launches/pages/register_page.dart';

import 'pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _authenticated = false;
  bool _onLogin = true;

  void setAuthenticated() {
    setState(() {
      _authenticated = true;
    });
  }

  void setOnLogin() {
    setState(() {
      _onLogin = !_onLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Nxt Launch', style: TextStyle(fontSize: 30))
        ),
        body: _authenticated ?
          HomePage() : 
            _onLogin ?
              LoginPage(setAuthenticated, setOnLogin) :
              RegisterPage(setAuthenticated, setOnLogin)
      )
    ); 
  }
}
