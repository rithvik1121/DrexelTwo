import 'dart:html';
import 'package:drexeltwo/tab.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  bool isValidUser = false;

  @override
  Widget build(BuildContext build) {
    //TODO: add button that is disabled until valid credentials have been input into username and password
    //TODO: finalize theme
    return Scaffold(
        body: Container(
            child: Column(children: <Widget>[
      Expanded(
        child: const Tabs(),
      )
    ])));
  }
}
