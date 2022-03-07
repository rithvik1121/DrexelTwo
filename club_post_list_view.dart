import 'package:flutter/material.dart';
import 'package:postdrexeltwo/model/post.dart';
import 'package:intl/intl.dart';

class ClubPostListView extends StatefulWidget {
  const ClubPostListView({Key? key}) : super(key: key);

  //TODO - does this need to be a Statful Widget --- not sure ????

  @override
  _ClubPostListViewState createState() => _ClubPostListViewState();
}

class _ClubPostListViewState extends State<ClubPostListView> {
  // TODO need to see if this can be read from the json file OR from the firebase tables
  // ignore: non_constant_identifier_names
  final _MockClubPosts = [
    Post('1', 'Drama(isabel) club meeting tonight at 7:00 pm at Urban Theater.',
        'Ana 1', 'Mar 01, 2021, 8:15 AM'),
    Post('2', 'Mens basketball tonight at 7:00 pm at DAC.', 'James 2',
        'Mar 01, 2021, 10:08 AM'),
    Post('3', 'Womens basketball game tomorrow at 7:00 pm at DAC.', 'Ally 3',
        'Mar 02, 2021, 10:08 AM')
  ];

  // ignore: non_constant_identifier_names
  var _ClubPosts = [];

  var isCommentBoxVisible = false;
  final TextEditingController _capturePostSubject = TextEditingController();
  final TextEditingController _capturePostersName = TextEditingController();
  final TextEditingController _captureComment = TextEditingController();

  @override
  void initState() {
    super.initState();
    _ClubPosts = _MockClubPosts;
    // _ClubPosts = _MockClubPosts.where((post) => post.postersName == 'Ana 1').toList();
  }

  // void _makeCommentBoxVisable() {
  //   setState(() {
  //     // This call to setState tells the Flutter framework that something has
  //     // changed in this State, which causes it to rerun the build method below
  //     // so that the display can reflect the updated values. If we changed
  //     // <SOMETHING> without calling setState(), then the build method would not be
  //     // called again, and so nothing would appear to happen.

  //     // TODO this will flip the comment box on and off
  //     // want to find another way of no longer showing commnet box .. maybe after they have entered a comment
  //     isCommentBoxVisible = isCommentBoxVisible ? false : true;
  //   });
  // }

