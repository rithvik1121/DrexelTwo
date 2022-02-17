import 'package:drexeltwo/home.dart';
import 'package:flutter/material.dart';
import 'package:drexeltwo/authentication.dart';
import 'dart:async';
import "dart:convert";
import "package:flutter/services.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  List _users = [];
  bool isValidUser = false;

  //this should be updated to read from the database in the future. If we use the Firebase that stores data as json trees
  // we probably won't have to change much of this method
  //This method was originally in authentication.dart, but due to difficulties, was migrated here
  Future<void> login(BuildContext context) async {
    final String response =
        await rootBundle.loadString("lib/authentication.json");
    final data = await json.decode(response);
    setState(() {
      _users = data["users"];
    });

    if (_users.isNotEmpty) {
      for (var i = 0; i < _users.length; i++) {
        if (username.text == _users[i]["username"] &&
            password.text == _users[i]["password"]) {
          isValidUser = true;
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        }
      }
    }
    ;
  }

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
                const SizedBox(height: 120.0),
                TextFormField(
                  controller: username,
                  decoration: const InputDecoration(
                    filled: false,
                    labelText: 'username',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15.0),
                TextFormField(
                  controller: password,
                  decoration: const InputDecoration(
                    filled: false,
                    labelText: 'password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () => login(build),
                  child: Text("log in"),
                ),
                isValidUser
                    ? const Text("Welcome!")
                    : const Text("Invalid username or password")
              ],
            ),
          ]),
    ));
  }
}
