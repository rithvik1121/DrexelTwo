import 'package:drexeltwo/club_post_list_view.dart';
import 'package:flutter/material.dart';

class Dining extends StatefulWidget {
  const Dining({Key? key}) : super(key: key);

  @override
  _DiningState createState() {
    return _DiningState();
  }
}

class _DiningState extends State<Dining> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          child: ClubPostListView(section: 'dining')),
    );
  }
}