  //----------------------
  // this is the main build method
  // -- this has the add button
  // -- this starts the creation of the ListView
  //----------------------
  @override
  Widget build(BuildContext context) {
    var topCardHeight = 56.0;
    var fabPadding = 2 * 16 + 56.0;

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
          // add post button
          //----------------------
          ElevatedButton(
            child: const Text("Add a club post"),
            onPressed: () {
              //listBloc.loadItems();
              _showAddPostPopup(context);
            },
          ),
          //----------------------
          // list of posts
          //----------------------
          Flexible(
              child: ListView.separated(
            padding: EdgeInsets.only(
              top: topCardHeight + 4,
              bottom: fabPadding,
            ),
            itemBuilder: (_, i) => build_PostListTile_withCard(
                _ClubPosts[i]), // <------------ using Card
            separatorBuilder: (_, __) => const Divider(),
            itemCount: _ClubPosts.length,
            //constraints: BoxConstraints(maxWidth: 200, minWidth: 20)),
          ))
        ]));
  }

  // //----------------------
  // // this is the main build method
  // // this starts the creation of the ListView
  // //----------------------
  // @override
  // Widget build(BuildContext context) {
  //   var topCardHeight = 56.0;
  //   var fabPadding = 2 * 16 + 56.0;
  //
  //   return ListView.separated(
  //     padding: EdgeInsets.only(
  //       top: topCardHeight + 4,
  //       bottom: fabPadding,
  //     ),
  //     itemBuilder: (_, i) => build_PostListTile_withCard(_ClubPosts[i]),  // <------------ using Card
  //     separatorBuilder: (_, __) => Divider(),
  //     itemCount: _ClubPosts.length,
  //   );
  // }

  //----------------------
  // this code builds the list of <Posts> implemented with Card
  //----------------------
  // ignore: non_constant_identifier_names
  Widget build_PostListTile_withCard(Post post) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.album),
            title: Text(post.title), // <------------ Post title
            subtitle: Text('posted on: ' +
                post.postDatetime +
                ' .. posted by: ' +
                post.postersName), // <------------ Post Date and Name
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              //----------------------
              // comment button
              //----------------------
              TextButton(
                child: const Text('+comment'),
                onPressed: () {
                  // <----------- TODO want to be able to add a comment
                  //_makeCommentBoxVisable();
                  _showAddCommentPopup(context, post);
                },
              ),
              const SizedBox(width: 8),
              //----------------------
              // view comment button
              //----------------------
              TextButton(
                child: const Text('view comments'),
                onPressed: () {
                  // <----------- TODO want to be able to add a comment
                  //_makeCommentBoxVisable();
                  _showViewCommentPopup(context, post);
                },
              ),
              const SizedBox(width: 8),
              //----------------------
              // favorite button
              //----------------------
              IconButton(
                icon: const Icon(Icons.favorite),
                color: post.favoriteCount > 0 ? Colors.red : Colors.blue,
                onPressed: () {
                  post.favoriteCount == 0 ? _incrementHeartCount(post): _subtractHeartCount(post);
                },
              ),
              const SizedBox(width: 8),
              Text(post.favoriteCount.toString() + '     ')
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Visibility(
                visible:
                    isCommentBoxVisible, // <----------- this variable to show the comment box in the card
                child: TextFormField(
                  decoration: const InputDecoration(
                      filled: false,
                      labelText: 'comment',
                      border: OutlineInputBorder(),
                      constraints: BoxConstraints(maxWidth: 200, minWidth: 20)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _incrementHeartCount(Post post) {
    setState(() {
      post.favoriteCount++;
    });
  }
  void _subtractHeartCount (Post post){
    setState(() {
      post.favoriteCount--;
    });
  }
  
//----------------------
// this will popup a dialog box for you to enter a <Comment> about a <Post>
//----------------------
  Future<void> _showAddCommentPopup(BuildContext context, Post post) async {
    return await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add a comment?'),
        content: TextFormField(
          controller: _captureComment,
          decoration: const InputDecoration(
              filled: false,
              labelText: 'Add comment',
              border: OutlineInputBorder(),
              constraints: BoxConstraints(maxWidth: 200, minWidth: 20)),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('SAVE'),
            onPressed: () {
              _saveComment(post);
              Navigator.pop(context);
            },
            //TODO do something here to save a comment  <------------------------------
          ),
          TextButton(
            child: const Text('CANCEL'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _showViewCommentPopup(BuildContext context, Post post) async {
    return await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Comments'),
        content: Text(post.comment),
        actions: <Widget>[
          TextButton(
            child: const Text('EXIT'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  //----------------------
// this will popup a dialog box for you to enter a brand new <Post>
//----------------------
  Future<void> _showAddPostPopup(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add a post?'),
        content: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            //position
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Enter post subject:"),
              TextFormField(
                controller: _capturePostSubject,
                decoration: const InputDecoration(
                    filled: false,
                    labelText: 'Add subject',
                    border: OutlineInputBorder(),
                    constraints: BoxConstraints(maxWidth: 200, minWidth: 20)),
              ),
              const Text("Enter posters name:"),
              TextFormField(
                controller: _capturePostersName,
                decoration: const InputDecoration(
                    filled: false,
                    labelText: 'Add poster name',
                    border: OutlineInputBorder(),
                    constraints: BoxConstraints(maxWidth: 200, minWidth: 20)),
              )
            ]),
        actions: <Widget>[
          TextButton(
              //TODO do something here to save a post  <------------------------------
              child: const Text('SAVE'),
              onPressed: () {
                _saveNewPost();
                Navigator.pop(context);
              }),
          TextButton(
            child: const Text('CANCEL'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _saveNewPost() {
    setState(() {
      _ClubPosts.add(Post(
          _ClubPosts.length.toString(),
          _capturePostSubject.text,
          _capturePostersName.text,
          DateFormat('MMM dd, yyyy, hh:mm a').format(DateTime.now())));
    });
  }//'Mar 1, 2021, 8:15 AM'

  void _saveComment(Post post) {
    setState(() {
      post.comment += '\n'+  _captureComment.text;
    });
  }
}
