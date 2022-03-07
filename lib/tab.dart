import 'package:drexeltwo/athletics.dart';
import 'package:drexeltwo/clubs.dart';
import 'package:drexeltwo/community.dart';
import 'package:drexeltwo/dining.dart';
import 'package:drexeltwo/login.dart';
import 'package:drexeltwo/media.dart';
import 'package:flutter/material.dart';
import 'package:drexeltwo/profile.dart';
import 'package:drexeltwo/posting.dart';

class Tabs extends StatefulWidget {
  const Tabs({Key? key}) : super(key: key);

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('DrexelTwo'),
          centerTitle: true,
          backgroundColor: const Color(0xFF002099),
          foregroundColor: const Color(0xFFFF9030),
          automaticallyImplyLeading: false,
          //leading: TextButton(
          //    child: const Text("sign out"),
          //    onPressed: () => Navigator.push(context,
          //        MaterialPageRoute(builder: (context) => const LoginPage()))),
          actions: [
            ElevatedButton(
                child: const Text("Post"),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: const BorderSide(color: Colors.amber),
                ))),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Post()))),
          ],
          bottom: TabBar(
            controller: _tabController,
            tabs: const <Widget>[
              Tab(
                icon: Text("Profile"),
              ),
              Tab(
                icon: Text("Media"),
              ),
              Tab(
                icon: Text("Community"),
              ),
              Tab(
                icon: Text("Dining"),
              ),
              Tab(
                icon: Text("Clubs"),
              ),
              Tab(
                icon: Text("Athletics"),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            Profile(),
            Media(),
            Community(),
            Dining(),
            Clubs(),
            Athletics()
          ],
        ));
  }
}
