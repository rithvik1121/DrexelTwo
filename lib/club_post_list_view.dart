import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//creates an instance of Firebase
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//this creates a list of posts
class ClubPostListView extends StatelessWidget {
  //allows us to create a club post ListView with the section of firebase it must read and write from

  final String section;
  const ClubPostListView({Key? key, required this.section}) : super(key: key);

  //TODO - does this need to be a Statful Widget --- not sure ????

  //allows the section to be accessed from our state managing class
  @override
  Widget build(BuildContext context) {
    var topCardHeight = 56.0;
    var fabPadding = 2 * 16 + 56.0;

    //allows realtime reading of data from the database
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection(section).snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return Center(
                  // Center is a layout widget. It takes a single child and positions it
                  // in the middle of the parent.
                  child: Column(
                      // Column is also a layout widget. It takes a list of children and
                      // arranges them vertically. By default, it sizes itself to fit its
                      // children horizontally, and tries to be as tall as its parent.
                      // Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                    //----------------------
                    // list of posts
                    //----------------------
                    Flexible(
                        child: ListView.separated(
                      padding: EdgeInsets.only(
                        top: topCardHeight + 4,
                        bottom: fabPadding,
                      ),

                      //creates a Display Post widget, passing in the data of the i-th
                      //element in the collection. This allows the Display Post widget
                      //to generate a Card widget formatted with the data of the post
                      itemBuilder: (_, i) {
                        return DisplayPost(
                            snapshot: snapshot.data!.docs[i].data(),
                            section: section);
                      }, // <------------ using Card
                      separatorBuilder: (_, __) => const Divider(),
                      //sets the item count of the Listview to the number of docs
                      //in the collection
                      itemCount: snapshot.data!.docs.length,
                      //constraints: BoxConstraints(maxWidth: 200, minWidth: 20)),
                    ))
                  ]));
            }));
  }

  //@override
  //_ClubPostListViewState createState() => _ClubPostListViewState();
}

//class _ClubPostListViewState extends State<ClubPostListView> {
//  // TODO need to see if this can be read from the json file OR from the firebase tables
//  // ignore: non_constant_identifier_names
//
//  // ignore: non_constant_identifier_names
//
//  var isCommentBoxVisible = false;
//  final TextEditingController _capturePostSubject = TextEditingController();
//  final TextEditingController _capturePostersName = TextEditingController();
//  final TextEditingController _captureComment = TextEditingController();
//
//  // void _makeCommentBoxVisable() {
//  //   setState(() {
//  //     // This call to setState tells the Flutter framework that something has
//  //     // changed in this State, which causes it to rerun the build method below
//  //     // so that the display can reflect the updated values. If we changed
//  //     // <SOMETHING> without calling setState(), then the build method would not be
//  //     // called again, and so nothing would appear to happen.
//
//  //     // TODO this will flip the comment box on and off
//  //     // want to find another way of no longer showing commnet box .. maybe after they have entered a comment
//  //     isCommentBoxVisible = isCommentBoxVisible ? false : true;
//  //   });
//  // }
//
//  //----------------------
//  // this is the main build method
//  // -- this has the add button
//  // -- this starts the creation of the ListView
//  //----------------------
//  @override
//  Widget build(BuildContext context) {
//    var topCardHeight = 56.0;
//    var fabPadding = 2 * 16 + 56.0;
//
//    //allows realtime reading of data from the database
//    return Scaffold(
//        body: StreamBuilder(
//            stream: FirebaseFirestore.instance.collection('clubs').snapshots(),
//            builder: (context,
//                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
//              if (snapshot.connectionState == ConnectionState.waiting) {
//                return const Center(child: CircularProgressIndicator());
//              }
//              return Center(
//                  // Center is a layout widget. It takes a single child and positions it
//                  // in the middle of the parent.
//                  child: Column(
//                      // Column is also a layout widget. It takes a list of children and
//                      // arranges them vertically. By default, it sizes itself to fit its
//                      // children horizontally, and tries to be as tall as its parent.
//                      // Column(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      children: <Widget>[
//                    //----------------------
//                    // list of posts
//                    //----------------------
//                    Flexible(
//                        child: ListView.separated(
//                      padding: EdgeInsets.only(
//                        top: topCardHeight + 4,
//                        bottom: fabPadding,
//                      ),
//
//                      //creates a Display Post widget, passing in the data of the i-th
//                      //element in the collection. This allows the Display Post widget
//                      //to generate a Card widget formatted with the data of the post
//                      itemBuilder: (_, i) {
//                        return DisplayPost(
//                            snapshot: snapshot.data!.docs[i].data(),
//                            section: 'clubs');
//                      }, // <------------ using Card
//                      separatorBuilder: (_, __) => const Divider(),
//                      //sets the item count of the Listview to the number of docs
//                      //in the collection
//                      itemCount: snapshot.data!.docs.length,
//                      //constraints: BoxConstraints(maxWidth: 200, minWidth: 20)),
//                    ))
//                  ]));
//            }));
//  }
//
//  // //----------------------
//  // // this is the main build method
//  // // this starts the creation of the ListView
//  // //----------------------
//  // @override
//  // Widget build(BuildContext context) {
//  //   var topCardHeight = 56.0;
//  //   var fabPadding = 2 * 16 + 56.0;
//  //
//  //   return ListView.separated(
//  //     padding: EdgeInsets.only(
//  //       top: topCardHeight + 4,
//  //       bottom: fabPadding,
//  //     ),
//  //     itemBuilder: (_, i) => build_PostListTile_withCard(_ClubPosts[i]),  // <------------ using Card
//  //     separatorBuilder: (_, __) => Divider(),
//  //     itemCount: _ClubPosts.length,
//  //   );
//  // }
//
//  //----------------------
//  // this code builds the list of <Posts> implemented with Card
//  //----------------------
//  // ignore: non_constant_identifier_names
//
//}

