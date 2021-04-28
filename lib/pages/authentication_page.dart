import 'package:flutter/material.dart';

import 'login_page.dart';
import 'register_page.dart';

class AuthenticationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextButton(
            onPressed: () => Navigator.pushReplacement(
              context, 
              MaterialPageRoute(
                builder: (BuildContext context) => LoginPage()
              )
            ),
            child: Text('Login'),
          ),
          TextButton(
            onPressed: () => Navigator.pushReplacement(
              context, 
              MaterialPageRoute(
                builder: (BuildContext context) => RegisterPage()
              )
            ),
            child: Text('Register'),
          ),
        ],
      )
    );
  }
}