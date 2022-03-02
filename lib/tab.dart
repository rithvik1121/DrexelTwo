import 'package:flutter/material.dart';
import 'package:drexeltwo/profile.dart';

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
          //removes back button from app bar. may need to be reimplemented for simple logout feature, however
          //firebase may mean we don't need to change this. Also may cause issues with the navigation stack
          automaticallyImplyLeading: false,
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
          children: [
            Profile(),
            const Text("Media"),
            const Text("Community"),
            const Text("Dining"),
            const Text("Clubs"),
            const Text("Athletics")
          ],
        ));
  }
}
