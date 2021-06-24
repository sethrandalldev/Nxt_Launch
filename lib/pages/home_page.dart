import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
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
  dynamic crew;

  @override
  void initState() {
    super.initState();
    getLaunchInfo();
  }

  void getLaunchInfo() async {
    var url = Uri.parse('https://api.spacexdata.com/v4/launches/next');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      setState(() {
        launchName = jsonResponse['name'];
        launchTime = DateTime.parse(jsonResponse['date_utc']);
        crew = jsonResponse['crew'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FutureBuilder(
                  future: FlutterSession().get('user'),
                  builder: (context, snapshot) {
                    return Text(snapshot.hasData ? snapshot.data.toString() : 'Loading...');
                  }
                ),
                ListTile(
                  title: Text(launchName),
                  subtitle: Text(formatDate(launchTime, [M, ' ', dd, ', ', yyyy]) + '; ' + (crew != null && crew.length > 0 ? 'Crew size: ${crew.length}' : 'Uncrewed'))
                )
              ],
            )
          ),
        ],
      )
    );
  }
}