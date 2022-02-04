import 'dart:html';

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext build) {
    //TODO: add button that is disabled until valid credentials have been input into username and password
    //TODO: finalize theme
    return Scaffold(
        body: SafeArea(
      child: ListView(
          //creates padding from the margins
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 80.0),
            //allows all components of this page to be in one single column
            Column(
              children: <Widget>[
                const Text('Welcome to DrexelTwo'),
              ],
            ),
            const SizedBox(height: 120.0),
            TextFormField(
              decoration: const InputDecoration(
                filled: false,
                labelText: 'username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15.0),
            TextFormField(
              decoration: const InputDecoration(
                filled: false,
                labelText: 'password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            )
          ]),
    ));
  }
}
