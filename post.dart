import 'package:flutter/material.dart';
import 'package:drexeltwo/tab.dart';

class Post extends StatelessWidget {
  const Post({Key? key}) : super(key: key);

  static const String _title = 'DrexelTwo';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: _title,
        home: Scaffold(
          body: MyStatelessWidget(),
        ));
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              //title: Text('The Enchanted Nightingale'),
              subtitle: Text('Club meeting tonight.'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('comment'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
                TextButton(
                  child: const Icon(Icons.favorite),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
