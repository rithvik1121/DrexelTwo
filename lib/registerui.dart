import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drexeltwo/login.dart';
import 'package:drexeltwo/utlities.dart' as utilities;
import 'package:drexeltwo/authentication.dart' as authentication;

class RegisterUI extends StatefulWidget {
  const RegisterUI({Key? key}) : super(key: key);

  @override
  _RegisterUIState createState() {
    return _RegisterUIState();
  }
}

class _RegisterUIState extends State<RegisterUI> {
  final authentication.Authentication auth = authentication.Authentication();

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext build) {
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
                labelText: 'drexel email',
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
            onPressed: () =>
                auth.register(username.text, password.text, context),
            child: const Text("register"),
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xFF002099)),
                foregroundColor: MaterialStateProperty.all(Colors.amber)),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            child: const Text("Already a user? Login"),
          )
        ],
      ),
    ));
  }
}
