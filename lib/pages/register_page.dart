import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:spacex_launches/models/user.dart';
import 'package:spacex_launches/pages/login_page.dart';
import 'package:http/http.dart' as http;
import 'package:crypt/crypt.dart';

import 'home_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  final passwordConfirmation = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    passwordConfirmation.dispose();
    super.dispose();
  }

  void _registerUser() async {
    var url = Uri.parse('http://localhost:3000/register');
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register')
      ),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    validator: (value) {
                      if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                        return 'Email format is invalid';
                      }
                      return null;
                    },
                    controller: email,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                      hintText: 'Enter email ex. abc@gmail.com'
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    obscureText: true,
                    controller: password,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter your secure password'
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    validator: (value) {
                      if (value != password.value.text) {
                        return 'Password Confirmation must match Password';
                      }
                      return null;
                    },
                    obscureText: true,
                    controller: passwordConfirmation,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Confirm Password',
                      hintText: 'Enter your password again'
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.green, borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _registerUser();
                      }
                    },
                    child: Text(
                      'Create Account',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
                
              ],
            ),
          ),
          SizedBox(
            height: 130,
          ),
          TextButton(
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LoginPage())), 
            child: Text('Already Registered? Log In')
          )
        ],
      ), 
    );
  }
}
