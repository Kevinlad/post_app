import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/scheduler.dart';

import '../controllers/posts_controller.dart'; // Import SchedulerBinding

class PostDetailScreen extends StatelessWidget {
  final int postId;

  PostDetailScreen({required this.postId});

  @override
  Widget build(BuildContext context) {
    final PostController postController = Get.find<PostController>();

    // Schedule fetching post details after the current frame
    SchedulerBinding.instance.addPostFrameCallback((_) {
      postController.fetchPostDetails(postId);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Post Details'),
      ),
      body: Obx(() {
        if (postController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (postController.selectedPost.value != null) {
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  postController.selectedPost.value!.title ?? "",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(postController.selectedPost.value!.body ?? ""),
              ],
            ),
          );
        } else {
          return Center(child: Text('No post details available.'));
        }
      }),
    );
  }
}
