import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import '../controllers/posts_controller.dart'; // Import SchedulerBinding

class PostDetailScreen extends StatefulWidget {
  final int postId;

  PostDetailScreen({required this.postId});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final PostController postController = Get.put(PostController());
    SchedulerBinding.instance.addPostFrameCallback((_) {
      postController.fetchPostDetails(widget.postId);
    });
    return Scaffold(
      appBar: AppBar( 
        title: const Text('Post Details'),
      ),
      body: Obx(() {
        if (postController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (postController.selectedPost.value != null) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  postController.selectedPost.value!.title ?? "",
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Text(postController.selectedPost.value!.body ?? ""),
              ],
            ),
          );
        } else {
          return const Center(child: Text('No post details available.'));
        }
      }),
    );
  }
}
