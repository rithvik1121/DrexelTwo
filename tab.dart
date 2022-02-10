import 'package:flutter/material.dart';

class Tabs extends StatelessWidget {
  const Tabs({Key? key}) : super(key: key);

  static const String _title = 'DrexelTwo';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drexel Two'),
        centerTitle: true,
        backgroundColor: const Color(0xFF002099),
        foregroundColor: const Color(0xFFFF9030),
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
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
    );
  }
}
