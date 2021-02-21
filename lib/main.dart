import 'package:flutter/material.dart';
import 'package:spacex_launches/pages/home_page.dart';

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
          title: Text('Next Launch', style: TextStyle(fontSize: 30))
        ),
        body: HomePage()
      )
    );
  }
}
