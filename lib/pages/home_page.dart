import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

/// HomePage - The entry point of the application
class HomePage extends StatefulWidget {

  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String launchName = '';
  DateTime launchTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    getLaunchInfo();
  }

  void getLaunchInfo() async {
    var url = 'https://api.spacexdata.com/v4/launches/next';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      setState(() {
        launchName = jsonResponse['name'];
        launchTime = DateTime.parse(jsonResponse['date_utc']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Center(child: Text(launchName, style: TextStyle(fontSize: 40)))),
          Expanded(
            child: Center(
              child: Text(
                formatDate(launchTime, [M, ' ', dd, ', ', yyyy]),
                style: TextStyle(fontSize: 30)
              )
            )
          )
        ],
      )
    );
  }
}