import 'package:flutter/material.dart';

class Community extends StatefulWidget {
  const Community({Key? key}) : super(key: key);

  @override
  _CommunityState createState() {
    return _CommunityState();
  }
}

class _CommunityState extends State<Community> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Container(alignment: Alignment.center, child: Text("Community page")),
    );
  }
}
