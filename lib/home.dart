import 'dart:html';
import 'package:drexeltwo/tab.dart';
import 'package:drexeltwo/utlities.dart' as utlities;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    utlities.UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext build) {
    //TODO: add button that is disabled until valid credentials have been input into username and password
    //TODO: finalize theme

    return Scaffold(
        //appBar: AppBar(automaticallyImplyLeading: false, actions: [
        //TextButton(child: const Text("sign out"), onPressed: () {})
        //]),

        body: Container(
            child: Column(children: <Widget>[
      Expanded(
        child: const Tabs(),
      )
    ])));
  }
}
