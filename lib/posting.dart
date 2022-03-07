import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:drexeltwo/home.dart';
import 'package:drexeltwo/utlities.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class PostTest extends StatelessWidget {
  const PostTest({Key? key}) : super(key: key);

  static const String _title = 'DrexelTwo- Post';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const Center(child: Post()),
      ),
    );
  }
}

class Post extends StatefulWidget {
  const Post({Key? key}) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _postcontentcontroller = TextEditingController();
  String postSection = 'media';

  Future<void> uploadPost(String content, String userId, String section) async {
    try {
      String postId = const Uuid().v1();
      PostData post =
          PostData(content: content, postId: postId, userID: userId, likes: []);
      _firestore.collection(section).doc(postId).set(
            post.toJson(),
          );
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
        body: Form(
      key: _formKey,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 200.0, width: 10.0),
            TextFormField(
              controller: _postcontentcontroller,
              decoration:
                  const InputDecoration(hintText: 'Whats on your mind?'),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            DropdownButton<String>(
                value: postSection,
                onChanged: (String? newValue) {
                  setState(() {
                    postSection = newValue!;
                  });
                },
                items: <String>[
                  'media',
                  'community',
                  'dining',
                  'clubs',
                  'athletics'
                ].map((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList()),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 100.0, horizontal: 20.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Validate will return true if the form is valid, or false if
                    // the form is invalid.
                    if (_formKey.currentState!.validate()) {
                      // Process data.
                      uploadPost(
                          _postcontentcontroller.text, user.uid, postSection);
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  },
                  child: const Text('Post'),
                ),
              ),
            ),
            TextButton(
                child: const Text("Cancel"),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage())))
          ],
        ),
      ),
    ));
  }
}
