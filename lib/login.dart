//import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:drexeltwo/registerui.dart';
import 'package:drexeltwo/utlities.dart';
import 'package:drexeltwo/authentication.dart' as authentication;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final authentication.Authentication auth = authentication.Authentication();

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  //List _users = [];

  Widget showErr() {
    return const Scaffold(
        body: SnackBar(content: Text("Something went wrong, try again")));
  }

  //legacy: original login in functionality contained in login() function.

  // final String response =
  // await rootBundle.loadString("lib/authentication.json");
  // final data = await json.decode(response);
  // setState(() {
  // _users = data["users"];
  // });
//
  // if (_users.isNotEmpty) {
  // for (var i = 0; i < _users.length; i++) {
  // if (username.text == _users[i]["username"] &&
  // password.text == _users[i]["password"]) {
  // isValidUser = true;
  // Navigator.push(context,
  // MaterialPageRoute(builder: (context) => const HomePage()));
  // }
  // }
  // }
  //}

  @override
  Widget build(BuildContext build) {
    //TODO: add button that is disabled until valid credentials have been input into username and password
    //TODO: finalize theme
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Colors.teal, Colors.purple],
        ),
      ),
      alignment: Alignment.center,
      child: //allows all components of this page to be in one single column
          Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text(
            "DrexelTwo",
            style: TextStyle(
              fontSize: 90.0,
              color: Colors.amber,
            ),
          ),
          const SizedBox(height: 120.0),
          const SizedBox(height: 120.0),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: TextFormField(
              controller: username,
              decoration: const InputDecoration(
                filled: false,
                labelText: 'drexel id(without @drexel.edu)',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 15.0),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0.0),
            child: TextFormField(
              controller: password,
              decoration: const InputDecoration(
                filled: false,
                labelText: 'drexel password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () => auth.login(username.text, password.text),
            child: const Text("log in"),
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xFF002099)),
                foregroundColor: MaterialStateProperty.all(Colors.amber)),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RegisterUI()),
              );
            },
            child: const Text("Not a user? Register"),
          )
        ],
      ),
    ));
  }
}
