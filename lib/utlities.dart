import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:drexeltwo/authentication.dart' as authentication;

class PostData {
  final String content;
  final String postId;
  final String userID;
  final String username;
  final List likes;
  final uploadTime;

  //constructor
  const PostData({
    required this.content,
    required this.postId,
    required this.userID,
    required this.username,
    required this.likes,
    required this.uploadTime,
  });

  //to make uploading posts easier
  Map<String, dynamic> toJson() => {
        "content": content,
        "postID": postId,
        "userID": userID,
        "username": username,
        "likes": likes,
        "uploadTime": uploadTime
      };

  //returns a post, to read posts from backend
  static PostData fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return PostData(
        content: snapshot['content'],
        postId: snapshot['postID'],
        userID: snapshot['userID'],
        username: snapshot['username'],
        likes: snapshot['likes'],
        uploadTime: snapshot['uploadTime']);
  }
}

class User {
  final String username;
  final String uid;
  final List followers;
  final List following;
  final String bio;

  const User(
      {required this.username,
      required this.uid,
      required this.followers,
      required this.following,
      required this.bio});

  Map<String, dynamic> toJson() => {
        'username': username,
        'followers': followers,
        'following': following,
        'bio': bio,
        'uid': uid
      };

  static User fromSnapshot(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return User(
        username: snapshot['username'],
        followers: snapshot['followers'],
        following: snapshot['following'],
        bio: snapshot['bio'],
        uid: snapshot['uid']);
  }
}

class UserProvider with ChangeNotifier {
  User? _user;
  final authentication.Authentication auth = authentication.Authentication();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await auth.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
