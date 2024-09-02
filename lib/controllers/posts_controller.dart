import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../model/posts_model.dart';

class PostController extends GetxController {
  var posts = <Post>[].obs;
  var isLoading = true.obs;
  var selectedPost = Rx<Post?>(null);
  @override
  void onInit() {
    fetchPosts();
    super.onInit();
  }

  void fetchPosts() async {
    try {
      isLoading(true);
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

      if (response.statusCode == 200) {
        var postList = json.decode(response.body) as List;
        posts.value = postList.map((post) => Post.fromJson(post)).toList();
        await loadReadStatus();
      }
    } finally {
      isLoading(false);
    }
  }

  void fetchPostDetails(int postId) async {
    try {
      isLoading(true);
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/$postId'));

      if (response.statusCode == 200) {
        var postJson = json.decode(response.body);
        selectedPost.value = Post.fromJson(postJson);
      }
    } finally {
      isLoading(false);
    }
  }

  void markPostAsRead(int postId) async {
    var postIndex = posts.indexWhere((post) => post.id == postId);
    if (postIndex != -1) {
      posts[postIndex].isRead = true;
      posts.refresh();
      await saveReadStatus();
    }
  }

  Future<void> saveReadStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final readStatus = posts
        .map((post) => {
              'id': post.id,
              'isRead': post.isRead,
            })
        .toList();
    await prefs.setString('readStatus', json.encode(readStatus));
  }

  Future<void> loadReadStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final readStatusJson = prefs.getString('readStatus');
    if (readStatusJson != null) {
      final readStatus = json.decode(readStatusJson) as List;
      final readStatusMap = {
        for (var item in readStatus) item['id']: item['isRead']
      };
      for (var post in posts) {
        if (readStatusMap.containsKey(post.id)) {
          post.isRead = readStatusMap[post.id] ?? false;
        }
      }
      posts.refresh();
    }
  }
}
