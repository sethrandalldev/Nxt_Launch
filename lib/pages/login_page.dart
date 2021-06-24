import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:spacex_launches/models/user.dart';
import 'package:spacex_launches/pages/register_page.dart';
import 'package:http/http.dart' as http;

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  Function setAuthenticated;
  Function setOnLogin;

  LoginPage(setAuthenticated, setOnLogin) {
    this.setAuthenticated = setAuthenticated;
    this.setOnLogin = setOnLogin;
  }

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  void _login() async {
    var url = Uri.parse('http://localhost:3000/login');
    var response = await http.post(
      url, 
      body: {
        'email': email.value.text,
        'password': password.value.text
      }
    );
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      User user = new User(id: json['_id'], email: json['email']);
      await FlutterSession().set("user", user);
      widget.setAuthenticated();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                      hintText: 'Enter valid mail id as abc@gmail.com'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter your secure password'),
                ),
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.green, borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () {
                    _login();
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              SizedBox(
                height: 130,
              ),
              TextButton(
                onPressed: () => widget.setOnLogin(), 
                child: Text('New User? Create Account')
              )
            ],
          ),
        ),
      ],
    );
  }
}
