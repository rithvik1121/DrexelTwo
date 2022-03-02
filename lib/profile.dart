import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Username goes here"),
        //gets rid of back button
        automaticallyImplyLeading: false,
      ),
      body: Container(
        alignment: Alignment.center,
      ),
    );
  }
}
