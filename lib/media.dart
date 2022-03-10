import 'package:drexeltwo/club_post_list_view.dart';
import 'package:flutter/material.dart';

class Media extends StatefulWidget {
  const Media({Key? key}) : super(key: key);

  @override
  _MediaState createState() {
    return _MediaState();
  }
}

class _MediaState extends State<Media> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          child: const ClubPostListView(section: 'media')),
    );
  }
}
