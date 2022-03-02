import 'dart:html';
import 'dart:ui';
import 'package:drexeltwo/home.dart';
import 'package:flutter/material.dart';
import "dart:convert";
import "package:flutter/services.dart";

//create a user object, should make it easier to organize each user's page
class User {
  final String username;
  final int password;

  User(this.username, this.password);

  User.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        password = json['password'];

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
      };
}

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

//read from the user list in the json file, this will be replaced by the database later
class _AuthenticateState extends State<Authenticate> {
  List _users = [];
  //this should be updated to read from the database in the future. If we use the Firebase that stores data as json trees
  // we probably won't have to change much of this method
  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString("lib/authentication.json");
    final data = await json.decode(response);
    setState(() {
      _users = data["users"];
    });

    //returns the total list of the users, decoded from json
  }

  //check if the user's information is in the authentication.json, if not then add it
  //User authentify(String usern, int pass) {}

  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(children: [
      ElevatedButton(
        child: const Text("Pretend log in"),
        onPressed: readJson,
      ),
      const Text("Bruh"),
      //_users.isNotEmpty
      //    ? Expanded(
      //        child: ListView.builder(
      //          itemCount: _users.length,
      //          itemBuilder: (context, index) {
      //            return Card(
      //              margin: const EdgeInsets.all(10),
      //              child: ListTile(
      //                leading: Text(_users[index]["username"]),
      //                subtitle: Text(_users[index]["password"]),
      //              ),
      //            );
      //          },
      //        ),
      //      )
      //    : Container()
    ])));
  }
}
