import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:drexeltwo/authentication.dart' as authentication;

class PostData {
  final String content;
  final String postId;
  final String userID;
  final List likes;

  //constructor
  const PostData({
    required this.content,
    required this.postId,
    required this.userID,
    required this.likes,
  });

  //to make uploading posts easier
  Map<String, dynamic> toJson() =>
      {"content": content, "postID": postId, "userID": userID, "likes": likes};

  //returns a post, to read posts from backend
  static PostData fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return PostData(
        content: snapshot['content'],
        postId: snapshot['postID'],
        userID: snapshot['userID'],
        likes: snapshot['likes']);
  }
}

class User {
  final String email;
  final String uid;
  final List followers;
  final List following;
  final String bio;

  const User(
      {required this.email,
      required this.uid,
      required this.followers,
      required this.following,
      required this.bio});

  Map<String, dynamic> toJson() => {
        'email': email,
        'followers': followers,
        'following': following,
        'bio': bio,
        'uid': uid
      };

  static User fromSnapshot(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return User(
        email: snapshot['email'],
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
