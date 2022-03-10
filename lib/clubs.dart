import 'package:flutter/material.dart';
import 'club_post_list_view.dart';

class Clubs extends StatefulWidget {
  const Clubs({Key? key}) : super(key: key);

  @override
  _ClubsState createState() {
    return _ClubsState();
  }
}

class _ClubsState extends State<Clubs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          child: ClubPostListView(section: 'clubs')),
    );
  }
}