//Rithvik 3-9-2022: separated the creation of the card with post data from the creation of the list of posts.
//This makes it easier to read and use(bc object oriented programming and modularity and stuff)
//and also the tutorial guy did it this way lol
//
class DisplayPost extends StatelessWidget {
  //snapshot is a DocumentSnapshot containing data from one document(one item) in the database
  final snapshot;
  final String section;
  const DisplayPost({Key? key, required this.snapshot, required this.section})
      : super(key: key);

  void likePost(String postId, String uid, List likes, String section) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection(section).doc(postId).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection(section).doc(postId).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.album),
            title: Text(snapshot['content']), // <------------ Post title
            subtitle: Text('posted on: ' +
                //DateFormat comes from the intl package. we use it because DateTime.now() - which is
                //how we store the time a post is uploaded to our database- does not return a string
                //so we must convert it to a string before displaying it to our users
                DateFormat.yMMMd().format(snapshot['uploadTime'].toDate()) +
                '\nposted by: ' +
                snapshot['username']), // <------------ Post Date and Name
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              //  //----------------------
              //  // comment button
              //  //----------------------
              //  TextButton(
              //    child: const Text('+comment'),
              //    onPressed: () {
              //      // <----------- TODO want to be able to add a comment
              //      //_makeCommentBoxVisable();
              //      _showAddCommentPopup(context, post);
              //    },
              //  ),
              //  const SizedBox(width: 8),
              //  //----------------------
              //  // view comment button
              //  //----------------------
              //  TextButton(
              //    child: const Text('view comments'),
              //    onPressed: () {
              //      // <----------- TODO want to be able to add a comment
              //      //_makeCommentBoxVisable();
              //      _showViewCommentPopup(context, post);
              //    },
              //  ),
              //  const SizedBox(width: 8),
              //----------------------
              // favorite button
              //----------------------
              IconButton(
                icon: const Icon(Icons.favorite),
                color: snapshot['likes'].length > 0 ? Colors.red : Colors.blue,
                onPressed: () {
                  likePost(snapshot['postID'], snapshot['userID'],
                      snapshot['likes'], section);
                },
              ),
              const SizedBox(width: 8),
              Text('${snapshot['likes'].length}')
            ],
          ),
          //Row(
          //  mainAxisAlignment: MainAxisAlignment.center,
          //  children: <Widget>[
          //    Visibility(
          //      visible:
          //          isCommentBoxVisible, // <----------- this variable to show the comment box in the card
          //      child: TextFormField(
          //        decoration: const InputDecoration(
          //            filled: false,
          //            labelText: 'comment',
          //            border: OutlineInputBorder(),
          //            constraints: BoxConstraints(maxWidth: 200, minWidth: 20)),
          //      ),
          //    ),
          //  ],
          //),
        ],
      ),
    );
  }

