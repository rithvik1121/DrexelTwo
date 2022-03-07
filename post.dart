class Post {
  final String id;
  final String title;
  final String postersName;
  final String postDatetime;
  String comment = '';
  int favoriteCount = 0;

  Post(this.id, this.title, this.postersName, this.postDatetime);

  // factory Post.fromJson(Map<String, dynamic> json) {
  //   return Post(
  //       id: json["id"],
  //       title: json["title"],
  //       postersName: json["postersName"],
  //       postDatetime: json["postDatetime"]);
  // }
}

// class PostsList {
//   final List<Post> items;
//
//   final String errorMessage;
//
//   PostsList(this.items, this.errorMessage);
// }