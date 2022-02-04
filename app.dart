//dependecies
import 'package:flutter/material.dart';
import 'package:drexeltwo/login.dart';

//app logic
class DrexelTwo extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(backgroundColor: Colors.grey[850]), home: LoginPage());
  }
}
