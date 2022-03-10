import 'package:drexeltwo/club_post_list_view.dart';
import 'package:flutter/material.dart';

class Athletics extends StatefulWidget {
  const Athletics({Key? key}) : super(key: key);

  @override
  _AthleticsState createState() {
    return _AthleticsState();
  }
}

class _AthleticsState extends State<Athletics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          child: ClubPostListView(section: 'athletics')),
    );
  }
}
