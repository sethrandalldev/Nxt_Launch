import 'package:flutter/material.dart';
import 'package:spacex_launches/pages/authentication_page.dart';
import 'package:spacex_launches/pages/home_page.dart';
import 'package:spacex_launches/pages/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
        body: AuthenticationPage()
      )
    );
  }
}
