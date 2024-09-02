class Post {
  int? userId;
  int? id;
  String? title;
  String? body;
  bool isRead;
  Post({this.userId, this.id, this.title, this.body, this.isRead = false});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
      isRead: json['isRead'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = userId;
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    data['isRead'] = isRead;
    return data;
  }
}