//----------------------
// this will popup a dialog box for you to enter a <Comment> about a <Post>
//----------------------
  //Future<void> _showAddCommentPopup(BuildContext context, Post post) async {
  //  return await showDialog(
  //    context: context,
  //    builder: (_) => AlertDialog(
  //      title: const Text('Add a comment?'),
  //      content: TextFormField(
  //        controller: _captureComment,
  //        decoration: const InputDecoration(
  //            filled: false,
  //            labelText: 'Add comment',
  //            border: OutlineInputBorder(),
  //            constraints: BoxConstraints(maxWidth: 200, minWidth: 20)),
  //      ),
  //      actions: <Widget>[
  //        TextButton(
  //          child: const Text('SAVE'),
  //          onPressed: () {
  //            _saveComment(post);
  //            Navigator.pop(context);
  //          },
  //          //TODO do something here to save a comment  <------------------------------
  //        ),
  //        TextButton(
  //          child: const Text('CANCEL'),
  //          onPressed: () {
  //            Navigator.pop(context);
  //          },
  //        ),
  //      ],
  //    ),
  //  );
  //}
//
  //Future<void> _showViewCommentPopup(BuildContext context, Post post) async {
  //  return await showDialog(
  //    context: context,
  //    builder: (_) => AlertDialog(
  //      title: const Text('Comments'),
  //      content: Text(post.comment),
  //      actions: <Widget>[
  //        TextButton(
  //          child: const Text('EXIT'),
  //          onPressed: () {
  //            Navigator.pop(context);
  //          },
  //        ),
  //      ],
  //    ),
  //  );
  //}

  //----------------------
// this will popup a dialog box for you to enter a brand new <Post>
//----------------------
  //Future<void> _showAddPostPopup(BuildContext context) async {
  //  return await showDialog(
  //    context: context,
  //    builder: (_) => AlertDialog(
  //      title: const Text('Add a post?'),
  //      content: Column(
  //          crossAxisAlignment: CrossAxisAlignment.stretch,
  //          //position
  //          mainAxisSize: MainAxisSize.min,
  //          children: [
  //            const Text("Enter post subject:"),
  //            TextFormField(
  //              controller: _capturePostSubject,
  //              decoration: const InputDecoration(
  //                  filled: false,
  //                  labelText: 'Add subject',
  //                  border: OutlineInputBorder(),
  //                  constraints: BoxConstraints(maxWidth: 200, minWidth: 20)),
  //            ),
  //            const Text("Enter posters name:"),
  //            TextFormField(
  //              controller: _capturePostersName,
  //              decoration: const InputDecoration(
  //                  filled: false,
  //                  labelText: 'Add poster name',
  //                  border: OutlineInputBorder(),
  //                  constraints: BoxConstraints(maxWidth: 200, minWidth: 20)),
  //            )
  //          ]),
  //      actions: <Widget>[
  //        TextButton(
  //            //TODO do something here to save a post  <------------------------------
  //            child: const Text('SAVE'),
  //            onPressed: () {
  //              _saveNewPost();
  //              Navigator.pop(context);
  //            }),
  //        TextButton(
  //          child: const Text('CANCEL'),
  //          onPressed: () {
  //            Navigator.pop(context);
  //          },
  //        ),
  //      ],
  //    ),
  //  );
  //}

  //void _saveNewPost() {
  //  setState(() {
  //    _ClubPosts.add(Post(
  //        _ClubPosts.length.toString(),
  //        _capturePostSubject.text,
  //        _capturePostersName.text,
  //        DateFormat('MMM dd, yyyy, hh:mm a').format(DateTime.now())));
  //  });
  //} //'Mar 1, 2021, 8:15 AM'
//
  //void _saveComment(Post post) {
  //  setState(() {
  //    post.comment += '\n' + _captureComment.text;
  //  });
  //}
}
